{ pkgs, lib, ... }: {
  
  services.searx.enable = true;
  services.searx.package = pkgs.unstable.searxng;
  services.searx.settingsFile = "/var/lib/searx/settings.yml";

  systemd.services."searx".serviceConfig = {
    User = lib.mkForce "nixserver-service";
    Group = lib.mkForce "nixserver-service";
  };

  services.tailscale.enable = true;

  services.cloudflared.enable = true;
  services.cloudflared.tunnels = {
    "${pkgs.readSecret "searx_tunnel_id"}" = {
      credentialsFile = "${toString (pkgs.writeSecret "searx_credentials_file")}";
      default = "http_status:404";
      ingress = {
        "${pkgs.readSecret "searx_hostname"}" = {
          service = "http://localhost:8888";
        };
      };
    };
  };
  
}