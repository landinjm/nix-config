{ config, pkgs, inputs, ... }:

{
  # Platform
  nixpkgs.hostPlatform = "x86_64-linux";

  # Packages
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    htop
    ghostty
  ];
  
  # Allow any linux distro & enable graphics
  system-manager.allowAnyDistro = true;
  system-graphics.enable = true;
}

