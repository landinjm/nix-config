{
  description = "Flake of landinjm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Unstable pkg repo
    nixpkgs-stable.url = "nixpkgs/nixos-25.11"; # Stable pkg repo
    chaotic.url = "github:chaotic-cx/nyx"; # Experimental pkg repo

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Window manager
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland.git?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Lock screen
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Caelestia dots
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # KDE Plasma
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Color schemes
    stylix.url = "github:nix-community/stylix";

    # Wallpapers
    awesome-wallpapers.url = "github:anotherhadi/awesome-wallpapers";

    # Neovim
    nvf.url = "github:notashelf/nvf";

    # Discord
    nixcord.url = "github:4evy/nixcord";

    # Spotify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Solaar (Logitech devices)
    solaar.url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";

    # DNS blocklists
    blocklist-hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };

    # Secrets
    # TODO: Add the secrets back
    /*
    secrets = {
      url = "git+file:///etc/nix.secrets";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */
  };
  
outputs = inputs @ { nixpkgs, ... }: {
  homeConfigurations = {
    trona = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };

      extraSpecialArgs = {
        inherit inputs;
      };

      modules = [
        inputs.stylix.homeModules.stylix
        ./hosts/trona/home.nix
      ];
    };
  };
};

}

# nix run 'github:numtide/system-manager' -- switch --flake .#trona --sudo

