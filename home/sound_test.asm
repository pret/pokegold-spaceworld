INCLUDE "constants.asm"

SECTION "home/sound_test.asm", ROM0

DebugMenuSoundTest::
	ldh a, [hROMBank]
	push af
	ld a, BANK(_DebugMenuSoundTest)
	call Bankswitch
	call _DebugMenuSoundTest
	pop af
	call Bankswitch
	jp DebugMenu
