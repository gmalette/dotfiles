{
  description = "gmalette's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
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

      # Shared home-manager module list
      homeModules = [
        ./modules/common.nix
        ./modules/git.nix
        ./modules/zsh.nix
        ./modules/tmux.nix
        ./modules/neovim.nix
        ./modules/ideavim.nix
      ];

      mkHomeConfig = hostName: hostCfg:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = hostCfg.system; };
          extraSpecialArgs = { inherit hostCfg; };
          modules = homeModules ++ [
            {
              home = {
                username = hostCfg.username;
                homeDirectory = hostCfg.homeDirectory;
                stateVersion = "24.11";
              };
            }
          ] ++ (if hostCfg.system == "x86_64-linux" then [ ./modules/linux.nix ] else []);
        };
    in
    {
      # home-manager switch --flake .#<host>
      homeConfigurations = {
        work-mac = mkHomeConfig "work-mac" hosts.work-mac;
        personal-mac = mkHomeConfig "personal-mac" hosts.personal-mac;
        linux-desktop = mkHomeConfig "linux-desktop" hosts.linux-desktop;
      };
    };
}
