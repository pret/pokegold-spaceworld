include "constants.asm"

SECTION "Window Functions", ROM0[$1fd4]

RefreshScreen::
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

Function1fea::
	call TextboxCleanup
	call ClearWindowData
	call InitToolgearBuffer
	ret
