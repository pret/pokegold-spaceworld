INCLUDE "constants.asm"

SECTION "data/tileset_headers.asm", ROMX

MACRO tileset
	db BANK(\1_GFX) ; shared bank
	dw \1_Meta, \1_GFX, \1_Coll
	dw \2, ; animation set
	dw NULL ; unused
ENDM

Tilesets:
	; name, animation set
	tileset Tileset_00, TilesetGenericAnim
	tileset Tileset_01, TilesetWaterAnim
	tileset Tileset_02, TilesetFlowerAnim
	tileset Tileset_03, TilesetFlowerAnim
	tileset Tileset_04, TilesetWaterAnim
	tileset Tileset_05, TilesetFontAnim
	tileset Tileset_06, TilesetWaterAnim
	tileset Tileset_07, TilesetFlowerAnim
	tileset Tileset_08, TilesetWaterAnim
	tileset Tileset_09, TilesetNoAnim
	tileset Tileset_0a, TilesetNoAnim
	tileset Tileset_0b, TilesetNoAnim
	tileset Tileset_0c, TilesetNoAnim
	tileset Tileset_0d, TilesetNoAnim
	tileset Tileset_0e, TilesetNoAnim
	tileset Tileset_0f, TilesetNoAnim
	tileset Tileset_10, TilesetNoAnim
	tileset Tileset_11, TilesetNoAnim
	tileset Tileset_12, TilesetNoAnim
	tileset Tileset_13, TilesetRocketHouseAnim
	tileset Tileset_14, TilesetNoAnim
	tileset Tileset_15, TilesetNoAnim
	tileset Tileset_16, TilesetNoAnim
	tileset Tileset_17, TilesetNoAnim
	tileset Tileset_18, TilesetNoAnim
	tileset Tileset_19, TilesetNoAnim
	tileset Tileset_1a, TilesetNoAnim
	tileset Tileset_1b, TilesetGenericAnim
