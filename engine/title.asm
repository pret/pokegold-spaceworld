INCLUDE "constants.asm"

SECTION "Title screen", ROMX[$5D8C], BANK[$01]

IntroSequence:: ; 5d8c
    ; TODO


if DEBUG
SECTION "Title screen TEMPORARY", ROMX[$62A5],BANK[1] ; TODO: merge this with the main section above
else
SECTION "Title screen TEMPORARY", ROMX[$62A2],BANK[1] ; TODO: merge this with the main section above
endc

GameInit:: ; 62a5
	call ClearWindowData
	ld a, $23
	ld [wce5f], a
	jp IntroSequence
