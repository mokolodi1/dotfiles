#!/bin/bash

# PS1
# \[\e[<type>;<color>m\] = colors
# \u = username
# \w = ~/thingies
# \$ = $ or # depending on if root
export PS1='\[\e[0;31m\]\u\[\e[0m\]:'
PS1+='\[\e[0;36m\]\w\[\e[0m\]:'
PS1+='\[\e[0;32m\]\j\[\e[0m\]'
PS1+='\$ '

# aliases
alias ll='ls -lA'
alias l='ls -CA'
alias gccw="gcc -Werror -Wextra -Wall -o a"
alias clean="find ~ -name \".DS_Store\" -depth -exec rm {} \;"
alias emacs='/usr/local/Cellar/emacs/24.3/bin/emacs'