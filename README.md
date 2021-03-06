# Install Deluge 1.3.15 on Ubuntu 20.04 ~~or 20.10~~

Installing deluge using `apt install deluge` on Ubuntu 20.04~~or 20.10~~ results in version 2.x being installed and version 2.x of Deluge cannot be used as a thin client for version 1.x. This is a problem if you have a remote install that can't be upgraded to version 2.x and you don't want to use the Web GUI for everything.

Note: This can be installed on 20.10 by uncommenting two lines in the script, however the two extra required files cause gnome settings to disappear so this is not recommended until another workaround is found.

### Installation

Download the script:

`wget https://raw.githubusercontent.com/josh-gaby/deluge1.3.15-Ubuntu-20.04/main/install_deluge-1.3.15.sh`

OR clone using Git

`git clone https://github.com/josh-gaby/deluge1.3.15-Ubuntu-20.04`

Make the script executable:

`chmod +x install_deluge-1.3.15.sh`

Run the script as sudo:

`sudo ./install_deluge-1.3.15.sh`
