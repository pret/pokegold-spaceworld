BattleCommand_Attract:
; Get player's species.
	ld a, [wBattleMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
; Use that to determine gender.
	xor a ; PARTYMON
	ld [wMonType], a
	callfar GetGender
; Get enemy's species
	push af
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
; Use that to determine gender.
	ld a, TEMPMON
	ld [wMonType], a
	callfar GetGender

; Retrieves both values of register f, and checks if they have the same gender.
; Inherits issues from GetGender: gender-unknown monsters are considered female.
	push af
	pop bc
	ld a, c
	pop bc
	xor c
	bit 4, a
	jr z, .failed

	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus1

.got_substatus
	call CheckHiddenOpponent
	jr nz, .failed

	bit SUBSTATUS_IN_LOVE, [hl]
	jr nz, .failed

	set SUBSTATUS_IN_LOVE, [hl]
	call LoadMoveAnim
	ld hl, .FellInLoveText
	jp PrintText

.FellInLoveText:
	text "<TARGET>は"
	line "メロメロに　なった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed
