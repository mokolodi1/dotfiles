# sets PS1
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
	# assume zsh
	#export PROMPT="%m%# " normal
	PS1=$'%{\e[0;31m%}%m%{\e[0m%}:%{\e[0;36m%}%~%{\e[0m%}:%{\e[0;32m%}%j%{\e[0m%}%# '
fi
if [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
	# assume bash
	# PS1
	# \[\e[<type>;<color>m\] = colors
	# \u = username
	# \w = ~/thingies
	# \$ = $ or # depending on if root
	export LC_ALL=en_US.UFT-8
	export PS1='\[\e[0;31m\]\u\[\e[0m\]:\[\e[0;36m\]\w\[\e[0m\]:\[\e[0;32m\]\j\[\e[0m\]\$ '
fi

# aliases
alias ll='ls -lAh'
alias l='ls -CA1'
alias gccw="gcc -Werror -Wextra -Wall -o a"

cleanup () {
	find $1 -name $2 -depth -exec rm {} \;
}

cleanup_all () {
	cleanup ~ ".DS_Store"
    cleanup ~/Copy/42/git "*.o"
}

alias clean=cleanup_all

alias findinfiles='find . -type f -print0 | xargs -0 grep'
alias top='top -o cpu'
alias subl="/Applications/Sublime\ Text\ 3.app/Contents/SharedSupport/bin/subl"
