INCLUDE "constants.asm"

SECTION "engine/link/place_waiting_text.asm", ROMX

PlaceWaitingText::
	hlcoord 3, 10
	ld b, 1
	ld c, 11
	ld a, [wBattleMode]
	and a
	jr z, .link_textbox
	call DrawTextBox
	jr .textbox_done

.link_textbox
	predef LinkTextboxAtHL
.textbox_done
	hlcoord 4, 11
	ld de, .Waiting
	call PlaceString
	ld c, 50
	jp DelayFrames

.Waiting
	db "つうしんたいきちゅう！@"
