ReanchorMap::
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; and BANK(LoadFonts_NoOAMUpdate)
	call Bankswitch

	call ReanchorBGMap_NoOAMUpdate
	call LoadFonts_NoOAMUpdate

	pop af
	call Bankswitch
	ret

CloseText::
	call TextboxCleanup
	call ClearWindowData
	call InitToolgearBuffer
	ret
