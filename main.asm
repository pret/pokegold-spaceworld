INCLUDE "constants.asm"

; bank 1
INCLUDE "engine/link/place_waiting_text.asm"
INCLUDE "engine/title.asm"
INCLUDE "engine/predef.asm"
; TODO

SECTION "Font Gfx", ROMX[$4362], BANK[$3e]
    INCBIN "gfx/font.1bpp"

SECTION "Main Menu Definition", ROMX[$5418], BANK[$01]
MainMenuHeader:
    db $40
    db 0, 0, 7, 13
    dw .data
    db 1 ; default option
.data
    db $80
    db 0 ; number of options

    dw $5461
    db $8a, $1f
    dw MainMenuStrings

MainMenuStrings: ; 01:5428
    db "つづきから　はじめる@"
    db "さいしょから　はじめる@"
    db "せっていを　かえる@"
    db "#を　あそぶ@"
    db "じかんセット@"
; 01:5457

SECTION "TM/HM Moves", ROMX[$52D1],BANK[$04]
INCLUDE "data/moves/tmhm_moves.asm"

SECTION "Type Matchups", ROMX[$506D],BANK[$0D]
INCLUDE "data/types/type_matchups.asm"

SECTION "Alphabetical Pokedex Order", ROMX[$4943],BANK[$10]
INCLUDE "data/pokemon/dex_order_alpha.asm"

SECTION "Evolutions and Attacks", ROMX[$6493],BANK[$10]
INCLUDE "data/pokemon/evos_attacks.asm"

SECTION "Base Data", ROMX[$4F10],BANK[$14]
INCLUDE "data/pokemon/base_stats.asm"

INCLUDE "gfx/pokemon/pkmn_pics.asm"

SECTION "Annon Pic Ptrs and Pics", ROMX[$4d6a], BANK[$1f]
INCLUDE "gfx/pokemon/annon_pic_ptrs.asm"
INCLUDE "gfx/pokemon/annon_pics.asm"
