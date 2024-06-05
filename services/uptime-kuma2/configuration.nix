{
  # Enable the uptime-kuma service
  services.uptime-kuma.enable = true;
  
  # Uptime Kuma package to use.
  # services.uptime-kuma.package = pkgs.uptime-kuma;
  
  # Additional configuration for Uptime Kuma, see
  # <https://github.com/louislam/uptime-kuma/wiki/Environment-Variables>
  # for supported values.
  #
  # services.uptime-kuma.settings = { };
  
  # Whether to enable apprise support for notifications.
  # services.uptime-kuma.appriseSupport = false;
}