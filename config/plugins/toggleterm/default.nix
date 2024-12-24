{
  plugins.toggleterm = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.cmd = "ToggleTerm";
    };
    settings = {
      autochdir = true;
      direction = "float";
      float_opts = {
        border = "curved";
      };
    };
  };
}
