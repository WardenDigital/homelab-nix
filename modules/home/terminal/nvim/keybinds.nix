{ ... }:
{
  programs.nvf.settings = {
    vim.keymaps = [
      {
        key = "<leader>v";
        mode = "n";
        action = ":vsplit<CR>";
      }
      {
        key = "<leader>y";
        mode = [
          "n"
          "v"
        ];
        silent = true;
        action = ''"+y'';
      }
      {
        mode = "x";
        key = "<leader>p";
        action = ''"_dP'';
      }
      {
        key = "n";
        mode = "n";
        silent = true;
        action = "nzzzv";
      }
      {
        key = "N";
        mode = "n";
        silent = true;
        action = "Nzzzv";
      }
      {
        key = "<C-d>";
        mode = "n";
        silent = true;
        action = "<C-d>zz";
      }
      {
        key = "<C-u>";
        mode = "n";
        silent = true;
        action = "<C-u>zz";
      }
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        mode = "n";
        key = "<leader>>";
        action = ":cnext<CR>";
      }
      {
        mode = "n";
        key = "<leader><";
        action = ":cprev<CR>";
      }
    ];
  };
}
