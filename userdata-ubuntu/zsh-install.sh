#!/bin/bash
apt-get update
apt-get install zsh git curl -y
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# change shell
chsh -s $(which zsh)