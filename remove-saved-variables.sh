#!/bin/bash

# Könyvtár útvonala
directory="/Applications/World of Warcraft/_classic_era_/WTF/Account/401798421#1/SavedVariables"

# Fájlok törlése
rm -f "$directory/QuestLogger.lua"
rm -f "$directory/QuestLogger.lua.bak"

echo "A QuestLogger.lua és QuestLogger.lua.bak fájlok törölve lettek a $directory könyvtárból."
