INCLUDE "constants.asm"

SECTION "GetLandmarkName", ROMX[$4AA5], BANK[$3F]

GetLandmarkName::
	dec a
	ld hl, LandmarkNames
	call GetNthString
	ld d, h
	ld e, l
	ret
