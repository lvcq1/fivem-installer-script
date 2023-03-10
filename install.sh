#!/bin/bash

# Vars

function WRONG_ANSWER {
echo "Wrong answer, please use option above!"
}

clear

BUILD="5848-4f71128ee48b07026d6d7229a60ebc5f40f2b9db"
TMP_FOLDER="/tmp/fivem-installer"

# Install dependencies
APT_PACKAGELIST=""
PACKAGELIST="curl screen git tar xz-utils"
for PACKAGE in $PACKAGELIST; do
	[ -z $(which $PACKAGE) ] && APT_PACKAGELIST="$APT_PACKAGELIST $PACKAGE"
done
[ ! -z "$APT_PACKAGELIST" ] && echo "Install dependencies, this takes some time..." \
&& apt-get update -y >/dev/null && apt-get install -y $APT_PACKAGELIST >/dev/null

clear

# Download fivem server
mkdir -p $TMP_FOLDER
echo -e "Download FiveM Server build ${BUILD}, please wait...\n"
curl "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${BUILD}/fx.tar.xz" -o "${TMP_FOLDER}/fx.tar.xz" --progress-bar

clear

# Let user select fivem server location
echo "Select folder, where the FiveM server will be installed"
read -e -p " » " -i "/home/fivem" SELECTED_FOLDER

# Check if folder is empty
if [ ! -d ${SELECTED_FOLDER} ]; then
	mkdir -p ${SELECTED_FOLDER}
else
	echo "Selected folder is not empty, do you want to delete and create the folder?"
	while true; do
		read -p "(y/n): " yn
		echo
		case $yn in
			[Yy]) rm -rf ${SELECTED_FOLDER}; mkdir -p ${SELECTED_FOLDER}; break;;
			[Nn]) echo "Exit script!"; exit 0;;
			   *) echo "Wrong answer, try again";;
		esac
	done
fi

clear

echo "Move file to selected folder and go inside"
mv ${TMP_FOLDER}/fx.tar.xz ${SELECTED_FOLDER}/
cd ${SELECTED_FOLDER}

clear

echo "Extract and delete file"
tar xf fx.tar.xz
rm fx.tar.xz

clear

echo "Delete temp folder"
rm -rf ${TMP_FOLDER}

clear

echo -e "Installing cfx-server-data\n"
git clone https://github.com/citizenfx/cfx-server-data

clear

echo -e "Downloading server.cfg\n"
cd ${SELECTED_FOLDER}/cfx-server-data/
wget https://lvcq.xyz/dl/fm-ds/${BUILD}/server.cfg

clear

echo "Do you want to install ESX-Framework?"
while true; do
	read -e -p "(y/n): " -i "y" yn3
	case $yn3 in
		[Yy])
		echo "Which version do you want to install?"
		echo -e "1) ESX-Legacy (available but not tested yet)\n2) ESX-1.0 (recommended)\n"
		cd ${SELECTED_FOLDER}/cfx-server-data/resources/
		while true; do
			read -e -p " » " -i "2" ESX_VERSION
			case $ESX_VERSION in
				1) git clone https://github.com/lvcq1/esx_core
					cd ${SELECTED_FOLDER}/cfx-server-data/resources/
				 	mv * ${SELECTED_FOLDER}/cfx-server-data/resources/ ..
					cd ${SELECTED_FOLDER}/cfx-server-data/resources/; break;;
				2) git clone https://github.com/lvcq1/esx-framework-1.0 
					cd ${SELECTED_FOLDER}/cfx-server-data/resources/esx-framework-1.0 
				 	mv * ${SELECTED_FOLDER}/cfx-server-data/resources/ ..
					cd ${SELECTED_FOLDER}/cfx-server-data/resources/
					mv esx [esx]
					rm esx-framework-1.0 -r; break;;
				*) echo "Wrong answer, try again";;
			esac
		done
		break;;
		[Nn]) echo "Exit script!"; exit 0;;
		   *) echo "Wrong answer, try again";;
	esac
done

clear

echo "Do you have a Database?"
while true; do
                read -e -p "(y/n): " -i "n" yn4
                case $yn4 in
                        [Yy]) echo "Exit script!"; exit 0;;
                        [Nn]) echo "Install MariaDB-Server, please wait..."; apt-get install mariadb-server -y >/dev/null; break;;
                           *) echo "Wrong answer, try again";;
                esac
        done


exit 0
