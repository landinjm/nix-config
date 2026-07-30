{lib, ...}: {
  programs.nvf.settings.vim = {
    viAlias = false;
    vimAlias = true;
    options = {
      smartindent = true;
      foldlevel = 99;
      foldcolumn = "auto:1";
      mousescroll = "ver:1,hor:1";
      mousemoveevent = true;
      fillchars = "eob:‿,fold: ,foldopen:▼,foldsep:⸽,foldclose:⏵";
      softtabstop = 2;
    };
    globals = {
      navic_silence = true; # navic tries to attach multiple LSPs and fails
      suda_smart_edit = 1; # use super user write automatically
      neovide_scale_factor = 0.7;
      neovide_cursor_animation_length = 0.1;
      neovide_cursor_short_animation_length = 0;
    };
    luaConfigRC.osc52-clipboard = ''
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy '+',
          ['*'] = require('vim.ui.clipboard.osc52').copy '*',
        },
        paste = {
          ['+'] = require('vim.ui.clipboard.osc52').paste '+',
          ['*'] = require('vim.ui.clipboard.osc52').paste '*',
        },
      }
    '';
  };
}
