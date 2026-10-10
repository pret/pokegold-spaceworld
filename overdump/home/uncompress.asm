Unreferenced_Corrupt__InterlaceMergeSpriteBuffers.interlaceLoopFlipped:
	xor a
	dec a
	ldh [hConnectionStripLength], a
	jr nz, @ - 25 ; Unknown function
	ret
