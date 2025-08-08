{pkgs, ...}: {
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
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "ts-error-translator.";
      src = pkgs.fetchFromGitHub {
        owner = "dmmulroy";
        repo = "ts-error-translator.nvim";
        rev = "47e5ba89f71b9e6c72eaaaaa519dd59bd6897df4";
        hash = "sha256-fi68jJVNTL2WlTehcl5Q8tijAeu2usjIsWXjcuixkCM=";
      };
    })
  ];
  plugins = {
    lsp-format = {
      enable = true;
      lspServersToEnable = [
        "nixd"
        "lua_ls"
        "clangd"
        "eslint"
        "tailwindcss"
        "tinymist"
        "hyprls"
        "jdtls"
        "rust_analyzer"
        "oxlint"
        "cssls"
        "nushell"
      ];
    };

    nvim-surround.enable = true;

    project-nvim.enable = true;

    # rustaceanvim.enable = true;

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
