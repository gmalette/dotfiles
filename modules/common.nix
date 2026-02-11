{ pkgs, hostCfg, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    delta
    zoxide
    jq
    curl
    htop
  ];

  programs.home-manager.enable = true;
}
