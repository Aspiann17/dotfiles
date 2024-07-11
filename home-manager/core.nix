{ pkgs, ... }:

{
  home.packages = with pkgs; [
    coreutils
    curl
    htop
    nano
    neofetch
    nettools
    openssh
    pinentry-tty
    rsync
    trash-cli
    tree
    wget
  ];

  programs = {
    git = {
      enable = true;
      userName = "Aspian";
      userEmail = "p.aspian1738@gmail.com";
      extraConfig.init.defaultBranch = "main";

      ignores = [
        ".venv/"
        ".vscode/"
        "__pycache__/"
        "*.pyc"
      ];

      # includes = [];
    };

    # gpg.enable = true;

    ssh = {
      enable = true;
      controlMaster = "auto";
      controlPersist = "30m";
      controlPath = "~/.ssh/control/%r@%n:%p";
      # programs.ssh.addKeysToAgent = [];
    };
  };
}