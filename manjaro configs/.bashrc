[[ $- != *i* ]] && return #don't run bashrc if not interactove
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
# Set prompt
if [[ ${EUID} == 0 ]] ; then
	PS1='\[\033[0;31m\][\[\033[0;33m\]root\[\033[0;32m\]@\[\033[0;34m\]manjaro\[\033[1;35m\] \W\[\033[0;31m\]]\[\033[0;37m\]\$\[\033[1;32m\] '
else
	PS1='\[\033[0;31m\][\[\033[0;33m\]\u\[\033[0;32m\]@\[\033[0;34m\]manjaro\[\033[1;35m\] \W\[\033[0;31m\]]\[\033[0;37m\]\$\[\033[1;32m\] '
fi
xhost +local:root > /dev/null 2>&1 #allow root user access to X server
# Enable vi mode
set -o vi
# Shopt - set options
shopt -s histappend #append to history instead of overwriting
shopt -s cmdhist #save multiline commands as single line
shopt -s expand_aliases
shopt -s checkwinsize #update windows size after each non-native command
# Different programs
export EDITOR="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" #bat as manpager
alias tree="exa --tree"
# DO NOT CLUTTER HOME !!!
export LESSHISTFILE=/dev/null
export HISTFILE=~/.local/share/bash/bash_history
export HISTFILESIZE=# #infinite bash history
alias calcurse="calcurse -D ~/.local/share/calcurse"
# Ease of use
alias clipboard="xclip -sel clipboard -i"
alias whereami="geoiplookup \$(curl -s ifconfig.me) 2>/dev/null || echo no internet"
mne (){
	mkdir -p -- "$1" && cd -P -- "$1"
}
duration (){
	ffmpeg -i "$1" 2>&1 | grep "Duration"| cut -d ' ' -f 4 | sed s/,//
}
# Sensible defaults
alias bat="bat --theme gruvbox-dark"
alias exa="exa --icons"
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
stty -ixon #Disable crtl-s and crtl-q for pausing
