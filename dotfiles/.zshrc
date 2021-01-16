export ZSH="/Users/georgeblack/.oh-my-zsh"
ZSH_THEME="af-magic"
plugins=(git docker zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Rbenv Ruby Versions
export PATH=$HOME/.rbenv/bin:$PATH

# Java Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# Golang
export GOPATH=$HOME/Repositories/go
export PATH=$GOPATH/bin:$PATH

# Init Rbenv
eval "$(rbenv init -)"

# Init Pyenv
eval "$(pyenv init -)"

# Custom alias
alias h='cd ~'
alias dr='docker run'
alias dc='docker container'
alias db='docker build'
alias dn='docker network'
alias di='docker image'
alias serve='browser-sync start -s -f . --port 9000'
