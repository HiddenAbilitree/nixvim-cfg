{
  keymaps = [
    # general mappings
    {
      key = "K";
      action = "<cmd>lua vim.lsp.buf.hover()<cr>";
      options.noremap = true;
    }
    {
      key = "<leader>cd";
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      options.noremap = true;
    }
    {
      key = "<leader>lr";
      action = "<cmd> lua vim.lsp.buf.rename()<cr>";
      options.noremap = true;
    }
    {
      key = "<C-h>";
      action = "b";
      options.noremap = true;
    }
    {
      key = "<C-l>";
      action = "w";
      options.noremap = true;
    }
    {
      key = "<C-k>";
      action = "<C-u>";
      options.noremap = true;
    }
    {
      key = "<C-j>";
      action = "<C-d>";
      options.noremap = true;
    }
    {
      key = "'<,'>w";
      action = "<cmd>wl-copy<cr>";
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
    # this join bind is so bad
    {
      key = "J";
      action = "<Nop>";
      options.noremap = true;
    }

    # true bis bindings
    {
      key = ";";
      action = ":";
      options.noremap = true;
    }
    {
      key = "<leader>h";
      action = ":";
      options = {
        noremap = true;
        nowait = true;
      };
    }
    # oil.nvim
    {
      key = "\'";
      action = "<cmd>Oil<Cr>";
      options = {
        noremap = true;
        nowait = true;
      };
    }
    {
      key = "b";
      action = "<cmd>Oil<Cr>";
      options = {
        noremap = true;
        nowait = true;
      };
    }

    # lazygit.nvim
    {
      key = "<leader>g";
      action = "<cmd>LazyGit<cr>";
    }

    # telescope.nvim
    {
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
    }
    {
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
    }
    {
      key = "<leader>fc";
      action = "<cmd>Telescope buffers<cr>";
    }
    {
      key = "<leader>fd";
      action = "<cmd>Telescope lsp_workspace_symbols<cr>";
    }

    # toggleterm.nvim
    {
      key = "<leader>t";
      action = "<cmd>ToggleTerm<cr>";
    }
  ];
}
