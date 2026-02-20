#!/bin/bash
# Why the fuck do I even have to do this? This shouldn't be so irritating
#Cleanup from possible existing installation, just comment this out if you don't want to do a clean install
echo "Cleaning up from possible existing installation"
rm -rf ~/.local/share/hytale-launcher/
rm -rf ~/.local/share/Hytale/

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
cp hytale-launcher.desktop ~/.local/share/applications/hytale-launcher.desktop

echo "Hytale Launcher is freshly installed!"
