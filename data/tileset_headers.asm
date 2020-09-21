INCLUDE "constants.asm"

SECTION "data/tileset_headers.asm", ROMX

Tilesets::

Tileset_00:
	db $06 ; bank
	dw Tileset_00_Meta ; blocks
	dw Tileset_00_GFX ; graphics
	dw Tileset_00_Coll ; collisions
	db $77 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_01:
	db $06 ; bank
	dw Tileset_01_Meta ; blocks
	dw Tileset_01_GFX ; graphics
	dw Tileset_01_Coll ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_02:
	db $06 ; bank
	dw Tileset_02_Meta ; blocks
	dw Tileset_02_GFX ; graphics
	dw Tileset_02_Coll ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_03:
	db $07 ; bank
	dw Tileset_03_Meta ; blocks
	dw Tileset_03_GFX ; graphics
	dw Tileset_03_Coll ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_04:
	db $08 ; bank
	dw Tileset_04_Meta ; blocks
	dw Tileset_04_GFX ; graphics
	dw Tileset_04_Coll ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_05:
	db $07 ; bank
	dw Tileset_05_Meta ; blocks
	dw Tileset_05_GFX ; graphics
	dw Tileset_05_Coll ; collisions
	db $a7 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_06:
	db $07 ; bank
	dw Tileset_06_Meta ; blocks
	dw Tileset_06_GFX ; graphics
	dw Tileset_06_Coll ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_07:
	db $08 ; bank
	dw Tileset_07_Meta ; blocks
	dw Tileset_07_GFX ; graphics
	dw Tileset_07_Coll ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_08:
	db $08 ; bank
	dw Tileset_08_Meta ; blocks
	dw Tileset_08_GFX ; graphics
	dw Tileset_08_Coll ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_09:
	db $06 ; bank
	dw Tileset_09_Meta ; blocks
	dw Tileset_09_GFX ; graphics
	dw Tileset_09_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0a:
	db $13 ; bank
	dw Tileset_0a_Meta ; blocks
	dw Tileset_0a_GFX ; graphics
	dw Tileset_0a_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0b:
	db $0c ; bank
	dw Tileset_0b_Meta ; blocks
	dw Tileset_0b_GFX ; graphics
	dw Tileset_0b_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0c:
	db $0c ; bank
	dw Tileset_0c_Meta ; blocks
	dw Tileset_0c_GFX ; graphics
	dw Tileset_0c_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0d:
	db $0c ; bank
	dw Tileset_0d_Meta ; blocks
	dw Tileset_0d_GFX ; graphics
	dw Tileset_0d_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0e:
	db $07 ; bank
	dw Tileset_0e_Meta ; blocks
	dw Tileset_0e_GFX ; graphics
	dw Tileset_0e_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0f:
	db $08 ; bank
	dw Tileset_0f_Meta ; blocks
	dw Tileset_0f_GFX ; graphics
	dw Tileset_0f_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_10:
	db $37 ; bank
	dw Tileset_10_Meta ; blocks
	dw Tileset_10_GFX ; graphics
	dw Tileset_10_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_11:
	db $08 ; bank
	dw Tileset_11_Meta ; blocks
	dw Tileset_11_GFX ; graphics
	dw Tileset_11_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_12:
	db $0c ; bank
	dw Tileset_12_Meta ; blocks
	dw Tileset_12_GFX ; graphics
	dw Tileset_12_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_13:
	db $07 ; bank
	dw Tileset_13_Meta ; blocks
	dw Tileset_13_GFX ; graphics
	dw Tileset_13_Coll ; collisions
	db $df ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_14:
	db $0c ; bank
	dw Tileset_14_Meta ; blocks
	dw Tileset_14_GFX ; graphics
	dw Tileset_14_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_15:
	db $37 ; bank
	dw Tileset_15_Meta ; blocks
	dw Tileset_15_GFX ; graphics
	dw Tileset_15_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_16:
	db $13 ; bank
	dw Tileset_16_Meta ; blocks
	dw Tileset_16_GFX ; graphics
	dw Tileset_16_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_17:
	db $37 ; bank
	dw Tileset_17_Meta ; blocks
	dw Tileset_17_GFX ; graphics
	dw Tileset_17_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_18:
	db $37 ; bank
	dw Tileset_18_Meta ; blocks
	dw Tileset_18_GFX ; graphics
	dw Tileset_18_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_19:
	db $13 ; bank
	dw Tileset_19_Meta ; blocks
	dw Tileset_19_GFX ; graphics
	dw Tileset_19_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_1a:
	db $13 ; bank
	dw Tileset_1a_Meta ; blocks
	dw Tileset_1a_GFX ; graphics
	dw Tileset_1a_Coll ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

; uses tileset 00 graphics
Tileset_1b:
	db $06 ; bank
	dw Tileset_1b_Meta ; blocks
	dw Tileset_00_GFX ; graphics
	dw Tileset_1b_Coll ; collisions
	db $77 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown
