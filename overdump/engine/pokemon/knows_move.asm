if DEF(_GOLD)
Unreferenced_Corrupt_AlreadyKnowsMoveText1:
	db "います"
	prompt

Unreferenced_Corrupt_AlreadyKnowsMoveText2:
	dw wStringBuffer2 ; This is missing the preceeding "text_from_ram" byte
	text "を　おぼえています"
	prompt

	db $28, $3c ; overdump
endc
if DEF(_SILVER)
Unreferenced_Corrupt_AlreadyKnowsMoveText1:
	db "ぼえています"
	prompt

Unreferenced_Corrupt_AlreadyKnowsMoveText2:
	db "を　おぼえています"
	prompt

	db $de, $3b ; overdump
endc

Unreferenced_Corrupt_KnowsMove:
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, .AlreadyKnowsMoveText
	call PrintText
	scf
	ret

.AlreadyKnowsMoveText:
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt
