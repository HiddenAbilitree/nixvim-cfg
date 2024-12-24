{
  plugins.lsp = {
    enable = true;
    servers = {
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
      bashls.enable = true;
      ts_ls.enable = true;
      tailwindcss.enable = true;

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
