{ pkgs, lib, ... }: 
{
  services.uptime-kuma = {
    enable = true;
    package = pkgs.unstable.uptime-kuma;
  };

  systemd.services."uptime-kuma".serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "nixserver-service";
    Group = "nixserver-service";
  };

  services.tailscale.enable = true;
}