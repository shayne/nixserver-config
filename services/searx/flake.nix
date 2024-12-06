{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    secrets.url = "github:nixserver-io/secrets-placeholder";
    nixserver.url = "https://releases.nixserver.io/latest/nixosModules";
    nixserver.inputs.nixos-unstable.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixserver, secrets, ... }@inputs: {
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
