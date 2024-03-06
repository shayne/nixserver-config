{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixserver.url = "https://releases.nixserver.io/latest/nixosModules";
  };

  outputs = { self, nixpkgs, nixserver }: {
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixserver.nixosModules.docker
        ./configuration.nix
      ];
      specialArgs = {
        inherit nixserver;
        containerPath = ./.;
      };
    };
  };
}
