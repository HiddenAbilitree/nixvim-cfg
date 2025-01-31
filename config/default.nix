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
  clipboard.providers.wl-copy.enable = true;
}
