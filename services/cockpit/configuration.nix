{
  # Enable the cockpit service
  services.cockpit.enable = true;
  
  # Open port for cockpit.
  # services.cockpit.openFirewall = false;
  
  # The Cockpit package to use.
  # services.cockpit.package = pkgs.cockpit;
  
  # Port where cockpit will listen.
  # services.cockpit.port = 9090;
  
  # Settings for cockpit that will be saved in /etc/cockpit/cockpit.conf.
  #
  # See the [documentation](https://cockpit-project.org/guide/latest/cockpit.conf.5.html), that is also available with `man cockpit.conf.5` for details.
  #
  services.cockpit.settings = {
    WebService = {
      Origins = [ "https://cockpit.shayne.ts.net/" ];
    };
  };

  services.tailscale.enable = true;
}