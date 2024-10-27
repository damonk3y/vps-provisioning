#! /bin/bash

set -e

echo "-> setup build-essentials"
sudo apt-get install build-essential
echo "-> setting up vps"
sudo apt update
sudo apt upgrade -yls -la /usr/local/lib/docker/cli-plugins/
echo "-> installing docker"
sudo apt install -y docker.io
echo "-> installing docker compose"
sudo apt install -y docker-compose
sudo apt-get update && sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "-> installing git"
sudo apt install -y git
echo "-> installing curl"
sudo apt install -y curl
echo "-> installing vim"
sudo apt install -y vim
echo "-> installing neovim"
sudo apt install -y neovim
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
if [ ! -f ~/.keys/github ]; then
    echo "-> setting up github ssh key"
    mkdir -p ~/.keys
    ssh-keygen -t ed25519 -f ~/.keys/github -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.keys/github
fi

sudo docker network create tardis_shared_network