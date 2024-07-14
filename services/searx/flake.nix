{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    secrets.url = "github:nixserver-io/secrets-placeholder";
    nixserver.url = "https://releases.nixserver.io/latest/nixosModules";
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
        servicePath = ./.;
      };
    };
  };
}
