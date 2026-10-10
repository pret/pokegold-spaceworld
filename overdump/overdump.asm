; This file contains all of the unreferenced overdump data that exists in each ROM's banks.


SECTION "High Home Overdump", ROM0

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/high_home_gold.2bpp", 8
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/high_home_silver.2bpp", 8
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/high_home_gold.2bpp", 8
	endc
	if DEF(_SILVER)
	INCBIN "overdump/high_home_silver.2bpp", 8
	endc
endc


SECTION "Home Overdump", ROM0

if DEF(_DEBUG)

DEF Old_FarCallFunctionAddress EQU $2f91

INCLUDE "overdump/home/uncompress.asm"
INCLUDE "overdump/home/battle.asm"
INCLUDE "overdump/home/item.asm"
INCLUDE "overdump/home/battle_anims.asm"
INCLUDE "overdump/home/sprite_anims.asm"
INCLUDE "overdump/home/audio.asm"

else
if DEF(_GOLD)
INCLUDE "overdump/home/audio.asm"
INCBIN "overdump/home_gold.2bpp", 50
endc
if DEF(_SILVER)
INCBIN "overdump/home_silver.2bpp", 246
endc
endc

SECTION "Bank 01 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	ds 982, $39, $00
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank01_silver.2bpp", 42
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank01_gold.2bpp", 39
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank01_silver.2bpp", 39
	endc
endc


SECTION "Bank 02 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank02_gold.2bpp", 188
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank02_silver.2bpp", 188
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank02_gold.2bpp", 188
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank02_silver.2bpp", 188
	endc
endc


SECTION "Bank 03 Overdump", ROMX

if DEF(_DEBUG)

INCLUDE "overdump/engine/pokemon/knows_move.asm"

if DEF(_GOLD)
INCBIN "overdump/debug/bank03_gold.2bpp", 35
endc
if DEF(_SILVER)
INCBIN "overdump/debug/bank03_silver.2bpp", 35
endc
else
if DEF(_GOLD)
INCBIN "overdump/bank03_gold.2bpp", 200
endc
if DEF(_SILVER)
INCBIN "overdump/bank03_silver.2bpp", 200
endc
endc


SECTION "Bank 04 Overdump", ROMX

if DEF(_DEBUG)
	db $18, $00 ; leftover of previous graphics
Unreferenced_UnusedLeaderNameGFX:: INCBIN "gfx/trainer_card/unused_leader_name.2bpp"
	if DEF(_GOLD)
INCBIN "overdump/debug/bank04_gold.2bpp", 227
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank04_silver.2bpp", 227
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank04_gold.2bpp", 161
endc
	if DEF(_SILVER)
INCBIN "overdump/bank04_silver.2bpp", 161
	endc
endc


SECTION "Bank 05 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank05_gold.2bpp", 74
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank05_silver.2bpp", 74
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank05_gold.2bpp", 38
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank05_silver.2bpp", 38
	endc
endc


SECTION "Bank 06 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank06_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank06_silver.2bpp"
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank06_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank06_silver.2bpp"
	endc
endc


SECTION "Bank 09 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank09_gold.2bpp", 116
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank09_silver.2bpp", 116
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank09_gold.2bpp", 116
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank09_silver.2bpp", 116
	endc
endc


SECTION "Bank 0a Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank0a_gold.2bpp", 62
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank0a_silver.2bpp", 62
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank0a_gold.2bpp", 62
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank0a_silver.2bpp", 62
	endc
endc


SECTION "Bank 0b Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank0b_gold.2bpp", 111
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank0b_silver.2bpp", 111
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank0b_gold.2bpp", 111
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank0b_silver.2bpp", 111
	endc
endc


SECTION "Bank 0c Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank0c_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank0c_silver.2bpp"
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank0c_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank0c_silver.2bpp"
	endc
endc


SECTION "Bank 0d Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank0d_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank0d_silver.2bpp"
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank0d_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank0d_silver.2bpp"
	endc
endc


