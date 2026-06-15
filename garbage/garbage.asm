INCLUDE "constants.asm"


SECTION "garbage.asm@Bank 01 Garbage", ROMX

if DEF(_GOLD)
	ds 982, $39, $00
endc
if DEF(_SILVER)
INCBIN "garbage/bank01_silver.2bpp", 42
endc


SECTION "garbage.asm@Bank 02 Garbage", ROMX

if DEF(_GOLD)
INCBIN "garbage/bank02_gold.2bpp", 188
endc
if DEF(_SILVER)
INCBIN "garbage/bank02_silver.2bpp", 188
endc


SECTION "garbage.asm@Bank 03 Garbage", ROMX

if DEF(_GOLD)
Unreferenced_Corrupt_AlreadyKnowsMoveText1:
	db "います"
	prompt

Unreferenced_Corrupt_AlreadyKnowsMoveText2:
	dw wStringBuffer2 ; This is missing the preceeding "text_from_ram" byte
	text "を　おぼえています"
	prompt

	db $28, $3c ; garbage
endc
if DEF(_SILVER)
Unreferenced_Corrupt_AlreadyKnowsMoveText1:
	db "ぼえています"
	prompt

Unreferenced_Corrupt_AlreadyKnowsMoveText2:
	db "を　おぼえています"
	prompt

	db $de, $3b ; garbage
endc

Unreferenced_Corrupt_KnowsMove:
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, .AlreadyKnowsMoveText
	call PrintText
	scf
	ret

.AlreadyKnowsMoveText:
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

if DEF(_GOLD)
INCBIN "garbage/bank03_gold.2bpp", 35
endc
if DEF(_SILVER)
INCBIN "garbage/bank03_silver.2bpp", 35
endc


SECTION "garbage.asm@Bank 04 Garbage", ROMX

if DEF(_GOLD)
INCBIN "garbage/bank04_gold.2bpp", 227
endc
if DEF(_SILVER)
INCBIN "garbage/bank04_silver.2bpp", 227
endc


SECTION "garbage.asm@Bank 05 Garbage", ROMX

if DEF(_GOLD)
INCBIN "garbage/bank05_gold.2bpp", 74
endc
if DEF(_SILVER)
INCBIN "garbage/bank05_silver.2bpp", 74
endc


SECTION "garbage.asm@Bank 06 Garbage", ROMX

if DEF(_GOLD)
INCBIN "garbage/bank06_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank06_silver.2bpp"
endc


SECTION "garbage.asm@Bank 09 Garbage", ROMX

if DEF(_GOLD)
INCBIN "garbage/bank09_gold.2bpp", 116
endc
if DEF(_SILVER)
INCBIN "garbage/bank09_silver.2bpp", 116
endc


SECTION "garbage.asm@Bank 0a Garbage", ROMX

if DEF(_GOLD)
INCBIN "garbage/bank0a_gold.2bpp", 62
endc
if DEF(_SILVER)
INCBIN "garbage/bank0a_silver.2bpp", 62
endc


SECTION "garbage.asm@Bank 0b Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank0b_gold.2bpp", 111
endc
if DEF(_SILVER)
INCBIN "garbage/bank0b_silver.2bpp", 111
endc


SECTION "garbage.asm@Bank 0c Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank0c_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank0c_silver.2bpp"
endc


SECTION "garbage.asm@Bank 0d Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank0d_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank0d_silver.2bpp"
endc


SECTION "garbage.asm@Bank 0e Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank0e_gold.2bpp", 188
endc
if DEF(_SILVER)
INCBIN "garbage/bank0e_silver.2bpp", 185
endc


SECTION "garbage.asm@Bank 0f Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank0f_gold.2bpp", 75
endc
if DEF(_SILVER)
INCBIN "garbage/bank0f_silver.2bpp", 75
endc


SECTION "garbage.asm@Bank 10 Garbage", ROMX
if DEF(_GOLD)
Unreferenced_Corrupt_LeafyEvosAttacks1:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_ABSORB
	db 35, MOVE_RAZOR_LEAF
	db 42, MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
Unreferenced_Corrupt_LeafyEvosAttacks2:
	db MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
