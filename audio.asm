INCLUDE "constants.asm"


SECTION "Audio", ROMX[$4000],BANK[$3A]

INCLUDE "audio/engine.asm"


SECTION "Cries", ROMX[$51CB],BANK[$3C] ; TODO: Temporary, please map 4000-51CA and move this section's base

CryHeaders:: ; TODO: Rip the data, then INCBIN it
