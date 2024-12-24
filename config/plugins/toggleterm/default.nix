{
  plugins.toggleterm = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings.cmd = "ToggleTerm";
    };
    settings = {
      direction = "float";
      float_opts = {
        border = "curved";
      };
    };
  };
}
