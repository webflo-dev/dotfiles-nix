export CARGO_HOME="$XDG_DATA_HOME/cargo"
# export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"

export MANPAGER='nvim +Man!'
export PAGER='bat -p'
export LESS='-g -i -M -R -S -w -z-4'

export TERMINAL="kitty"
export BROWSER="microsoft-edge-stable"
export VISUAL="nvim"
export EDITOR="nvim"

# export LESS='-F -i -M -R -S -w -z-3'
# export LESS='-F -i -M -R -S -z-3'
export LESS='-i -M -R -S -z-4'
export LESSHISTFILE=/dev/null
export LESS_TERMCAP_md=$'\e[01;97m'     # Begins bold.
export LESS_TERMCAP_so=$'\e[00;47;30m'  # Begins standout-mode.
export LESS_TERMCAP_us=$'\e[04;97m'     # Begins underline.
export LESS_TERMCAP_me=$'\e[0m'         # Ends mode.
export LESS_TERMCAP_se=$'\e[0m'         # Ends standout-mode.
export LESS_TERMCAP_ue=$'\e[0m'         # Ends underline.


# WORDCHARS (non-alphanumeric chars treated as part of a word)
# You can also tweak this if you'd prefer ^w to break on dot, underscore, etc.
export WORDCHARS='*?[]~=&;!#$%^(){}<>'