Unreferenced_Corrupt_TailEvosAttacks:
	db 25, MOVE_SWIFT
	db 31, MOVE_MUD_SLAP
	db 38, MOVE_FURY_SWIPES
	db 45, MOVE_MIMIC
	db 0 ; no more level-up moves
Unreferenced_Corrupt_LeafyEvosAttacks3:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_ABSORB
	db 35, MOVE_RAZOR_LEAF
	db 42, MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
Unreferenced_Corrupt_LeafyEvosAttacks4:
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

	db $E6, $6D, $C3, $FF ; garbage

INCBIN "garbage/bank10_gold.2bpp"
endc

if DEF(_SILVER)
Unreferenced_Corrupt_LeafyEvosAttacks1:
	db MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
Unreferenced_Corrupt_LeafyEvosAttacks2:
	db MOVE_ABSORB
	db 35, MOVE_RAZOR_LEAF
	db 42, MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
Unreferenced_Corrupt_TailEvosAttacks:
	db  1, MOVE_SCRATCH
	db  5, MOVE_LEER
	db  9, MOVE_SAND_ATTACK
	db 14, MOVE_PURSUIT
	db 19, MOVE_ENCORE
	db 25, MOVE_SWIFT
	db 31, MOVE_MUD_SLAP
	db 38, MOVE_FURY_SWIPES
	db 45, MOVE_MIMIC
	db 0 ; no more level-up moves
Unreferenced_Corrupt_LeafyEvosAttacks3:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_ABSORB
	db 35, MOVE_RAZOR_LEAF
	db 42, MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
Unreferenced_Corrupt_LeafyEvosAttacks4:
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

	db 0, 0, 0, 0 ; garbage

INCBIN "garbage/bank10_silver.2bpp"
endc


SECTION "garbage.asm@Bank 14 Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank14_gold.2bpp", 116
endc
if DEF(_SILVER)
INCBIN "garbage/bank14_silver.2bpp", 116
endc


SECTION "garbage.asm@Bank 20 Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank20_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank20_silver.2bpp"
endc


SECTION "garbage.asm@Bank 22 Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank22_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank22_silver.2bpp"
endc


SECTION "garbage.asm@Bank 35 Garbage", ROMX
; This whole bank is garbage data.
rept 23
	ret
endr
if DEF(_GOLD)
INCBIN "garbage/bank35_gold.2bpp", 23
endc
if DEF(_SILVER)
INCBIN "garbage/bank35_silver.2bpp", 23
endc


SECTION "garbage.asm@Bank 28 Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank28_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank28_silver.2bpp"
endc


SECTION "garbage.asm@Bank 29 Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank29_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank29_silver.2bpp"
endc


SECTION "garbage.asm@Bank 2a Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank2a_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2a_silver.2bpp"
endc


SECTION "garbage.asm@Bank 2b Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank2b_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2b_silver.2bpp"
endc


SECTION "garbage.asm@Bank 2c Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank2c_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2c_silver.2bpp"
endc


SECTION "garbage.asm@Bank 2d Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank2d_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2d_silver.2bpp"
endc


SECTION "garbage.asm@Bank 2e Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank2e_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2e_silver.2bpp"
endc


SECTION "garbage.asm@Bank 31 Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank31_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank31_silver.2bpp"
endc


SECTION "garbage.asm@Bank 39 Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank39_gold.2bpp", 159
endc
if DEF(_SILVER)
INCBIN "garbage/bank39_silver.2bpp", 159
endc


SECTION "garbage.asm@Bank 3c Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank3c_gold.2bpp", 78
endc
if DEF(_SILVER)
INCBIN "garbage/bank3c_silver.2bpp", 78
endc


SECTION "garbage.asm@Bank 3d Garbage", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "garbage/bank3d_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank3d_silver.2bpp"
endc


SECTION "garbage.asm@Bank 3f Garbage", ROMX
if DEF(_GOLD)
INCBIN "garbage/bank3f_gold.2bpp", 45
endc
if DEF(_SILVER)
INCBIN "garbage/bank3f_silver.2bpp", 45
endc
