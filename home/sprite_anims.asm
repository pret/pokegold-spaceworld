INCLUDE "constants.asm"

SECTION "home/sprite_anims.asm", ROM0

InitSpriteAnimStruct::
	ld [wSpriteAnimAddrBackup], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSpriteAnimStruct)
	call Bankswitch
	ld a, [wSpriteAnimAddrBackup]
	call _InitSpriteAnimStruct
	pop af
	call Bankswitch
	ret

ReinitSpriteAnimFrame:: ; stubbed
	ret
