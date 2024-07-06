{ pkgs, ... }:
{
  services.radarr = { 
    enable = true;
    dataDir = "/config";
    package = pkgs.unstable.radarr;

    user = "nixserver-service";
    group = "nixserver-service";
  };

  services.tailscale.enable = true;
}