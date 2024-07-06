{ pkgs, ... }:
{
  services.sonarr = {
    enable = true;
    package = pkgs.unstable.sonarr;
    dataDir = "/config";
    user = "nixserver-service";
    group = "nixserver-service";
  };

  services.tailscale.enable = true;
}