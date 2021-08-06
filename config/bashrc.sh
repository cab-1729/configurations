export EDITOR='nvim'
PS1="\033[1;34m\w # \033[0m"
set bell-style none
PROMPT_COMMAND='if [[ "$bashrc" != "$PWD" && "$PWD" != "$HOME" && -e .bashrc ]]; then bashrc="$PWD"; . .bashrc; fi' #run local rc


