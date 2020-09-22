INCLUDE "constants.asm"

SECTION "data/tileset_headers.asm", ROMX

tileset: MACRO
	db BANK(\2)   ; Bank
	dw \1, \2, \3 ; Block, GFX, Coll
	db \4, \5, \6 ; counter tiles
	db \7         ; grass tile
	; db \8         ; permission (indoor, cave, outdoor)
ENDM

Tilesets: ; bank, block, gfx, coll, 3 counter tiles, grass tile, permission
	tileset Tileset_00_Meta, Tileset_00_GFX, Tileset_00_Coll, $77, $40, $00, $00
	tileset Tileset_01_Meta, Tileset_01_GFX, Tileset_01_Coll, $4b, $40, $00, $00
	tileset Tileset_02_Meta, Tileset_02_GFX, Tileset_02_Coll, $1f, $40, $00, $00
	tileset Tileset_03_Meta, Tileset_03_GFX, Tileset_03_Coll, $1f, $40, $00, $00
	tileset Tileset_04_Meta, Tileset_04_GFX, Tileset_04_Coll, $4b, $40, $00, $00
	tileset Tileset_05_Meta, Tileset_05_GFX, Tileset_05_Coll, $a7, $40, $00, $00
	tileset Tileset_06_Meta, Tileset_06_GFX, Tileset_06_Coll, $4b, $40, $00, $00
	tileset Tileset_07_Meta, Tileset_07_GFX, Tileset_07_Coll, $1f, $40, $00, $00
	tileset Tileset_08_Meta, Tileset_08_GFX, Tileset_08_Coll, $4b, $40, $00, $00
	tileset Tileset_09_Meta, Tileset_09_GFX, Tileset_09_Coll, $07, $41, $00, $00
	tileset Tileset_0a_Meta, Tileset_0a_GFX, Tileset_0a_Coll, $07, $41, $00, $00
	tileset Tileset_0b_Meta, Tileset_0b_GFX, Tileset_0b_Coll, $07, $41, $00, $00
	tileset Tileset_0c_Meta, Tileset_0c_GFX, Tileset_0c_Coll, $07, $41, $00, $00
	tileset Tileset_0d_Meta, Tileset_0d_GFX, Tileset_0d_Coll, $07, $41, $00, $00
	tileset Tileset_0e_Meta, Tileset_0e_GFX, Tileset_0e_Coll, $07, $41, $00, $00
	tileset Tileset_0f_Meta, Tileset_0f_GFX, Tileset_0f_Coll, $07, $41, $00, $00
	tileset Tileset_10_Meta, Tileset_10_GFX, Tileset_10_Coll, $07, $41, $00, $00
	tileset Tileset_11_Meta, Tileset_11_GFX, Tileset_11_Coll, $07, $41, $00, $00
	tileset Tileset_12_Meta, Tileset_12_GFX, Tileset_12_Coll, $07, $41, $00, $00
	tileset Tileset_13_Meta, Tileset_13_GFX, Tileset_13_Coll, $df, $40, $00, $00
	tileset Tileset_14_Meta, Tileset_14_GFX, Tileset_14_Coll, $07, $41, $00, $00
	tileset Tileset_15_Meta, Tileset_15_GFX, Tileset_15_Coll, $07, $41, $00, $00
	tileset Tileset_16_Meta, Tileset_16_GFX, Tileset_16_Coll, $07, $41, $00, $00
	tileset Tileset_17_Meta, Tileset_17_GFX, Tileset_17_Coll, $07, $41, $00, $00
	tileset Tileset_18_Meta, Tileset_18_GFX, Tileset_18_Coll, $07, $41, $00, $00
	tileset Tileset_19_Meta, Tileset_19_GFX, Tileset_19_Coll, $07, $41, $00, $00
	tileset Tileset_1a_Meta, Tileset_1a_GFX, Tileset_1a_Coll, $07, $41, $00, $00
	; Tileset_1b uses Tileset_00 graphics
	tileset Tileset_1b_Meta, Tileset_00_GFX, Tileset_1b_Coll, $77, $40, $00, $00