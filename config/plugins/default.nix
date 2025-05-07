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
    lsp-format.enable = true;

    nvim-surround.enable = true;

    project-nvim.enable = true;

    tailwind-tools = {
      enable = true;
      settings.server.override = false;
    };

    transparent = {
      enable = true;
      autoLoad = true;
      settings.extra_groups = [
        "NormalFloat"
        "BufferLineTabClose"
        "BufferlineBufferSelected"
        "BufferLineFill"
        "BufferLineBackground"
        "BufferLineSeparator"
        "BufferLineIndicatorSelected"

        "IndentBlanklineChar"

        "LspFloatWinNormal"
        "Normal"
        "NormalFloat"
        "FloatBorder"
        "TelescopeNormal"
        "TelescopeBorder"
        "TelescopePromptBorder"
        "TelescopePromptTitle"
        "SagaBorder"
        "SagaNormal"
        "WhichKeyNormal"
      ];
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
