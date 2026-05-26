#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# prompt
source /usr/share/git/completion/git-prompt.sh

CYAN="\[\033[0;36m\]"
BLUE="\[\033[0;34m\]"
MAGENTA="\[\033[0;35m\]"
GRAY="\[\033[0;90m\]"
GREEN="\[\033[0;32m\]"
RESET="\[\033[0m\]"

export GIT_PS1_SHOWDIRTYSTATE=1

PS1="${CYAN}󰣇 \u ${GRAY}on ${BLUE} \W${GREEN}\$(__git_ps1 ' (%s)')\n${MAGENTA}# ${RESET}"

# alias definitions
alias ls='eza -lh --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --long --icons --git'
alias grep='rg --color=auto'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias find="fd"
alias lg="lazygit"
alias n="nvim ."
alias zj="zellij"

# Load Git CLI autocompletion.
source /usr/share/bash-completion/completions/git

# yazi integration
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

eval "$(zoxide init bash)"

. "$HOME/.local/share/../bin/env"

export PATH="/home/nng/.pixi/bin:$PATH"
