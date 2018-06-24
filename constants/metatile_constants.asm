
; all outside tileset share certain metatiles
; this is used in overworld code when editing the map
; D - dirt
; L - lawn
; T - small tree
; C - cut tree
; G - grass
METATILE_GROUND EQU $01 ; DD
                        ; DD
METATILE_LAWN   EQU $04 ; LL
                        ; LL
METATILE_SMALL_TREES_N EQU $25 ; TT
                               ; LL
METATILE_SMALL_TREES_W EQU $28 ; TL
                               ; TL
METATILE_SMALL_TREES_E EQU $2a ; LT
                               ; LT
METATILE_CUT_SE_TREES_N EQU $30 ; TT
                                ; LC
METATILE_CUT_NW_TREES_E EQU $31 ; CT
                                ; LT
METATILE_CUT_NE_TREE_NW EQU $32 ; TC
                                ; LL
METATILE_CUT_NE_TREE_SE EQU $33 ; LC
                                ; LT
METATILE_SMALL_TREE_NW EQU $34 ; TL
                               ; LL
METATILE_SMALL_TREE_SE EQU $35 ; TL
                               ; LL
METATILE_GRASS  EQU $3b        ; GG
                               ; GG
