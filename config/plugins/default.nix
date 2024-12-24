{
  imports = [
    ./cmp
    ./lazygit
    ./lsp
    ./lz-n
    ./luasnip
    ./none-ls
    ./mini
    ./oil
    ./telescope
    ./toggleterm
    ./treesitter
    ./vimtex
    ./supermaven
  ];
  plugins = {
    cmp-latex-symbols = {
      enable = true;
    };

    web-devicons = {
      enable = true;
    };

    lsp-format = {
      enable = true;
    };

    ts-autotag = {
      enable = true;
    };

    ts-comments = {
      enable = true;
    };

    treesitter-context = {
      enable = true;
    };

    vim-css-color = {
      enable = true;
    };

    project-nvim = {
      enable = true;
    };
  };
}
