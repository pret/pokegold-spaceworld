INCLUDE "constants.asm"

; TODO

SECTION "Font Gfx", ROMX[$4362], BANK[$3e]
    INCBIN "gfx/font.1bpp"

SECTION "Main Menu Definition", ROMX[$5418], BANK[$01]
MainMenuHeader:
    db $40
    db 0, 0, 7, 14
    dw .data
    db 1 ; default option
.data
    db $80
    db 0 ; number of options

    dw $5461
    db $8a, $1f
    dw MainMenuStrings

MainMenuStrings: ; 01:5428
    db "CONTINUE@"
    db "NEW GAME@"
    db "OPTIONS@"
    db "PLAY POKéMON@"
    db "TIME@"
    db "@@@"
; 01:5457

