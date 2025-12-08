{
  description = "nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixvim,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvimLib = nixvim.lib.${pkgs.stdenv.hostPlatform.system};
        systemNixvim = nixvim.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        nixvimModule = {
          inherit pkgs;
          module = import ./config;
        };
        nvim = systemNixvim.makeNixvimWithModule nixvimModule;
      in {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        checks.default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        formatter = pkgs.alejandra;
        packages.default = nvim;
      };
    };
}
