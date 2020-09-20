INCLUDE "constants.asm"

SECTION "data/tileset_headers.asm", ROMX

Tilesets::

Tileset_00:
	db $06 ; bank
	dw $4400 ; blocks
	dw Tileset_00_GFX ; graphics
	dw $4c00 ; collisions
	db $77 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_01:
	db $06 ; bank
	dw $5c00 ; blocks
	dw Tileset_01_GFX ; graphics
	dw $6400 ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_02:
	db $06 ; bank
	dw $6a00 ; blocks
	dw Tileset_02_GFX ; graphics
	dw $7200 ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_03:
	db $07 ; bank
	dw $7600 ; blocks
	dw Tileset_03_GFX ; graphics
	dw $7e00 ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_04:
	db $08 ; bank
	dw $4400 ; blocks
	dw Tileset_04_GFX ; graphics
	dw $4c00 ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_05:
	db $07 ; bank
	dw $6800 ; blocks
	dw Tileset_05_GFX ; graphics
	dw $7000 ; collisions
	db $a7 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_06:
	db $07 ; bank
	dw $5a00 ; blocks
	dw Tileset_06_GFX ; graphics
	dw $6200 ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_07:
	db $08 ; bank
	dw $5200 ; blocks
	dw Tileset_07_GFX ; graphics
	dw $5a00 ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_08:
	db $08 ; bank
	dw $6000 ; blocks
	dw Tileset_08_GFX ; graphics
	dw $6800 ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_09:
	db $06 ; bank
	dw $7a00 ; blocks
	dw Tileset_09_GFX ; graphics
	dw $7e00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0a:
	db $13 ; bank
	dw $4600 ; blocks
	dw Tileset_0a_GFX ; graphics
	dw $4a00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0b:
	db $0c ; bank
	dw $5100 ; blocks
	dw Tileset_0b_GFX ; graphics
	dw $5500 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0c:
	db $0c ; bank
	dw $7700 ; blocks
	dw Tileset_0c_GFX ; graphics
	dw $7b00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0d:
	db $0c ; bank
	dw $5c00 ; blocks
	dw Tileset_0d_GFX ; graphics
	dw $6000 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0e:
	db $07 ; bank
	dw $5100 ; blocks
	dw Tileset_0e_GFX ; graphics
	dw $5500 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0f:
	db $08 ; bank
	dw $7000 ; blocks
	dw Tileset_0f_GFX ; graphics
	dw $7400 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_10:
	db $37 ; bank
	dw $4600 ; blocks
	dw Tileset_10_GFX ; graphics
	dw $4a00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_11:
	db $08 ; bank
	dw $7b00 ; blocks
	dw Tileset_11_GFX ; graphics
	dw $7f00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_12:
	db $0c ; bank
	dw $4600 ; blocks
	dw Tileset_12_GFX ; graphics
	dw $4a00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_13:
	db $07 ; bank
	dw $4600 ; blocks
	dw Tileset_13_GFX ; graphics
	dw $4a00 ; collisions
	db $df ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_14:
	db $0c ; bank
	dw $6700 ; blocks
	dw Tileset_14_GFX ; graphics
	dw $6f00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_15:
	db $37 ; bank
	dw $5100 ; blocks
	dw Tileset_15_GFX ; graphics
	dw $5900 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_16:
	db $13 ; bank
	dw $5100 ; blocks
	dw Tileset_16_GFX ; graphics
	dw $5900 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_17:
	db $37 ; bank
	dw $6100 ; blocks
	dw Tileset_17_GFX ; graphics
	dw $6900 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_18:
	db $37 ; bank
	dw $7100 ; blocks
	dw Tileset_18_GFX ; graphics
	dw $7900 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_19:
	db $13 ; bank
	dw $5f00 ; blocks
	dw Tileset_19_GFX ; graphics
	dw $6700 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_1a:
	db $13 ; bank
	dw $6d00 ; blocks
	dw Tileset_1a_GFX ; graphics
	dw $7500 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

; uses tileset 00 graphics
Tileset_1b:
	db $06 ; bank
	dw $4e00 ; blocks
	dw Tileset_00_GFX ; graphics
	dw $5600 ; collisions
	db $77 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown
