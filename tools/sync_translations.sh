#!/bin/bash

SPREADSHEET_KEY=1ThSNpQWQjSt_QfWeAuN411otkG8ZxFFA2hhl9TosB34
SHEETS=(
    # CSV path, GID
    hack/intro.csv            1521166950
    hack/PlayersHouse1F.csv   157586730
    hack/PlayersHouse2F.csv   961494702
    hack/Route1Gate1F.csv     640558502
    hack/Route1Gate2F.csv     8926885
    hack/Route1P1.csv         438381029
    hack/Route1P2.csv         2013016190
    hack/SilentHills.csv      2145947014
    hack/SilentHouse.csv      207731727
    hack/SilentLabP1.csv      549369982
    hack/SilentLabP2.csv      1367866430
    hack/SilentPokecenter.csv 245025873
)

for (( i = 0; i < ${#SHEETS[@]}; i += 2 ))
do
    echo "Fetching ${SHEETS[i]}..."
    wget -q --no-check-certificate -O ${SHEETS[i]} "https://docs.google.com/spreadsheets/d/${SPREADSHEET_KEY}/export?format=csv&gid=${SHEETS[i + 1]}"
done

echo "All done!"
