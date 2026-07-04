; This file contains all of the unreferenced garbage data that exists in each ROM's banks.


SECTION "garbage.asm@High Home Garbage", ROM0

if DEF(_DEBUG)
	if DEF(_GOLD)
	db $00, $00, $00, $00, $00, $C5, $F7, $1B,
	db $BA, $E7, $F5, $6D, $B6, $7B, $FD, $F8,
	db $37, $DD, $17, $F5, $F7, $FF, $F9, $72,
	db $BB, $AF, $F7, $EF, $5C, $12, $00, $BA,
	db $17, $02, $15, $C0, $12, $7E, $03, $10,
	db $08, $00, $41, $00, $48, $2C, $01, $3E,
	db $00, $C0, $50, $01, $00, $82, $43, $00,
	db $03, $06, $B2, $07, $50, $29, $33, $50,
	db $47, $50, $D0, $04, $E1, $05, $31, $84,
	db $50, $2F, $84, $01, $82, $38, $82, $04,
	db $10, $15, $70, $02, $10, $23, $61, $38,
	db $00, $01, $06, $32, $50, $D1, $23, $04,
	db $85, $22, $44, $A9, $01, $B4, $61, $00,
	db $40, $24, $3C, $0C, $06, $0A, $19, $A0,
	db $21, $1A, $15, $30, $11, $02, $14, $00,
	db $12, $07, $47, $00, $41, $D0, $B1, $4A,
	db $4C, $01, $E1, $00, $2C, $00, $00, $02,
	db $93, $29, $4C, $01, $08, $A1, $28, $79,
	db $05, $51, $44, $69, $15, $81, $10, $8A,
	db $C8, $0E, $86, $45, $12
	endc
	if DEF(_SILVER)
	db $00, $00, $00, $00, $00, $03, $20, $10,
	db $01, $24, $00, $23, $20, $00, $20, $20,
	db $40, $20, $00, $01, $01, $81, $30, $40,
	db $01, $09, $95, $10, $A1, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $7F, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $50, $D2, $76, $F3, $7F,
	db $FF, $00, $01, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $DF, $FF, $FF,
	db $FD, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FD, $FC, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
	db $FF, $FF, $FF, $FF, $FF
	endc
else
	if DEF(_GOLD)
	db $00, $00, $00, $00, $00, $FB, $7F, $FF,
	db $F9, $BF, $FF, $ED, $FF, $7F, $E7, $EB,
	db $FF, $6F, $1F, $F8, $E7, $4F, $F6, $5F,
	db $5F, $FF, $FF, $DF, $BE, $1A, $51, $2A,
	db $41, $4B, $49, $21, $C0, $31, $20, $52,
	db $97, $18, $00, $09, $05, $AA, $78, $64,
	db $01, $8D, $94, $33, $82, $90, $A6, $3B,
	db $82, $10, $08, $9D, $5C, $2F, $50, $95,
	db $40, $1D, $24, $12, $63, $80, $31, $68,
	db $80, $43, $02, $BA, $44, $50, $86, $14,
	db $21, $68, $56, $00, $88, $9B, $3B, $0A,
	db $97, $83, $C1, $0D, $42, $4B, $03, $D1,
	db $87, $2D, $A0, $01, $CA, $2B, $88, $CB,
	db $20, $61, $21, $14, $0E, $CF, $76, $05,
	db $F0, $02, $11, $02, $9E, $EC, $13, $59,
	db $51, $31, $15, $1D, $8A, $31, $03, $22,
	db $C0, $CE, $A0, $DF, $38, $95, $3D, $00,
	db $50, $8C, $20, $9B, $10, $2C, $28, $85,
	db $61, $33, $1C, $4C, $A5, $51, $00, $1E,
	db $82, $E8, $02, $9E, $24
	endc
	if DEF(_SILVER)
	db $00, $00, $00, $00, $00, $28, $AA, $AA,
	db $22, $AE, $AA, $A2, $AA, $A8, $AA, $AA,
	db $A2, $A8, $AA, $88, $AA, $AA, $A2, $A3,
	db $2A, $AA, $A2, $0A, $AB, $EA, $AF, $AA,
	db $A6, $AE, $EA, $EB, $8A, $EA, $AA, $AA,
	db $FA, $AE, $BA, $AB, $AA, $EA, $AE, $BE,
	db $AB, $AA, $AE, $AA, $AE, $BB, $BA, $AE,
	db $EB, $EB, $AE, $AE, $AF, $AA, $AA, $AA,
	db $F2, $AA, $AA, $EB, $EA, $AA, $AA, $AA,
	db $BF, $AA, $AA, $8E, $AE, $EA, $FE, $AA,
	db $AA, $BA, $AE, $AA, $AA, $AE, $EA, $AA,
	db $EE, $AE, $AA, $AA, $BA, $AA, $B8, $AB,
	db $AE, $AA, $6A, $AA, $E8, $AA, $EA, $EA,
	db $EB, $EE, $28, $EA, $BC, $AB, $BA, $AE,
	db $AA, $AA, $FE, $AA, $AA, $BB, $AA, $EA,
	db $AA, $AB, $AB, $BE, $BB, $EB, $AE, $BA,
	db $AE, $EA, $AA, $AA, $AA, $CA, $BF, $AA,
	db $AF, $AE, $BA, $AA, $AB, $AE, $AA, $EA,
	db $AA, $AA, $AE, $AA, $AA, $AB, $AE, $EE,
	db $AE, $AB, $AE, $BA, $AA
	endc
