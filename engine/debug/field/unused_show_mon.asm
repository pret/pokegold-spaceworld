FieldDebug_UnusedShowRandomMon: ; unreferenced
	call .get_number
	ld a, [wNumSetBits]
	ld [wCurPartySpecies], a
	callfar Pokepic
	ret

.get_number
	call Random
	cp NUM_POKEMON
	jr nc, .get_number
	inc a
	ld [wNumSetBits], a
	ret
