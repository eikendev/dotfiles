# User services. Home Manager writes the unit files, enables them through
# their Install section and restarts changed units on switch.
{ ... }:
{
  systemd.user.services.tbunread = {
    Unit.Description = "tbunread";

    Service = {
      Type = "simple";
      ExecStartPre = "/usr/bin/mkdir -p %h/.local/share/tbunread";
      ExecStart = "%h/.config/cargo/bin/tbunread --output %h/.local/share/tbunread/count";
      Restart = "on-success";
      RestartSec = "5s";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
