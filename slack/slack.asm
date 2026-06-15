INCLUDE "constants.asm"


SECTION "slack.asm@Bank 01 Padding", ROMX

if DEF(_GOLD)
	ds 982, $39, $00
endc
if DEF(_SILVER)
INCBIN "slack/bank01padding_silver.2bpp", 42
endc


SECTION "slack.asm@Bank 02 Padding", ROMX

if DEF(_GOLD)
INCBIN "slack/bank02padding_gold.2bpp", 188
endc
if DEF(_SILVER)
INCBIN "slack/bank02padding_silver.2bpp", 188
endc


SECTION "slack.asm@Bank 03 Padding", ROMX

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
INCBIN "slack/bank03padding_gold.2bpp", 35
endc
if DEF(_SILVER)
INCBIN "slack/bank03padding_silver.2bpp", 35
endc


SECTION "slack.asm@Bank 04 Padding", ROMX

if DEF(_GOLD)
INCBIN "slack/bank04padding_gold.2bpp", 227
endc
if DEF(_SILVER)
INCBIN "slack/bank04padding_silver.2bpp", 227
endc


SECTION "slack.asm@Bank 05 Padding", ROMX

if DEF(_GOLD)
INCBIN "slack/bank05padding_gold.2bpp", 74
endc
if DEF(_SILVER)
INCBIN "slack/bank05padding_silver.2bpp", 74
endc


SECTION "slack.asm@Bank 06 Padding", ROMX

if DEF(_GOLD)
INCBIN "slack/bank06padding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank06padding_silver.2bpp"
endc


SECTION "slack.asm@Bank 09 Padding", ROMX

if DEF(_GOLD)
INCBIN "slack/bank09padding_gold.2bpp", 116
endc
if DEF(_SILVER)
INCBIN "slack/bank09padding_silver.2bpp", 116
endc


SECTION "slack.asm@Bank 0a Padding", ROMX

if DEF(_GOLD)
INCBIN "slack/bank0apadding_gold.2bpp", 62
endc
if DEF(_SILVER)
INCBIN "slack/bank0apadding_silver.2bpp", 62
endc


SECTION "slack.asm@Bank 0b Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank0bpadding_gold.2bpp", 111
endc
if DEF(_SILVER)
INCBIN "slack/bank0bpadding_silver.2bpp", 111
endc


SECTION "slack.asm@Bank 0c Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank0cpadding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank0cpadding_silver.2bpp"
endc


SECTION "slack.asm@Bank 0d Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank0dpadding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank0dpadding_silver.2bpp"
endc


SECTION "slack.asm@Bank 0e Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank0epadding_gold.2bpp", 188
endc
if DEF(_SILVER)
INCBIN "slack/bank0epadding_silver.2bpp", 185
endc


SECTION "slack.asm@Bank 0f Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank0fpadding_gold.2bpp", 75
endc
if DEF(_SILVER)
INCBIN "slack/bank0fpadding_silver.2bpp", 75
endc


SECTION "slack.asm@Bank 10 Padding", ROMX
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

INCBIN "slack/bank10padding_gold.2bpp"
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

INCBIN "slack/bank10padding_silver.2bpp"
endc


SECTION "slack.asm@Bank 14 Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank14padding_gold.2bpp", 116
endc
if DEF(_SILVER)
INCBIN "slack/bank14padding_silver.2bpp", 116
endc


SECTION "slack.asm@Bank 20 Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank20padding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank20padding_silver.2bpp"
endc


SECTION "slack.asm@Bank 22 Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank22padding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank22padding_silver.2bpp"
endc


SECTION "slack.asm@Bank 35 Padding", ROMX
; This whole bank is garbage data.
rept 23
	ret
endr
if DEF(_GOLD)
INCBIN "slack/bank35padding_gold.2bpp", 23
endc
if DEF(_SILVER)
INCBIN "slack/bank35padding_silver.2bpp", 23
endc


SECTION "slack.asm@Bank 28 Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank28padding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank28padding_silver.2bpp"
endc


SECTION "slack.asm@Bank 29 Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank29padding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank29padding_silver.2bpp"
endc


SECTION "slack.asm@Bank 2a Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank2apadding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank2apadding_silver.2bpp"
endc


SECTION "slack.asm@Bank 2b Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank2bpadding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank2bpadding_silver.2bpp"
endc


SECTION "slack.asm@Bank 2c Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank2cpadding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank2cpadding_silver.2bpp"
endc


SECTION "slack.asm@Bank 2d Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank2dpadding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank2dpadding_silver.2bpp"
endc


SECTION "slack.asm@Bank 2e Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank2epadding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank2epadding_silver.2bpp"
endc


SECTION "slack.asm@Bank 31 Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank31padding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank31padding_silver.2bpp"
endc


SECTION "slack.asm@Bank 39 Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank39padding_gold.2bpp", 159
endc
if DEF(_SILVER)
INCBIN "slack/bank39padding_silver.2bpp", 159
endc


SECTION "slack.asm@Bank 3c Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank3cpadding_gold.2bpp", 78
endc
if DEF(_SILVER)
INCBIN "slack/bank3cpadding_silver.2bpp", 78
endc


SECTION "slack.asm@Bank 3d Padding", ROMX
; This whole bank is garbage data.
if DEF(_GOLD)
INCBIN "slack/bank3dpadding_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "slack/bank3dpadding_silver.2bpp"
endc


SECTION "slack.asm@Bank 3f Padding", ROMX
if DEF(_GOLD)
INCBIN "slack/bank3fpadding_gold.2bpp", 45
endc
if DEF(_SILVER)
INCBIN "slack/bank3fpadding_silver.2bpp", 45
endc
