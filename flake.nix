{
  description = "Flake of landinjm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    chaotic.url = "github:chaotic-cx/nyx";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland.git?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix.url = "github:nix-community/stylix";

    blocklist-hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };

    # TODO: Add the secrets back
    /*
        secrets = {
          url = "git+file:///etc/nix.secrets";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    */
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      chaotic,
      ...
    }:

    let
      lib = nixpkgs.lib;

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };

      mkStablePkgs =
        system:
        import nixpkgs-stable {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };

      /*
        Define hosts explicitly.

        type:
          "nixos" = full NixOS machine
          "home"  = standalone Home Manager, e.g. Ubuntu/macOS

        system:
          x86_64-linux
          aarch64-linux
          x86_64-darwin
          aarch64-darwin
      */
      hosts = {
        nephrite = {
          type = "home";
          system = "x86_64-linux";
          username = "nephrite";
        };
      };

      mkHome =
        hostName: host:
        let
          pkgs = mkPkgs host.system;
          pkgs-stable = mkStablePkgs host.system;
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs pkgs-stable hostName;
            username = host.username;
            system = host.system;
            isDarwin = lib.hasSuffix "darwin" host.system;
            isLinux = lib.hasSuffix "linux" host.system;
          };

          modules = [
            ./modules/home
            ./hosts/${hostName}/home.nix
          ];
        };

      mkNixos =
        hostName: host:
        let
          pkgs = mkPkgs host.system;
          pkgs-stable = mkStablePkgs host.system;
        in
        lib.nixosSystem {
          system = host.system;

          specialArgs = {
            inherit inputs pkgs-stable hostName;
            username = host.username;
          };

          modules = [
            {
              networking.hostName = hostName;
              nixpkgs.config.allowUnfree = true;
            }

            ./modules/nixos
            ./hosts/${hostName}

            chaotic.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = {
                inherit inputs pkgs-stable hostName;
                username = host.username;
                system = host.system;
                isDarwin = false;
                isLinux = true;
              };

              home-manager.users.${host.username} = import ./hosts/${hostName}/home.nix;
            }
          ];
        };

      nixosHosts = lib.filterAttrs (_: host: host.type == "nixos") hosts;

      homeHosts = lib.filterAttrs (_: host: host.type == "home") hosts;

    in
    {
      nixosConfigurations = lib.mapAttrs mkNixos nixosHosts;

      homeConfigurations = lib.mapAttrs mkHome homeHosts;
    };
}
