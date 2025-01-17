{ pkgs, ... }:

{
  home.shellAliases = {
    dh = "du -h";
    dt = "df -Th";
    durl = "curl -O --progress-bar";
    l = "ls -lah";
    la = "ls -lAh";
    ll = "ls -lh";
    ncu = "nix-channel --update";
    ncl = "nix-channel --list";
    nclg = "nix-channel --list-generations";
    rm = "${pkgs.trash-cli}/bin/trash-put"; # don't change this line
    remove = "${pkgs.coreutils}/bin/rm";
    tree = "eza --tree";
  };

  home.packages = with pkgs; [
    bat
    coreutils
    curl
    gitui
    nano
    ncdu
    rsync
    trash-cli
  ];

  programs = {
    eza = {
      enable = true;
      git = true;
      icons = "always";
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraOptions = [
        "--group"
        "--group-directories-first"
        "--mounts"
        "--no-quotes"
      ];
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
      defaultOptions = [
        "--border"
        "--height 100%"
      ];
    };

    git = {
      enable = true;
      userName = "Aspian";
      userEmail = "p.aspian1738@gmail.com";
      delta.enable = true;

      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";

        core = {
          fileMode = true;
          pager = "${pkgs.delta}/bin/delta";
        };

        delta = {
          line-numbers = true;
          side-by-side = false;
        };

        interactive = {
          diffFilter = "${pkgs.delta}/bin/delta --color-only";
        };
      };

      ignores = [
        "tmp/"
        "vendor/"
        "node_modules/"
        ".venv/"
        ".vscode/"
        "__pycache__/"
        "*.pyc"
      ];
    };

    ssh = {
      enable = true;
      matchBlocks.github = {
        host = "github.com";
        user = "git";
        forwardAgent = true;
        identityFile = [
          "~/.ssh/id_rsa"
          "~/.ssh/id_ed25519"
        ];
      };
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [];
    };
  };
}