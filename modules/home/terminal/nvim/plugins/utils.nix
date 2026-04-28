{ ... }:
{
  programs.nvf = {
    settings = {
      vim.utility = {
        motion.flash-nvim = {
          enable = true;
          mappings = {
            jump = "<C-s>";
          };
        };
        preview.markdownPreview = {
          enable = true;
          autoStart = true;
        };
      };

      vim.git.gitsigns = {
        enable = true;
        mappings = {
          toggleBlame = "<leader>gb";
        };
      };
    };
  };
}
