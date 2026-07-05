BattleCommand_LeechSeed:
	ld a, [wAttackMissed]
	and a
	jr nz, .evaded

	ld hl, wEnemySubStatus4
	ld de, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wPlayerSubStatus4
	ld de, wBattleMonHP

.ok
; BUG: Code assumes de contains the target's type, when it actually contains HP.
; The move always fails if target's HP modulo 256 is exactly 22.
	ld a, [de]
	cp TYPE_GRASS
	jr z, .evaded
	inc de
	ld a, [de]
	cp TYPE_GRASS
	jr z, .evaded

	bit SUBSTATUS_LEECH_SEED, [hl]
	jr nz, .evaded
	set SUBSTATUS_LEECH_SEED, [hl]
	call LoadMoveAnim
	ld hl, WasSeededText
	jp PrintText

.evaded
	call BattleCommand_MoveDelay
	ld hl, EvadedText
	jp PrintText

WasSeededText:
	text "<TARGET>に"
	line "たねを　うえつけた！"
	prompt

EvadedText:
	text "<TARGET>は"
	line "こうげきを　かわした！"
	prompt
