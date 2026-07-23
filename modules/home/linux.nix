{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    playerctl
    brightnessctl
  ];
}
