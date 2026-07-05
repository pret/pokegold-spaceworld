BattleCommand_PerishSong:
	ld hl, wPlayerSubStatus1
	ld de, wEnemySubStatus1
	bit SUBSTATUS_PERISH, [hl]
	jr z, .ok

	ld a, [de]
	bit SUBSTATUS_PERISH, a
	jr nz, .failed

.ok
	bit SUBSTATUS_PERISH, [hl]
	jr nz, .enemy

	set SUBSTATUS_PERISH, [hl]
	ld a, 4
	ld [wPlayerPerishCount], a

.enemy
	ld a, [de]
	jr nz, .done

	set SUBSTATUS_PERISH, a
	ld [de], a
	ld a, 4
	ld [wEnemyPerishCount], a

.done
	call LoadMoveAnim
	ld hl, StartPerishText
	call PrintText
	ret

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

StartPerishText:
	text "おたがいの#は"
	line "３ターンごに　ほろびてしまう！"
	prompt
