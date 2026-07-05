BattleCommand_Nightmare:
	ld hl, wEnemySubStatus1
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wPlayerSubStatus1
	ld de, wBattleMonStatus

.got_status
; Can't hit an absent opponent.
	call CheckHiddenOpponent
	jr nz, .failed

; CAN hit a Substitute, unlike the final game.

; Only works on a sleeping opponent.
	ld a, [de]
	and SLP
	jr z, .failed

; Bail if the opponent is already having a nightmare.
	bit SUBSTATUS_NIGHTMARE, [hl]
	jr nz, .failed

; Otherwise give the opponent a nightmare.
	set SUBSTATUS_NIGHTMARE, [hl]
	call LoadMoveAnim
	ld hl, .StartedNightmareText
	jp PrintText

.StartedNightmareText:
	text "<TARGET>は"
	line "あくむを　みはじめた！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed
