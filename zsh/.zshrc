HISTFILE=~/.config/zsh/history
HISTSIZE=1000
SAVEHIST=1000

unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/fasamii/.config/zsh/.zshrc'

[ -f "/home/wasabi/.ghcup/env" ] && . "/home/wasabi/.ghcup/env" # ghcup-env

autoload -Uz compinit
compinit

# alias ls='ls -lAh --color'
alias ls='exa -A -F -alF --icons --color=always --group-directories-first'
alias l=ls
alias mk=mkdir
alias rmd='rm -d'
alias rmr='rm -r'
alias rmfr='rm -rf'
alias c=clear
alias h=hyprland
alias v=nvim
alias vim=nvim
alias :q=exit
alias rd=radare2
alias e=exit
alias q=exit
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gcm='git commit -m'
alias gps='git push'
alias fman='compgen -c | fzf | xargs man'
alias a='ip -c a'
alias snote='hyprctl notify -1 999999999 "rgb(ffffff)" '
udate() {
    while true; do
        printf '\r%s' "$(command date)"
        sleep 1
    done
}
cd() {
	if [[ $@ == "..." ]]; then
		builtin cd ../..;
	elif [[ $@ == "...." ]]; then
		builtin cd ../../..;
	else 
		builtin cd $@;
	fi
}

PATH=$PATH:/home/$(whoami)/.config/bin

##########
# PROMPT #
##########

VIOLET='#7547ff'
PURPLE='#ff87ff'

setopt PROMPT_SUBST

precmd() {
	EXIT_CODE=$?
}

command_status() {
	if [[ $EXIT_CODE -eq 0 ]]; then
		echo "%{%F{green}%}+%{%f%}"
	else 
		echo "%{%F{red}%}$EXIT_CODE%{%f%}"
	fi
}

usr_color() {
	if [[ $(id -u) -eq 0 ]]; then
		echo "%{%K{red}%}"
	else
		echo "%{%K{black}%}"
	fi
}

# PROMPT='%F{${VIOLET}}◖%F{black}%K{${VIOLET}}%B%F{black}<$(command_status)%F{black}><%~>%F{${VIOLET}}%K{black} %b%F{blue}'
PROMPT='%B%F{magenta}<$(command_status)%F{magenta}><%~>%F{blue} '

# to clear color after the prompt
preexec() {
	echo -en "\e[0m"
}
