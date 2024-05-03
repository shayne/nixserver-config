{ pkgs, ... }: {

  environment.systemPackages = [
    pkgs.python
  ];
  
}