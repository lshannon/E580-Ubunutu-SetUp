# E580 Ubunutu 20.01 Java Developer SetUp

Script to set up a base Ubuntu 20.01 for Java development on a E580 Thinkpad. This is a work in progress. Use at your own risk.

## Environment Options

This sets up:

- STS
- Java 11
- Maven
- Node
- Visual Studio Code (text editing)

## Observations

More than once my machine has not shut down correctly and corrupted my OS. This script is useful for recovering from this situation.

## Before Running The Script

Replace the <user> in the STS.desktop file. This can be done after the file has been copied to the desktop
  
## Usage
  
```shell
  
sudo ./setup-java-dev.sh
  
```
  
## Setting Up SSH

```shell

ssh-keygen -t ed25519 -C "your_email@example.com"ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

```
Follow these directions to complete setting up the new SSH key in Github:

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
  
## Notes

