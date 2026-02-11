{ pkgs, hostCfg, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    delta
    zoxide
    eza
    jq
    curl
    htop
  ];

  programs.home-manager.enable = true;
}
