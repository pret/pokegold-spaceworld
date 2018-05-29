SECTION "HRAM", HRAM[$FF80]

hOAMDMA:: ; ff80
    ds 10


    ds 14 ; TODO


hROMBank:: ; ff98
    db


hVBlank:: ; ff99
    db


    ds 54 ; TODO


hLCDCPointer:: ; ffd0
    db


    ds 3 ; TODO


hSerialRecieved:: ; ffd4
    db

hLinkPlayerNumber:: ; ffd5
    db


    db ; TODO


hSerialSend:: ; ffd7
    db
hSerialRecieve:: ; ffd8
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
