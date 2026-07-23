{ ... }:

{
  config = {
    userSettings = {
      # Setup
      shell = {
        enable = true;
        apps.enable = true;
        extraApps.enable = true;
      };
      xdg.enable = true;

      # Programs
      browser = "firefox";
      editor = "neovim";
      vscodium.enable = true;
      yazi.enable = true;
      git.enable = true;
      engineering.enable = false;
      art.enable = false;
      flatpak.enable = false;
      godot.enable = false;
      keepass.enable = false;
      media.enable = true;
      music.enable = false;
      office.enable = true;
      recording.enable = false;
      virtualization = {
        virtualMachines.enable = false;
      };
      ai.enable = false;

      # Window manager
      hyprland.enable = true;

      # Style
      stylix.enable = true;

      # Hardware
      bluetooth.enable = true;
    };

    # NOTE: Extra config goes here
  };
}
