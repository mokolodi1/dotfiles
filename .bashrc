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
	export PS1='\[\e[0;31m\]\u\[\e[0m\]:\[\e[0;36m\]\w\[\e[0m\]:\[\e[0;32m\]\j\[\e[0m\]\$ '
fi

# aliases
alias ll='ls -lAh'
alias l='ls -CA1'
alias gccw="gcc -Werror -Wextra -Wall -o a"
alias psall='ps -ef'
alias findinfiles='find . -type f -print0 | xargs -0 grep'

function zipfolder {
    zip -r $1.zip $1
}

delete_files_in_folder () {
	find $1 -name $2 -depth -exec rm {} \;
}
clean () {
    delete_files_in_folder ~ ".DS_Store"
    # other stuff here if needed
}

collectionexport () {
    mongoexport --db $1 --collection $2 --out $2.mongoexport
}
collectionimport () {
    mongoimport --db $1 --collection $2 --file $2.mongoexport
}

# git stuff
git config --global alias.undo-commit 'reset --soft HEAD^'
alias network="git log --graph --decorate --oneline"


tagit () {
    git tag -a $1 -m $1
}
