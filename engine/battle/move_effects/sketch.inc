BattleCommand_Sketch:
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr z, .failed

	call CheckSubstituteOpp
	jp nz, .failed
; BUG: Just like Bide, there is absolutely no handling for when the opponent uses it.
; If the enemy uses it, then it overwrites the player's selected move with Sketch.
; Also: no PP handling. The new move will have the PP of the old move.
	ld hl, wBattleMonMoves
	ld a, [wCurMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wLastEnemyCounterMove]
	ld [hl], a

	ld hl, wPartyMon1Moves
	add hl, bc
	ld [hl], a

	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	call LoadMoveAnim
	ld hl, SketchedText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

SketchedText:
	text "<USER>は"
	line "@"
	text_from_ram wStringBuffer1
	text "を　ダビングした！"
	prompt
