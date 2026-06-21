BattleCommand_Conversion2:
	ld hl, wEnemyMonType
	ldh a, [hBattleTurn]
	and a
	jr z, .got_type
	ld hl, wBattleMonType

.got_type
	ld a, [wAttackMissed]
	and a
	jr nz, .failed
	call LoadMoveAnim
	ld a, [hli]
	ld b, a
	ld c, [hl]

.loop
	call BattleRandom
	and %11111
; Exclude types the target already has.
	cp b
	jr z, .loop
	cp c
	jr z, .loop

; BUG: Hasn't been modified to include Metal and Dark types yet.
	cp TYPE_METAL
	jr c, .okay
	cp UNUSED_TYPES_END
	jr c, .loop
	cp TYPE_DARK
	jr c, .okay
	jr .loop

.okay
	ld [hld], a
	ld [hl], a
	ld [wNamedObjectIndexBuffer], a
	predef GetTypeName
	ld hl, .TransformedTypeText
	jp PrintText

.TransformedTypeText
	text "<TARGET>の　タイプを"
	line "@"
	text_from_ram wStringBuffer1
	text "に　かえた！"
	prompt

.failed
	jp PrintDidntAffectText
