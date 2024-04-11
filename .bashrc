# Shell Environment

HISTSIZE=9999999999
HISTFILESIZE=9999999999

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/bin/python3" ] ; then
    PATH="$HOME/.local/bin/python3/bin:$PATH"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi