HISTFILE=~/.config/zsh/history
HISTSIZE=1000
SAVEHIST=1000

unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/fasamii/.config/zsh/.zshrc'

autoload -Uz compinit
compinit

# alias ls='ls -lAh --color'
alias ls='exa -A -F -alF --icons --color=always --group-directories-first'
alias l=ls
alias c=clear
alias n=nvim
alias rd=radare2
alias e=exit
alias gs='git status'
alias fman='compgen -c | fzf | xargs man'
alias a='ip -c a'
alias snote='hyprctl notify -1 999999999 "rgb(ffffff)" '
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

#COLOR_A='#F57200'
#COLOR_B='#a46100'

#COLOR_A='#ff0088'
#COLOR_B='#8f0056'

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
		echo "%{%F{red}%}"
	else
		echo "%{%F{magenta}%}"
	fi
}

PROMPT='%B%F{magenta}<$(command_status)%F{magenta}><%~>%F{blue} '
preexec() {
	echo -en "\e[0m"
}
