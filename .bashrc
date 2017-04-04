# fixes something bad so we don't load this twice I think
[ -z "$PS1" ] && return

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

    # Sexy Solarized Bash Prompt, inspired by "Extravagant Zsh Prompt"
    # Customized for the Solarized color scheme by Sean O'Neil

    if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then TERM=gnome-256color; fi
    if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
	    BASE03=$(tput setaf 234)
	    BASE02=$(tput setaf 235)
	    BASE01=$(tput setaf 240)
	    BASE00=$(tput setaf 241)
	    BASE0=$(tput setaf 244)
	    BASE1=$(tput setaf 245)
	    BASE2=$(tput setaf 254)
	    BASE3=$(tput setaf 230)
	    YELLOW=$(tput setaf 136)
	    ORANGE=$(tput setaf 166)
	    RED=$(tput setaf 160)
	    MAGENTA=$(tput setaf 125)
	    VIOLET=$(tput setaf 61)
	    BLUE=$(tput setaf 33)
	    CYAN=$(tput setaf 37)
	    GREEN=$(tput setaf 64)
	else
	    BASE03=$(tput setaf 8)
	    BASE02=$(tput setaf 0)
	    BASE01=$(tput setaf 10)
	    BASE00=$(tput setaf 11)
	    BASE0=$(tput setaf 12)
	    BASE1=$(tput setaf 14)
	    BASE2=$(tput setaf 7)
	    BASE3=$(tput setaf 15)
	    YELLOW=$(tput setaf 3)
	    ORANGE=$(tput setaf 9)
	    RED=$(tput setaf 1)
	    MAGENTA=$(tput setaf 5)
	    VIOLET=$(tput setaf 13)
	    BLUE=$(tput setaf 4)
	    CYAN=$(tput setaf 6)
	    GREEN=$(tput setaf 2)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
    else
    # Linux console colors. I don't have the energy
    # to figure out the Solarized values
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	WHITE="\033[1;37m"
	BOLD=""
	RESET="\033[m"
    fi

    # needed in the PS1
    parse_git_dirty () {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
    }
    parse_git_branch () {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
    }

    PS1="\[${BOLD}${CYAN}\]\u \[$BASE0\]at \[$CYAN\]\h \[$BASE0\]in \[$BLUE\]\w\[$BASE0\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$YELLOW\]\$(parse_git_branch)\[$BASE0\]\n\$ \[$RESET\]"
fi

# # color iTerm tab based on host
# # NOTE: this has to be done before we alias cd to also run ls
# if hash python2.7 2>/dev/null; then
#     # dirname is the directory in which this file is
#     DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#     python2.7 $DIR/rainbow-parade.py .5 1
# else
#     echo "python2.7 not installed... Can't color iTerm tabs based on hostname."
# fi

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
        builtin cd "$@" && ll
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
git config --global credential.helper "cache --timeout=7884000"
alias gnetwork="git log --graph --decorate --oneline"

# open the GitHub network page
ghubnet () {
    url="$(git remote -v | tr " " "\t" | cut -f 2 | head -1)/network";
    open $url;
}

# open the CircleCI page
circleci () {
    open "$(git remote -v | tr " " "\t" | cut -f 2 | head -1 | sed 's/github.com/circleci.com\/gh/')"
}

tagit () {
    git tag -a $1 -m $1
}

# watch script from the internet
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
