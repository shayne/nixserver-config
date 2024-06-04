{ lib, ... }: {
  # Enable the tandoor-recipes service
  services.tandoor-recipes.enable = true;
  
  # Web interface address.
  # services.tandoor-recipes.address = "localhost";
  
  # The Tandoor Recipes package to use.
  # services.tandoor-recipes.package = pkgs.tandoor-recipes;
  
  # Web interface port.
  services.tandoor-recipes.port = 8080;
  
  # Extra tandoor recipes config options.
  #
  # See [the example dot-env file](https://raw.githubusercontent.com/vabene1111/recipes/master/.env.template)
  # for available options.
  #
  # services.tandoor-recipes.extraConfig = { };

  systemd.services."tandoor-recipes".serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "nixserver-service";
    Group = "nixserver-service";
  };
}