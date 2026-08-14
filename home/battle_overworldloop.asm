; These functions were originally in bank $0e according to _OverworldLoop.Pointers (see home/map.asm).
OverworldLoop_StartBattle::
	predef StartBattle
	ld a, MAPSETUP_RELOADMAP
	ldh [hMapEntryMethod], a
	ld hl, wGameModeFlags
	set 5, [hl]
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	set JOYPAD_DISABLE_SYNC_MUTEX_F, [hl]
	ld a, MAPSTATUS_EXIT_BATTLE
	call SetMapStatus
	ret

OverworldLoop_UnusedBattle::
	ret

OverworldLoop_ExitBattle::
	ld a, [wBattleResult]
	cp LOSE
	jr z, .DemoGameOver
	ld a, MAPSTATUS_RETURN_TO_MAIN
	call SetMapStatus
	ret

.DemoGameOver:
	ld hl, wJoypadDisable
	res JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld hl, .text
	call OpenTextbox
	call GBFadeOutToBlack
	jp Init

.text:
	text "つぎは　がんばるぞ！！"
	done
