{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    supermaven-nvim
  ];
  extraConfigLua = ''
    require("supermaven-nvim").setup({});
  '';
}
