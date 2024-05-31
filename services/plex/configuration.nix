{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
  ];
  
  # Enable the plex service
  services.plex.enable = true;
  
  # The directory where Plex stores its data files.
  services.plex.dataDir = "/var/lib/plex";
  
  # A list of paths to extra plugin bundles to install in Plex's plugin
  # directory. Every time the systemd unit for Plex starts up, all of the
  # symlinks in Plex's plugin directory will be cleared and this module
  # will symlink all of the paths specified here to that directory.
  #
  # services.plex.extraPlugins = [ ];
  
  # A list of paths to extra scanners to install in Plex's scanners
  # directory.
  #
  # Every time the systemd unit for Plex starts up, all of the symlinks
  # in Plex's scanners directory will be cleared and this module will
  # symlink all of the paths specified here to that directory.
  #
  # services.plex.extraScanners = [ ];
  
  # Open ports in the firewall for the media server.
  # services.plex.openFirewall = false;
  
  # The Plex package to use. Plex subscribers may wish to use their own
  # package here, pointing to subscriber-only server versions.
  #
  services.plex.package = pkgs.unstable.plex;
  
  # User account under which Plex runs.
  services.plex.user = "nixserver-service";
  
  # Group under which Plex runs.
  services.plex.group = "nixserver-service";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  
  services.tailscale.enable = true;
}