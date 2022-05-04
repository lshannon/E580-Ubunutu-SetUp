#!/bin/bash
# Source found at: https://github.com/lshannon/E580-Ubunutu-SetUp

#check if this is running as sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as sudo"
  exit
fi

echo "What is the username you will be doing Java development with?"
read USERNAME

echo "You have provided: '$USERNAME', folders and tools will be copied/created under: '/home/$USERNAME'? (Type 'Y' to proceed)"
read CONFIRMATION
if [ "$CONFIRMATION" != "Y" ]; then
  echo "Terminating the program"
  exit 0;
fi

echo "Creating folders: tools, source, workspace"
#set up all the different folders
mkdir /home/$USERNAME/tools
mkdir /home/$USERNAME/source
mkdir /home/$USERNAME/workspace

echo "Ubuntu's version of CURL has not played well with SDKman in the past. Removing this and updating and installing a new one"
#fix curl for SDK man
sudo snap remove curl
sudo apt-get install curl

echo "Downloading and installing SDKman"
#install SDK Man
curl -s "https://get.sdkman.io" | bash
source "/home/$USERNAME/.sdkman/bin/sdkman-init.sh"

echo "Installing Java 17 - Oracle version"
#install Java with SDK man
sdk install java 17.0.2-oracle

echo "Installing latest version of mvn"
#install Maven with SDK man
sdk install maven

echo "Downloading and installing NVM"
#install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "Installing Visual Studio Code"
#set up Visual Studio code
sudo snap install --classic code

echo "Installing Github"
#set up Github
sudo apt-get update
sudo apt-get install git

echo "Getting STS"
#get STS
wget https://download.springsource.com/release/STS4/4.14.1.RELEASE/dist/e4.23/spring-tool-suite-4-4.14.1.RELEASE-e4.23.0-linux.gtk.x86_64.tar.gz
tar -C ~/tools -zxvf spring-tool-suite-4-4.14.1.RELEASE-e4.23.0-linux.gtk.x86_64.tar.gz

echo "Copying the short cut file on to the Desktop"
cp STS.desktop /home/$USERNAME/Desktop

echo "Updating the <username> in the shortcut file to: $USERNAME"
sed -i "s/<username>/$USERNAME/" /home/$USERNAME/Desktop/STS.desktop

echo "Right click on STS.desktop on the desktop and enable 'Launching'"

echo "Getting Postgres"
#Get Postgres
sudo apt install postgresql postgresql-contrib

echo "For more information about Postgres setup: https://wiki.crowncloud.net/?How_To_Install_PostgreSQL_on_Ubuntu_21_04"

echo "For a great tool to work with Postgres: https://dbeaver.io/download/"

echo "Updating OS to play videos with DRM"
#Set for video place
sudo apt install ubuntu-restricted-extras

echo "Post Installation Tips:"
echo "https://linuxconfig.org/things-to-do-after-installing-ubuntu-20-04-focal-fossa-linux"

echo "Github Set Up:"
echo "Run git config --global --edit"
