include "constants.asm"

SECTION "Sprite Anims Home", ROM0 [$3CA8]

InitSpriteAnimStruct:: ; 00:3ca8
	ld [wSpriteAnimIDBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSpriteAnimStruct)
	call Bankswitch
	ld a, [wSpriteAnimIDBuffer]
	call _InitSpriteAnimStruct
	pop af
	call Bankswitch
	ret

Function3cbe::
	ret
