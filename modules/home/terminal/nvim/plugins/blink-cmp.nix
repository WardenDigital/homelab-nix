{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
in
{
  programs.nvf = {
    settings = {
      vim.autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          keymap = {
            preset = "default";
          };

          appearance = {
            nerd_font_variant = "code";
          };
          completion = {
            menu = {
              border = "single";
              draw = {
                components = {
                  kind_icon = {
                    text = (lua "function(ctx) return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' ' end");
                  };
                };
              };
            };
            documentation = {
              auto_show = true;
            };
          };

          cmdline = {
            keymap = {
              "<Tab>" = [
                "show"
                "accept"
              ];
            };
            completion = {
              menu = {
                auto_show = true;
              };
            };
          };
          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];
          };

          fuzzy = {
            implementation = "prefer_rust_with_warning";
          };
        };
      };
    };
  };
}
