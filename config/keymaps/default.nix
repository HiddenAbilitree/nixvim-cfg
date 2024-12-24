{
  keymaps = [
    {
      key = "<C-j>";
      action = "w";
      options.noremap = true;
    }
    {
      key = "<C-;>";
      action = "b";
      options.noremap = true;
    }
    {
      key = "\'";
      action = "\\";
      options.remap = true;
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
    # {
    #   key = ":";
    #   action = ":";
    # }
    {
      key = "\\";
      action = "<cmd>Oil<Cr>";
    }
    {
      key = "<leader>lg";
      action = "<cmd>LazyGit<cr>";
    }
  ];
}
