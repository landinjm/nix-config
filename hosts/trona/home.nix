{ config, pkgs, inputs, ... }:

{
  home.username = "trona";
  home.homeDirectory = "/home/trona";

  home.stateVersion = "26.05";

  # TODO: Refactor
  # User packages
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    tree
    bat
    eza
  ];

  # TODO: Refactor
  programs.git = {
    enable = true;

    settings.user.name = "landinjm";
    settings.user.email = "landinjm@umich.edu";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}

