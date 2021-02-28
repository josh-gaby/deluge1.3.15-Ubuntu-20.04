# Install Deluge 1.3.15 on Ubuntu 20.04

Version 2.x of Deluge cannot be used as a thin client for version 1.x, this is a problem if you have a remote download client that doesnt support 2.x (feralhosting.com)

### Installation

Download the updater script:

`wget https://raw.githubusercontent.com/josh-gaby/deluge1.3.15-Ubuntu-20.04/main/install_deluge-1.3.15.sh`

OR clone using Git

`git clone https://github.com/josh-gaby/deluge1.3.15-Ubuntu-20.04`

Make the script executable:

`chmod +x install_deluge-1.3.15.sh`

Run the script as sudo:

`sudo ./install_deluge-1.3.15.sh`
