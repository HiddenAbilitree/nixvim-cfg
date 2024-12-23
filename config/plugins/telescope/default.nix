{
  plugins.telescope = {
    enable = true;
    settings.pickers.find_files.hidden = true;
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
      };
      "<leader>fg" = {
        action = "live_grep";
      };
      "<leader>fb" = {
        action = "buffers";
      };
      "<leader>fd" = {
        action = "lsp_workspace_symbols";
      };
    };
  };
}
