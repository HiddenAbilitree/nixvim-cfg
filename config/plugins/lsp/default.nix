{lib, ...}: {
  plugins.lsp = {
    enable = true;
    luaConfig.post = builtins.readFile ./lsp.lua;

    servers = {
      astro.enable = true;
      bashls.enable = true;
      clangd.enable = true;
      cssls = {
        enable = true;
        settings = {
          css = {
            validate = true;
            lint.unknownAtRules = "ignore";
          };
        };
      };
      eslint.enable = true;
      gopls.enable = true;
      hyprls = {
        enable = true;
        filetypes = ["conf"];
      };
      jdtls.enable = true;
      jsonls = {
        enable = true;
        settings.json = {
          schemas = [
            {
              name = "Rojo project";
              description = "JSON schema for Rojo *.project.json files";
              fileMatch = ["*.project.json"];
              url = "https://raw.githubusercontent.com/rojo-rbx/vscode-rojo/master/schemas/project.template.schema.json";
            }
          ];
          validate.enable = true;
        };
      };
      # ltex.enable = true;
      lua_ls.enable = true;
      nixd = {
        enable = true;
        settings.formatting.command = ["alejandra"];
      };
      nushell.enable = true;
      oxlint.enable = true;
      pylsp = {
        enable = true;
        rootMarkers = [
          "pyproject.toml"
          "uv.lock"
          "setup.py"
          "setup.cfg"
          "requirements.txt"
          "Pipfile"
          ".git"
        ];
        settings.plugins = {
          black.enabled = true;
          ruff.enabled = true;
          pylint.enabled = true;
        };
        extraOptions.before_init = lib.nixvim.mkRaw "_G.__nixvim_python_lsp_before_init";
      };
      pyright = {
        enable = true;
        rootMarkers = [
          "pyrightconfig.json"
          "pyproject.toml"
          "uv.lock"
          "setup.py"
          "setup.cfg"
          "requirements.txt"
          "Pipfile"
          ".git"
        ];
        extraOptions.before_init = lib.nixvim.mkRaw "_G.__nixvim_python_lsp_before_init";
      };
      ruff.enable = true;
      rust_analyzer = {
        enable = true;
        settings.check.command = "clippy";
        installRustc = false;
        installCargo = false;
      };
      tailwindcss.enable = true;
      taplo.enable = true;
      tinymist.enable = true;
      ts_ls.enable = true;
    };
  };
}
