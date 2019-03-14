#!/bin/bash

SPREADSHEET_KEY=1ThSNpQWQjSt_QfWeAuN411otkG8ZxFFA2hhl9TosB34
SHEETS=(
    # CSV path, GID
    hack/text/intro.csv                   1521166950
    hack/text/field_moves.csv             1797457383
    hack/text/PlayersHouse1F.csv          157586730
    hack/text/PlayersHouse2F.csv          961494702
    hack/text/Route1Gate1F.csv            640558502
    hack/text/Route1Gate2F.csv            8926885
    hack/text/Route1P1.csv                438381029
    hack/text/Route1P2.csv                2013016190
    hack/text/SilentHills.csv             2145947014
    hack/text/SilentHouse.csv             207731727
    hack/text/SilentLabP1.csv             549369982
    hack/text/SilentLabP2.csv             1367866430
    hack/text/SilentPokecenter.csv        245025873
    hack/text/OldCityPokecenter2F.csv     711673974
    hack/text/OldCityPokecenterBattle.csv 175114979
    hack/text/OldCityPokecenterTrade.csv  189348153
    hack/text/ShizukanaOka.csv            152149892
)

for (( i = 0; i < ${#SHEETS[@]}; i += 2 ))
do
    echo "Fetching ${SHEETS[i]}..."
    wget -q --no-check-certificate -O ${SHEETS[i]} "https://docs.google.com/spreadsheets/d/${SPREADSHEET_KEY}/export?format=csv&gid=${SHEETS[i + 1]}"
done

echo "All done!"
