INCLUDE "constants.asm"

SECTION "garbage.asm@Home Garbage", ROM0

if DEF(_DEBUG)

DEF Old_FarCallFunctionAddress EQU $2f91

Unreferenced_Corrupt__InterlaceMergeSpriteBuffers.interlaceLoopFlipped:
	xor a
	dec a
	ldh [hConnectionStripLength], a
	jr nz, @ - 25 ; Unknown function
	ret

Unreferenced_Corrupt_GetPartyParamLocation_Old:
	push bc
	ld hl, wPartyMons
	ld c, a
	ld b, 0
	add hl, bc
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call $3412 ; Early position for AddNTimes
	pop bc
	ret

Unreferenced_Corrupt_DoItemEffect_Old:
	ld a, BANK(_DoItemEffect)
	ld hl, $67C4 ; Early location for _DoItemEffect
	jp Old_FarCallFunctionAddress

Unreferenced_Corrupt_CheckTossableItem_Old:
	push hl
	push de
	push bc
	ld hl, $53E5 ; Early location for _CheckTossableItem
	ld a, BANK(_CheckTossableItem)
	call Old_FarCallFunctionAddress
	pop bc
	pop de
	pop hl
	ret

Unreferenced_Corrupt_GetBattleAnimPointer_Old:
	ld a, BANK(BattleAnimations)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ld a, [hli]
	ld [wBattleAnimAddress], a
	ld a, [hl]
	ld [wBattleAnimAddress + 1], a

	ld a, BANK(PlayBattleAnim)
	ld [MBC3RomBank], a
	ldh [hROMBank], a
	ret

Unreferenced_Corrupt_GetBattleAnimByte_Old:
	push hl
	push de

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]

	ld a, BANK(BattleAnimations)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ld a, [de]
	ld [wBattleAnimByte], a
	inc de

	ld a, BANK(PlayBattleAnim)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ld [hl], d
	dec hl
	ld [hl], e

	pop de
	pop hl

	ld a, [wBattleAnimByte]
	ret

Unreferenced_Corrupt_InitSpriteAnimStruct_Old:
	ld [wCurSpriteOAMFlags], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSpriteAnimStruct)
	call $32AB ; Old location of Bankswitch
	ld a, [wCurSpriteOAMFlags]
	call _InitSpriteAnimStruct
	pop af
	call $32AB ; Old location of Bankswitch
	ret

Unreferenced_Corrupt_ReinitSpriteAnimFrame_Old: ; stubbed
	ret

Unreferenced_Corrupt_DisableAudio_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_DisableAudio)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _DisableAudio
	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unused_UpdateSound_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_UpdateSound)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _UpdateSound
	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_Corrupt_LoadMusicByte_Old:
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	ld a, [de]
	push af
	ld a, BANK(_UpdateSound)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	ret

Unreferenced_Corrupt_PlayMusic_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayMusic)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _PlayMusic
	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_Corrupt_PlayCryHeader_Old:
	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(PokemonCries)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	ld hl, PokemonCries
rept 6
	add hl, de
endr
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld [wCryPitch], a
	ld a, [hli]
	ld [wCryPitch + 1], a
	ld a, [hli]
	ld [wCryLength], a
	ld a, [hl]
	ld [wCryLength + 1], a

	ld a, BANK(_PlayCryHeader)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _PlayCryHeader

	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unused_PlaySFX_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlaySFX)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _PlaySFX
	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_Corrupt_WaitPlaySFX_Old:
	call Unused_WaitSFX_Old
	call Unused_PlaySFX_Old
	ret

Unused_WaitSFX_Old:
	push hl
.loop
	ld hl, wChannel5Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .loop
	ld hl, wChannel6Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .loop
	ld hl, wChannel7Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .loop
	ld hl, wChannel8Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .loop
	pop hl
	ret

Unreferenced_Corrupt_MaxVolume_Old:
	ld a, $77
	ld [wVolume], a
	ret

Unreferenced_Corrupt_LowVolume_Old:
	ld a, $33
	ld [wVolume], a
	ret

Unreferenced_Corrupt_UpdateSoundNTimes_Old:
.loop
	and a
	ret z
	dec a
	call Unused_UpdateSound_Old
	jr .loop

Unreferenced_Corrupt_FadeToMapMusic_Old:
	push hl
	push de
	push bc
	push af
; The check appears to be backwards: the carry flag is set if the player is on a vehicle, and unset otherwise.
; If the player is on no vehicle, then it would've used the last value of 'de' as the music id, potentially playing a garbage track.
; The final game fixes this by instead checking if the vehicle track is already playing, but the final GetMapMusic still sets the carry flag.
	call Unused_SpecialMapMusic_Old
	jr c, .dont_change
	ld a, 8
	ld [wMusicFade], a
	call _DisableAudio
	ld a, e
	ld [wMusicFadeID], a
	ld a, d
	ld [wMusicFadeID + 1], a
.dont_change
	pop af
	pop bc
	pop de
	pop hl
	ret

; Disables audio when the player is not on a bike or skateboard.
Unreferenced_Corrupt_PlayMapMusic_Old:
	push hl
	push de
	push bc
	push af
	ld de, MUSIC_NONE
	call Unreferenced_Corrupt_PlayMusic_Old
	call DelayFrame
	call Unused_SpecialMapMusic_Old
	jr c, .play_music

; _DisableAudio is in a mapper bank, but the bank is not switched in this function.
; Either this function was supposed to be called when in the same bank,
; or this is an oversight, and they meant to call DisableAudio instead (note the lack of underscore).
	call _DisableAudio
