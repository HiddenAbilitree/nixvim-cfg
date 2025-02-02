{
  imports = [
    ./cmp
    ./codecompanion
    ./image
    ./lazygit
    ./lsp
    ./luasnip
    ./mini
    ./noice
    ./none-ls
    ./nui
    ./oil
    ./telescope
    ./toggleterm
    ./treesitter
    ./vimtex
  ];
  plugins = {
    cmp-latex-symbols.enable = true;

    web-devicons.enable = true;

    lsp-format.enable = true;

    tailwind-tools.enable = true;

    ts-autotag.enable = true;

    ts-comments.enable = true;

    treesitter-context.enable = true;

    vim-css-color.enable = true;

    which-key.enable = true;

    project-nvim.enable = true;
  };
}
