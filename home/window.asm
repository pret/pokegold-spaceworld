include "constants.asm"

SECTION "home/window.asm", ROM0

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
