{ config, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # historyControl = [ "ignoreboth" ];
    historyFile = "${config.home.homeDirectory}/.local/history/bash";

    shellAliases = {
      rm = "trash-put";
      reload = "source ~/.bashrc";
      hmbs = "home-manager build switch";
      sshd = "$(which sshd) -f ~/.ssh/sshd_config";
    };

    bashrcExtra = ''
      . ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh

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

      if [ -x /usr/bin/dircolors ]; then
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
}