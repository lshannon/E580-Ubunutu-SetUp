# Ubunutu 20.04 Java Developer SetUp

In the past, more than once I have had to rebuild a Ubuntu machine due to an issue with the OS that have occured while using the machine. Most of these issues seemed to be caused with disk corruption following an incorrect shutdown (ie: laptop running out of battery).

This script is designed to run on a new Ubuntu machine and set up the Java Dev tools and stack I like to work with. There is no assurances offered, use at your own risk.

## Environment Options

This sets up:

- SDKman
- STS 4.14.1 (https://spring.io/tools)
- Java 17
- Maven (lastest)
- Node v0.39.1 (https://github.com/nvm-sh/nvm#installing-and-updating)
- Visual Studio Code (text editing)

## Before Running The Script

The script will need to run as sudo, however it will prompt you for your username as all the tools and config will be set up under your account
  
## Usage
  
```shell
  
sudo ./setup-java-dev.sh
  
```
## Disclaimer

This will download, create and install things on your Ubuntu system. Refer the script before running, use at your own risk.
