INCLUDE "constants.asm"

SECTION "Tileset Headers", ROMX[$488D], BANK[$03]

Tileset_00: ; 0xc88d
	db $06 ; bank
	dw $4400 ; blocks
	dw Tileset_00_GFX ; graphics
	dw $4c00 ; collisions
	db $77 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_01: ; 0xc898
	db $06 ; bank
	dw $5c00 ; blocks
	dw Tileset_01_GFX ; graphics
	dw $6400 ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_02: ; 0xc8a3
	db $06 ; bank
	dw $6a00 ; blocks
	dw Tileset_02_GFX ; graphics
	dw $7200 ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_03: ; 0xc8ae
	db $07 ; bank
	dw $7600 ; blocks
	dw Tileset_03_GFX ; graphics
	dw $7e00 ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_04: ; 0xc8b9
	db $08 ; bank
	dw $4400 ; blocks
	dw Tileset_04_GFX ; graphics
	dw $4c00 ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_05: ; 0xc8c4
	db $07 ; bank
	dw $6800 ; blocks
	dw Tileset_05_GFX ; graphics
	dw $7000 ; collisions
	db $a7 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_06: ; 0xc8cf
	db $07 ; bank
	dw $5a00 ; blocks
	dw Tileset_06_GFX ; graphics
	dw $6200 ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_07: ; 0xc8da
	db $08 ; bank
	dw $5200 ; blocks
	dw Tileset_07_GFX ; graphics
	dw $5a00 ; collisions
	db $1f ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_08: ; 0xc8e5
	db $08 ; bank
	dw $6000 ; blocks
	dw Tileset_08_GFX ; graphics
	dw $6800 ; collisions
	db $4b ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_09: ; 0xc8f0
	db $06 ; bank
	dw $7a00 ; blocks
	dw Tileset_09_GFX ; graphics
	dw $7e00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0a: ; 0xc8fb
	db $13 ; bank
	dw $4600 ; blocks
	dw Tileset_0a_GFX ; graphics
	dw $4a00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0b: ; 0xc906
	db $0c ; bank
	dw $5100 ; blocks
	dw Tileset_0b_GFX ; graphics
	dw $5500 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0c: ; 0xc911
	db $0c ; bank
	dw $7700 ; blocks
	dw Tileset_0c_GFX ; graphics
	dw $7b00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0d: ; 0xc91c
	db $0c ; bank
	dw $5c00 ; blocks
	dw Tileset_0d_GFX ; graphics
	dw $6000 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0e: ; 0xc927
	db $07 ; bank
	dw $5100 ; blocks
	dw Tileset_0e_GFX ; graphics
	dw $5500 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_0f: ; 0xc932
	db $08 ; bank
	dw $7000 ; blocks
	dw Tileset_0f_GFX ; graphics
	dw $7400 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_10: ; 0xc93d
	db $37 ; bank
	dw $4600 ; blocks
	dw Tileset_10_GFX ; graphics
	dw $4a00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_11: ; 0xc948
	db $08 ; bank
	dw $7b00 ; blocks
	dw Tileset_11_GFX ; graphics
	dw $7f00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_12: ; 0xc953
	db $0c ; bank
	dw $4600 ; blocks
	dw Tileset_12_GFX ; graphics
	dw $4a00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_13: ; 0xc95e
	db $07 ; bank
	dw $4600 ; blocks
	dw Tileset_13_GFX ; graphics
	dw $4a00 ; collisions
	db $df ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_14: ; 0xc969
	db $0c ; bank
	dw $6700 ; blocks
	dw Tileset_14_GFX ; graphics
	dw $6f00 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_15: ; 0xc974
	db $37 ; bank
	dw $5100 ; blocks
	dw Tileset_15_GFX ; graphics
	dw $5900 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_16: ; 0xc97f
	db $13 ; bank
	dw $5100 ; blocks
	dw Tileset_16_GFX ; graphics
	dw $5900 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_17: ; 0xc98a
	db $37 ; bank
	dw $6100 ; blocks
	dw Tileset_17_GFX ; graphics
	dw $6900 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_18: ; 0xc995
	db $37 ; bank
	dw $7100 ; blocks
	dw Tileset_18_GFX ; graphics
	dw $7900 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_19: ; 0xc9a0
	db $13 ; bank
	dw $5f00 ; blocks
	dw Tileset_19_GFX ; graphics
	dw $6700 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

Tileset_1a: ; 0xc9ab
	db $13 ; bank
	dw $6d00 ; blocks
	dw Tileset_1a_GFX ; graphics
	dw $7500 ; collisions
	db $07 ; talking over tile 1
	db $41 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown

; uses tileset 00 graphics
Tileset_1b: ; 0xc9b6
	db $06 ; bank
	dw $4e00 ; blocks
	dw Tileset_00_GFX ; graphics
	dw $5600 ; collisions
	db $77 ; talking over tile 1
	db $40 ; talking over tile 2
	db $00 ; talking over tile 3
	db $00 ; unknown
