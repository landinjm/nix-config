{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh
    starship
    direnv
    nix-direnv
    fzf
    zoxide
    eza
    bat
    ripgrep
    fd
    jq
    neovim
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza -lah --icons=auto --git";
      cat = "bat";
      cd = "z";
      gs = "git status";
    };
  };

  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf.enable = true;
  programs.zoxide.enable = true;
}
