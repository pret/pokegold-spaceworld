SECTION "PlaceWaitingText", ROMX[$4000],BANK[1]

PlaceWaitingText:: ; 1:4000
    hlcoord 3, 10
    ld b, 1
    ld c, 11
    ld a, [wBattleMode]
    and a
    jr z, .link_textbox
    call Textbox
    jr .textbox_done

.link_textbox
    predef Predef_LinkTextbox
.textbox_done
    hlcoord 4, 11
    ld de, .Waiting
    call PlaceString
    ld c, 50
    jp DelayFrames

.Waiting:
    db "Waiting...!@"