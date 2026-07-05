GetMonBackpic::
	ld a, $00
	call OpenSRAM
	push hl
	ld hl, sSpriteBuffer1
	ld de, sSpriteBuffer0
	ld bc, SPRITEBUFFERSIZE
	call CopyBytes

	ld hl, sSpriteBuffer2
	ld de, sSpriteBuffer1
	ld bc, SPRITEBUFFERSIZE
	call CopyBytes

	call _InterlaceMergeSpriteBuffers

	pop hl
	ld de, sSpriteBuffer1
	ld c, 6 * 6
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	call CloseSRAM
	ret
