BattleCommand_TryEscape:
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_turn
	ld a, [wBattleMode]
	dec a
	jr nz, .player_failed
; If player level >= enemy level, Teleport will succeed
	ld a, [wCurPartyLevel]
	ld b, a
	ld a, [wBattleMonLevel]
	cp b
	jr nc, .player_run
; c = player level + enemy level + 1
	add b
	ld c, a
	inc c

.loop_player
	call BattleRandom
	cp c
	jr nc, .loop_player
	srl b
	srl b
	cp b
	jr nc, .player_run

	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld a, [wPlayerMoveStruct]
; Print different fail text when using Teleport as opposed to Roar/Whirlwind
	cp MOVE_TELEPORT
	jp nz, PrintDidntAffectText
	jp PrintButItFailed

.player_run
	ld hl, UpdateBattleMonInParty
	call CallFromBank0F
	xor a
	ld [wNumHits], a
	inc a ; TRUE
	ld [wBattleEnded], a
	ld a, [wPlayerMoveStruct]
	jr .run_away

.player_failed
; BUG: This build plays the moves' animations even when they fail.
; This causes problems with Teleport's animation, which makes the user's sprite invisible.
; The invisibility sticks until another animation that reinstates the user's sprite plays.
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, IsUnaffectedText
	ld a, [wPlayerMoveStruct]
	cp MOVE_TELEPORT
	jp nz, PrintText
	jp PrintButItFailed

.enemy_turn
	ld a, [wBattleMode]
	dec a
	jr nz, .enemy_failed

	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr nc, .enemy_run
	add b
	ld c, a
	inc c

.loop_enemy
	call BattleRandom
	cp c
	jr nc, .loop_enemy
	srl b
	srl b
	cp b
	jr nc, .enemy_run

	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld a, [wEnemyMoveStruct]
	cp MOVE_TELEPORT
	jp nz, PrintDidntAffectText
	jp PrintButItFailed

.enemy_run
	ld hl, UpdateBattleMonInParty
	call CallFromBank0F
	xor a
	ld [wNumHits], a
	inc a ; TRUE
	ld [wBattleEnded], a
	ld a, [wEnemyMoveStruct]
	jr .run_away

.enemy_failed
; Same flaw as in the .player_failed section
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, IsUnaffectedText
	ld a, [wEnemyMoveStruct]
	cp MOVE_TELEPORT
	jp nz, PrintText
	jp TryPrintButItFailed

.run_away
	push af
	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld c, 20
	call DelayFrames
	pop af

	ld hl, FledFromBattleText
	cp MOVE_TELEPORT
	jr z, .print_flee_text

	ld hl, FledInFearText
	cp MOVE_ROAR
	jr z, .print_flee_text

	; MOVE_WHIRLWIND
	ld hl, BlownAwayText

.print_flee_text
	jp PrintText

FledFromBattleText:
	text "<USER>は　せんとうから"
	line "りだつした！"
	prompt

FledInFearText:
	text "<TARGET>は　おじけづいて"
	line "にげだした！"
	prompt

BlownAwayText:
	text "<TARGET>は"
	line "ふきとばされた！"
	prompt
