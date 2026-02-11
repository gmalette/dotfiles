{
  description = "gmalette's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      # Per-host configuration parameters
      hosts = {
        work-mac = {
          system = "aarch64-darwin";
          username = "gmalette";
          homeDirectory = "/Users/gmalette";
          gitUser = "Guillaume Malette";
          gitEmail = "guillaume.malette@shopify.com";
          isWork = true;
        };
        personal-mac = {
          system = "aarch64-darwin";
          username = "gmalette";
          homeDirectory = "/Users/gmalette";
          gitUser = "Guillaume Malette";
          gitEmail = "g@gmalette.dev";
          isWork = false;
        };
        linux-desktop = {
          system = "x86_64-linux";
          username = "gmalette";
          homeDirectory = "/home/gmalette";
          gitUser = "Guillaume Malette";
          gitEmail = "g@gmalette.dev";
          isWork = false;
        };
      };

      # Helper to build home-manager config for any host
      mkHomeConfig = hostName: hostCfg: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit hostCfg; };
          users.${hostCfg.username} = { pkgs, ... }: {
            home = {
              username = hostCfg.username;
              homeDirectory = hostCfg.homeDirectory;
            };
            imports = [
              ./modules/common.nix
              ./modules/git.nix
              ./modules/zsh.nix
              ./modules/tmux.nix
              ./modules/neovim.nix
              ./modules/ideavim.nix
            ];
          };
        };
      };

      # Darwin systems (macOS)
      mkDarwinSystem = hostName: hostCfg:
        nix-darwin.lib.darwinSystem {
          system = hostCfg.system;
          specialArgs = { inherit hostCfg; };
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin.nix
            (mkHomeConfig hostName hostCfg)
          ];
        };

      # Standalone home-manager for Linux
      mkHomeManagerConfig = hostName: hostCfg:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = hostCfg.system; };
          extraSpecialArgs = { inherit hostCfg; };
          modules = [
            ./modules/common.nix
            ./modules/git.nix
            ./modules/zsh.nix
            ./modules/tmux.nix
            ./modules/neovim.nix
            ./modules/ideavim.nix
            ./modules/linux.nix
            {
              home = {
                username = hostCfg.username;
                homeDirectory = hostCfg.homeDirectory;
              };
            }
          ];
        };
    in
    {
      # darwin-rebuild switch --flake .#work-mac
      darwinConfigurations = {
        work-mac = mkDarwinSystem "work-mac" hosts.work-mac;
        personal-mac = mkDarwinSystem "personal-mac" hosts.personal-mac;
      };

      # home-manager switch --flake .#linux-desktop
      homeConfigurations = {
        linux-desktop = mkHomeManagerConfig "linux-desktop" hosts.linux-desktop;
      };
    };
}
