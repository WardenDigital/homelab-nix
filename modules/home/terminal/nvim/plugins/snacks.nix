{ ... }:
{
  programs.nvf = {
    settings = {
      vim.keymaps = [
        {
          key = "<leader>fp";
          mode = "n";
          silent = true;
          lua = true;
          action = ''function() require("snacks").picker() end'';

        }
        {
          key = "<leader>ff";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").picker.files'';

        }
        {
          key = "<leader>sg";
          mode = "n";
          silent = true;
          lua = true;
          action = ''function() require("snacks").picker.grep({regex = false}) end'';

        }
        {
          key = "<leader>sr";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").picker.grep'';

        }
        {
          key = "<leader>sw";
          mode = [
            "n"
            "v"
          ];
          silent = true;
          lua = true;
          action = ''require("snacks").picker.grep_word'';

        }
        {
          key = "<leader>sb";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").picker.grep_buffers'';

        }
        {
          key = "<leader>sd";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").picker.diagnostics'';

        }
        {
          key = "<leader>fb";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").picker.buffers'';

        }
        {
          key = "<leader>fh";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").picker.help'';

        }
        {
          key = "<leader>don";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").dim.enable'';

        }
        {
          key = "<leader>dof";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").dim.disable'';

        }
        {
          key = "<leader>gs";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").lazygit.open'';

        }
        {
          key = "ex";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks").explorer.open'';

        }
        {
          key = "<leader>dn";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks.notifier").hide'';

        }
        {
          key = "<leader>i";
          mode = "n";
          silent = true;
          lua = true;
          action = ''
                function()
                        local indent = require("snacks.indent")
                        if indent.enabled then
            		        indent.disable()
            	        else
            		        indent.enable()
                        end
                end
          '';
        }
        {
          key = "gd";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks.picker").lsp_definitions'';
        }
        {
          key = "gr";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks.picker").lsp_references'';
        }
        {
          key = "gi";
          mode = "n";
          silent = true;
          lua = true;
          action = ''require("snacks.picker").lsp_implementations'';
        }

      ];
      vim.utility = {
        snacks-nvim = {
          enable = true;
          setupOpts = {
            indent = {
              enabled = false;
              indent = {
                only_scope = true;
              };
            };
            notifier = {
              enable = true;
            };
            picker = {
              matcher = {
                fuzzy = true;
                smartcase = true;
                ignorecase = true;
                sort_empty = false;
                filename_bonus = true;
                file_pos = true;
                cwd_bonus = false;
                frecency = false;
                history_bonus = false;
              };
              sources = {
                explorer = {
                  layout = {
                    layout = {
                      position = "right";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
