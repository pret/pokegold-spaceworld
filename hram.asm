SECTION "HRAM", HRAM[$FF80]

hOAMDMA:: ; ff80
    ds 10


    ds 14 ; TODO


hROMBank:: ; ff98
    db


hVBlank:: ; ff99
    db


    ds 21 ; TODO

hSpriteWidth:: ; ffaf
hSpriteInterlaceCounter:: ; ffaf
    db 
hSpriteHeight:: ; ffb0
    db 
hSpriteOffset:: ; ffb1
    db
    ds 30 ; TODO


hLCDCPointer:: ; ffd0
    db


    ds 3 ; TODO


hSerialReceived:: ; ffd4
    db

hLinkPlayerNumber:: ; ffd5
    db


    db ; TODO


hSerialSend:: ; ffd7
    db
hSerialReceive:: ; ffd8
    db


hSCX:: db ; ffd9
hSCY:: db ; ffda
hWX:: db ; ffdb
hWY:: db ; ffdc

    db ; TODO

hBGMapMode:: ; ffde
    db

    db ; TODO

hBGMapAddress:: ; ffe0
    dw


    ds 6 ; TODO


hMapAnims:: ; ffe8
    ; TODO: figure out size


    ; TODO
