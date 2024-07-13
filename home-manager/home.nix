{ config, pkgs, ... }:

{
  imports = [
    ./modules/init.nix

    ./core.nix
    ../../piles/home-manager/private.nix
  ];

  # Nix Channel
  # https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  # https://nixos.org/channels/nixpkgs-unstable nixpkgs

  home = {
    username = "sinon";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.11";

    shellAliases = {
      hmbs = "home-manager build switch";
      rm = "trash-put";
      sl = "ls";
    };

    # file = { # config.lib.file.mkOutOfStoreSymlink };

    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FantasqueSansMono" "0xProto" ]; })

      # Archive
      bzip2
      bzip3
      gzip
      unrar
      unzip
      gnutar
      xz
      zip
      zstd

      # Database
      sqlite

      # Files
      bat
      ffmpeg

      # Monitor
      bottom
      # gotop
      # iftop
      # iotop
      # nyx

      # Network
      aria2
      dnsutils
      ngrok
      nmap
      proxychains
      speedtest-cli
      tor
      torsocks

      # Programming
      nodejs
      jdk_headless
      jre_headless
      php
      phpPackages.composer
      python3
      python3Packages.pip
      python3Packages.virtualenv
      # python3Packages.face-recognition
      # python3Packages.insightface
      podman-compose

      # Security
      # pass
      steghide

      # System
      android-tools
      # clamav
      gnumake
      scrcpy
      usbutils
      xorg.xrandr

      # Other
      ollama
      # media-downloader
    ];
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
  programs.git.extraConfig.core.editor = "code --wait";

  shell = {
    bash.enable = true;
    zsh.enable = true;
  };

  utils = {
    ffm.enable = true;
    fzf.enable = true;
    neovim.enable = true;
    starship.enable = true;
    tmux.enable = true;
    yt-dlp.enable = true;
    yt-dlp.path = "${config.home.homeDirectory}/Downloads/";
    zoxide.enable = true;
  };
}