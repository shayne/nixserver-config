{ pkgs, ... }: {
  # SABnzbd
  services.sabnzbd.enable = true;
  services.sabnzbd.package = pkgs.unstable.sabnzbd;

  services.sabnzbd.user = "nixserver-service";
  services.sabnzbd.group = "nixserver-service";

  # Tailscale
  services.tailscale.enable = true;
}
