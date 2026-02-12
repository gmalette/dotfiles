{ pkgs, hostCfg, lib, ... }:

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

  # Copy (not symlink) mutable config files that agents/tools need to write to
  home.activation.copyMutableConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/opencode
    # Only seed the file if it doesn't exist — don't clobber runtime changes
    if [ ! -f ~/.config/opencode/AGENT.md ]; then
      cp ${../config/opencode/AGENT.md} ~/.config/opencode/AGENT.md
      chmod 644 ~/.config/opencode/AGENT.md
    fi
  '';
}
