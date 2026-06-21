BattleCommand_HiddenPower:
	ld a, [wAttackMissed]
	and a
	ret nz

	push bc
	ld hl, wBattleMonDVs
	ld bc, wPlayerMoveStructType
	ldh a, [hBattleTurn]
	and a
	jr z, .got_dvs_and_type
	ld hl, wEnemyMonDVs
	ld bc, wEnemyMoveStructType

.got_dvs_and_type

; Power:

; Take the top bit from each stat

	; Attack
	push bc
	ld a, [hl]
	swap a
	and %1000

	; Defense
	ld b, a
	ld a, [hli]
	and %1000
	srl a
	or b

	; Speed
	ld b, a
	ld a, [hl]
	swap a
	and %1000
	srl a
	srl a
	or b

	; Special
	ld b, a
	ld a, [hl]
	and %1000
	srl a
	srl a
	srl a
	or b

; Multiply by 5
	ld b, a
	add a
	add a
	add b

; Add Special & 3
	ld b, a
	ld a, [hld]
	and %0011
	add b

	ld d, a

; Type:

	; Def & 3
	ld a, [hl]
	and %0011
	ld b, a

	; + (Atk & 3) << 2
	ld a, [hl]
	and %0011 << 4
	swap a
	sla a
	sla a
	or b

; Skip Normal
	inc a

; Skip Bird
	cp TYPE_BIRD
	jr c, .done
	inc a

; Skip unused types
	cp UNUSED_TYPES
	jr c, .done
	add UNUSED_TYPES_END - UNUSED_TYPES

.done
; Overwrite the current move type.
	pop bc
	ld [bc], a
	pop bc
	ret
