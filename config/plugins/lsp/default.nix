{
  lib,
  pkgs,
  ...
}: {
  plugins.lsp = {
    enable = true;
    luaConfig.post = builtins.readFile ./lsp.lua;

    servers = {
      astro.enable = true;
      clangd.enable = true;
      ltex.enable = true;
      nixd = {
        enable = true;
        settings.formatting.command = ["alejandra"];
      };
      hyprls = {
        enable = true;
        filetypes = ["conf"];
      };
      eslint.enable = true;
      jsonls.enable = true;
      cssls.enable = true;
      bashls.enable = true;
      ts_ls.enable = true;
      tailwindcss = {
        enable = true;
        package = pkgs.stdenv.mkDerivation (finalAttrs: {
          pname = "tailwindcss-language-server";
          version = "0.14.3";

          src = pkgs.fetchFromGitHub {
            owner = "tailwindlabs";
            repo = "tailwindcss-intellisense";
            rev = "v0.14.3";
            hash = "sha256-mZVHWirvJvcqeEKOp3NBOuWwEvJwKmh+0U2dbHKrI4U=";
          };

          pnpmDeps = pkgs.pnpm_9.fetchDeps {
            inherit
              (finalAttrs)
              pname
              version
              src
              pnpmWorkspaces
              prePnpmInstall
              ;
            hash = "sha256-jqiYwAQUK4wzZMCbMULUpY8kQFEu3lz3VzEtuYANaVE=";
          };

          nativeBuildInputs = [
            pkgs.nodejs_23
            pkgs.pnpm_9.configHook
          ];

          buildInputs = [
            pkgs.nodejs_23
          ];

          pnpmWorkspaces = ["@tailwindcss/language-server..."];
          prePnpmInstall = ''
            # Warning section for "pnpm@v8"
            # https://pnpm.io/cli/install#--filter-package_selector
            pnpm config set dedupe-peer-dependents false
            export NODE_EXTRA_CA_CERTS="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
          '';

          buildPhase = ''
            runHook preBuild

            # Must build the "@tailwindcss/language-service" package. Dependency is linked via workspace by "pnpm"
            # (https://github.com/tailwindlabs/tailwindcss-intellisense/blob/%40tailwindcss/language-server%40v0.0.27/pnpm-lock.yaml#L47)
            pnpm --filter "@tailwindcss/language-server..." build

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            mkdir -p $out/{bin,lib/tailwindcss-language-server}
            cp -r {packages,node_modules} $out/lib/tailwindcss-language-server
            chmod +x $out/lib/tailwindcss-language-server/packages/tailwindcss-language-server/bin/tailwindcss-language-server
            ln -s $out/lib/tailwindcss-language-server/packages/tailwindcss-language-server/bin/tailwindcss-language-server $out/bin/tailwindcss-language-server

            runHook postInstall
          '';

          meta = with lib; {
            description = "Tailwind CSS Language Server";
            homepage = "https://github.com/tailwindlabs/tailwindcss-intellisense";
            license = licenses.mit;
            maintainers = with maintainers; [happysalada];
            mainProgram = "tailwindcss-language-server";
            platforms = platforms.all;
          };
        });
      };

      rust_analyzer = {
        enable = true;
        # package = pkgs.rust-analyzer;
        settings.check.command = "clippy";
        installRustc = false;
        installCargo = false;
      };
      ruff.enable = true;
      lua_ls.enable = true;
    };
  };
}
