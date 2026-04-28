{ pkgs, ... }:
{
  imports = [
    ./blink-cmp.nix
    ./snacks.nix
    ./mini.nix
    ./utils.nix
    ./neorg.nix
  ];

  programs.nvf.settings.vim = {
    globals.tmux_navigator_no_mappings = 1;
    extraPlugins = {
      vim-tmux-navigator = {
        package = pkgs.vimPlugins.vim-tmux-navigator;
      };
    };

    keymaps = [
      {
        key = "<C-h>";
        mode = "n";
        action = "function() vim.cmd('TmuxNavigateLeft') end";
        lua = true;
      }
      {
        key = "<C-j>";
        mode = "n";
        action = "function() vim.cmd('TmuxNavigateDown') end";
        lua = true;

      }
      {
        key = "<C-k>";
        mode = "n";
        action = "function() vim.cmd('TmuxNavigateUp') end";
        lua = true;

      }
      {
        key = "<C-l>";
        mode = "n";
        action = "function() vim.cmd('TmuxNavigateRight') end";
        lua = true;
      }
    ];
  };
}
