{
  sops,
  gemini-api-key,
  ...
}: {
  plugins.codecompanion = {
    enable = true;
    settings = {
      strategies = {
        chat.adapter = "gemini";
        inline.adapter = "gemini";
      };
      adapters = {
        gemini.__raw =
          # lua
          ''
            return require("codecompanion.adapters").extend("gemini", {
              schema = {
                model = {
                  default = "gemini-2.0-flash-exp",
                },
              },
              env = {
                api_key = "cmd:cat ${gemini-api-key}",
              },
            })
          '';
      };
    };
  };
}
