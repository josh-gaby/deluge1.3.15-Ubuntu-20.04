#!/bin/bash
# Just a script version of the answer here: https://askubuntu.com/a/1184229

echo " ___           _        _ _   ____       _                    _   _____  _ ____  "
echo "|_ _|_ __  ___| |_ __ _| | | |  _ \  ___| |_   _  __ _  ___  / | |___ / / | ___|"
echo " | || '_ \/ __| __/ _\` | | | | | | |/ _ \ | | | |/ _\` |/ _ \ | |   |_ \ | |___ \ "
echo " | || | | \__ \ || (_| | | | | |_| |  __/ | |_| | (_| |  __/ | |_ ___) || |___) |"
echo "|___|_| |_|___/\__\__,_|_|_| |____/ \___|_|\__,_|\__, |\___| |_(_)____(_)_|____/"
echo "                                                |___/                           "
echo ""

RED='\033[0;31m'
GRN='\033[0;32m'
YEL='\033[1;33m'
NC='\033[0m'

if [ "$EUID" -ne 0 ]
then
  printf "${RED}Please run script as root!${NC}\n\n"
  exit
fi

# Check if Deluge 1.3.15 is already installed
if command -v deluge &> /dev/null
then
  INSTALLED=$(deluge --version | head -n 1 | cut -d' ' -f2)
  if [[ $INSTALLED == "1.3.15" ]]
  then
    printf "${RED}Version 1.3.15 is already installed!${NC}\n\n"
    exit
  fi
fi

printf "${GRN}Switching to a temporary directory...${NC}\n"
TEMP_DIR=$(mktemp -d -t dlg_inst-XXXXXXXXXX)
cd $TEMP_DIR

printf "\n${GRN}Downloading the required files...${NC}\n"
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/libt/libtorrent-rasterbar/python-libtorrent_1.1.5-1build1_amd64.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/libt/libtorrent-rasterbar/libtorrent-rasterbar9_1.1.5-1build1_amd64.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/main/b/boost1.65.1/libboost-system1.65.1_1.65.1+dfsg-0ubuntu5_amd64.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/b/boost1.65.1/libboost-python1.65.1_1.65.1+dfsg-0ubuntu5_amd64.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/d/deluge/deluge-common_1.3.15-2_all.deb
wget -q --show-progress --progress=bar:force http://security.ubuntu.com/ubuntu/pool/main/t/twisted/python-twisted-core_17.9.0-2ubuntu0.1_all.deb
wget -q --show-progress --progress=bar:force http://security.ubuntu.com/ubuntu/pool/main/t/twisted/python-twisted-bin_17.9.0-2ubuntu0.1_amd64.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/main/i/incremental/python-incremental_16.10.1-3_all.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/python-glade2_2.24.0-5.1ubuntu2_amd64.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/python-gtk2_2.24.0-5.1ubuntu2_amd64.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/n/notify-python/python-notify_0.1.1-4_amd64.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/main/c/chardet/python-chardet_2.3.0-2_all.deb
wget -q --show-progress --progress=bar:force http://security.ubuntu.com/ubuntu/pool/universe/p/pyxdg/python-xdg_0.25-4ubuntu1.1_all.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/d/deluge/deluge-common_1.3.15-2_all.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/d/deluge/deluge-gtk_1.3.15-2_all.deb
wget -q --show-progress --progress=bar:force http://archive.ubuntu.com/ubuntu/pool/universe/d/deluge/deluge_1.3.15-2_all.deb

printf "\n${GRN}Setting ownership of files for apt...${NC}\n"
sudo chown _apt -R $TEMP_DIR

printf "\n${GRN}Installing packages...${NC}\n"
sudo apt install -qq -y ./*.deb

printf "\n${GRN}Locking version to 1.3.15...${NC}\n"
cat <<EOF | sudo tee /etc/apt/preferences.d/pin-deluge
Package: deluge
Pin: version 1.3.15-2
Pin-Priority: 1337

Package: deluge-common
Pin: version 1.3.15-2
Pin-Priority: 1337

Package: deluge-gtk
Pin: version 1.3.15-2
Pin-Priority: 1337

Package: libtorrent-rasterbar9
Pin: version 1.1.5-1build1
Pin-Priority: 1337
EOF

printf "\n${GRN}Cleaning up files...${NC}\n"
cd /
sudo rm -R $TEMP_DIR

# Check if Deluge 1.3.15 is installed
if command -v deluge &> /dev/null
then
  INSTALLED=$(deluge --version | head -n 1 | cut -d' ' -f2)
  if [[ $INSTALLED == "1.3.15" ]]
  then
    printf "\n${YEL}Deluge 1.3.15 has been succefully installed!${NC}\n\n"
    exit
  fi
fi
printf "\n${RED}Deluge 1.3.15 failed to install!${NC}\n\n"
