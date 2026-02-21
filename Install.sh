#!/bin/bash
# Why the fuck do I even have to do this? This shouldn't be so irritating
#Cleanup from possible existing installation, just comment this out if you don't want to do a clean install
HytaleSave="/home/$USER/.local/share/Hytale/UserData/Saves"
if [ -d "$HytaleSave" ]; then
	echo "Backing up $HytaleSave to MyHytaleSave"
	mkdir -p MyHytaleSave
	cp -r $HytaleSave/* MyHytaleSave/
fi

BackedUpSave="MyHytaleSave"

HytaleLauncherData="/home/$USER/.local/share/hytale-launcher"
if [ -d "$HytaleLauncherData" ]; then
	echo "Cleaning up previously installed launcher data"
	rm -rf "$HytaleLauncherData"
fi

HytaleGameData="/home/$USER/.local/share/Hytale"
if [ -d "$HytaleGameData" ]; then
	echo "Cleaning up previously installed Hytale game data"
	rm -rf "$HytaleGameData"
fi

LauncherInstallPath="/opt/hytale"
if [ -d "$LauncherInstallPath" ]; then
        echo "Cleaning up previously installed Launcher"
        rm -rf $LauncherInstallPath/*
fi

#Now for the actual download
echo "Downloading and installing Hytale launcher"
DLURL=$(curl https://launcher.hytale.com/version/release/launcher.json | jq -r '.download_url.linux.amd64.url')
echo $DLURL
sudo mkdir -p /opt/hytale/
sudo chown -R $USER /opt/hytale
curl $DLURL -o /opt/hytale/hytale-launcher.zip
7z x /opt/hytale/hytale-launcher.zip -o/opt/hytale/
rm /opt/hytale/hytale-launcher.zip

echo "Copying .desktop file"
cp hytale-launcher.desktop /home/$USER/.local/share/applications/hytale-launcher.desktop

if [ -d "$BackedUpSave" ]; then
        echo "Copying $BackedUpSave to $HytaleSave"
	mkdir -p "$HytaleSave"
        cp -r $BackedUpSave/* "$HytaleSave/"
fi

echo "Hytale Launcher installed!"
