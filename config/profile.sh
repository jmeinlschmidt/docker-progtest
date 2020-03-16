#!/bin/bash
source /etc/bash_completion.d/git-prompt
source /usr/share/bash-completion/completions/git
export PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0;33m\]$(__git_ps1)\[\e[0m\]\$ '

export LS_OPTIONS='--color=auto'

# Temporarily disabled
# eval "`dircolors`"

# Colors!
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -la'

# Some more alias to avoid making mistakes
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Gcc compiler
alias g="gcc -Wall -pedantic -g -o a.out"
alias gf="gcc -Wall -pedantic -g -fsanitize=address -o a.out"
alias gg="g++ -Wall -pedantic -std=c++14 -g -o a.out"
alias ggf="g++ -Wall -pedantic -std=c++14 -g -fsanitize=address -o a.out"