{ config, pkgs, ... }:

{
  home.username = "nephrite";
  home.homeDirectory = "/home/nephrite";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    neovim
    nixfmt
  ];
}
