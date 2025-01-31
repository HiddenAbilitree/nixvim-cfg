{
  imports = [
    ./plugins
    ./keymaps
    ./opts
    ./theme.nix
  ];
  enableMan = true;
  viAlias = true;
  vimAlias = true;
  globals.mapleader = " ";
  extraConfigLuaPre =
    # lua
    ''
      vim.keymap.del("n", "\'")
    '';
  clipboard.providers.wl-copy.enable = true;
}
