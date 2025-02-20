{
  plugins.cmp = {
    enable = true;
    settings = {
      sources = [
        {name = "ai";}
        {name = "nvim_lsp";}
        {name = "latex-symbols";}
        {name = "path";}
        {name = "buffer";}
        {name = "treesitter";}
        {name = "luasnip";}
      ];
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };
  };
}
