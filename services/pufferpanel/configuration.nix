{ pkgs, lib, ... }:
{
  services.pufferpanel = {
    enable = true;
    extraPackages = with pkgs; [ bash curl gawk gnutar gzip ];
    package = pkgs.buildFHSEnv {
      name = "pufferpanel-fhs";
      runScript = lib.getExe pkgs.pufferpanel;
      targetPkgs = pkgs': with pkgs'; [ icu openssl zlib ];
    };
  };

  systemd.services."pufferpanel".serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "nixserver-service";
    Group = "nixserver-service";
  };

  services.tailscale.enable = true;
}

