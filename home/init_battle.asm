InitTrainerBattle::
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_START_TRAINER_BATTLE
	ld [wMapStatus], a
	ret

TestWildBattleStart::
	ldh a, [hJoyState]
	and PAD_CTRL_PAD
	ret z ; if no directions are down, don't try and trigger a wild encounter
	call CheckBPressedDebug
	jp nz, xor_a ; if b button is down in debug mode, don't try and trigger a wild encounter
	callfar TryWildBattle
	ld a, [wBattleMode]
	and a
	ret z ; if no battle, return
	ld a, MAPSTATUS_START_WILD_BATTLE
	call SetMapStatus
	call xor_a_dec_a ; set the carry flag to start a wild battle
	ret
