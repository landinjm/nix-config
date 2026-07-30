{ config, pkgs, inputs, ... }:

{
  home.username = "trona";
  home.homeDirectory = "/home/trona";

  home.stateVersion = "26.05";

  # User packages
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    tree
    bat
    eza
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
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}

