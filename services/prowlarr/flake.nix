{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixserver.url = "https://releases.nixserver.io/latest/nixosModules";
  };

  outputs = { self, nixpkgs, nixserver }: {
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        nixserver.nixosModules.docker
        ./configuration.nix
      ];
      specialArgs = {
        inherit nixserver;
        servicePath = ./.;
      };
    };
  };
}
