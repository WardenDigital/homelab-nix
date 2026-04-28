{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
in
{

  programs.nvf = {
    settings = {
      vim.keymaps = [
        {
          key = "-";
          mode = "n";
          silent = true;
          lua = true;
          action = ''
            function()
              require("mini.files").open(vim.api.nvim_buf_get_name(0))
            end
          '';
        }
        {
          key = "<leader>m";
          mode = "n";
          silent = true;
          lua = true;
          action = ''
            function()
              require("mini.map").toggle()
            end
          '';
        }

      ];
      vim.mini = {
        ai.enable = true;
        pairs.enable = true;
        surround.enable = true;
        comment.enable = true;
        map = {
          enable = true;
          setupOpts = {
            integrations = [
              (lua ''require("mini.map").gen_integration.builtin_search()'')
              (lua ''require("mini.map").gen_integration.diff()'')
              (lua ''require("mini.map").gen_integration.diagnostic()'')
            ];
            symbols = {
              encode = (lua ''require("mini.map").gen_encode_symbols.dot("3x2")'');
            };
            window = {
              width = 20;
              winblend = 0;
            };
          };
        };

        files = {
          enable = true;

          setupOpts = {
            content = {
              filter = null;
              prefix = null;
              sort = null;
            };

            mappings = {
              close = "q";
              go_in = "l";
              go_in_plus = "L";
              go_out = "h";
              go_out_plus = "H";
              reset = "<BS>";
              reveal_cwd = "@";
              show_help = "g?";
              synchronize = "<CR>";
              trim_left = "<";
              trim_right = ">";
            };

            options = {
              permanent_delete = true;
              use_as_default_explorer = true;
            };

            windows = {
              max_number = 9999999999;
              preview = false;
              width_focus = 50;
              width_nofocus = 15;
              width_preview = 25;
            };
          };
        };
      };
    };
  };
}
