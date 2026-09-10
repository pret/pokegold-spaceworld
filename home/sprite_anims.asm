InitSpriteAnimStruct::
	ld [wSpriteAnimID], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSpriteAnimStruct)
	call Bankswitch
	ld a, [wSpriteAnimID]
	call _InitSpriteAnimStruct
	pop af
	call Bankswitch
	ret

ReinitSpriteAnimFrame:: ; stubbed
	ret
