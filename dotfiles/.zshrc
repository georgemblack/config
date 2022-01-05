export ZSH="/Users/george/.oh-my-zsh"
ZSH_THEME="af-magic"
plugins=(git docker zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Rbenv
export PATH=$HOME/.rbenv/bin:$

# Pyenv
export PATH=/Users/george/.pyenv/shims:$PATH

# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"

# Yarn
export PATH="$PATH:$(yarn global bin)"

# Go
export GOPATH=$HOME/Developer/go
export PATH=$GOPATH/bin:$PATH

# Custom alias
alias h='cd ~'
alias f='open -a Finder ./'
alias tf='terraform'
alias awswhoami='echo $(aws sts get-caller-identity)'
