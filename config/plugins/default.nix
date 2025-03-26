{
  imports = [
    ./cmp
    ./image
    ./lazygit
    ./lsp
    ./luasnip
    ./mini
    ./noice
    ./oil
    ./telescope
    ./toggleterm
    ./treesitter
    ./vimtex
  ];
  plugins = {
    web-devicons.enable = true;

    lsp-format.enable = true;

    tailwind-tools = {
      enable = true;
      settings.server.override = false;
    };

    ts-autotag.enable = true;

    ts-comments.enable = true;

    treesitter-context.enable = true;

    typst-preview.enable = true;

    vim-css-color.enable = true;

    which-key.enable = true;

    project-nvim.enable = true;
  };
}
