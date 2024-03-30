{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixserver.url = "https://releases.nixserver.io/latest/nixosModules";
    secrets.url = "path:/home/shayne/nixserver-config/secrets";
  };

  outputs = { self, nixpkgs, nixserver, secrets }: {
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        nixserver.nixosModules.docker
        ./configuration.nix
      ];
      specialArgs = {
        inherit nixserver secrets;
        containerPath = ./.;
      };
    };
  };
}
