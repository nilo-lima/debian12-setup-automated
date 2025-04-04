#!/bin/bash
set -e
LOGFILE="script_log_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOGFILE") 2>&1

#

# Script: instalacao_de_pacotes.sh
# Objetivo: Instalar os pacotes necessarios para o projeto


clear

echo ""
echo "--- Iniciando instalacao do ambiente de desenvolvimento by [ NHLJ ] ---"

clear && sleep 2
echo ""
echo "--- Atualizando lista de pacotes ---"
apt -y update

echo ""
echo "--- Atualizando o sistema ---"
apt -y full-upgrade

echo ""
echo "--- Instalando pacotes basicos para desenvolvimento ---"
apt -y install vim software-properties-common vim curl git binutils cpp flex gcc libarchive-zip-perl lynx m4 make ncftp nmap openssl unzip zip zlib1g-dev autoconf libtool bison autotools-dev g++ build-essential bzip2 

echo ""
echo "--- Instalando pacotes de rede ---"
apt -y install net-tools tcpdump iptraf-ng sysv-rc-conf debconf-utils libncurses5-dev bwm-ng iftop tcptrack dstat ifstat nload htop

echo ""
echo "[OK] --- Ambiente de desenvolvimento concluido ---"

# Instale apartir daqui o que você desejar 
echo ""
apt -y install wget curl unzip software-properties-common gnupg2
apt -y install postgresql-client
apt -y  install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev pkg-config

echo ""
echo "Preparando ambiente Docker e Docker Compose"
apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common jq bash-completion
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
apt update
apt -y install docker-ce docker-ce-cli containerd.io docker-compose

echo ""
echo "Executanto update novamente"
apt update
apt upgrade -y

echo ""
echo "Instalando bibliotecas para posterior instalação do Python 3.12.4"
apt install -y wget build-essential libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev libffi-dev libgdbm-compat-dev
apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git

echo ""
echo "Preparando ambiente para Dev Python + VsCode"
apt update && sudo apt upgrade -y
apt install build-essential curl wget git unzip -y

apt install python3-venv python3-pip -y

apt install git make gcc g++ cmake pkg-config libssl-dev libffi-dev -y

apt -y install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt -y update
apt -y install code

apt -y install lightdm
systemctl enable lightdm
systemctl set-default graphical.target
apt -y install xfce4 xfce4-goodies
echo "exec startxfce4" > ~/.xinitrc
chmod +x ~/.xinitrc

sudo apt -y update
sudo apt -y install xrdp xfce4 xfce4-goodies

echo "startxfce4" > ~/.xsession

sudo systemctl enable xrdp --now
sudo systemctl restart xrdp

echo "==== Instalação de pacotes concluída! ===="