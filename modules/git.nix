{ pkgs, hostCfg, lib, ... }:

{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    ignores = [
      ".DS_Store"
      "*.swp"
      "*.dylib"
      "*.a"
      "*.o"
      "*.rlib"
      ".idea"
      ".claude"
      "CLAUDE.md"
    ];

    settings = {
      user = {
        name = hostCfg.gitUser;
        email = hostCfg.gitEmail;
      };
      alias = {
        ci = "commit";
        co = "checkout";
        st = "status --short";
        amend = "commit --amend -C @";
        frob = "!git rebase -i \"$(git merge-base @ origin/main)\"";
        squash = "!HEAD_COMMIT=$(git rev-list @ -n 1) BASE_COMMIT=$(git merge-base @ origin/main) && git reset --soft $BASE_COMMIT && git commit --reuse-message=$HEAD_COMMIT~$[$(git rev-list $BASE_COMMIT..$HEAD_COMMIT --count)-1] --edit";
        llog = "log --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat";
        slog = "log --oneline --decorate";
        clbr = ''!f() { git branch --merged origin/main | rg --invert-match "\\*|master|main" | xargs -r git branch -d; }; f'';
      };
      core = {
        editor = "nvim";
        fsmonitor = true;
        commitgraph = true;
        writeCommitGraph = true;
      };
      feature.manyFiles = true;
      branch.autosetuprebase = "always";
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      pull.rebase = true;
      color.ui = true;
      help.autocorrect = 5;
      diff = {
        noprefix = true;
        colorMoved = "default";
      };
      merge.conflictstyle = "diff3";
      fetch.prune = true;
      rerere.enabled = true;
      rebase.updateRefs = true;
      init.defaultBranch = "main";
    };

    includes = lib.optionals hostCfg.isWork [
      { path = "~/.config/dev/gitconfig"; }
    ];
  };

  # Force overwrite in case existing files conflict
  xdg.configFile."git/ignore".force = true;
}
