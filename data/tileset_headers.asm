INCLUDE "constants.asm"

SECTION "data/tileset_headers.asm", ROMX

tileset: MACRO
	db BANK(\1_GFX) ; shared bank
	dw \1_Meta, \1_GFX, \1_Coll
	db \2, \3, \4 ; counter tiles
	db \5         ; unknown
ENDM

Tilesets:
	; name, 3 counter tiles, unknown
	tileset Tileset_00, $77, $40, $00, $00
	tileset Tileset_01, $4b, $40, $00, $00
	tileset Tileset_02, $1f, $40, $00, $00
	tileset Tileset_03, $1f, $40, $00, $00
	tileset Tileset_04, $4b, $40, $00, $00
	tileset Tileset_05, $a7, $40, $00, $00
	tileset Tileset_06, $4b, $40, $00, $00
	tileset Tileset_07, $1f, $40, $00, $00
	tileset Tileset_08, $4b, $40, $00, $00
	tileset Tileset_09, $07, $41, $00, $00
	tileset Tileset_0a, $07, $41, $00, $00
	tileset Tileset_0b, $07, $41, $00, $00
	tileset Tileset_0c, $07, $41, $00, $00
	tileset Tileset_0d, $07, $41, $00, $00
	tileset Tileset_0e, $07, $41, $00, $00
	tileset Tileset_0f, $07, $41, $00, $00
	tileset Tileset_10, $07, $41, $00, $00
	tileset Tileset_11, $07, $41, $00, $00
	tileset Tileset_12, $07, $41, $00, $00
	tileset Tileset_13, $df, $40, $00, $00
	tileset Tileset_14, $07, $41, $00, $00
	tileset Tileset_15, $07, $41, $00, $00
	tileset Tileset_16, $07, $41, $00, $00
	tileset Tileset_17, $07, $41, $00, $00
	tileset Tileset_18, $07, $41, $00, $00
	tileset Tileset_19, $07, $41, $00, $00
	tileset Tileset_1a, $07, $41, $00, $00
	tileset Tileset_1b, $77, $40, $00, $00
