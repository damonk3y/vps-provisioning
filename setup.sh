#! /bin/bash

set -e

echo "-> setup build-essentials"
sudo apt-get install build-essential
echo "-> setting up vps"
sudo apt-get update
sudo apt-get upgrade
if ! command -v zsh &> /dev/null
then
    echo "-> installing zsh"
    sudo apt install -y zsh
    echo "-> installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "-> installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/themes/powerlevel10k}
    echo "-> installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "-> installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    rm -rf zsh-syntax-highlighting
fi
echo "-> installing docker"
sudo apt install apt-transport-https ca-certificates curl software-properties-common
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce
sudo apt-get update
sudo apt-get install docker-compose-plugin
echo "-> installing git"
sudo apt install -y git
echo "-> installing curl"
sudo apt install -y curl
echo "-> installing vim"
sudo apt install -y vim
if [ ! -f ~/.keys/github ]; then
    echo "-> setting up github ssh key"
    mkdir -p ~/.keys
    ssh-keygen -t ed25519 -f ~/.keys/github -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.keys/github
fi

sudo docker network create tardis_shared_network