SECTION "Bank 0e Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank0e_gold.2bpp", 188
	endc
	if DEF(_SILVER)
INCLUDE "overdump/data/trainers/parties.asm"
INCBIN "overdump/debug/bank0e_silver.2bpp", 185
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank0e_gold.2bpp", 188
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank0e_silver.2bpp", 175
	endc
endc


SECTION "Bank 0f Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank0f_gold.2bpp", 75
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank0f_silver.2bpp", 75
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank0f_gold.2bpp", 75
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank0f_silver.2bpp", 75
	endc
endc


SECTION "Bank 10 Overdump", ROMX

INCLUDE "overdump/data/pokemon/evos_attacks.asm"
if DEF(_DEBUG)
if DEF(_GOLD)
	db $E6, $6D, $C3, $FF ; overdump
INCBIN "overdump/debug/bank10_gold.2bpp"
endc
if DEF(_SILVER)
	db 0, 0, 0, 0 ; overdump
INCBIN "overdump/debug/bank10_silver.2bpp"
endc
else
	if DEF(_GOLD)
	db $1E, $DF, $90, $F6 ; overdump
INCBIN "overdump/bank10_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank10_silver.2bpp", 186
	endc
endc

SECTION "Bank 11 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank11_gold.2bpp", 49
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank11_silver.2bpp", 49
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank11_gold.2bpp", 49
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank11_silver.2bpp", 49
	endc
endc

SECTION "Bank 12 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank12_gold.2bpp", 146
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank12_silver.2bpp", 146
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank12_gold.2bpp", 146
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank12_silver.2bpp", 146
	endc
endc


SECTION "Bank 13 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank13_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank13_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank13_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank13_silver.2bpp"
	endc
endc


SECTION "Bank 14 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank14_gold.2bpp", 116
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank14_silver.2bpp", 116
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank14_gold.2bpp", 116
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank14_silver.2bpp", 116
	endc
endc


SECTION "Bank 15 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank15_gold.2bpp", 159
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank15_silver.2bpp", 159
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank15_gold.2bpp", 159
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank15_silver.2bpp", 159
	endc
endc


SECTION "Bank 16 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank16_gold.2bpp", 168
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank16_silver.2bpp", 168
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank16_gold.2bpp", 168
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank16_silver.2bpp", 168
	endc
endc


SECTION "Bank 17 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank17_gold.2bpp", 238
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank17_silver.2bpp", 238
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank17_gold.2bpp", 238
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank17_silver.2bpp", 238
	endc
endc


SECTION "Bank 18 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank18_gold.2bpp", 87
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank18_silver.2bpp", 87
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank18_gold.2bpp", 87
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank18_silver.2bpp", 87
	endc
endc


SECTION "Bank 19 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank19_gold.2bpp", 161
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank19_silver.2bpp", 161
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank19_gold.2bpp", 161
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank19_silver.2bpp", 161
	endc
endc


SECTION "Bank 1a Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank1a_gold.2bpp", 230
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank1a_silver.2bpp", 230
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank1a_gold.2bpp", 230
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank1a_silver.2bpp", 230
	endc
endc


SECTION "Bank 1b Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank1b_gold.2bpp", 39
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank1b_silver.2bpp", 39
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank1b_gold.2bpp", 39
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank1b_silver.2bpp", 39
	endc
endc


SECTION "Bank 1c Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank1c_gold.2bpp", 127
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank1c_silver.2bpp", 127
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank1c_gold.2bpp", 127
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank1c_silver.2bpp", 127
	endc
endc


SECTION "Bank 1d Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank1d_gold.2bpp", 207
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank1d_silver.2bpp", 207
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank1d_gold.2bpp", 207
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank1d_silver.2bpp", 207
	endc
endc


SECTION "Bank 1e Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank1e_gold.2bpp", 34
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank1e_silver.2bpp", 34
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank1e_gold.2bpp", 34
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank1e_silver.2bpp", 34
	endc
endc


