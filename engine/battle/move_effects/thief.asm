BattleCommand_Thief:
; BUG: No checks to prevent stealing mail, unlike in the final game.
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

; The player needs to be able to steal an item.

	call .playeritem
	ld a, [hl]
	and a
	ret nz

; The enemy needs to have an item to steal.

	call .enemyitem
	ld a, [hl]
	and a
	ret z

	ld [wNamedObjectIndexBuffer], a
	call BattleCommand_EffectChance
	ret nc

	xor a
	ld [hl], a
	ld [de], a
	call .playeritem

	ld a, [wNumSetBits]
	ld [hl], a
	ld [de], a
	jr .stole

.enemy

; The enemy can't already have an item.

	call .enemyitem
	ld a, [hl]
	and a
	ret nz

; The player must have an item to steal.

	call .playeritem
	ld a, [hl]
	and a
	ret z

	ld [wNamedObjectIndexBuffer], a
	call BattleCommand_EffectChance
	ret nc

; If the enemy steals your item,
; it's gone for good if you don't get it back.

	xor a
	ld [hl], a
	ld [de], a
	call .enemyitem

	ld a, [wNamedObjectIndexBuffer]
	ld [hl], a
	ld [de], a

.stole
	call GetItemName
	ld hl, StoleText
	call PrintText
	ret

.playeritem
	ld hl, wPartyMon1Item
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wBattleMonItem
	ret

.enemyitem
	ld hl, wOTPartyMon1Item
	ld a, [wCurOTMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonItem
	ret

StoleText:
	text "<USER>は　<TARGET>から"
	line "@"
	text_from_ram wStringBuffer1
	text "を　うばいとった！"
	prompt
