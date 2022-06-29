#!/bin/bash
# Source found at: https://github.com/lshannon/Ubunutu-Java-Dev-SetUp

DIVIDER=$DIVIDER

echo $DIVIDER
echo "This script will set up the following: "
echo $DIVIDER
echo ""
echo "SDKman (https://sdkman.io/)"
echo "STS 4.14.1 (https://spring.io/tools) **optional"
echo "Java 17 Oracle Disto (via SDKman)"
echo "Maven (lastest - via SDKman)"
echo "Node v0.39.1 (https://github.com/nvm-sh/nvm#installing-and-updating)"
echo "Visual Studio Code (text editing)"
echo "Docker - https://docs.docker.com/engine/install/ubuntu/"
echo $DIVIDER
echo "https://github.com/lshannon/Ubunutu-Java-Dev-SetUp"
echo $DIVIDER

# Verify this is good before proceeding
echo "Are good to continue? (Type 'Y' to proceed)"
read CONFIRMATION
if [ "$CONFIRMATION" != "Y" ]; then
  echo "Terminating the program - have a good one!"
  exit 0;
fi

# Check if this is running as sudo
if [ "$EUID" -ne 0 ]
  then echo "This script needs to run as sudo. Please re-execute as sudo"
  exit
fi

# All Set Up Logic

collect_username() {
  echo $DIVIDER
  echo "What is the username you will be doing Java development with? This will be used to determine where to create folders and copy resources too"
  echo $DIVIDER
  read USERNAME

  echo "You have provided: '$USERNAME', folders and tools will be copied/created under: '/home/$USERNAME'? (Type 'Y' to proceed)"
  read CONFIRMATION
  if [ "$CONFIRMATION" != "Y" ]; then
    echo "Terminating the program - take it easy my friend"
    exit 0;
  fi
  echo $DIVIDER
}

create_folders() {
  echo $DIVIDER
  echo "Creating folders: tools, source, workspace"
  echo $DIVIDER
  #set up all the different folders
  mkdir /home/$USERNAME/tools
  mkdir /home/$USERNAME/source
  mkdir /home/$USERNAME/workspace
  echo $DIVIDER
  echo ""
}

update_curl() {
  echo $DIVIDER
  echo "Ubuntu's version of CURL. In the past it has not played well with SDKman."
  echo "Removing existing and updating and installing a new one"
  echo $DIVIDER
  #fix curl for SDK man
  sudo snap remove curl
  sudo apt-get install curl
  echo $DIVIDER
  echo ""
}

download_sdk_man() {
  echo $DIVIDER
  echo "Downloading and installing SDKman"
  echo $DIVIDER
  #install SDK Man
  curl -s "https://get.sdkman.io" | bash
  source "/home/$USERNAME/.sdkman/bin/sdkman-init.sh"
  echo $DIVIDER
  echo ""
}

install_java() {
  echo $DIVIDER
  echo "Installing Java 17 - Oracle version"
  echo $DIVIDER
  #install Java with SDK man
  sdk install java 17.0.2-oracle
  echo $DIVIDER
  java --version
  echo ""
}

install_mvn() {
  echo $DIVIDER
  echo "Installing latest version of mvn"
  echo $DIVIDER
  #install Maven with SDK man
  sdk install maven
  echo $DIVIDER
  echo "mvn -v"
  echo ""
}

install_nvm() {
  echo $DIVIDER
  echo "Downloading and installing NVM"
  echo $DIVIDER
  #install NVM
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  echo $DIVIDER
  nvm --version
  echo ""
}

install_vscode() {
  echo $DIVIDER
  echo "Installing Visual Studio Code"
  echo $DIVIDER
  #set up Visual Studio code
  sudo snap install --classic code
  echo $DIVIDER
  echo ""
}

install_github() {
  echo $DIVIDER
  echo "Installing Github"
  echo $DIVIDER
  #set up Github
  sudo apt-get update
  sudo apt-get install git
  echo $DIVIDER
  git --version
  echo ""
}

install_sts() {
  echo $DIVIDER
  echo "Would you like to download and install STS?"
  echo "Type 'Y' to install"
  echo $DIVIDER
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
  echo $DIVIDER
  echo ""
}

install_postgres() {
  echo $DIVIDER
  echo "Getting Postgres"
  echo $DIVIDER
  #Get Postgres
  sudo apt install postgresql postgresql-contrib
  echo "For more information about Postgres setup: https://wiki.crowncloud.net/?How_To_Install_PostgreSQL_on_Ubuntu_21_04"
  echo "For a great tool to work with Postgres: https://dbeaver.io/download/"
  echo $DIVIDER
  echo ""
}

install_docker() {
  echo $DIVIDER
  echo "Setting Up Docker"
  echo $DIVIDER
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
  echo $DIVIDER
  echo ""
}

setup_video_extras() {
  echo $DIVIDER
  echo "Updating OS to play videos with DRM"
  echo $DIVIDER
  #Set for video place
  sudo apt install ubuntu-restricted-extras
  echo $DIVIDER
  echo ""
}

setup_github() {
  echo "What is the email address you use for Github? This will be used to create your SSH Key for Github (https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)"
  read EMAIL
  echo "You have provided: '$EMAIL' (Type 'Y' to proceed)"
  read $EMAIL
  if [ "$EMAIL" -eq "Y" ]; then
    ssh-keygen -t ed25519 -C "$EMAIL"ssh-keygen -t ed25519 -C "$EMAIL"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo $DIVIDER
    echo "Run: 'cat ~/.ssh/id_ed25519.pub' and copy them into Github -> Settings -> SSH and GPG keys -> New SSH key"
    echo "Github Set Up:"
    echo "Run git config --global --edit"
    echo $DIVIDER
  fi
}

post_installation_tips() {
  echo $DIVIDER
  echo "Post Installation Tips:"
  echo "https://linuxconfig.org/things-to-do-after-installing-ubuntu-20-04-focal-fossa-linux"
  echo $DIVIDER
  echo ""
  echo "Happy Coding My Friend! Have An Awesome Day! :-)"
}

# Execute Set Up
collect_username
create_folders
update_curl
download_sdk_man
install_java
install_mvn
install_nvm
install_vscode
install_github
install_sts
install_postgres
install_docker
setup_video_extras
setup_github
post_installation_tips