endc


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
else
if DEF(_GOLD)
INCBIN "garbage/home_gold.2bpp", 246
endc
if DEF(_SILVER)
INCBIN "garbage/home_silver.2bpp", 246
endc
endc

SECTION "garbage.asm@Bank 01 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	ds 982, $39, $00
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank01_silver.2bpp", 42
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank01_gold.2bpp", 39
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank01_silver.2bpp", 39
	endc
endc


SECTION "garbage.asm@Bank 02 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank02_gold.2bpp", 188
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank02_silver.2bpp", 188
	endc
else
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
INCBIN "garbage/debug/bank03_gold.2bpp", 35
endc
if DEF(_SILVER)
INCBIN "garbage/debug/bank03_silver.2bpp", 35
endc
else
if DEF(_GOLD)
INCBIN "garbage/bank03_gold.2bpp", 200
endc
if DEF(_SILVER)
INCBIN "garbage/bank03_silver.2bpp", 200
endc
endc


SECTION "garbage.asm@Bank 04 Garbage", ROMX

if DEF(_DEBUG)
	db $18, $00 ; leftover of previous graphics
Unreferenced_UnusedLeaderNameGFX:: INCBIN "gfx/trainer_card/unused_leader_name.2bpp"
	if DEF(_GOLD)
INCBIN "garbage/debug/bank04_gold.2bpp", 227
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank04_silver.2bpp", 227
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank04_gold.2bpp", 161
endc
	if DEF(_SILVER)
INCBIN "garbage/bank04_silver.2bpp", 161
	endc
endc


SECTION "garbage.asm@Bank 05 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank05_gold.2bpp", 74
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank05_silver.2bpp", 74
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank05_gold.2bpp", 38
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank05_silver.2bpp", 38
	endc
endc


SECTION "garbage.asm@Bank 06 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank06_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank06_silver.2bpp"
	endc
else
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
INCBIN "garbage/debug/bank09_gold.2bpp", 116
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank09_silver.2bpp", 116
	endc
else
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
INCBIN "garbage/debug/bank0a_gold.2bpp", 62
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank0a_silver.2bpp", 62
	endc
else
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
INCBIN "garbage/debug/bank0b_gold.2bpp", 111
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank0b_silver.2bpp", 111
	endc
else
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
INCBIN "garbage/debug/bank0c_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank0c_silver.2bpp"
	endc
else
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
INCBIN "garbage/debug/bank0d_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank0d_silver.2bpp"
	endc
