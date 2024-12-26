#!/bin/bash

wowType="_classic_era_" # "_classic_era_" vagy "_retail_"
accountNumber="401798421#1"

# Könyvtár útvonala
directory="/Applications/World of Warcraft/$wowType/WTF/Account/$accountNumber/SavedVariables"

# Fájlok törlése
rm -f "$directory/QuestLogger.lua"
rm -f "$directory/QuestLogger.lua.bak"

echo "A QuestLogger.lua és QuestLogger.lua.bak fájlok törölve lettek a $directory könyvtárból."
