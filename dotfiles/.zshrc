################################################################################
# OH-MY-ZSH
################################################################################

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="gozilla"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

################################################################################
# PATH & ENVIRONMENT
################################################################################

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Custom Binaries
export PATH="$PATH:$HOME/Developer/Softwares/bin"

# Go
export GOPATH="$HOME/Developer/Softwares/go"
export PATH="$PATH:$GOPATH/bin"

# Volta
export PATH="$PATH:$HOME/.volta/bin"

# PNPM 
export PNPM_HOME="/Users/georgeblack/Library/pnpm"

# Google Cloud SDK
export PATH="$PATH:$HOME/Developer/Softwares/google-cloud-sdk/bin"

# AWS CLI
export AWS_CLI_AUTO_PROMPT=on-partial
export AWS_DEFAULT_PROFILE=george

# Sublime Text
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export EDITOR='subl -w'

# PNPM
export PATH="$HOME/Library/pnpm:$PATH"

################################################################################
# ALIASES
################################################################################

alias h='cd ~'
alias f='open -a Finder ./'
alias tf='terraform'
alias ssm='aws ssm start-session --target'
alias repos='cd ~/Developer/Repos'
alias awswhoami='echo $(aws sts get-caller-identity)'

################################################################################
# FUNCTIONS
################################################################################

# Create a timestamped Junkfile and open in Sublime
jf() {
  local dir="$HOME/Developer/Junkfiles"
  local ts=$(date +"%Y-%m-%d-%H-%M-%S")
  local file="$dir/${ts}.txt"

  touch "$file" || return 1
  subl "$file"
}

################################################################################
# DEFAULT DIRECTORY LOGIC
################################################################################

# Start new terminal sessions in ~/Developer/Repos
if [[ "$PWD" == "$HOME" ]]; then
  cd ~/Developer/Repos
fi
