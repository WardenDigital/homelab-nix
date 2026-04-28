{ pkgs, ... }:
{
  home.packages = with pkgs; [
    typescript-language-server
  ];
  programs.nvf.settings = {
    vim.lsp.lspconfig = {
      enable = true;
      sources = {
        ts_ls = ''
          vim.lsp.config('ts_ls', {
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
            },
          })
          vim.lsp.enable('ts_ls')
        '';
      };
    };
  };
}
