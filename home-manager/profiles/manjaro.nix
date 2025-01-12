{ config, pkgs, ... }:

{
  imports = [
    ../modules/init.nix
  ];

  nixpkgs.config.allowUnfree = true;
  shell.bash.enable = true;
  fonts.fontconfig.enable = true;

  home = {
    username = "kuro";
    homeDirectory = "/home/kuro";
    stateVersion = "25.05";

    shellAliases = {
      hmbs = "home-manager build switch";
      hmg = "home-manager generations";
      pc = "podman-compose";
      pps = "podman ps";
    };

    file = {
      ".local/share/icons/candy-icons".source = "${pkgs.candy-icons}/share/icons/candy-icons";
      ".config/i3/config".source = ../../manjaro/i3/config;
    };

    packages = with pkgs; [
      nerd-fonts._0xproto
      nerd-fonts.caskaydia-cove
      candy-icons

      # Browser
      firefox
      tor-browser

      # Editor
      android-studio
      obsidian
      vscode

      # Network
      # ngrok
      nmap
      sqlmap
      # tor
      # torsocks

      # Programming
      nodejs
      jdk_headless
      jre_headless
      php84
      # frankenphp
      phpPackages.composer
      phpExtensions.pdo
      # phpExtensions.sqlite3
      # phpExtensions.pdo_mysql
      # phpExtensions.pdo_sqlite
      python312
      python312Packages.pip
      python312Packages.virtualenv

      # Utils
      # android-tools
      # caddy
      distrobox
      duf
      immich-cli
      # mkp224o
      neofetch
      nix-bash-completions
      # ollama
      # qemu
      podman-compose

      ###
      rofi
      polybar
      xfce.xfce4-terminal
      maim
      calc
      vlc
      exiftool
      netbeans
      postman
      immich-go
    ];
  };

  programs = {
    home-manager.enable = true;
    git.extraConfig.core.editor = "${pkgs.vscode}/bin/code --wait";

    clamav.enable = true;
    eza.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    gpg.homedir = "${config.xdg.dataHome}/gnupg";
    mycli.enable = true;
    neovim.enable = true;
    password-store.enable = true;
    ssh.control = true;
    tmux.enable = true;
    yazi.enable = true;
    yt-dlp.enable = true;
    yt-dlp.downloader = "aria2c";
    zoxide.enable = true;
  };

  services = {
    podman.enable = true;

    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };
}