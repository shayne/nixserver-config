{ config, pkgs, lib, ... }: {
  # Enable the nextcloud service
  services.nextcloud.enable = true;
  
  # The directory where the skeleton files are located. These files will be
  # copied to the data directory of new users. Leave empty to not copy any
  # skeleton files.
  #
  # services.nextcloud.skeletonDirectory = "";
  
  # Secret options which will be appended to Nextcloud's config.php file (written as JSON, in the same
  # form as the [](#opt-services.nextcloud.extraOptions) option), for example
  # `{"redis":{"password":"secret"}}`.
  #
  # services.nextcloud.secretFile = null;
  
  # Enable this option if you plan on using the webfinger plugin.
  #
  # The appropriate nginx rewrite rules will be added to your configuration.
  #
  # services.nextcloud.webfinger = false;
  
  # The full path to a file that contains the admin's password. Must be
  # readable by user `nextcloud`. The password is set only in the initial
  # setup of Nextcloud by the systemd service `nextcloud-setup.service`.
  #
  # Type: string
  services.nextcloud.config.adminpassFile = "${toString (pkgs.writeSecret "nextcloud_admin_password")}";
  
  # Options for PHP's php.ini file for nextcloud.
  #
  # Please note that this option is _additive_ on purpose while the
  # attribute values inside the default are option defaults: that means that
  # ```nix
  # {
  #   services.nextcloud.phpOptions."opcache.interned_strings_buffer" = "23";
  # }
  # ```
  # will override the `php.ini` option `opcache.interned_strings_buffer` without
  # discarding the rest of the defaults.
  #
  # Overriding all of `phpOptions` (including `upload_max_filesize`, `post_max_size`
  # and `memory_limit` which all point to [](#opt-services.nextcloud.maxUploadSize)
  # by default) can be done like this:
  # ```nix
  # {
  #   services.nextcloud.phpOptions = lib.mkForce {
  #     /* ... */
  #   };
  # }
  # ```
  # services.nextcloud.phpOptions = {
  #   catch_workers_output = "yes";
  #   display_errors = "stderr";
  #   error_reporting = "E_ALL & ~E_DEPRECATED & ~E_STRICT";
  #   expose_php = "Off";
  #   "opcache.fast_shutdown" = "1";
  #   "opcache.interned_strings_buffer" = "8";
  #   "opcache.max_accelerated_files" = "10000";
  #   "opcache.memory_consumption" = "128";
  #   "opcache.revalidate_freq" = "1";
  #   "openssl.cafile" = "/etc/ssl/certs/ca-certificates.crt";
  #   output_buffering = "0";
  #   short_open_tag = "Off";
  # };
  
  # Options for nextcloud's PHP pool. See the documentation on `php-fpm.conf` for details on configuration directives.
  # services.nextcloud.poolSettings = {
  #   pm = "dynamic";
  #   "pm.max_children" = "32";
  #   "pm.max_requests" = "500";
  #   "pm.max_spare_servers" = "4";
  #   "pm.min_spare_servers" = "2";
  #   "pm.start_servers" = "2";
  # };
  
  # Create the objectstore if it does not exist.
  # Type: boolean
  # services.nextcloud.config.objectstore.s3.autocreate = ;
  
  # Database host or socket path.
  #
  # If [](#opt-services.nextcloud.database.createLocally) is true and
  # [](#opt-services.nextcloud.config.dbtype) is either `pgsql` or `mysql`,
  # defaults to the correct Unix socket instead.
  #
  # services.nextcloud.config.dbhost = "localhost";
  services.nextcloud.config.dbhost = "/run/postgresql";
  
  # Database name.
  # services.nextcloud.config.dbname = "nextcloud";
  # services.nextcloud.config.dbname = "nixserver-service";
  
  # The full path to a file that contains the database password.
  # services.nextcloud.config.dbpassFile = null;
  services.nextcloud.config.dbpassFile = "${toString (pkgs.writeSecret "nextcloud_admin_password")}";
  
  # Database port.
  # services.nextcloud.config.dbport = null;
  
  # Table prefix in Nextcloud's database.
  # services.nextcloud.config.dbtableprefix = null;
  
  # Database type.
  # services.nextcloud.config.dbtype = "sqlite";
  services.nextcloud.config.dbtype = "pgsql";
  
  # Database user.
  # services.nextcloud.config.dbuser = "nextcloud";
  # services.nextcloud.config.dbuser = "nixserver-service";
  
  # An [ISO 3166-1](https://www.iso.org/iso-3166-country-codes.html)
  # country code which replaces automatic phone-number detection
  # without a country code.
  #
  # As an example, with `DE` set as the default phone region,
  # the `+49` prefix can be omitted for phone numbers.
  #
  # services.nextcloud.config.defaultPhoneRegion = null;
  
  # Trusted domains from which the Nextcloud installation will be
  # accessible.  You don't need to add
  # `services.nextcloud.hostname` here.
  #
  # services.nextcloud.config.extraTrustedDomains = [ ];
  
  # The access key for the S3 bucket.
  # Type: string
  # services.nextcloud.config.objectstore.s3.key = "";
  
  # Required for some non-Amazon implementations.
  # services.nextcloud.config.objectstore.s3.region = null;
  
  # Trusted proxies to provide if the Nextcloud installation is being
  # proxied to secure against, e.g. spoofing.
  #
  # services.nextcloud.config.trustedProxies = [ ];
  
  # Whether to configure Nextcloud to use the recommended Redis settings for small instances.
  #
  # ::: {.note}
  # The `notify_push` app requires Redis to be configured. If this option is turned off, this must be configured manually.
  #
  # :::
  # services.nextcloud.configureRedis = config.services.nextcloud.notify_push.enable;
  
  # Whether to create the database and database user locally.
  # services.nextcloud.database.createLocally = false;
  
  # Nextcloud's data storage path.  Will be [](#opt-services.nextcloud.home) by default.
  #
  # This folder will be populated with a config.php file and a data folder which contains the state of the instance (excluding the database).";
  # services.nextcloud.datadir = config.services.nextcloud.home;
  services.nextcloud.datadir = "/nextcloud-files";
  
  # Whether to enable the ImageMagick module for PHP.
  #
  # This is used by the theming app and for generating previews of certain images (e.g. SVG and HEIF).
  #
  # You may want to disable it for increased security. In that case, previews will still be available
  # for some images (e.g. JPEG and PNG).
  #
  # See <https://github.com/nextcloud/server/issues/13099>.
  #
  # .
  #
  # services.nextcloud.enableImagemagick = true;
  
  # Extra apps to install. Should be an attrSet of appid to packages generated by fetchNextcloudApp.
  #
  # The appid must be identical to the "id" value in the apps appinfo/info.xml.
  #
  # Using this will disable the appstore to prevent Nextcloud from updating these apps (see [](#opt-services.nextcloud.appstoreEnable)).
  #
  # services.nextcloud.extraApps = { };
  
  # Automatically enable the apps in [](#opt-services.nextcloud.extraApps) every time Nextcloud starts.
  #
  # If set to false, apps need to be enabled in the Nextcloud web user interface or with `nextcloud-occ app:enable`.
  #
  # services.nextcloud.extraAppsEnable = true;
  
  # Storage path of nextcloud.
  services.nextcloud.home = "/nextcloud-files";
  
  # FQDN for the nextcloud instance.
  # Type: string
  services.nextcloud.hostName = "nextcloud.shayne.ts.net";
  
  # Use HTTPS for generated links.
  # services.nextcloud.https = false;
  
  # The upload limit for files. This changes the relevant options
  # in php.ini and nginx if enabled.
  #
  # services.nextcloud.maxUploadSize = "512M";
  
  # Value for the `max-age` directive of the HTTP
  # `Strict-Transport-Security` header.
  #
  # See section 6.1.1 of IETF RFC 6797 for detailed information on this
  # directive and header.
  #
  # services.nextcloud.nginx.hstsMaxAge = 15552000;
  
  # Enable additional recommended HTTP response headers
  # services.nextcloud.nginx.recommendedHttpHeaders = true;
  
  # Whether to add an entry to `/etc/hosts` for the configured nextcloud domain to point to `localhost` and add `localhost `to nextcloud's `trusted_proxies` config option.
  #
  # This is useful when nextcloud's domain is not a static IP address and when the reverse proxy cannot be bypassed because the backend connection is done via unix socket.
  #
  # services.nextcloud.notify_push.bendDomainToLocalhost = false;
  
  # Database host or socket path.
  #
  # If [](#opt-services.nextcloud.database.createLocally) is true and
  # [](#opt-services.nextcloud.config.dbtype) is either `pgsql` or `mysql`,
  # defaults to the correct Unix socket instead.
  #
  # services.nextcloud.notify_push.dbhost = "config.services.nextcloud.config.dbhost";
  
  # Database name.
  # services.nextcloud.notify_push.dbname = "config.services.nextcloud.config.dbname";
  
  # The full path to a file that contains the database password.
  # services.nextcloud.notify_push.dbpassFile = "config.services.nextcloud.config.dbpassFile";
  
  # Database port.
  # services.nextcloud.notify_push.dbport = "config.services.nextcloud.config.dbport";
  
  # Table prefix in Nextcloud's database.
  # services.nextcloud.notify_push.dbtableprefix = "config.services.nextcloud.config.dbtableprefix";
  
  # Database type.
  # services.nextcloud.notify_push.dbtype = "config.services.nextcloud.config.dbtype";
  
  # Which package to use for the Nextcloud instance.
  # Type: package
  # services.nextcloud.package = null;
  
  # PHP package to use for Nextcloud.
  # services.nextcloud.phpPackage = "pkgs.php";
  
  # Username for the admin account. The username is only set during the
  # initial setup of Nextcloud! Since the username also acts as unique
  # ID internally, it cannot be changed later!
  # services.nextcloud.config.adminuser = "root";
  
  # Required for some non-Amazon implementations.
  # services.nextcloud.config.objectstore.s3.port = null;
  
  # FastCGI timeout for database connection in seconds.
  # services.nextcloud.fastcgiTimeout = 120;
  
  # Logging backend to use.
  #
  # systemd requires the php-systemd package to be added to services.nextcloud.phpExtraExtensions.
  #
  # See the [nextcloud documentation](https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/logging_configuration.html) for details.
  #
  # services.nextcloud.logType = "syslog";
  
  # Options for Nextcloud's PHP pool. See the documentation on `php-fpm.conf` for details on configuration directives.
  # services.nextcloud.poolConfig = null;
  
  # Required for some non-Amazon implementations.
  # services.nextcloud.config.objectstore.s3.hostname = null;
  
  # If provided this is the full path to a file that contains the key
  # to enable [server-side encryption with customer-provided keys][1]
  # (SSE-C).
  #
  # The file must contain a random 32-byte key encoded as a base64
  # string, e.g. generated with the command
  # ```
  # openssl rand 32 | base64
  # ```
  # Must be readable by user `nextcloud`.
  #
  # [1]: https://docs.aws.amazon.com/AmazonS3/latest/userguide/ServerSideEncryptionCustomerKeys.html
  # services.nextcloud.config.objectstore.s3.sseCKeyFile = null;
  
  # Log level value between 0 (DEBUG) and 4 (FATAL).
  #
  # - 0 (debug): Log all activity.
  #
  # - 1 (info): Log activity such as user logins and file activities, plus warnings, errors, and fatal errors.
  #
  # - 2 (warn): Log successful operations, as well as warnings of potential problems, errors and fatal errors.
  #
  # - 3 (error): Log failed operations and fatal errors.
  #
  # - 4 (fatal): Log only fatal errors that cause the server to stop.
  #
  # services.nextcloud.logLevel = 2;
  
  # Socket path to use for notify_push
  # services.nextcloud.notify_push.socketPath = "/run/nextcloud-notify_push/sock";
  
  # The name of the S3 bucket.
  # Type: string
  # services.nextcloud.config.objectstore.s3.bucket = "";
  
  # Which package to use for notify_push
  # services.nextcloud.notify_push.package = pkgs.nextcloud-notify_push;
  
  # Whether to enable S3 object storage as primary storage.
  #
  # This mounts a bucket on an Amazon S3 object storage or compatible
  # implementation into the virtual filesystem.
  #
  # Further details about this feature can be found in the
  # [upstream documentation](https://docs.nextcloud.com/server/22/admin_manual/configuration_files/primary_storage.html).
  #
  # .
  #
  # services.nextcloud.config.objectstore.s3.enable = false;
  
  # Makes user-profiles globally available under `nextcloud.tld/u/user.name`.
  #
  # Even though it's enabled by default in Nextcloud, it must be explicitly enabled
  # here because it has the side-effect that personal information is even accessible to
  # unauthenticated users by default.
  #
  # By default, the following properties are set to “Show to everyone”
  # if this flag is enabled:
  # - About
  # - Full name
  # - Headline
  # - Organisation
  # - Profile picture
  # - Role
  # - Twitter
  # - Website
  # Only has an effect in Nextcloud 23 and later.
  #
  # services.nextcloud.globalProfiles = false;
  
  # Extra options which should be appended to Nextcloud's config.php file.
  # services.nextcloud.extraOptions = { };
  
  # Additional PHP extensions to use for Nextcloud.
  #
  # By default, only extensions necessary for a vanilla Nextcloud installation are enabled,
  # but you may choose from the list of available extensions and add further ones.
  #
  # This is sometimes necessary to be able to install a certain Nextcloud app that has additional requirements.
  #
  # services.nextcloud.phpExtraExtensions = all: [];
  
  # Run a regular auto-update of all apps installed from the Nextcloud app store.
  # services.nextcloud.autoUpdateApps.enable = false;
  
  # When to run the update. See `systemd.services.<name>.startAt`.
  # services.nextcloud.autoUpdateApps.startAt = "05:00:00";
  
  # Whether to load the APCu module into PHP.
  # services.nextcloud.caching.apcu = true;
  
  # Whether to load the Memcached module into PHP.
  #
  # You still need to enable Memcached in your config.php.
  #
  # See https://docs.nextcloud.com/server/14/admin_manual/configuration_server/caching_configuration.html
  # services.nextcloud.caching.memcached = false;
  
  # Allow the installation and updating of apps from the Nextcloud appstore.
  #
  # Enabled by default unless there are packages in [](#opt-services.nextcloud.extraApps).
  #
  # Set this to true to force enable the store even if [](#opt-services.nextcloud.extraApps) is used.
  #
  # Set this to false to disable the installation of apps from the global appstore. App management is always enabled regardless of this setting.
  #
  # services.nextcloud.appstoreEnable = null;
  
  # Whether to load the Redis module into PHP.
  #
  # You still need to enable Redis in your config.php.
  #
  # See https://docs.nextcloud.com/server/14/admin_manual/configuration_server/caching_configuration.html
  # services.nextcloud.caching.redis = false;
  
  # The full path to a file that contains the access secret. Must be
  # readable by user `nextcloud`.
  #
  # Type: string
  # services.nextcloud.config.objectstore.s3.secretFile = "";
  
  # Required for some non-Amazon S3 implementations.
  #
  # Ordinarily, requests will be made with
  # `http://bucket.hostname.domain/`, but with path style
  # enabled requests are made with
  # `http://hostname.domain/bucket` instead.
  #
  # services.nextcloud.config.objectstore.s3.usePathStyle = false;
  
  # Use SSL for objectstore access.
  # services.nextcloud.config.objectstore.s3.useSsl = true;
  
  # Force Nextcloud to always use HTTP or HTTPS i.e. for link generation.
  #
  # Nextcloud uses the currently used protocol by default, but when
  # behind a reverse-proxy, it may use `http` for everything although
  # Nextcloud may be served via HTTPS.
  #
  # services.nextcloud.config.overwriteProtocol = null;
  
  # Database user.
  # services.nextcloud.notify_push.dbuser = "config.services.nextcloud.config.dbuser";
  
  # Whether to enable Notify push.
  # services.nextcloud.notify_push.enable = false;
  
  # Log level
  # services.nextcloud.notify_push.logLevel = "error";

  systemd.services."nixserver-nextcloud-mkdirs" = {
    wantedBy = [ "multi-user.target" ];
    before = [ "nextcloud-setup.service" ];
    path = [ pkgs.coreutils ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      mkdir -p /nextcloud-files/data /nextcloud-files/config /nextcloud-files/store-apps
      chown nixserver-service:nextcloud /nextcloud-files /nextcloud-files/* /nextcloud-files/config/*
      chmod g+w /nextcloud-files /nextcloud-files/* /nextcloud-files/config/*
      chmod -R g+w /nextcloud-files/data/appdata*
      chmod 770 /nextcloud-files/data /nextcloud-files/config
    '';
  };

  systemd.services."nixserver-nextcloud-fixperms" = {
    wantedBy = [ "multi-user.target" ];
    after = [ "phpfpm-nextcloud.service" ];
    path = [ pkgs.coreutils ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      chown nixserver-service:nextcloud /nextcloud-files /nextcloud-files/* /nextcloud-files/config/*
      chown -R nixserver-service:nextcloud /nextcloud-files/data/appdata*
      chmod g+w /nextcloud-files /nextcloud-files/* /nextcloud-files/config/*
      chmod -R g+w /nextcloud-files/data/appdata*
      chmod 770 /nextcloud-files/data /nextcloud-files/config
    '';
  };

  # systemd.services."nextcloud-setup".serviceConfig.User = lib.mkForce "nixserver-service"; 
  systemd.services."nextcloud-setup" = {
    after = [ "postgresql.service" ];
    requires = [ "postgresql.service" ];
    serviceConfig = {
      User = lib.mkForce "nixserver-service";
      Group = lib.mkForce "nextcloud";
    };
  };

  # systemd.services."nextcloud-cron".serviceConfig.User = lib.mkForce "nixserver-service";
  systemd.services."nextcloud-cron".serviceConfig = {
    User = lib.mkForce "nixserver-service";
    Group = lib.mkForce "nextcloud";
  };
  
  # # systemd.services."nextcloud-update-plugins".serviceConfig = {
  # #   User = lib.mkForce "nixserver-service";
  # #   # Group = lib.mkForce "nixserver-service";
  # # };

  # systemd.services."nextcloud-update-db".serviceConfig.User = lib.mkForce "nixserver-service";
  # # systemd.services."nextcloud-update-db".serviceConfig = {
  # #   User = lib.mkForce "nixserver-service";
  # #   # Group = lib.mkForce "nixserver-service";
  # # };

  # services.phpfpm.pools.nextcloud.user = lib.mkForce "nixserver-service";
  # services.phpfpm.pools.nextcloud.group = lib.mkForce "nixserver-service";
  services.phpfpm = {
    pools.nextcloud = {
      user = lib.mkForce "nixserver-service";
      group = lib.mkForce "nextcloud";
      # group = lib.mkForce "nixserver-service";
    };
  };

  users.groups."nextcloud".members = [ "nixserver-service" config.services.nginx.user ];
  # this is a workaround for the nextcloud-occ script which calls 'sudo -u nextcloud'
  users.groups."wheel".members = [ "nixserver-service" ];
  security.sudo.wheelNeedsPassword = false;

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
    # ensureUsers = [{
    #   name = "nixserver";
    #   # ensureDBOwnership = true;
    # }];
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE nextcloud LOGIN;
      CREATE DATABASE nextcloud;
      GRANT ALL PRIVILEGES ON DATABASE nextcloud TO nextcloud;
      \c nextcloud
      GRANT USAGE ON SCHEMA public TO nextcloud;
      GRANT CREATE ON SCHEMA public TO nextcloud;
    '';
  };

  services.tailscale.enable = true;
}