{
  plugins.cmp = {
    enable = true;

    lazyLoad = true;
    autoEnableSources = true;
    settings = {
      mapping = {
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = ''
          function(fallback)
            local luasnip = require('luasnip')
            local supermaven = require('supermaven-nvim.completion_preview')
            if supermaven.has_suggestion() then
              supermaven.on_accept_suggestion()
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end
        '';
      };
      sources = [
        {name = "nvim_lsp";}
        {name = "latex-symbols";}
        {name = "path";}
        {name = "buffer";}
        {name = "treesitter";}
        {name = "luasnip";}
      ];
    };
  };
}
