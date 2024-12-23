{pkgs, ...}: {
  plugins.luasnip = {
    enable = true;
    fromLua = [{paths = ./snippets/latex.lua;}];
    settings = {enable_autosnippets = true;};
  };
  extraPlugins = [pkgs.vimPlugins.friendly-snippets];
}
