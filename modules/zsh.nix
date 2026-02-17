{ pkgs, hostCfg, lib, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    defaultKeymap = "emacs";

    sessionVariables = {
      EDITOR = "nvim";
      TZ = "America/Montreal";
    };

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
    };

    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreAllDups = true;
      share = true;
    };

    initContent = lib.concatStringsSep "\n" (
      [
        # Case-sensitive completion
        ''zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' ''

        # Terminal title management
        ''
        function set_terminal_title() {
          local cmd="''${1:-''${(%):-%~}}"
          print -Pn "\e]0;''${cmd}\a"
        }

        function preexec() {
          local cmd="''${1[(w)1]}"
          set_terminal_title "$cmd"
        }

        function precmd() {
          set_terminal_title "''${(%):-%~}"
        }
        ''

        # Extra PATH entries
        ''export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"''

        # Don't close terminal on Ctrl-D
        "setopt ignoreeof"

        # Disable C-s/C-q flow control (C-s is tmux prefix)
        "stty -ixon -ixoff 2>/dev/null"
      ]
      ++ lib.optionals hostCfg.isWork [
        # Export Buildkite API token from bk.yaml so it survives direnv overriding XDG_CONFIG_HOME
        ''
        if [[ -f "$HOME/.config/bk.yaml" ]]; then
          export BUILDKITE_API_TOKEN="$(${pkgs.yq-go}/bin/yq '.organizations.[].api_token' "$HOME/.config/bk.yaml" | head -1)"
        fi
        ''

        # Shopify dev tools
        ''
        [[ -f /opt/dev/dev.sh ]] && source /opt/dev/dev.sh

        export PATH="$HOME/.dev/userprofile/bin:$PATH"
        ''

        # tec agent
        ''
        [[ -x "$HOME/.local/state/tec/profiles/base/current/global/init" ]] && \
          eval "$("$HOME/.local/state/tec/profiles/base/current/global/init" zsh)"
        ''
      ]
    );
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = "\${custom.worldpath}$all";

      package.disabled = true;
      python.disabled = true;
      gcloud.disabled = true;
      nodejs.disabled = true;
      directory.disabled = true;
      container.disabled = true;
      nix_shell.disabled = true;
      docker_context.disabled = true;

      character = {
        success_symbol = "[;](bold green)";
        error_symbol = "[;](bold red)";
      };

      git_branch.style = "bold 220";

      custom.worldpath = {
        command = "worldpath --full --spare | cut -d@ -f1";
        when = true;
        format = "[$output]($style) ";
        style = "bold cyan";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;  # caches nix shells so they load fast
  };
}
