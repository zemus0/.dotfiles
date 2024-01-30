#!/bin/bash

if ! command -v asar &> /dev/null
then
    echo '`asar` need to be install' &>2
    exit
fi

electron_path=$(echo $HOME/.config/discordcanary/*/modules/discord_desktop_core)
extract_path="/tmp/extract_asar"

### create a backup
cp "$electron_path/core.asar" "$electron_path/core-backup.asar"

### extract asar
asar extract "$electron_path/core.asar" "$extract_path"

### get rid of menu bar 
# find path
app_index="$(grep -iRl 'mainWindow = new' "$extract_path" | grep -v node_modules)"
# replace
sed -i '/mainWindow = new/a \ \ mainWindow.removeMenu();' "$app_index"
# repack
asar pack "$extract_path" "$electron_path/core.asar"