SECTION "Bank 1f Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank1f_gold.2bpp", 201
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank1f_silver.2bpp", 201
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank1f_gold.2bpp", 201
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank1f_silver.2bpp", 201
	endc
endc


SECTION "Bank 20 Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank20_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank20_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank20_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank20_silver.2bpp"
	endc
endc


SECTION "Bank 21 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank21_gold.2bpp", 208
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank21_silver.2bpp", 208
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank21_gold.2bpp", 208
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank21_silver.2bpp", 208
	endc
endc


SECTION "Bank 22 Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank22_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank22_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank22_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank22_silver.2bpp"
	endc
endc


SECTION "Bank 23 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank23_gold.2bpp", 37
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank23_silver.2bpp", 37
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank23_gold.2bpp", 37
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank23_silver.2bpp", 37
	endc
endc


SECTION "Bank 24 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank24_gold.2bpp", 43
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank24_silver.2bpp", 43
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank24_gold.2bpp", 43
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank24_silver.2bpp", 43
	endc
endc


SECTION "Bank 25 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank25_gold.2bpp", 221
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank25_silver.2bpp", 221
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank25_gold.2bpp", 221
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank25_silver.2bpp", 221
	endc
endc


SECTION "Bank 26 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank26_gold.2bpp", 34
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank26_silver.2bpp", 34
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank26_gold.2bpp", 34
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank26_silver.2bpp", 34
	endc
endc


SECTION "Bank 27 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank27_gold.2bpp", 88
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank27_silver.2bpp", 88
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank27_gold.2bpp", 88
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank27_silver.2bpp", 88
	endc
endc


SECTION "Bank 28 Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank28_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank28_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank28_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank28_silver.2bpp"
	endc
endc


SECTION "Bank 29 Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank29_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank29_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank29_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank29_silver.2bpp"
	endc
endc


SECTION "Bank 2a Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank2a_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank2a_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank2a_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank2a_silver.2bpp"
	endc
endc


SECTION "Bank 2b Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank2b_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank2b_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank2b_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank2b_silver.2bpp"
	endc
endc

SECTION "Bank 2c Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank2c_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank2c_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank2c_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank2c_silver.2bpp"
	endc
endc


SECTION "Bank 2d Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank2d_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank2d_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank2d_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank2d_silver.2bpp"
	endc
endc


SECTION "Bank 2e Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank2e_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank2e_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank2e_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank2e_silver.2bpp"
	endc
endc


SECTION "Bank 2f Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank2f_gold.2bpp", 150
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank2f_silver.2bpp", 62
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank2f_gold.2bpp", 150
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank2f_silver.2bpp", 62
	endc
endc


SECTION "Bank 30 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank30_gold.2bpp", 64
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank30_silver.2bpp", 64
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank30_gold.2bpp", 64
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank30_silver.2bpp", 64
	endc
endc


SECTION "Bank 31 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank31_gold.2bpp", 64
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank31_silver.2bpp", 64
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank31_gold.2bpp", 64
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank31_silver.2bpp", 64
	endc
endc


SECTION "Bank 32 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank32_gold.2bpp", 98
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank32_silver.2bpp", 98
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank32_gold.2bpp", 98
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank32_silver.2bpp", 98
	endc
endc


SECTION "Bank 33 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank33_gold.2bpp", 32
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank33_silver.2bpp", 32
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank33_gold.2bpp", 32
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank33_silver.2bpp", 32
	endc
endc


SECTION "Bank 34 Overdump", ROMX

