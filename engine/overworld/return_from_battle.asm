OverworldLoop_ReturnFromBattle::
	ld a, MAPSTATUS_MAIN
	call SetMapStatus
	ret
