{ pkgs, ... }:
{
  services.sonarr = {
    enable = true;
    package = pkgs.unstable.sonarr;
    dataDir = "/config";
    user = "nixserver-service";
    group = "nixserver-service";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-wrapped-6.0.36"
  ];

  services.tailscale.enable = true;
}