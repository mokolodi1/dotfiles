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
	# \h = hostname  (old: \u = username)
	# \w = ~/thingies
	# \$ = $ or # depending on if root
	export PS1='\[\e[0;31m\]\h\[\e[0m\]:\[\e[0;36m\]\w\[\e[0m\]:\[\e[0;32m\]\j\[\e[0m\]\$ '
fi

# color iTerm tab based on host
# NOTE: this has to be done before we alias cd to also run ls
if hash python2.7 2>/dev/null; then
    # dirname is the directory in which this file is
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    python2.7 $DIR/rainbow-parade.py .5 1
else
    echo "python2.7 not installed... Can't color iTerm tabs based on hostname."
fi

# aliases
#export LSCOLORS="cxfxexdxbxegedabagacad"
#alias ls='ls -G' # -G implied for rest of ls commands
alias ll='ls -lAh'
alias l='ls -CA1'

alias findinfiles='find . -type f -print0 | xargs -0 grep'
alias "su2c-dev"="ssh dtflemin@su2c-dev.ucsc.edu"

# ls after on every cd
if [ ! -z "$PS1" ]; then # only for interactive prompts
    function cd {
        builtin cd "$@" && l
    }
fi

# symlink atom if it's installed
atom_path="/Applications/Atom.app/Contents/Resources/app/atom.sh"
if [ -f $atom_path ]; then
    alias atom=$atom_path
fi

# mongo
collectionexport () {
    mongoexport --db $1 --collection $2 --out $2.mongoexport
}
collectionimport () {
    mongoimport --db $1 --collection $2 --file $2.mongoexport
}

# git
git config --global user.name "Teo Fleming" --replace-all
git config --global user.email "mokolodi1@gmail.com" --replace-all
git config --global core.editor emacs
git config --global alias.undo-commit 'reset --soft HEAD^'
alias gnetwork="git log --graph --decorate --oneline"

tagit () {
    git tag -a $1 -m $1
}

# watch
# ex: watch "ls -l"
watch () {
    if [ -z $1 ]; then
	echo 'Example: watch "ls -l"';
	return;
    fi
    
    while :;
    do
	clear
	date
	$1
	sleep 2
    done
}
