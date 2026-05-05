{pkgs, ...}: {
  extraPackages = with pkgs; [
    luau
    luau-lsp
    rojo
    selene
    stylua
    wally
  ];

  plugins.luau-lsp = {
    enable = true;
    settings = {
      platform.type = "roblox";
      types.roblox_security_level = "PluginSecurity";

      sourcemap = {
        enabled = true;
        autogenerate = true;
        include_non_scripts = true;
        rojo_path = "rojo";
        rojo_project_file = "default.project.json";
        sourcemap_file = "sourcemap.json";
      };

      server.path = "luau-lsp";
    };
  };

  extraConfigLuaPre = ''
    do
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
      end

      capabilities = vim.tbl_deep_extend("force", capabilities, {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      })

      vim.lsp.config("*", {
        capabilities = capabilities,
      })
    end
  '';

  filetype = {
    extension = {
      luau = "luau";
      lua.__raw = ''
        function(path)
          if not path or path == "" then
            return "lua"
          end

          if path:match("%.nvim%.lua$") then
            return "lua"
          end

          if path:match("%.server%.lua$") or path:match("%.client%.lua$") then
            return "luau"
          end

          local dirname = vim.fs.dirname(path)
          if dirname
            and vim.fs.root(dirname, function(name)
              return name:match(".+%.project%.json$") ~= nil
            end)
          then
            return "luau"
          end

          return "lua"
        end
      '';
    };
    filename.".luaurc" = "json";
  };
}
