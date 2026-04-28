{ pkgs, ... }:
{
  imports = [
    ./vue_tmp.nix
  ];

  programs.nvf = {
    settings = {
      vim.extraPackages = with pkgs; [
        gotools
      ];

      ## TreeSitter ##
      vim.treesitter = {
        enable = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          php
          go
          templ
          typescript
          javascript
          tsx
          css
          scss
          vue
          lua
          json
          yaml
          toml
          csv
          sql
          nix
        ];

      };

      ## LSP ##
      vim.lsp = {
        enable = true;
        lspconfig.enable = true;
        mappings = {
          renameSymbol = "<leader>rn";
          openDiagnosticFloat = "<leader>e";
          hover = "K";
          codeAction = "<leader>ca";
        };
      };
      vim.languages = {
        nix.enable = true;
        php = {
          enable = true;
          lsp = {
            enable = true;
            servers = [ "intelephense" ];
          };
        };
        go = {
          enable = true;
          lsp = {
            enable = true;
            servers = [ "gopls" ];
          };
        };
        lua = {
          enable = true;
          lsp = {
            enable = true;
            lazydev.enable = true;
            servers = [ "lua-language-server" ];
          };
        };

        html.enable = true;
        markdown.enable = true;
      };

      ## AUTOFORMAT ##

      vim.formatter.conform-nvim = {
        enable = true;
        setupOpts = {
          default_format_opts = {
            lsp_format = "fallback";
          };
          format_on_save = {
            lsp_fallback = true;
            async = false;
            timeout_ms = 2500;
          };
          formatters_by_ft = {
            lua = [ "stylua" ];
            php = [ "phpcbf" ];
            vue = [ "prettier" ];
            html = [ "prettier" ];
            js = [ "prettier" ];
            ts = [ "prettier" ];
            typescript = [ "prettier" ];
            svelte = [ "prettier" ];
            json = [ "fixjson" ];
            go = [ "goimports" ];
            nix = [ "alejandra" ];
          };
        };
      };
    };
  };
}
