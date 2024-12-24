{
  keymaps = [
    # general mappings
    {
      key = "<C-j>";
      action = "b";
      options.noremap = true;
    }
    {
      key = "<C-;>";
      action = "w";
      options.noremap = true;
    }
    {
      key = "<S-k>";
      action = "<C-d>";
      options.noremap = true;
    }
    {
      key = "<S-l>";
      action = "<C-u>";
      options.noremap = true;
    }

    # unbind arrow keys
    {
      key = "<Up>";
      action = "<Nop>";
      options.noremap = true;
    }
    {
      key = "<Left>";
      action = "<Nop>";
      options.noremap = true;
    }
    {
      key = "<Down>";
      action = "<Nop>";
      options.noremap = true;
    }
    {
      key = "<Right>";
      action = "<Nop>";
      options.noremap = true;
    }

    # true bis bindings
    {
      key = "h";
      action = ":";
      options.noremap = true;
    }
    {
      key = "j";
      action = "h";
      options.noremap = true;
    }
    {
      key = "k";
      action = "j";
      options.noremap = true;
    }
    {
      key = "l";
      action = "k";
      options.noremap = true;
    }
    {
      key = ";";
      action = "l";
      options.noremap = true;
    }

    # oil.nvim
    {
      key = "\'";
      action = "<cmd>Oil<Cr>";
    }

    # lazygit.nvim
    {
      key = "<leader>g";
      action = "<cmd>LazyGit<cr>";
    }

    # telescope.nvim
    {
      key = "<leader>ff";
      action = "find_files";
    }
    {
      key = "<leader>fg";
      action = "live_grep";
    }
    {
      key = "<leader>fc";
      action = "buffers";
    }
    {
      key = "<leader>fd";
      action = "lsp_workspace_symbols";
    }

    # toggleterm.nvim
    {
      key = "<leader>t";
      action = "<cmd>ToggleTerm<cr>";
    }

    # cmp.nvim
    {
      key = "<C-b>";
      action = "cmp.mapping.scroll_docs(-4)";
    }
    {
      key = "<C-f>";
      action = "cmp.mapping.scroll_docs(4)";
    }
    {
      key = "<C-Space>";
      action = "cmp.mapping.complete()";
    }
    {
      key = "<C-e>";
      action = "cmp.mapping.abort()";
    }
    {
      key = "<CR>";
      action = "cmp.mapping.confirm({ select = true })";
    }

    # cmp.nvim/supermaven.nvim
    {
      key = "<Tab>";
      action = ''
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
    }
  ];
}
