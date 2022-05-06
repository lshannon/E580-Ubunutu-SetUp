#!/bin/bash
# Source found at: https://github.com/lshannon/Ubunutu-Java-Dev-SetUp

echo "****************************************************"
echo "This script will set up the following: "
echo "****************************************************"
echo "SDKman (https://sdkman.io/)"
echo "STS 4.14.1 (https://spring.io/tools) **optional"
echo "Java 17 Oracle Disto (via SDKman)"
echo "Maven (lastest - via SDKman)"
echo "Node v0.39.1 (https://github.com/nvm-sh/nvm#installing-and-updating)"
echo "Visual Studio Code (text editing)"
echo "Docker - https://docs.docker.com/engine/install/ubuntu/"
echo "****************************************************"
echo "https://github.com/lshannon/Ubunutu-Java-Dev-SetUp"
echo "****************************************************"

echo "Are good to continue? (Type 'Y' to proceed)"
read CONFIRMATION
if [ "$CONFIRMATION" != "Y" ]; then
  echo "Terminating the program - have a good one!"
  exit 0;
fi

#check if this is running as sudo
if [ "$EUID" -ne 0 ]
  then echo "This script needs to run as sudo. Please re-execute as sudo"
  exit
fi

echo "What is the username you will be doing Java development with? This will be used to determine where to create folders and copy resources too"
read USERNAME

echo "You have provided: '$USERNAME', folders and tools will be copied/created under: '/home/$USERNAME'? (Type 'Y' to proceed)"
read CONFIRMATION
if [ "$CONFIRMATION" != "Y" ]; then
  echo "Terminating the program - take it easy my friend"
  exit 0;
fi

echo "Creating folders: tools, source, workspace"
echo "****************************************************"
#set up all the different folders
mkdir /home/$USERNAME/tools
mkdir /home/$USERNAME/source
mkdir /home/$USERNAME/workspace
echo "****************************************************"
echo ""
echo "Ubuntu's version of CURL. In the passt it has not played well with SDKman. Removing existing and updating and installing a new one"
echo "****************************************************"
#fix curl for SDK man
sudo snap remove curl
sudo apt-get install curl
echo "****************************************************"
echo ""

echo "Downloading and installing SDKman"
echo "****************************************************"
#install SDK Man
curl -s "https://get.sdkman.io" | bash
source "/home/$USERNAME/.sdkman/bin/sdkman-init.sh"
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Installing Java 17 - Oracle version"
#install Java with SDK man
sdk install java 17.0.2-oracle
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Installing latest version of mvn"
#install Maven with SDK man
sdk install maven
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Downloading and installing NVM"
#install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Installing Visual Studio Code"
#set up Visual Studio code
sudo snap install --classic code
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Installing Github"
#set up Github
sudo apt-get update
sudo apt-get install git
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Would you like to download and install STS?"
echo "Type 'Y' to install"
read STS
if [ "$STS" -eq "Y" ]; then
  echo "Getting STS"
  wget https://download.springsource.com/release/STS4/4.14.1.RELEASE/dist/e4.23/spring-tool-suite-4-4.14.1.RELEASE-e4.23.0-linux.gtk.x86_64.tar.gz
  tar -C ~/tools -zxvf spring-tool-suite-4-4.14.1.RELEASE-e4.23.0-linux.gtk.x86_64.tar.gz
  echo "Copying the short cut file on to the Desktop"
  cp STS.desktop /home/$USERNAME/Desktop
  echo "Updating the <username> in the shortcut file to: $USERNAME"
  sed -i "s/<username>/$USERNAME/" /home/$USERNAME/Desktop/STS.desktop
  echo "Right click on STS.desktop on the desktop and enable 'Launching'"
fi
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Getting Postgres"
#Get Postgres
sudo apt install postgresql postgresql-contrib
echo "For more information about Postgres setup: https://wiki.crowncloud.net/?How_To_Install_PostgreSQL_on_Ubuntu_21_04"
echo "For a great tool to work with Postgres: https://dbeaver.io/download/"
echo "****************************************************"
echo ""

echo "Setting Up Docker"
echo "****************************************************"
sudo apt-get update
echo "Set up the repository"
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
echo "Add Docker’s official GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "Set up the stable repository"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Install Docker Engine"
sudo apt-get remove docker docker-engine docker.io containerd runc
echo "Test Docker"
sudo docker run hello-world
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Updating OS to play videos with DRM"
#Set for video place
sudo apt install ubuntu-restricted-extras
echo "****************************************************"
echo ""
echo "****************************************************"
echo "Post Installation Tips:"
echo "https://linuxconfig.org/things-to-do-after-installing-ubuntu-20-04-focal-fossa-linux"

echo "Github Set Up:"
echo "Run git config --global --edit"
echo "****************************************************"
echo ""
echo "Happy Coding My Friend! Have An Awesome Day! :-)"
