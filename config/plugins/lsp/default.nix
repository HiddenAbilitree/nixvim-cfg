{pkgs, ...}: {
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
      eslint = {
        enable = true;
        package = pkgs.eslint_d;
      };
      hyprls = {
        enable = true;
        filetypes = ["conf"];
      };
      jdtls.enable = true;
      jsonls.enable = true;
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
        settings.plugins = {
          ruff.enabled = true;
          pylint.enabled = true;
        };
      };
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
