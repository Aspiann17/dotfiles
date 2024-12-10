{ config, pkgs, ... }:

{
  imports = [
    ../modules/init.nix
    ../core.nix
  ];

  # Nix Channel
  # https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  # https://nixos.org/channels/nixpkgs-unstable nixpkgs

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  shell = {
    ohmyposh.enable = false;

    nu.enable = false;
    zsh.enable = true;
    bash.enable = true;
  };

  home = {
    username = "aspian";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.11";

    shellAliases = {
      hmbs = "home-manager build switch";
      hmg = "home-manager generations";
      sql = "PYTHONWARNINGS='ignore' mycli mysql://root:'uh'@localhost/tugas_dbs_aspian";
    };

    sessionVariables = {
      MYCLI_HISTFILE="~/.local/share/mycli/history.txt";
    };

    file = {
      ".myclirc".source = ../../.myclirc;
      ".local/share/applications/obsidian.desktop".text = ''
        [Desktop Entry]
        Categories=Office
        Comment=Knowledge base
        Exec=${config.home.homeDirectory}/.nix-profile/bin/obsidian %u
        Icon=obsidian
        MimeType=x-scheme-handler/obsidian
        Name=Obsidian
        Type=Application
        Version=1.4
      '';
    };

    packages = with pkgs; [
      # Network
      dnsutils
      i2pd
      ipcalc
      ngrok
      nmap
      speedtest-cli
      tor
      torsocks

      # Programming
      nodejs
      jdk_headless
      jre_headless
      php84
      phpPackages.composer
      phpExtensions.pdo
      phpExtensions.sqlite3
      phpExtensions.pdo_mysql
      phpExtensions.pdo_sqlite
      python314
      python314Packages.pip
      python314Packages.virtualenv

      # Utils
      android-tools
      caddy
      distrobox
      duf
      glow
      gnumake
      mkp224o
      obsidian
      qemu
      scrcpy
      wavemon
      zenith
    ];
  };

  programs = {
    ssh.control = true;
    home-manager.enable = true;
    git.extraConfig.core.editor = "nvim";
    git.extraConfig.delta = {
      hyperlinks = true;
      hyperlinks-file-link-format = "vscode://file/{path}:{line}";
    };

    utils = {
      general = true;
      clamav.enable = true;
      librewolf.enable = true;
      neovim.enable = true;
      pass.enable = true;
      tmux.enable = true;
      vscode.enable = true;
      yt-dlp.downloader = "aria2c";
    };

    bash.bashrcExtra = ''
      [ -f ~/.profile ] && source ~/.profile

      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
      esac

      if [ -n "$force_color_prompt" ]; then
          if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
              color_prompt=yes
          else
              color_prompt=
          fi
      fi

      if [ -x "$(command -v dircolors)" ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
          alias ls='ls --color=auto'

          alias grep='grep --color=auto'
          alias fgrep='fgrep --color=auto'
          alias egrep='egrep --color=auto'
      fi

      if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
          . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
          . /etc/bash_completion
        fi
      fi
    '';
  };

  services.glance.enable = false;
  services.glance.settings.pages = [
    {
      name = "Home";
      columns = [
        {
          size = "small";
          widgets = [
            { type = "calendar"; }

            {
              type = "monitor";
              title = "Sites";
              cache = "10m";
              sites = [
                {
                  title = "Github";
                  url = "https://github.com/";
                }

                {
                  title = "Google";
                  url = "https://google.com/";
                }
              ];
            }
          ];
        }

        {
          size = "full";
          widgets = [
            { # https://commentpicker.com/youtube-channel-id.php
              title = "YouTube";
              type = "videos";
              channels = [
                "UCxxnxya_32jcKj4yN1_kD7A" # Muse Indonesia
                "UCUn0hEbVJc273anl_0ozDMQ" # Ani One ID
                "UCL_D8_Oqnb_Icr3zRn9pVNw" # Guru Gembul
                "UC14ZKB9XsDZbnHVmr4AmUpQ" # Programmer Zaman Now
              ];
            }

            { type = "hacker-news"; }
          ];
        }
      ];
    }

    {
      name = "Anime";
      columns = [
        {
          size = "full";
          widgets = [
            { # Muse Indonesia
              type = "videos";
              style = "grid-cards";
              title = "Muse Indonesia";
              collapse-after-rows = 1;
              channels = [ "UCxxnxya_32jcKj4yN1_kD7A" ];
            }

            { # Ani-One ID
              type = "videos";
              style = "grid-cards";
              title = "Ani-One Indonesia";
              collapse-after-rows = 1;
              channels = [ "UCUn0hEbVJc273anl_0ozDMQ" ];
            }

            { # Ani-One Asia
              type = "videos";
              style = "grid-cards";
              title = "Ani-One Asia";
              collapse-after-rows = 1;
              channels = [ "UC0wNSTMWIL3qaorLx0jie6A" ];
            }
          ];
        }
      ];
    }
  ];
  # xfconf.settings
}