{ pkgs, lib, ... }:
{
  config.vim = {
    theme = {
      enable = true;
      name = "onedark";
      style = "dark";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix = {
        enable = true;
        lsp.server = "nixd";
        format.enable = true;
        format.type = "nixfmt";
      };
      rust.enable = true;
    };

    lsp.formatOnSave = true;

    keymaps = [
      {
        key = "<Up>";
        mode = "n";
        silent = true;
        action = "<Nop>";
      }
      {
        key = "<Down>";
        mode = "n";
        silent = true;
        action = "<Nop>";
      }
      {
        key = "<Left>";
        mode = "n";
        silent = true;
        action = "<Nop>";
      }
      {
        key = "<Right>";
        mode = "n";
        silent = true;
        action = "<Nop>";
      }
    ];
  };
}
