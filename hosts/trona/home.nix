{ config, lib, pkgs, inputs, ... }:

{
  home.username = "trona";
  home.homeDirectory = "/home/trona";

  home.stateVersion = "26.05";

  # User packages
  home.packages = with pkgs; [
    neovim
    cmakeWithGui
    gcc
    openmpi
    python3
    clang-tools
    openblas
    boost
    scalapack
    symengine
    hdf5-mpi
    ripgrep
    xclip
  ];

  xdg.configFile."ghostty/config".text = ''
    window-padding-x = 10
    window-padding-y = 10
    confirm-close-surface = false

    clipboard-read = allow
    clipboard-write = allow
    copy-on-select = clipboard

    app-notifications = false

    keybind = ctrl+j=goto_split:left
    keybind = ctrl+i=goto_split:up
    keybind = ctrl+k=goto_split:down
    keybind = ctrl+l=goto_split:right

    keybind = shift+ctrl+h=new_split:left
    keybind = shift+ctrl+j=new_split:down
    keybind = shift+ctrl+k=new_split:up
    keybind = shift+ctrl+l=new_split:right

    keybind = shift+ctrl+tab=new_tab
  '';

  programs.git = {
    enable = true;

    settings.user.name = "landinjm";
    settings.user.email = "landinjm@umich.edu";
    settings.init.defaultBranch = "main";
    settings.push.autoSetupRemote = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--icons=always"
    ];
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$nix_shell"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$character"
      ];
      directory = {style = "090E13";};

      character = {
        success_symbol = "[❯](090E13)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](cyan)";
      };

      nix_shell = {
        format = "[$symbol]($style) ";
        symbol = "🐚";
        style = "";
      };

      git_branch = {
        symbol = "[](12171E) ";
        style = "fg:090E13 bg:12171E";
        format = "on [$symbol$branch]($style)[](12171E) ";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218)($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "";
        renamed = "";
        deleted = "";
        stashed = "≡";
      };

      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        style = "bright-black";
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      source ~/.config/home-manager/env.sh
    '';

    shellAliases = {
      # All roads lead to neovim
      vim = "nvim";
      vi = "nvim";
      v = "nvim";

      # zoxide
      cd = "z";

      # eza
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";

    }; 
  };

  programs.nvf = {
    enable = true;

    settings.vim = {

      ##
      #  Keymaps
      ##
      binds = {
        whichKey = {
          enable = true;
        };
      };
      keymaps = [
        # General mappings
        # Disable arrow keys in normal mode and middle click
         {
        key = "<Up>";
        mode = "n";
        silent = true;
        action = "<Nop>";
        desc = "Disable up arrow";
      }
      {
        key = "<Down>";
        mode = "n";
        silent = true;
        action = "<Nop>";
        desc = "Disable down arrow";
      }
      {
        key = "<Left>";
        mode = "n";
        silent = true;
        action = "<Nop>";
        desc = "Disable left arrow";
      }
      {
        key = "<Right>";
        mode = "n";
        silent = true;
        action = "<Nop>";
        desc = "Disable right arrow";
      }
      {
        key = "<MiddleMouse>";
        mode = ["n" "i" "v"];
        action = "<nop>";
        silent = true;
      }
      {
        key = "<2-MiddleMouse>";
        mode = ["n" "i" "v"];
        action = "<nop>";
        silent = true;
      }
      {
        key = "<3-MiddleMouse>";
        mode = ["n" "i" "v"];
        action = "<nop>";
        silent = true;
      }

      # UI

      # Windows
{
        key = "<leader>ws";
        mode = "n";
        silent = true;
        action = "<cmd>split<cr>";
        desc = "Split";
      }
      {
        key = "<leader>wv";
        mode = "n";
        silent = true;
        action = "<cmd>vsplit<cr>";
        desc = "VSplit";
      }
      {
        key = "<leader>wd";
        mode = "n";
        silent = true;
        action = "<cmd>close<cr>";
        desc = "Close";
      }

        # Move
      {
        key = "<C-h>";
        mode = "n";
        silent = true;
        action = "<C-w>h";
        desc = "Move to left window";
      }
      {
        key = "<C-j>";
        mode = "n";
        silent = true;
        action = "<C-w>j";
        desc = "Move to bottom window";
      }
      {
        key = "<C-k>";
        mode = "n";
        silent = true;
        action = "<C-w>k";
        desc = "Move to top window";
      }
      {
        key = "<C-l>";
        mode = "n";
        silent = true;
        action = "<C-w>l";
        desc = "Move to right window";
      }

 # Save
      {
        key = "<C-s>";
        mode = ["n" "i" "v"];
        silent = true;
        action = "<cmd>w<cr>";
        desc = "Save file";
      }
      ];

      ##
      #  Mini
      ##
      mini = {
        comment.enable = true;
        cursorword.enable = true;
        diff.enable = true;
        git.enable = true;
        icons.enable = true;
        indentscope.enable = true;
        map.enable = true;
        move.enable = true;
        notify.enable = true;
        pairs.enable = true;
        starter.enable = true;
      };

      ##
      #  Options
      ##

      # Enable NodeJS support
      withNodeJs = true;

      # Other options
      options = {
      autoindent = true;
	shiftwidth = 2;
	signcolumn = "yes";
	splitbelow = true;
	splitright = true;
	tabstop = 2;
	termguicolors = true;
	wrap = true;
      };

      # Global variables
      globals = {
        mapleader = " ";
      };

      # Clipboard options
      clipboard = {
        enable = true;
	providers.wl-copy.enable = true;
	providers.xclip.enable = true;
	registers = "unnamedplus";
      };

      # Theme
      theme = {
	enable = true;
	name = lib.mkForce "catppuccin";
      style = lib.mkForce "mocha";
      transparent = lib.mkForce true;
      };

    };
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}