.play_music
	call Unreferenced_Corrupt_PlayMusic_Old
	pop af
	pop bc
	pop de
	pop hl
	ret

; There was no GetMapMusic at this point in development.
Unused_SpecialMapMusic_Old:
	ld a, [wPlayerState]
	and a
	jr z, .normal
	cp PLAYER_SKATE
	jr z, .skateboard
	ld de, MUSIC_BICYCLE
	scf
	ret

.skateboard
	ld de, MUSIC_NONE
	scf
	ret

.normal
	and a
	ret

endc

SECTION "garbage.asm@Bank 01 Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
	ds 982, $39, $00
endc
if DEF(_SILVER)
INCBIN "garbage/bank01_silver.2bpp", 42
endc
endc


SECTION "garbage.asm@Bank 02 Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank02_gold.2bpp", 188
endc
if DEF(_SILVER)
INCBIN "garbage/bank02_silver.2bpp", 188
endc
endc


SECTION "garbage.asm@Bank 03 Garbage", ROMX

if DEF(_DEBUG)

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

endc


SECTION "garbage.asm@Bank 04 Garbage", ROMX

if DEF(_DEBUG)
	db $18, $00 ; leftover of previous graphics
Unreferenced_UnusedLeaderNameGFX:: INCBIN "gfx/trainer_card/unused_leader_name.2bpp"
if DEF(_GOLD)
INCBIN "garbage/bank04_gold.2bpp", 227
endc
if DEF(_SILVER)
INCBIN "garbage/bank04_silver.2bpp", 227
endc
endc


SECTION "garbage.asm@Bank 05 Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank05_gold.2bpp", 74
endc
if DEF(_SILVER)
INCBIN "garbage/bank05_silver.2bpp", 74
endc
endc


SECTION "garbage.asm@Bank 06 Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank06_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank06_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 09 Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank09_gold.2bpp", 116
endc
if DEF(_SILVER)
INCBIN "garbage/bank09_silver.2bpp", 116
endc
endc


SECTION "garbage.asm@Bank 0a Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank0a_gold.2bpp", 62
endc
if DEF(_SILVER)
INCBIN "garbage/bank0a_silver.2bpp", 62
endc
endc


SECTION "garbage.asm@Bank 0b Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank0b_gold.2bpp", 111
endc
if DEF(_SILVER)
INCBIN "garbage/bank0b_silver.2bpp", 111
endc
endc


SECTION "garbage.asm@Bank 0c Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank0c_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank0c_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 0d Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank0d_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank0d_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 0e Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank0e_gold.2bpp", 188
endc
if DEF(_SILVER)
	db -1 ; end

	; early version of KIMONO_GIRL_KOUME?
	db "こうめ@", TRAINERTYPE_ITEM_MOVES
	db  8, DEX_CLEFAIRY, ITEM_NONE
	db -1 ; end
INCBIN "garbage/bank0e_silver.2bpp", 185
endc
endc


SECTION "garbage.asm@Bank 0f Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank0f_gold.2bpp", 75
endc
if DEF(_SILVER)
INCBIN "garbage/bank0f_silver.2bpp", 75
endc
endc


SECTION "garbage.asm@Bank 10 Garbage", ROMX

if DEF(_DEBUG)

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
endc
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
if DEF(_GOLD)
	db $E6, $6D, $C3, $FF ; garbage

INCBIN "garbage/bank10_gold.2bpp"
endc
if DEF(_SILVER)
	db 0, 0, 0, 0 ; garbage

INCBIN "garbage/bank10_silver.2bpp"
endc

endc


SECTION "garbage.asm@Bank 14 Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank14_gold.2bpp", 116
endc
if DEF(_SILVER)
INCBIN "garbage/bank14_silver.2bpp", 116
endc
endc


SECTION "garbage.asm@Bank 20 Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank20_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank20_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 22 Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank22_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank22_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 35 Garbage", ROMX

; This whole bank is garbage data.
rept 23
	ret
endr
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank35_gold.2bpp", 23
endc
if DEF(_SILVER)
INCBIN "garbage/bank35_silver.2bpp", 23
endc
endc


SECTION "garbage.asm@Bank 28 Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank28_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank28_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 29 Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank29_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank29_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 2a Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank2a_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2a_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 2b Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank2b_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2b_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 2c Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank2c_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2c_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 2d Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank2d_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2d_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 2e Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank2e_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank2e_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 31 Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank31_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank31_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 39 Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank39_gold.2bpp", 159
endc
if DEF(_SILVER)
INCBIN "garbage/bank39_silver.2bpp", 159
endc
endc


SECTION "garbage.asm@Bank 3c Garbage", ROMX

if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank3c_gold.2bpp", 78
endc
if DEF(_SILVER)
INCBIN "garbage/bank3c_silver.2bpp", 78
endc
endc


SECTION "garbage.asm@Bank 3d Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
if DEF(_GOLD)
INCBIN "garbage/bank3d_gold.2bpp"
endc
if DEF(_SILVER)
INCBIN "garbage/bank3d_silver.2bpp"
endc
endc


SECTION "garbage.asm@Bank 3f Garbage", ROMX

if DEF(_DEBUG)
	cpl
	ret
if DEF(_GOLD)
INCBIN "garbage/bank3f_gold.2bpp", 45
endc
if DEF(_SILVER)
INCBIN "garbage/bank3f_silver.2bpp", 45
endc
endc
