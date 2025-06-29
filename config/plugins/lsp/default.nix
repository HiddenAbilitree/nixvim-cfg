{
  plugins.lsp = {
    enable = true;
    luaConfig.post = builtins.readFile ./lsp.lua;

    servers = {
      astro.enable = true;
      bashls.enable = true;
      clangd.enable = true;
      cssls.enable = true;
      eslint.enable = true;
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
      tinymist.enable = true;
      ts_ls.enable = true;
    };
  };
}
