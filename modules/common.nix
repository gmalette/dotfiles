{ pkgs, hostCfg, ... }:

{
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
