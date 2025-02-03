{
  description = "nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    private.url = "git+ssh://git@github.com/HiddenAbilitree/private-nixos-cfg.git?ref=main";
  };

  outputs = {
    nixvim,
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
        nixvimLib = nixvim.lib.${system};
        systemNixvim = nixvim.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = import ./config;
          extraSpecialArgs = {
            gemini-api-key = inputs.private.nixosModules.sops.secrets.gemini-api-key.path;
          };
        };
        nvim = systemNixvim.makeNixvimWithModule nixvimModule;
      in {
        checks.default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        formatter = pkgs.alejandra;
        packages.default = nvim;
      };
    };
}
