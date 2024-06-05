{ lib, ... }: 
{
  services.uptime-kuma = {
    enable = true;
  };

  systemd.services."uptime-kuma".serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "nixserver-service";
    Group = "nixserver-service";
  };
}