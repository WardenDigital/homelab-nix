{ lib, ... }:
{
  imports = [
    ./ui.nix
    ./keybinds.nix
    ./usercommands.nix
    ./plugins/plugins.nix
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        opts = {
          tabstop = 4;
          nu = true;
          relativenumber = true;
          softtabstop = 4;
          shiftwidth = 4;
          expandtab = true;
          swapfile = false;
          winborder = "rounded";
          hlsearch = false;
          incsearch = true;
          inccommand = "split";
          termguicolors = true;
          scrolloff = 8;
          signcolumn = "yes";
          colorcolumn = "120";
          updatetime = 50;
          conceallevel = 2;
          concealcursor = "ncv";
          foldlevelstart = 99;

          virtualedit = "block";
          ignorecase = true;
          smartcase = true;

          list = false;
        };
        diagnostics = {
          enable = true;
          config = {
            virtual_lines = true;
            signs.text = lib.generators.mkLuaInline ''
                {
                  [vim.diagnostic.severity.ERROR] = " ",
              	  [vim.diagnostic.severity.WARN] = " ",
              	  [vim.diagnostic.severity.INFO] = " ",
              	  [vim.diagnostic.severity.HINT] = " ",
                }
            '';
          };
        };
      };
    };
  };
}
