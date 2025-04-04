#!/bin/bash
set -e
LOGFILE="script_log_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOGFILE") 2>&1


# Script: setup_automacao_debian12.sh
# Objetivo: Automatizar a configuração inicial de um sistema Debian 12

echo "==== Iniciando automação do Debian 12 ===="

echo ">> Atualizando pacotes e instalando utilitários básicos (vim, dos2unix)..."
apt update && apt install -y vim dos2unix

#echo ">> Configurando vim..."
#VIMRC="/etc/vim/vimrc"
#grep -qxF "syntax on" $VIMRC || echo "syntax on" >> $VIMRC
#grep -qxF "set background=dark" $VIMRC || echo "set background=dark" >> $VIMRC
#source $VIMRC

echo ">> Configurando interface de rede enp4s0..."
cat <<EOF > /etc/network/interfaces.d/enp4s0
allow-hotplug enp4s0
iface enp4s0 inet static
    address 10.1.1.54
    netmask 255.255.255.0
    network 10.1.1.0
    broadcast 10.1.1.255
    gateway 10.1.1.1
    dns-nameservers 10.1.1.25 10.1.1.252
    dns-search fullgauge.com.br
EOF

echo ">> Reiniciando serviço de rede..."
/etc/init.d/networking restart

echo ">> Atualizando repositórios oficiais do Debian 12 (Bookworm)..."
cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOF

apt -y update

echo ">> Baixando e executando script de setup personalizado..."
chmod +x instalacao_de_pacotes.sh
./instalacao_de_pacotes.sh

echo ">> Configurando sessão XFCE para XRDP..."
echo "startxfce4" > ~/.xsession
chmod +x ~/.xsession

echo ">> Ajustando /etc/xrdp/startwm.sh..."
sed -i 's/^test -x \/etc\/X11\/Xsession/#&/' /etc/xrdp/startwm.sh
sed -i 's/^exec \/bin\/sh \/etc\/X11\/Xsession/#&/' /etc/xrdp/startwm.sh
echo "startxfce4" >> /etc/xrdp/startwm.sh
chmod +x /etc/xrdp/startwm.sh

echo ">> Reiniciando serviços XRDP..."
systemctl restart xrdp
systemctl restart xrdp-sesman


echo ">> Coonfigurando o VSCode para executar como root..."
mkdir -p /root/.vscode-root
echo 'alias code-root="sudo code . --user-data-dir=/root/.vscode-root --no-sandbox"' >> ~/.bashrc
source ~/.bashrc

echo ">> Instalando pacotes adicionais (xfce4-terminal, dbus-x11)..."
apt install -y xfce4-terminal dbus-x11

echo ">> Instalando Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo ">> Limpando cache do APT..."
apt -y autoremove

echo "==== Finalização concluída! ===="