if DEF(_SILVER) && !DEF(_DEBUG)
else
INCLUDE "overdump/maps/SilentHillLabBackUnused.asm"
INCLUDE "overdump/maps/SilentHillLabBack.asm"
INCLUDE "overdump/maps/SilentHillLabBackUnused_Old.asm"
INCLUDE "overdump/maps/SilentHillLabBack_Old.asm"
INCLUDE "overdump/maps/SilentHillLabBackUnused_Older.asm"
INCLUDE "overdump/maps/SilentHillLabBack_Older.asm"
INCLUDE "overdump/maps/SilentHillLabBackUnused_Oldest.asm"
endc
if DEF(_DEBUG)
DEF Bank34NonDebugOffset EQU 0
DEF Bank34StarterDexOffset EQU 13
DEF Bank34CorruptOffset EQU $17
	if DEF(_GOLD)
	DEF Bank34OldOffset EQU 5
INCBIN "overdump/debug/bank34_gold.2bpp", 115
	endc
	if DEF(_SILVER)
	DEF Bank34OldOffset EQU 0
	INCBIN "overdump/debug/bank34_silver.2bpp", 115
	endc
else
DEF Bank34NonDebugOffset EQU $1E
DEF Bank34OldOffset EQU -4
DEF Bank34CorruptOffset EQU -7
DEF Bank34StarterDexOffset EQU 37
	if DEF(_GOLD)
	INCBIN "overdump/bank34_gold.2bpp", 115
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank34_silver.2bpp", 149
	endc
endc


SECTION "Bank 35 Overdump", ROMX

; This whole bank is overdump data.
rept 23
	ret
endr
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank35_gold.2bpp", 23
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank35_silver.2bpp", 23
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank35_gold.2bpp", 23
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank35_silver.2bpp", 23
	endc
endc


SECTION "Bank 36 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank36_gold.2bpp", 221
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank36_silver.2bpp", 213
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank36_gold.2bpp", 221
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank36_silver.2bpp", 213
	endc
endc


SECTION "Bank 37 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank37_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank37_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank37_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank37_silver.2bpp"
	endc
endc

SECTION "Bank 38 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "overdump/debug/bank38_gold.2bpp", 87
	endc
	if DEF(_SILVER)
	INCBIN "overdump/debug/bank38_silver.2bpp", 87
	endc
else
	if DEF(_GOLD)
	INCBIN "overdump/bank38_gold.2bpp", 87
	endc
	if DEF(_SILVER)
	INCBIN "overdump/bank38_silver.2bpp", 87
	endc
endc


SECTION "Bank 39 Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank39_gold.2bpp", 159
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank39_silver.2bpp", 159
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank39_gold.2bpp", 159
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank39_silver.2bpp", 159
	endc
endc


SECTION "Bank 3a Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank3a_gold.2bpp", 177
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank3a_silver.2bpp", 177
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank3a_gold.2bpp", 177
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank3a_silver.2bpp", 177
	endc
endc


SECTION "Bank 3b Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank3b_gold.2bpp", 189
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank3b_silver.2bpp", 189
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank3b_gold.2bpp", 189
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank3b_silver.2bpp", 189
	endc
endc


SECTION "Bank 3c Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank3c_gold.2bpp", 78
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank3c_silver.2bpp", 78
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank3c_gold.2bpp", 78
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank3c_silver.2bpp", 78
	endc
endc


SECTION "Bank 3d Overdump", ROMX

; This whole bank is overdump data.
if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank3d_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank3d_silver.2bpp"
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank3d_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank3d_silver.2bpp"
	endc
endc


SECTION "Bank 3e Overdump", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "overdump/debug/bank3e_gold.2bpp", 42
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank3e_silver.2bpp", 42
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank3e_gold.2bpp", 42
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank3e_silver.2bpp", 42
	endc
endc


SECTION "Bank 3f Overdump", ROMX

if DEF(_DEBUG)
	cpl
	ret
	if DEF(_GOLD)
INCBIN "overdump/debug/bank3f_gold.2bpp", 45
	endc
	if DEF(_SILVER)
INCBIN "overdump/debug/bank3f_silver.2bpp", 45
	endc
else
	if DEF(_GOLD)
INCBIN "overdump/bank3f_gold.2bpp", 43
	endc
	if DEF(_SILVER)
INCBIN "overdump/bank3f_silver.2bpp", 43
	endc
endc
