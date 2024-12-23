{
  opts = {
    backspace.__raw = ''
      vim.list_extend(vim.opt.backspace:get(), { "nostop" })
    '';

    cmdheight = 0;
    completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];
    confirm = true;

    breakindent = true;
    copyindent = true;
    shiftwidth = 2;
    showtabline = 2;
    softtabstop = 2;
    tabstop = 2;

    cursorline = true;
    diffopt.__raw = ''
      vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
    '';
    expandtab = true;
    fillchars = {
      eob = " ";
    };
    foldcolumn = "1";
    foldenable = true;
    foldlevel = 99;
    foldlevelstart = 99;
    ignorecase = true;
    inccommand = "split";
    infercase = true;

    laststatus = 3;
    linebreak = true;
    list = true;
    listchars = "tab:‒▶,trail:·,multispace:·,lead: ,nbsp:⎕";
    mouse = "a";
    number = true;
    preserveindent = true;
    pumheight = 10;
    relativenumber = true;

    shortmess.__raw = ''
      vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true })
    '';
    showmode = false;

    signcolumn = "yes";
    smartcase = true;

    splitbelow = true;
    splitright = true;

    termguicolors = true;
    timeoutlen = 500;
    title = true;
    undofile = true;
    viewoptions.__raw = ''
      vim.tbl_filter(function(val) return val ~= "curdir" end, vim.opt.viewoptions:get())
    '';
    virtualedit = "block";
    wrap = false;
    writebackup = false;
  };
}
