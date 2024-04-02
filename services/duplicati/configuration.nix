{
  services.duplicati = {
    enable = true;
    user = "nixserver-service";
  };

  services.tailscale.enable = true;
}
