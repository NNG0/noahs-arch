#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

# Added by Toolbox App
export PATH="$PATH:/home/nng/.local/share/JetBrains/Toolbox/scripts"

. "$HOME/.cargo/env"

. "$HOME/.local/share/../bin/env"
