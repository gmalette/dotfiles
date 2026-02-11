{ pkgs, hostCfg, ... }:

{
  # Linux-specific packages
  home.packages = with pkgs; [
    xclip  # clipboard support for tmux-yank and neovim
  ];

  # Let home-manager manage the XDG directories
  xdg.enable = true;

  # Ensure fonts are available for terminal
  fonts.fontconfig.enable = true;
}
