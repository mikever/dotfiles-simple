# Command line
    PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;32m\]$(if git rev-parse --git-dir > /dev/null 2>&1; then echo " - ["; fi)$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]$(if git rev-parse --git-dir > /dev/null 2>&1; then echo "]"; fi)\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

# List directory after changing directory
function cd {
        builtin cd "$@" && ls -F
}

ZSH_THEME="af-magic"

plugins=(
  git
  vi-mode
)

# CONVENIENCE COMMANDS

# git commands
alias glod="git log --oneline --decorate"
alias gs="git status --short"
alias gaa="git add -A :/$*"
alias gcm="git commit -m $*"
alias gdt="git difftool"

# terminal commands
alias lal="ls -al"
alias cpwd="pwd | tr -d '\n' | pbcopy"

# CD and LS
function cd {
    builtin cd "$@" && ls -F
}

# ctags setup
ctags=/usr/local/bin/ctags

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
