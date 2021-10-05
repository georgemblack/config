export ZSH="/Users/georgeblack/.oh-my-zsh"
ZSH_THEME="af-magic"
plugins=(git docker zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Rbenv
export PATH=$HOME/.rbenv/bin:$PATH

# Pyenv
export PATH=/Users/george.black/.pyenv/shims:$PATH

# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# Golang
export GOPATH=$HOME/Developer/go
export PATH=$GOPATH/bin:$PATH

# Custom alias
alias h='cd ~'
alias awswhoami='echo $(aws sts get-caller-identity)'
