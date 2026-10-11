Unreferenced_Corrupt_InitSpriteAnimStruct_Old:
	ld [wCurSpriteOAMFlags], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSpriteAnimStruct)
	call $32AB ; Old location of Bankswitch
	ld a, [wCurSpriteOAMFlags]
	call _InitSpriteAnimStruct
	pop af
	call $32AB ; Old location of Bankswitch
	ret

Unreferenced_Corrupt_ReinitSpriteAnimFrame_Old: ; stubbed
	ret
