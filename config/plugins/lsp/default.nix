{
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
        autostart = true;
        filetypes = ["conf"];
      };
      eslint.enable = true;
      jsonls.enable = true;
      cssls.enable = true;
      bashls.enable = true;
      ts_ls.enable = true;
      tailwindcss = {
        enable = true;
        rootDir = ''
          function() return require("lspconfig").util.root_pattern("package.json") end
        '';
      };

      rust_analyzer = {
        enable = true;
        # package = pkgs.rust-analyzer;
        settings.check.command = "clippy";
        installRustc = false;
        installCargo = false;
      };
      pyright.enable = true;
      lua_ls.enable = true;
    };
  };
}
