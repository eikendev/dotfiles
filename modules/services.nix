{ config, ... }:
let
  stateDir = "${config.xdg.dataHome}/tbunread";
in
{
  # Installed with cargo, see toolchains.nix.
  systemd.user.services.tbunread = {
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
}
