INCLUDE "constants.asm"

SECTION "engine/landmarks.asm", ROMX

GetLandmarkName::
	dec a
	ld hl, LandmarkNames
	call GetNthString
	ld d, h
	ld e, l
	ret