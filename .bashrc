if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
	# assume zsh
	#export PROMPT="%m%# " normal
	PS1=$'\e[0;31m%m\e[0m:\e[0;36m%~\e[0m%# '
fi
if [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
	# assume bash
	# PS1
	# \[\e[<type>;<color>m\] = colors
	# \u = username
	# \w = ~/thingies
	# \$ = $ or # depending on if root
	export PS1='\[\e[0;31m\]\u\[\e[0m\]:'
	PS1+='\[\e[0;36m\]\w\[\e[0m\]:'
	PS1+='\[\e[0;32m\]\j\[\e[0m\]'
	PS1+='\$ '
fi

# aliases
alias ll='ls -lA'
alias l='ls -CA'
alias gccw="gcc -Werror -Wextra -Wall -o a"
alias clean="find ~ -name \".DS_Store\" -depth -exec rm {} \;"
#alias emacs='/usr/local/Cellar/emacs/24.3/bin/emacs'

# 42 stuff
alias norminettef='norminette --CheckForbiddenSourceHeader'
alias norminetteall='find . -name "*.c" -exec norminette {} \;'

alias pyb='python -B' # don't create bytecode
