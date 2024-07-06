{
  # Enable the netdata service
  services.netdata.enable = true;
  
  # If set, automatically registers the agent using the given claim token
  # file.
  #
  # services.netdata.claimTokenFile = null;
  
  # netdata.conf configuration as nix attributes. cannot be combined with configText.
  # services.netdata.config = { };
  
  # Verbatim netdata.conf, cannot be combined with config.
  # services.netdata.configText = null;
  
  # In order to detect when netdata is misbehaving, we run a concurrent task pinging netdata (wait-for-netdata-up)
  # in the systemd unit.
  #
  # If after a while, this task does not succeed, we stop the unit and mark it as failed.
  #
  # You can control this deadline in seconds with this option, it's useful to bump it
  # if you have (1) a lot of data (2) doing upgrades (3) have low IOPS/throughput.
  #
  # services.netdata.deadlineBeforeStopSec = 120;
  
  # Enable reporting of anonymous usage statistics to Netdata Inc. via either
  # Google Analytics (in versions prior to 1.29.4), or Netdata Inc.'s
  # self-hosted PostHog (in versions 1.29.4 and later).
  #
  # See: <https://learn.netdata.cloud/docs/agent/anonymous-statistics>
  # services.netdata.enableAnalyticsReporting = false;
  
  # Extra paths to add to the netdata global "plugins directory"
  # option.  Useful for when you want to include your own
  # collection scripts.
  #
  # Details about writing a custom netdata plugin are available at:
  # <https://docs.netdata.cloud/collectors/plugins.d/>
  # Cannot be combined with configText.
  #
  # services.netdata.extraPluginPaths = [ ];
  
  # Netdata package to use.
  # services.netdata.package = pkgs.netdata;
  
  # Whether to enable python-based plugins
  # services.netdata.python.enable = true;
  
  # Extra python packages available at runtime
  # to enable additional python plugins.
  #
  # services.netdata.python.extraPackages = ps: [];
  
  # Complete netdata config directory except netdata.conf.
  #
  # The default configuration is merged with changes
  # defined in this option.
  #
  # Each top-level attribute denotes a path in the configuration
  # directory as in environment.etc.
  #
  # Its value is the absolute path and must be readable by netdata.
  #
  # Cannot be combined with configText.
  #
  # services.netdata.configDir = { };
  
  # User account under which netdata runs.
  services.netdata.user = "nixserver-service";
  
  # Group under which netdata runs.
  services.netdata.group = "nixserver-service";

  services.tailscale.enable = true;
}