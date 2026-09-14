{ pkgs, ... }:
{
  extraPackages = [ pkgs.unixtools.ps ];

  plugins.cloak = {
    enable = true;
    settings.patterns = [
      {
        file_pattern = [
          ".env*"
          "*.env"
        ];
        cloak_pattern = [
          "^(%s*export%s+[%w_]+%s*=).*"
          "^(%s*[%w_]+%s*=).*"
          "^(%s*).*"
        ];
        replace = "%1";
      }
      {
        file_pattern.__raw = ''
          (function()
            local patterns = { "secrets*.yaml", "secrets*.yml", "*.sops.yaml", "*.sops.yml" }
            local parent = vim.api.nvim_get_proc(vim.uv.os_getppid())
            if parent and parent.name == "sops" then
              vim.list_extend(patterns, { "*.yaml", "*.yml" })
            end
            return patterns
          end)()
        '';
        cloak_pattern = [
          "^(%s*[%w_./-]+:%s*).*"
          "^(%s*).*"
        ];
        replace = "%1";
      }
    ];
  };
}
