{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    prefix = "C-s";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];

    extraConfig = ''
      # True color support
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -ag terminal-overrides ",alacritty:RGB"

      # Undercurl support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      # Focus events (needed for vim autoread, etc.)
      set -g focus-events on

      # Split panes with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Vim-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes with prefix + H/J/K/L
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Cycle through panes with prefix + C-s
      bind C-s select-pane -t :.+

      # Popup shell (tmux 3.2+)
      bind p display-popup -E -w 80% -h 80%

      # Renumber windows when one is closed
      set -g renumber-windows on

      # Status bar
      set -g status-position bottom
      set -g status-interval 5
      set -g status-style "bg=colour235,fg=colour248"
      set -g status-left-length 30
      set -g status-left "#[fg=colour220,bold] #S #[fg=colour248]| "
      set -g status-right "#[fg=colour248]#{?client_prefix,#[fg=colour220]PREFIX ,}%H:%M "
      set -g window-status-format " #I:#W "
      set -g window-status-current-format "#[fg=colour220,bold] #I:#W "
      set -g window-status-separator ""

      # Pane borders
      set -g pane-border-style "fg=colour238"
      set -g pane-active-border-style "fg=colour220"

      # Messages
      set -g message-style "bg=colour235,fg=colour220"

      # Copy mode vi bindings
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle

      # Quick reload
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"
    '';
  };
}
