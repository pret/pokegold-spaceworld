BattleCommand_Transform:
	ld hl, wBattleMonSpecies
	ld de, wEnemyMonSpecies
	ld bc, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr nz, .ok
	ld hl, wEnemyMonSpecies
	ld de, wBattleMonSpecies
	ld bc, wPlayerSubStatus5
	xor a
	ld [wCurMoveNum], a

.ok
	call CheckHiddenOpponent
	jp nz, .failed
	push hl
	push de
	push bc
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus4

.got_substatus
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, 1
	ld [wBattleAnimParam], a
	bit SUBSTATUS_SUBSTITUTE, [hl]
	push af
	ld a, MOVE_SUBSTITUTE
	call nz, LoadBattleAnim
	ld a, [wOptions]
	add a ; check if BATTLE_SCENE is set
	jr c, .skip_anim
	call LoadMoveAnim
	jr .anim_played

.skip_anim
	callfar AnimationSubstitute

.anim_played
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, 2
	ld [wBattleAnimParam], a
	pop af
	ld a, MOVE_SUBSTITUTE
	call nz, LoadBattleAnim

	pop bc
	ld a, [bc]
	set SUBSTATUS_TRANSFORMED, a
	ld [bc], a
	pop de
	pop hl
	push hl

	ld a, [hli]
	ld [de], a
	inc hl
	inc de
	inc de
	ld bc, NUM_MOVES
	call CopyBytes

	ldh a, [hBattleTurn]
	and a
	jr z, .mimic_enemy_backup
	ld a, [de]
	ld [wEnemyBackupDVs], a
	inc de
	ld a, [de]
	ld [wEnemyBackupDVs + 1], a
	dec de

.mimic_enemy_backup
; copy DVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
; move pointer to stats
	ld bc, wBattleMonStats - wBattleMonPP
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, wBattleMonStructEnd - wBattleMonStats
	call CopyBytes

	ld bc, wBattleMonMoves - wBattleMonStructEnd
	add hl, bc
	push de
	ld d, h
	ld e, l
	pop hl
	ld bc, wBattleMonPP - wBattleMonStructEnd
	add hl, bc
	ld b, NUM_MOVES

.pp_loop
	ld a, [de]
	inc de
	and a
	jr z, .done_move
	ld a, 5
	ld [hli], a
	dec b
	jr nz, .pp_loop

.done_move
	pop hl
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
; Copy all stats except HP
	ld hl, wEnemyStats
	ld de, wPlayerStats
	ld bc, 2 * NUM_BATTLE_STATS
	call .BattleSideCopy

	ld hl, wEnemyStatLevels
	ld de, wPlayerStatLevels
	ld bc, (wPlayerEvaLevel + 1 - wPlayerAtkLevel) + 1
	call .BattleSideCopy
	ld hl, TransformedText
	jp PrintText

; Copy bc bytes from hl to de if it's the player's turn.
; Copy bc bytes from de to hl if it's the enemy's turn.
.BattleSideCopy
	ldh a, [hBattleTurn]
	and a
	jr z, .copy

; Swap hl and de
	push hl
	ld h, d
	ld l, e
	pop de

.copy
	jp CopyBytes

.failed
	jp PrintButItFailed

TransformedText:
	text "<USER>は"
	line "@"
	text_from_ram wStringBuffer1
	text "に　へんしんした！"
	prompt
