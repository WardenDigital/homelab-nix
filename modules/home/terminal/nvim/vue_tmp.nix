{ pkgs, ... }:
{
  home.packages = with pkgs; [
    typescript-language-server
    vscode-langservers-extracted
    vue-language-server
    templ
  ];
  programs.nvf.settings = {
    vim.lsp.lspconfig = {
      enable = true;
      sources = {
        templ = ''
          vim.lsp.config('templ', {
            cmd = { "templ", "lsp", "-http=localhost:7474" },
            filetypes = { 'templ' },
            root_markers = {"go.mod", ".git"},
            settings = {},
          })
          vim.lsp.enable('templ')
        '';
        vue_ls = ''
          vim.lsp.config('vue_ls', {})
          vim.lsp.enable('vue_ls')
        '';
        ts_ls = ''
          vim.lsp.config('ts_ls', {
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = "${pkgs.vue-language-server}/lib/language-tools/packages/language-server",
                  configNamespace = "typescript",
                  languages = {"vue"},
                },
              },
            },
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
            },
          })
          vim.lsp.enable('ts_ls')
        '';
      };
    };
  };
}
