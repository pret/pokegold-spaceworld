INCLUDE "constants.asm"

SECTION "engine/pokemon/correct_nick_errors.asm", ROMX

; Replace invalid name characters with question marks, or replaces entire name with "？" if no terminator is found.
; These characters include control characters, kana with diacritics they shouldn't have, and English letter tiles.
CorrectNickErrors:
	push bc
	push de
	ld b, MON_NAME_LENGTH
.checkchar
	ld a, [de]
	cp "@"
	jr z, .end
	ld hl, InvalidNicknameChars
	dec hl
.loop
	inc hl
	ld a, [hl]
	cp -1
	jr z, .done
	ld a, [de]
	cp [hl]
	inc hl
	jr c, .loop
	cp [hl]
	jr nc, .loop
	ld a, "？"
	ld [de], a
	jr .loop

.done
	inc de
	dec b
	jr nz, .checkchar
	pop de
	push de
	ld a, "？"
	ld [de], a
	inc de
	ld a, "@"
	ld [de], a
.end
	pop de
	pop bc
	ret

InvalidNicknameChars:
	db "<NULL>",   "オ゛" + 1
	db "<PLAY_G>", "ノ゛" + 1
	db "<NI>",     "<NO>" + 1
	db "<ROUTE>",  "<GREEN>" + 1
	db "<MOM>",    "┘" + 1
	db -1
