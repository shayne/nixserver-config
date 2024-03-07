{ pkgs, ... }: let
  # TODO(shayne): support "ombi.hostname"/nested secrets
  hostname = pkgs.readSecret "ombi_hostname";
  tunnelId = pkgs.readSecret "ombi_tunnel_id";
in
{
  services.ombi.enable = true;
  services.ombi.user = "nixserver-service";
  services.ombi.group = "nixserver-service";

  services.cloudflared.enable = true;
  services.cloudflared.tunnels = {
    "${tunnelId}" = {
      credentialsFile = "${toString (pkgs.writeSecret "ombi_credentialsFile")}";
      default = "http_status:404";
      ingress = {
        "${hostname}" = {
          service = "http://localhost:5000";
        };
      };
    };
  };
}
