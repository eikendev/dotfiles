{ config, ... }:
let
  stateDir = "${config.xdg.dataHome}/tbunread";
in
{
  systemd.user = {
    # Installed with cargo, see toolchains.nix.
    services.tbunread = {
      Unit.Description = "tbunread";

      Service = {
        Type = "simple";
        ExecStartPre = "/usr/bin/mkdir -p ${stateDir}";
        ExecStart = "${config.toolchains.cargoHome}/bin/tbunread --output ${stateDir}/count";
        Restart = "on-failure";
        RestartSec = "5s";
      };

      Install.WantedBy = [ "default.target" ];
    };

    # Volumes are left alone, they may hold data of stopped containers.
    services.podman-prune = {
      Unit.Description = "Prune unused Podman data";

      Service = {
        Type = "oneshot";
        ExecStart = "/usr/bin/podman system prune --all --force --filter until=168h";
      };
    };

    timers.podman-prune = {
      Unit.Description = "Prune unused Podman data weekly";

      Timer = {
        OnCalendar = "weekly";
        Persistent = true;
      };

      Install.WantedBy = [ "timers.target" ];
    };
  };
}
