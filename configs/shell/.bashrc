#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

alias ls='eza -lh --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --long --icons --git'
alias grep='rg --color=auto'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias find="fd"

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

# lazy load oh my posh
if [[ $- == *i* ]]; then
  eval "$(oh-my-posh init bash --config '~/amro.omp.json')"
fi

# >>> conda initialize (lazy)>>>
# !! Contents within this block are managed by 'conda init' !!
function conda() {
    __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/opt/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/opt/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    conda "$@"
}

