Unreferenced_Corrupt_GetPartyParamLocation_Old:
	push bc
	ld hl, wPartyMons
	ld c, a
	ld b, 0
	add hl, bc
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call $3412 ; Early position for AddNTimes
	pop bc
	ret
