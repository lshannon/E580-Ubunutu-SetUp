#!/bin/bash

#set up all the different folders
mkdir ~/tools
mkdir ~/source
mkdir ~/workspace

#fix curl for SDK man
sudo snap remove curl
sudo apt-get install curl

#install SDK Man
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

#install Java with SDK man
sdk install java 11.0.11.j9

#install Maven with SDK man
sdk install maven

#install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

#set up Visual Studio code
sudo snap install --classic code

#set up Github
sudo apt-get update
sudo apt-get install git

#get STS
wget https://download.springsource.com/release/STS4/4.13.0.RELEASE/dist/e4.22/spring-tool-suite-4-4.13.0.RELEASE-e4.22.0-linux.gtk.x86_64.tar.gz
tar -C ~/tools -zxvf spring-tool-suite-4-4.13.0.RELEASE-e4.22.0-linux.gtk.x86_64.tar.gz
cp STS.desktop ~/Desktop

echo "Right click on STS.desktop on the desktop and enable launching"

#Get Postgres
sudo apt install postgresql postgresql-contrib

echo "https://wiki.crowncloud.net/?How_To_Install_PostgreSQL_on_Ubuntu_21_04"

echo "https://dbeaver.io/download/"

#Set for video place
sudo apt install ubuntu-restricted-extras

echo "Post Installation Tips:"
echo "https://linuxconfig.org/things-to-do-after-installing-ubuntu-20-04-focal-fossa-linux"

echo "Github Set Up:"
echo "Run git config --global --edit"