else
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
INCBIN "garbage/debug/bank0e_gold.2bpp", 188
	endc
	if DEF(_SILVER)
	db -1 ; end

	; early version of KIMONO_GIRL_KOUME?
	db "こうめ@", TRAINERTYPE_ITEM_MOVES
	db  8, DEX_CLEFAIRY, ITEM_NONE
	db -1 ; end
INCBIN "garbage/debug/bank0e_silver.2bpp", 185
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank0e_gold.2bpp", 188
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank0e_silver.2bpp", 175
	endc
endc


SECTION "garbage.asm@Bank 0f Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank0f_gold.2bpp", 75
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank0f_silver.2bpp", 75
	endc
else
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

INCBIN "garbage/debug/bank10_gold.2bpp"
endc
if DEF(_SILVER)
	db 0, 0, 0, 0 ; garbage

INCBIN "garbage/debug/bank10_silver.2bpp"
endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank10_gold.2bpp", 186
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank10_silver.2bpp", 186
	endc
endc

SECTION "garbage.asm@Bank 11 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank11_gold.2bpp", 49
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank11_silver.2bpp", 49
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank11_gold.2bpp", 49
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank11_silver.2bpp", 49
	endc
endc

SECTION "garbage.asm@Bank 12 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank12_gold.2bpp", 146
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank12_silver.2bpp", 146
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank12_gold.2bpp", 146
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank12_silver.2bpp", 146
	endc
endc


SECTION "garbage.asm@Bank 13 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank13_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank13_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank13_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank13_silver.2bpp"
	endc
endc


SECTION "garbage.asm@Bank 14 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank14_gold.2bpp", 116
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank14_silver.2bpp", 116
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank14_gold.2bpp", 116
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank14_silver.2bpp", 116
	endc
endc


SECTION "garbage.asm@Bank 15 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank15_gold.2bpp", 159
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank15_silver.2bpp", 159
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank15_gold.2bpp", 159
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank15_silver.2bpp", 159
	endc
endc


SECTION "garbage.asm@Bank 16 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank16_gold.2bpp", 168
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank16_silver.2bpp", 168
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank16_gold.2bpp", 168
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank16_silver.2bpp", 168
	endc
endc


SECTION "garbage.asm@Bank 17 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank17_gold.2bpp", 238
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank17_silver.2bpp", 238
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank17_gold.2bpp", 238
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank17_silver.2bpp", 238
	endc
endc


SECTION "garbage.asm@Bank 18 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank18_gold.2bpp", 87
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank18_silver.2bpp", 87
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank18_gold.2bpp", 87
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank18_silver.2bpp", 87
	endc
endc


SECTION "garbage.asm@Bank 19 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank19_gold.2bpp", 161
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank19_silver.2bpp", 161
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank19_gold.2bpp", 161
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank19_silver.2bpp", 161
	endc
endc


SECTION "garbage.asm@Bank 1a Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank1a_gold.2bpp", 230
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank1a_silver.2bpp", 230
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank1a_gold.2bpp", 230
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank1a_silver.2bpp", 230
	endc
endc


SECTION "garbage.asm@Bank 1b Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank1b_gold.2bpp", 39
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank1b_silver.2bpp", 39
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank1b_gold.2bpp", 39
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank1b_silver.2bpp", 39
	endc
endc


SECTION "garbage.asm@Bank 1c Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank1c_gold.2bpp", 127
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank1c_silver.2bpp", 127
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank1c_gold.2bpp", 127
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank1c_silver.2bpp", 127
	endc
endc


SECTION "garbage.asm@Bank 1d Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank1d_gold.2bpp", 207
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank1d_silver.2bpp", 207
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank1d_gold.2bpp", 207
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank1d_silver.2bpp", 207
	endc
endc


SECTION "garbage.asm@Bank 1e Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank1e_gold.2bpp", 34
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank1e_silver.2bpp", 34
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank1e_gold.2bpp", 34
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank1e_silver.2bpp", 34
	endc
