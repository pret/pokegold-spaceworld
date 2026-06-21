BattleCommand_GetMagnitude:
	push bc
	call BattleRandom
	ld b, a
	ld hl, MagnitudePower
.loop
	ld a, [hli]
	cp b
	jr nc, .ok
	inc hl
	inc hl
	jr .loop

.ok
	ld d, [hl]
	push de
	inc hl
	ld a, [hl]
	ld [wTextDecimalByte], a
	call BattleCommand_MoveDelay
	ld hl, MagnitudeText
	call PrintText
	pop de
	pop bc
	ret

MagnitudeText:
	text "マグニチュード@"
	deciram wTextDecimalByte, 1, 1
	text "！！"
	prompt

INCLUDE "data/moves/magnitude_power.inc"
