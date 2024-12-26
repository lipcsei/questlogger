#!/bin/bash

# A forrás és cél könyvtárak elérési útjainak beolvasása a parancssori argumentumokból
forraskonyvtar='/Applications/World of Warcraft/_classic_era_/Interface/AddOns/QuestLogger'
celkonyvtar='/Applications/World of Warcraft/_retail_/Interface/AddOns'

# Ellenőrizzük, hogy a forráskönyvtár létezik-e
if [ ! -d "$forraskonyvtar" ]; then
    echo "A forráskönyvtár nem létezik: $forraskonyvtar"
    exit 1
fi

# Másoljuk át a könyvtárat a cél helyre az rsync segítségével
# Az -a kapcsoló az archív módot jelenti, ami rekurzívan másol és megőrzi az engedélyeket, tulajdonosokat stb.
# Az -v kapcsoló a verbose (bőbeszédű) módot jelenti, ami több információt nyújt a másolás folyamatáról
rsync -av "$forraskonyvtar" "$celkonyvtar"

# Ellenőrizzük, hogy a másolás sikeres volt-e
if [ "$?" -eq 0 ]; then
    echo "A könyvtár sikeresen átmásolva: $forraskonyvtar -> $celkonyvtar"
else
    echo "Hiba történt a könyvtár átmásolása közben."
    exit 1
fi