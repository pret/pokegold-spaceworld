INCLUDE "constants.asm"

SECTION "PlaceWaitingText", ROMX[$4000], BANK[$01]

PlaceWaitingText:: ; 1:4000
	hlcoord 3, 10
	ld b, 1
	ld c, 11
	ld a, [wBattleMode]
	and a
	jr z, .link_textbox
	call DrawTextBox
	jr .textbox_done

.link_textbox
	; TODO
	; predef Predef_LinkTextbox
	ld a, $1C
	call Predef
.textbox_done
	hlcoord 4, 11
	ld de, .Waiting
	call PlaceString
	ld c, 50
	jp DelayFrames

.Waiting
	db "つうしんたいきちゅう！@"
