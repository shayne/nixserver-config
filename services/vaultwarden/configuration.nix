{ pkgs, lib, ... }: let
  hostname = pkgs.readSecret "vaultwarden_hostname";
  tunnelId = pkgs.readSecret "vaultwarden_tunnel_id";
in
{
  services.vaultwarden = {
    enable = true;
    package = pkgs.unstable.vaultwarden;
    webVaultPackage = pkgs.unstable.vaultwarden.webvault;
    config = {
      SIGNUPS_ALLOWED = false;
      ROCKET_PORT = 8000;
    };
    backupDir = "/backup";
  };

  systemd.services."vaultwarden" = {
    serviceConfig = {
      User = lib.mkForce "nixserver-service";
      Group = lib.mkForce "nixserver-service";
    };
  };

  systemd.services."backup-vaultwarden" = {
    serviceConfig = {
      User = lib.mkForce "nixserver-service";
      Group = lib.mkForce "nixserver-service";
    };
  };

  services.cloudflared.enable = true;
  services.cloudflared.tunnels = {
    "${tunnelId}" = {
      credentialsFile = "${toString (pkgs.writeSecret "vaultwarden_credentials_file")}";
      default = "http_status:404";
      ingress = {
        "${hostname}" = {
          service = "http://localhost:8000";
        };
      };
    };
  };

  services.tailscale.enable = true;
}
