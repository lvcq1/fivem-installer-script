# FiveM Server-Installer Script v1.5.1

Build: latest recommend build

OS: Linux

## What is installed?
FiveM-Server artifacts, cfx-server-data, ESX-Framework and MariaDB Server (both can be rejected)

## How to install?
1. Go to a folder of your choice
2. ```apt install git```
3. ```git clone https://github.com/lvcq1/fivem-installer-script.git installer-script```
4. ```cd installer-script```
5. ```./installer.sh```
6. Follow the script...
7. When it's finished installing, you can delete the script with ```rm installer.sh``` if you want.

## Contributors
https://github.com/Razuuu & https://github.com/lvcq1

## Planned updates for the future
select whether you want to use txadmin
* if yes, you will be able to choose whether you want to install a framework that is installed by txadmin, or upload it yourself
* if you want to upload it yourself, there will still be the possibility that the script will install it, if you want that you can choose from different framework versions
* if you don't want to upload it yourself, you can then choose whether you want to use the server.cfg from txadmin or the official one from fivem.net
* 
* with both answers you will be asked if you have a database, if no, a mysql server will be installed, web server, and phpmyadmin. If yes, the script is terminated.

with the different frameworks the script will install everything correctly
* if it will be too complicated for the script, a file will be created containing everything you need to do after the installation of the server.

Eventual support for RedM in version 2.0.0
* The script (2.0.0) may also be able to install Server for RedM