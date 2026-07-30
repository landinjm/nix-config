{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
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
    ripgrep # TODO: Move to nvp
    xclip # TODO: Move to nvp
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

      # TODO: Add git aliases
    };
  };

  programs.nvf = {
    enable = true;

    settings.vim = {
      ##
      #  Keymaps
      ##
      binds.whichKey.enable = true;

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

      # TODO: Give a brief description of what these do
      mini = {
        comment.enable = true;
        cursorword.enable = true;
        diff.enable = true;
        git.enable = true;
        icons.enable = true;
        indentscope.enable = true;
        move.enable = true;
        notify.enable = true;
        pairs.enable = true;
        starter.enable = true;
      };

      ##
      #  Language Support
      ##
      syntaxHighlighting = true;

      # Provide diagnostic information inline
      diagnostics = {
        enable = true;
        config = {
          signs = {
            text = {
              "vim.diagnostic.severity.Error" = " ";
              "vim.diagnostic.severity.Warn" = " ";
              "vim.diagnostic.severity.Hint" = " ";
              "vim.diagnostic.severity.Info" = " ";
            };
          };
          underline = true;
          update_in_insert = true;
          virtual_text = {
            format =
              lib.generators.mkLuaInline
              /*
              lua
              */
              ''
                function(diagnostic)
                  return string.format("%s", diagnostic.message)
                  --return string.format("%s (%s)", diagnostic.message, diagnostic.source)
                end
              '';
          };
        };
        nvim-lint.enable = true;
      };

      # Treesitter for syntax highlighting
      # TODO: Do I need any other languages?
      treesitter = {
        enable = true;
        autotagHtml = true;
        context.enable = true;
        highlight.enable = true;
      };

      # Autocomplete
      autocomplete = {
        nvim-cmp = {
          enable = true;
        };
      };

      # LSP
      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = true;
        lspSignature.enable = true;
        lspconfig.enable = true;
        lspkind.enable = true;
        lspsaga = {
          enable = true;
          setupOpts = {
            ui = {
              code_action = "";
            };
            lightbulb = {
              sign = false;
              virtual_text = true;
            };
            breadcrumbs.enable = false;
          };
        };
        null-ls.enable = true;
        otter-nvim = {
          enable = true;
          setupOpts = {
            buffers.set_filetype = true;
            lsp = {
              diagnostic_update_event = [
                "BufWritePost"
                "InsertLeave"
              ];
            };
          };
        };
        servers.nixd.settings.nil.nix.autoArchive = true;
        # TODO: I don't think this works
        servers.clangd.extraOptions = [
          "--header-insertion=never"
        ];
        trouble.enable = true;
      };

      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;

        bash.enable = true;
        clang = {
          enable = true;
          lsp = {
            enable = true;
            servers = ["clangd"];
          };
        };
        cmake.enable = true;
        css.enable = true;
        docker.enable = true;
        html.enable = true;
        python = {
          enable = true;
          lsp = {
            enable = true;
            servers = ["pyright"];
          };
        };
        markdown = {
          enable = true;
          format.type = ["prettier"];
          extensions = {
            markview-nvim = {
              enable = true;
            };
          };
          extraDiagnostics.enable = true;
        };

        nix.enable = true;
      };

      formatter = {
        conform-nvim = {
          enable = true;
        };
      };

      ##
      #  Options
      ##

      # Enable NodeJS support
      # TODO: Does this belong in another section?
      withNodeJs = true;

      # Other options
      # TODO: Do I want to be explicit about defaults?
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
      # TODO: Move this to top of options file
      globals.mapleader = " ";

      # Clipboard options
      clipboard = {
        enable = true;
        providers.wl-copy.enable = true; # For wayland
        providers.xclip.enable = true; # For everything else
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
