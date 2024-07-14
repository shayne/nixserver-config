{ pkgs, ... }: {
  # Enable the searx service
  services.searx.enable = true;
  
  # Searx settings. These will be merged with (taking precedence over)
  # the default configuration. It's also possible to refer to
  # environment variables
  # (defined in [](#opt-services.searx.environmentFile))
  # using the syntax `@VARIABLE_NAME@`.
  #
  # ::: {.note}
  # For available settings, see the Searx
  # [docs](https://searx.github.io/searx/admin/settings.html).
  #
  # :::
  # services.searx.settings = { };
  
  # The path of the Searx server settings.yml file. If no file is
  # specified, a default file is used (default config file has debug mode
  # enabled). Note: setting this options overrides
  # [](#opt-services.searx.settings).
  #
  # ::: {.warning}
  # This file, along with any secret key it contains, will be copied
  # into the world-readable Nix store.
  #
  # :::
  # services.searx.settingsFile = "/run/searx/settings.yml";
  
  # Configure a local Redis server for SearXNG. This is required if you
  # want to enable the rate limiter and bot protection of SearXNG.
  #
  # services.searx.redisCreateLocally = false;
  
  # Environment file (see `systemd.exec(5)`
  # "EnvironmentFile=" section for the syntax) to define variables for
  # Searx. This option can be used to safely include secret keys into the
  # Searx configuration.
  #
  # services.searx.environmentFile = null;
  
  # Limiter settings for SearXNG.
  #
  # ::: {.note}
  # For available settings, see the SearXNG
  # [schema file](https://github.com/searxng/searxng/blob/master/searx/botdetection/limiter.toml).
  #
  # :::
  # services.searx.limiterSettings = { };
  
  # searx package to use.
  services.searx.package = pkgs.unstable.searxng;
  
  # Additional configuration of the uWSGI vassal running searx. It
  # should notably specify on which interfaces and ports the vassal
  # should listen.
  #
  # services.searx.uwsgiConfig = {
  #   http = ":8080";
  # };
  
  # Whether to run searx in uWSGI as a "vassal", instead of using its
  # built-in HTTP server. This is the recommended mode for public or
  # large instances, but is unnecessary for LAN or local-only use.
  #
  # ::: {.warning}
  # The built-in HTTP server logs all queries by default.
  #
  # :::
  # services.searx.runInUwsgi = false;

  services.tailscale.enable = true;
}