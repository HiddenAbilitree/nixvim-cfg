{
  imports = [
    ./cmp
    ./image
    ./lazygit
    ./lsp
    ./mini
    ./noice
    ./oil
    ./telescope
    ./toggleterm
    ./treesitter
    ./vimtex
  ];
  plugins = {
    java.enable = true;

    lsp-format.enable = true;

    project-nvim.enable = true;

    tailwind-tools = {
      enable = true;
      settings.server.override = false;
    };

    treesitter-context.enable = true;

    ts-autotag.enable = true;

    ts-comments.enable = true;

    typst-preview.enable = true;

    vim-css-color.enable = true;

    web-devicons.enable = true;

    which-key.enable = true;
  };
}
