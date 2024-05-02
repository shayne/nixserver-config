{
  # Enable the smokeping service
  services.smokeping.enable = true;
  
  # Configuration for alerts.
  # services.smokeping.alertConfig = ''
  #   to = root@localhost
  #   from = smokeping@localhost
  # '';
  
  # URL to the smokeping cgi.
  services.smokeping.cgiUrl = "https://smokeping.shayne.ts.net/smokeping.fcgi";
  
  # Full smokeping config supplied by the user. Overrides
  # and replaces any other configuration supplied.
  #
  # services.smokeping.config = null;
  
  # Configure the ping frequency and retention of the rrd files.
  #
  #           Once set, changing the interval will require deletion or migration of all
  #           the collected data.
  #
  services.smokeping.databaseConfig = ''
    step     = 30
    pings    = 5
    # consfn mrhb steps total
    AVERAGE  0.5   1  1008
    AVERAGE  0.5  12  4320
        MIN  0.5  12  4320
        MAX  0.5  12  4320
    AVERAGE  0.5 144   720
        MAX  0.5 144   720
        MIN  0.5 144   720
  '';
  
  # Any additional customization not already included.
  services.smokeping.extraConfig = ''
    *** General ***
    syslogpriority = debug
  '';
  
  # Host/IP to bind to for the web server.
  #
  # Setting it to `null` skips passing the -h option to thttpd,
  # which makes it bind to all interfaces.
  #
  services.smokeping.host = null;
  
  # DNS name for the urls generated in the cgi.
  services.smokeping.hostName = "smokeping.shayne.ts.net";
  
  # Base url for images generated in the cgi.
  #
  # The default is a relative URL to ensure it works also when e.g. forwarding
  # the GUI port via SSH.
  #
  # services.smokeping.imgUrl = "cache";
  
  # DNS name for the urls generated in the cgi.
  services.smokeping.linkStyle = "absolute";
  
  # Use this SMTP server to send alerts
  # services.smokeping.mailHost = "";
  
  # Real name of the owner of the instance
  # services.smokeping.owner = "nobody";
  
  # Email contact for owner
  # services.smokeping.ownerEmail = "no-reply@${hostName}";
  
  # Specify a custom smokeping package
  # services.smokeping.package = pkgs.smokeping;
  
  # TCP port to use for the web server.
  services.smokeping.port = 8081;
  
  # presentation graph style
  # services.smokeping.presentationConfig = ''
  #   + charts
  #   menu = Charts
  #   title = The most interesting destinations
  #   ++ stddev
  #   sorter = StdDev(entries=>4)
  #   title = Top Standard Deviation
  #   menu = Std Deviation
  #   format = Standard Deviation %f
  #   ++ max
  #   sorter = Max(entries=>5)
  #   title = Top Max Roundtrip Time
  #   menu = by Max
  #   format = Max Roundtrip Time %f seconds
  #   ++ loss
  #   sorter = Loss(entries=>5)
  #   title = Top Packet Loss
  #   menu = Loss
  #   format = Packets Lost %f
  #   ++ median
  #   sorter = Median(entries=>5)
  #   title = Top Median Roundtrip Time
  #   menu = by Median
  #   format = Median RTT %f seconds
  #   + overview
  #   width = 600
  #   height = 50
  #   range = 10h
  #   + detail
  #   width = 600
  #   height = 200
  #   unison_tolerance = 2
  #   "Last 3 Hours"    3h
  #   "Last 30 Hours"   30h
  #   "Last 10 Days"    10d
  #   "Last 360 Days"   360d
  # '';
  
  # Default page layout for the web UI.
  # services.smokeping.presentationTemplate = "${pkgs.smokeping}/etc/basepage.html.dist";
  
  # Probe configuration
  # services.smokeping.probeConfig = ''
  #   + FPing
  #   binary = ${config.security.wrapperDir}/fping
  # '';
  
  # Use this sendmail compatible script to deliver alerts
  # services.smokeping.sendmail = null;
  
  # Specify the smokemail template for alerts.
  # services.smokeping.smokeMailTemplate = "${package}/etc/smokemail.dist";
  
  # Target configuration
  services.smokeping.targetConfig = ''
    probe = FPing
    menu = Top
    title = Network Latency Grapher
    remark = Welcome to the SmokePing website of xxx Company. \
             Here you will learn all about the latency of our network.
    + Local
    menu = Local
    title = Local Network
    ++ LocalMachine
    menu = Local Machine
    title = This host
    host = localhost
    ++ Router
    menu = Router
    title = UDM Pro SE
    host = 10.2.0.1
    ++ PVE0
    menu = pve0
    title = pve0
    host = pve0.home.ss.ht
    ++ Tower
    menu = Tower
    title = Tower
    host = tower.home.ss.ht
  '';
  
  # Enable a smokeping web interface
  # services.smokeping.webService = true;
  
  # User that runs smokeping and (optionally) thttpd. A group of the same name will be created as well.
  services.smokeping.user = "nixserver-service";

  services.tailscale.enable = true;
}