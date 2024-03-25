{ lib, pkgs, ... }:
{
  services.prowlarr.enable = true;
  services.prowlarr.package = pkgs.unstable.prowlarr;

  systemd.services."prowlarr".serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "nixserver-service";
    Group = "nixserver-service";
  };

  services.tailscale.enable = true;
}
