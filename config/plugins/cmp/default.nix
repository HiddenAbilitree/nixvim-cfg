{
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings.sources = [
      {name = "nvim_lsp";}
      {name = "latex-symbols";}
      {name = "path";}
      {name = "buffer";}
      {name = "treesitter";}
      {name = "luasnip";}
    ];
  };
}