endc


SECTION "garbage.asm@Bank 1f Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank1f_gold.2bpp", 201
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank1f_silver.2bpp", 201
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank1f_gold.2bpp", 201
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank1f_silver.2bpp", 201
	endc
endc


SECTION "garbage.asm@Bank 20 Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank20_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank20_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank20_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank20_silver.2bpp"
	endc
endc


SECTION "garbage.asm@Bank 21 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank21_gold.2bpp", 208
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank21_silver.2bpp", 208
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank21_gold.2bpp", 208
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank21_silver.2bpp", 208
	endc
endc


SECTION "garbage.asm@Bank 22 Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank22_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank22_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank22_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank22_silver.2bpp"
	endc
endc


SECTION "garbage.asm@Bank 23 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank23_gold.2bpp", 37
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank23_silver.2bpp", 37
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank23_gold.2bpp", 37
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank23_silver.2bpp", 37
	endc
endc


SECTION "garbage.asm@Bank 24 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank24_gold.2bpp", 43
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank24_silver.2bpp", 43
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank24_gold.2bpp", 43
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank24_silver.2bpp", 43
	endc
endc


SECTION "garbage.asm@Bank 25 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank25_gold.2bpp", 221
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank25_silver.2bpp", 221
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank25_gold.2bpp", 221
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank25_silver.2bpp", 221
	endc
endc


SECTION "garbage.asm@Bank 26 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank26_gold.2bpp", 34
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank26_silver.2bpp", 34
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank26_gold.2bpp", 34
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank26_silver.2bpp", 34
	endc
endc


SECTION "garbage.asm@Bank 27 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank27_gold.2bpp", 88
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank27_silver.2bpp", 88
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank27_gold.2bpp", 88
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank27_silver.2bpp", 88
	endc
endc


SECTION "garbage.asm@Bank 28 Garbage", ROMX

; This whole bank is garbage data.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank28_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank28_silver.2bpp"
	endc
else
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
	INCBIN "garbage/debug/bank29_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank29_silver.2bpp"
	endc
else
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
	INCBIN "garbage/debug/bank2a_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank2a_silver.2bpp"
	endc
else
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
	INCBIN "garbage/debug/bank2b_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank2b_silver.2bpp"
	endc
else
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
	INCBIN "garbage/debug/bank2c_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank2c_silver.2bpp"
	endc
else
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
	INCBIN "garbage/debug/bank2d_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank2d_silver.2bpp"
	endc
else
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
	INCBIN "garbage/debug/bank2e_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank2e_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank2e_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank2e_silver.2bpp"
	endc
endc


SECTION "garbage.asm@Bank 2f Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank2f_gold.2bpp", 150
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank2f_silver.2bpp", 62
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank2f_gold.2bpp", 150
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank2f_silver.2bpp", 62
	endc
endc


SECTION "garbage.asm@Bank 30 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank30_gold.2bpp", 64
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank30_silver.2bpp", 64
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank30_gold.2bpp", 64
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank30_silver.2bpp", 64
	endc
endc


SECTION "garbage.asm@Bank 31 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank31_gold.2bpp", 64
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank31_silver.2bpp", 64
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank31_gold.2bpp", 64
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank31_silver.2bpp", 64
	endc
endc


SECTION "garbage.asm@Bank 32 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank32_gold.2bpp", 98
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank32_silver.2bpp", 98
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank32_gold.2bpp", 98
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank32_silver.2bpp", 98
	endc
endc


SECTION "garbage.asm@Bank 33 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank33_gold.2bpp", 32
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank33_silver.2bpp", 32
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank33_gold.2bpp", 32
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank33_silver.2bpp", 32
	endc
endc


SECTION "garbage.asm@Bank 34 Garbage", ROMX
; TODO: Extract the corrupt map scripts.

