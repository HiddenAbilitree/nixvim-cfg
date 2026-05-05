{
  plugins.none-ls = {
    enable = true;
    sources.diagnostics.selene = {
      enable = true;
      settings.condition.__raw = ''
        function(utils)
          return utils.root_has_file("selene.toml")
        end
      '';
    };
    sources.formatting.shfmt.enable = true;
    sources.formatting.stylua.enable = true;
  };
}
