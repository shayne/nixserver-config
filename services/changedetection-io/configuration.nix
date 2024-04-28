{
  # Enable the changedetection-io service
  services.changedetection-io.enable = true;
  
  # The base url used in notifications and `{base_url}` token.
  # services.changedetection-io.baseURL = null;
  
  # Enable this option when changedetection-io runs behind a reverse proxy, so that it trusts X-* headers.
  #
  # It is recommend to run changedetection-io behind a TLS reverse proxy.
  #
  # services.changedetection-io.behindProxy = false;
  
  # A free port on which webDriverSupport or playwrightSupport listen on localhost.
  # services.changedetection-io.chromePort = 4444;
  
  # The directory used to store all data for changedetection-io.
  services.changedetection-io.datastorePath = "/var/lib/changedetection-io";
  
  # Securely pass environment variabels to changedetection-io.
  #
  # This can be used to set for example a frontend password reproducible via `SALTED_PASS`
  # which convinetly also deactivates nags about the hosted version.
  #
  # `SALTED_PASS` should be 64 characters long while the first 32 are the salt and the second the frontend password.
  #
  # It can easily be retrieved from the settings file when first set via the frontend with the following command:
  # ``jq -r .settings.application.password /var/lib/changedetection-io/url-watches.json``
  # services.changedetection-io.environmentFile = null;
  
  # Address the server will listen on.
  # services.changedetection-io.listenAddress = "localhost";
  
  # Enable support for fetching web pages using playwright and Chromium.
  #
  # This starts a headless Chromium controlled by puppeteer in an oci container.
  #
  # ::: {.note}
  # Playwright can currently leak memory.
  #
  # See https://github.com/dgtlmoon/changedetection.io/wiki/Playwright-content-fetcher#playwright-memory-leak
  # :::
  # services.changedetection-io.playwrightSupport = false;
  
  # Port the server will listen on.
  services.changedetection-io.port = 5000;
  
  # Enable support for fetching web pages using WebDriver and Chromium.
  #
  # This starts a headless chromium controlled by puppeteer in an oci container.
  #
  # ::: {.note}
  # Playwright can currently leak memory.
  #
  # See https://github.com/dgtlmoon/changedetection.io/wiki/Playwright-content-fetcher#playwright-memory-leak
  # :::
  # services.changedetection-io.webDriverSupport = false;
  
  # User account under which changedetection-io runs.
  services.changedetection-io.user = "nixserver-service";
  
  # Group account under which changedetection-io runs.
  services.changedetection-io.group = "nixserver-service";
}