if DEF(_DEBUG)
DEF Bank34NonDebugOffset EQU 0
DEF Bank34OldOffset EQU 5
DEF Bank34StarterDexOffset EQU 13
DEF Bank34CorruptOffset EQU $17
	if DEF(_GOLD)
INCBIN "garbage/debug/bank34_gold.2bpp", 149
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank34_silver.2bpp", 149
	endc
else
DEF Bank34NonDebugOffset EQU $1E
DEF Bank34OldOffset EQU -4
DEF Bank34CorruptOffset EQU -7
DEF Bank34StarterDexOffset EQU 37
	if DEF(_GOLD)
INCBIN "garbage/bank34_gold.2bpp", 149
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank34_silver.2bpp", 149
	endc
endc


SECTION "garbage.asm@Bank 35 Garbage", ROMX

; This whole bank is garbage data.
rept 23
	ret
endr
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank35_gold.2bpp", 23
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank35_silver.2bpp", 23
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank35_gold.2bpp", 23
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank35_silver.2bpp", 23
	endc
endc


SECTION "garbage.asm@Bank 36 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank36_gold.2bpp", 221
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank36_silver.2bpp", 213
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank36_gold.2bpp", 221
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank36_silver.2bpp", 213
	endc
endc


SECTION "garbage.asm@Bank 37 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank37_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank37_silver.2bpp"
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank37_gold.2bpp"
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank37_silver.2bpp"
	endc
endc

SECTION "garbage.asm@Bank 38 Garbage", ROMX
; TODO: Investigate matching data at the beginning.
if DEF(_DEBUG)
	if DEF(_GOLD)
	INCBIN "garbage/debug/bank38_gold.2bpp", 87
	endc
	if DEF(_SILVER)
	INCBIN "garbage/debug/bank38_silver.2bpp", 87
	endc
else
	if DEF(_GOLD)
	INCBIN "garbage/bank38_gold.2bpp", 87
	endc
	if DEF(_SILVER)
	INCBIN "garbage/bank38_silver.2bpp", 87
	endc
endc


SECTION "garbage.asm@Bank 39 Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank39_gold.2bpp", 159
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank39_silver.2bpp", 159
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank39_gold.2bpp", 159
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank39_silver.2bpp", 159
	endc
endc


SECTION "garbage.asm@Bank 3a Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank3a_gold.2bpp", 177
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank3a_silver.2bpp", 177
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank3a_gold.2bpp", 177
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank3a_silver.2bpp", 177
	endc
endc


SECTION "garbage.asm@Bank 3b Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank3b_gold.2bpp", 189
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank3b_silver.2bpp", 189
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank3b_gold.2bpp", 189
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank3b_silver.2bpp", 189
	endc
endc


SECTION "garbage.asm@Bank 3c Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank3c_gold.2bpp", 78
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank3c_silver.2bpp", 78
	endc
else
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
INCBIN "garbage/debug/bank3d_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank3d_silver.2bpp"
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank3d_gold.2bpp"
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank3d_silver.2bpp"
	endc
endc


SECTION "garbage.asm@Bank 3e Garbage", ROMX

if DEF(_DEBUG)
	if DEF(_GOLD)
INCBIN "garbage/debug/bank3e_gold.2bpp", 42
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank3e_silver.2bpp", 42
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank3e_gold.2bpp", 42
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank3e_silver.2bpp", 42
	endc
endc


SECTION "garbage.asm@Bank 3f Garbage", ROMX

if DEF(_DEBUG)
	cpl
	ret
	if DEF(_GOLD)
INCBIN "garbage/debug/bank3f_gold.2bpp", 45
	endc
	if DEF(_SILVER)
INCBIN "garbage/debug/bank3f_silver.2bpp", 45
	endc
else
	if DEF(_GOLD)
INCBIN "garbage/bank3f_gold.2bpp", 43
	endc
	if DEF(_SILVER)
INCBIN "garbage/bank3f_silver.2bpp", 43
	endc
endc
