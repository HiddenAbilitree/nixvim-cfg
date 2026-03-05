{
  plugins.image = {
    enable = false;

    settings = {
      hijack_file_patterns = ["*.png" "*.jpg" "*.jpeg" "*.gif" "*.webp" "*.ico"];
      backend = "kitty";
    };
  };
}
