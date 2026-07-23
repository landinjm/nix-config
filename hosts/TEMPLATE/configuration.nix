{ ... }:

{
  config = {
    systemSettings = {
      # Users
      users = [ "USERNAME" ];
      adminUsers = [ "USERNAME" ];

      # Hardware
      cachy.enable = true;
      bluetooth.enable = true;
      powerprofiles.enable = true;
      tlp.enable = false;
      printing.enable = true;

      # Software
      flatpak.enable = false;
      gaming.enable = false;
      virtualization = {
        docker.enable = false;
        virtualMachines.enable = false;
      };
      firefox.enable = true;

      # Window manager
      hyprland.enable = true;

      # dotfiles
      dotfilesDir = "/etc/nixos";

      # Security
      security = {
        automount.enable = true;
        blocklist.enable = true;
        doas.enable = true;
        firejail.enable = false;
        firewall.enable = true;
        gpg.enable = true;
        openvpn.enable = true;
        sshd.enable = false;
      };

      # Style
      stylix = {
        enable = true;
        theme = "orichalcum";
      };
    };

    users.users.USERNAME.description = "NAME";
    home-manager.users.USERNAME.userSettings = {
      name = "NAME";
      email = "EMAIL";
    };

    # NOTE: Extra config goes here
  };

}
