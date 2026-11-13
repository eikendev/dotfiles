# OpenShell from the upstream release tarballs, with the gateway as a user
# service. Used by source/bin/capsule. The release is pinned in
# openshell.lock.json, refreshed by `make update`.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  pin = lib.importJSON ./openshell.lock.json;

  # Each tarball holds one executable at the top level.
  openshell = pkgs.stdenvNoCC.mkDerivation {
    pname = "openshell";
    inherit (pin) version;

    srcs = lib.mapAttrsToList (
      name: sha256:
      pkgs.fetchurl {
        url = "https://github.com/NVIDIA/OpenShell/releases/download/v${pin.version}/${name}";
        inherit sha256;
      }
    ) pin.assets;
    sourceRoot = ".";

    # The gateway links against glibc, the CLI and the prover are static.
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [ pkgs.stdenv.cc.cc.lib ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      install -D -m 0755 -t "$out/bin" openshell openshell-gateway openshell-prover
    '';
  };

  gateway = "${openshell}/bin/openshell-gateway";
  stateDir = "${config.xdg.stateHome}/openshell";
  tlsDir = "${stateDir}/tls";
in
{
  home.packages = [ openshell ];

  # Without the directory systemd links StateDirectory to ~/.config/openshell,
  # which it takes for the state of an older systemd.
  home.activation.openshellState = lib.hm.dag.entryBetween [ "reloadSystemd" ] [ "writeBoundary" ] ''
    run mkdir -p "${stateDir}"
  '';

  # The CLI is pointed at it once with
  # `openshell gateway add --local https://127.0.0.1:17670`.
  systemd.user.services.openshell-gateway = {
    Unit = {
      Description = "OpenShell Gateway";
      After = [ "podman.socket" ];
      Wants = [ "podman.socket" ];
    };

    Service = {
      Type = "exec";
      Environment = [
        "PATH=${openshell}/bin:/usr/local/bin:/usr/bin"
        "OPENSHELL_LOCAL_TLS_DIR=${tlsDir}"
        # From the store, the gateway refuses a linked configuration file.
        "OPENSHELL_GATEWAY_CONFIG=${../source/openshell/gateway.toml}"
      ];
      ExecStartPre = [
        "${gateway} config preflight"
        # Creates the local PKI on first start, the CLI finds the client
        # certificates in ~/.config/openshell/gateways.
        "${gateway} generate-certs --output-dir ${tlsDir} --server-san host.openshell.internal"
      ];
      ExecStart = gateway;
      StateDirectory = "openshell";
      Restart = "on-failure";
      RestartSec = "5s";

      NoNewPrivileges = true;
      ProtectSystem = "strict";
      # For the client certificates and the gateway registrations.
      ReadWritePaths = [ "${config.xdg.configHome}/openshell" ];
      PrivateTmp = true;
      RestrictAddressFamilies = "AF_INET AF_INET6 AF_UNIX";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
