{ pkgs, hostCfg, ... }:

{
  # Required for nix-darwin
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use GitHub token from gh CLI to avoid API rate limits during flake updates.
  # This runs `gh auth token` at activation time and writes it into the nix config.
  nix.extraOptions = ''
    !include /etc/nix/github-token.conf
  '';

  # Populate the token file from gh CLI at activation
  system.activationScripts.postActivation.text = ''
    if command -v gh &>/dev/null && gh auth status &>/dev/null 2>&1; then
      TOKEN=$(gh auth token 2>/dev/null)
      if [ -n "$TOKEN" ]; then
        echo "access-tokens = github.com=$TOKEN" > /etc/nix/github-token.conf
        chmod 600 /etc/nix/github-token.conf
      fi
    else
      # Ensure file exists even without gh, so !include doesn't error
      touch /etc/nix/github-token.conf
    fi
  '';

  # Use the Nix-installed zsh as default shell
  programs.zsh.enable = true;

  # macOS system preferences
  system.defaults = {
    dock = {
      show-recents = false;
      mru-spaces = false;
    };
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;  # enable key repeat
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };

  # Platform
  nixpkgs.hostPlatform = hostCfg.system;

  # nix-darwin versioning
  system.stateVersion = 5;
}
