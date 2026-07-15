; This file contains all of the unreferenced overdump data that exists in each ROM's banks.


SECTION "High Home Overdump", ROM0

if DEF(_DEBUG)
	if DEF(_GOLD)
	db $C5, $F7, $1B, $BA, $E7, $F5, $6D, $B6
	db $7B, $FD, $F8, $37, $DD, $17, $F5, $F7
	db $FF, $F9, $72, $BB, $AF, $F7, $EF, $5C
	db $12, $00, $BA, $17, $02, $15, $C0, $12
	db $7E, $03, $10, $08, $00, $41, $00, $48
	db $2C, $01, $3E, $00, $C0, $50, $01, $00
	db $82, $43, $00, $03, $06, $B2, $07, $50
	db $29, $33, $50, $47, $50, $D0, $04, $E1
	db $05, $31, $84, $50, $2F, $84, $01, $82
	db $38, $82, $04, $10, $15, $70, $02, $10
	db $23, $61, $38, $00, $01, $06, $32, $50
	db $D1, $23, $04, $85, $22, $44, $A9, $01
	db $B4, $61, $00, $40, $24, $3C, $0C, $06
	db $0A, $19, $A0, $21, $1A, $15, $30, $11
	db $02, $14, $00, $12, $07, $47, $00, $41
	db $D0, $B1, $4A, $4C, $01, $E1, $00, $2C
	db $00, $00, $02, $93, $29, $4C, $01, $08
	db $A1, $28, $79, $05, $51, $44, $69, $15
	db $81, $10, $8A, $C8, $0E, $86, $45, $12
	endc
	if DEF(_SILVER)
	db $03, $20, $10, $01, $24, $00, $23, $20
	db $00, $20, $20, $40, $20, $00, $01, $01
	db $81, $30, $40, $01, $09, $95, $10, $A1
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $7F, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $50, $D2
	db $76, $F3, $7F, $FF, $00, $01, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $DF, $FF, $FF, $FD, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FD, $FC, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
	endc
else
	if DEF(_GOLD)
	db $FB, $7F, $FF, $F9, $BF, $FF, $ED, $FF
	db $7F, $E7, $EB, $FF, $6F, $1F, $F8, $E7
	db $4F, $F6, $5F, $5F, $FF, $FF, $DF, $BE
	db $1A, $51, $2A, $41, $4B, $49, $21, $C0
	db $31, $20, $52, $97, $18, $00, $09, $05
	db $AA, $78, $64, $01, $8D, $94, $33, $82
	db $90, $A6, $3B, $82, $10, $08, $9D, $5C
	db $2F, $50, $95, $40, $1D, $24, $12, $63
	db $80, $31, $68, $80, $43, $02, $BA, $44
	db $50, $86, $14, $21, $68, $56, $00, $88
	db $9B, $3B, $0A, $97, $83, $C1, $0D, $42
	db $4B, $03, $D1, $87, $2D, $A0, $01, $CA
	db $2B, $88, $CB, $20, $61, $21, $14, $0E
	db $CF, $76, $05, $F0, $02, $11, $02, $9E
	db $EC, $13, $59, $51, $31, $15, $1D, $8A
	db $31, $03, $22, $C0, $CE, $A0, $DF, $38
	db $95, $3D, $00, $50, $8C, $20, $9B, $10
	db $2C, $28, $85, $61, $33, $1C, $4C, $A5
	db $51, $00, $1E, $82, $E8, $02, $9E, $24
	endc
	if DEF(_SILVER)
	db $28, $AA, $AA, $22, $AE, $AA, $A2, $AA
	db $A8, $AA, $AA, $A2, $A8, $AA, $88, $AA
	db $AA, $A2, $A3, $2A, $AA, $A2, $0A, $AB
	db $EA, $AF, $AA, $A6, $AE, $EA, $EB, $8A
	db $EA, $AA, $AA, $FA, $AE, $BA, $AB, $AA
	db $EA, $AE, $BE, $AB, $AA, $AE, $AA, $AE
	db $BB, $BA, $AE, $EB, $EB, $AE, $AE, $AF
	db $AA, $AA, $AA, $F2, $AA, $AA, $EB, $EA
	db $AA, $AA, $AA, $BF, $AA, $AA, $8E, $AE
	db $EA, $FE, $AA, $AA, $BA, $AE, $AA, $AA
	db $AE, $EA, $AA, $EE, $AE, $AA, $AA, $BA
	db $AA, $B8, $AB, $AE, $AA, $6A, $AA, $E8
	db $AA, $EA, $EA, $EB, $EE, $28, $EA, $BC
	db $AB, $BA, $AE, $AA, $AA, $FE, $AA, $AA
	db $BB, $AA, $EA, $AA, $AB, $AB, $BE, $BB
	db $EB, $AE, $BA, $AE, $EA, $AA, $AA, $AA
	db $CA, $BF, $AA, $AF, $AE, $BA, $AA, $AB
	db $AE, $AA, $EA, $AA, $AA, $AE, $AA, $AA
	db $AB, $AE, $EE, $AE, $AB, $AE, $BA, $AA
	endc
endc



SECTION "Home Overdump", ROM0

if DEF(_DEBUG)

DEF Old_FarCallFunctionAddress EQU $2f91

Overdump_Corrupt__InterlaceMergeSpriteBuffers.interlaceLoopFlipped:
	xor a
	dec a
	ldh [hConnectionStripLength], a
	jr nz, @ - 25 ; Unknown function
	ret

Overdump_Corrupt_GetPartyParamLocation_Old:
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

Overdump_Corrupt_DoItemEffect_Old:
	ld a, BANK(_DoItemEffect)
	ld hl, $67C4 ; Early location for _DoItemEffect
	jp Old_FarCallFunctionAddress

Overdump_Corrupt_CheckTossableItem_Old:
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

Overdump_Corrupt_GetBattleAnimPointer_Old:
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

Overdump_Corrupt_GetBattleAnimByte_Old:
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

Overdump_Corrupt_InitSpriteAnimStruct_Old:
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

Overdump_Corrupt_ReinitSpriteAnimFrame_Old: ; stubbed
	ret

Overdump_Corrupt_DisableAudio_Old:
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

Overdump_Corrupt_LoadMusicByte_Old:
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	ld a, [de]
	push af
	ld a, BANK(_UpdateSound)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	ret

Overdump_Corrupt_PlayMusic_Old:
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

Overdump_Corrupt_PlayCryHeader_Old:
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

Overdump_Corrupt_WaitPlaySFX_Old:
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

Overdump_Corrupt_MaxVolume_Old:
	ld a, $77
	ld [wVolume], a
	ret

Overdump_Corrupt_LowVolume_Old:
	ld a, $33
	ld [wVolume], a
	ret

Overdump_Corrupt_UpdateSoundNTimes_Old:
.loop
	and a
	ret z
	dec a
	call Unused_UpdateSound_Old
	jr .loop

Overdump_Corrupt_FadeToMapMusic_Old:
	push hl
	push de
	push bc
	push af
; The check appears to be backwards: the carry flag is set if the player is on a vehicle, and unset otherwise.
; If the player is on no vehicle, then it would've used the last value of 'de' as the music id, potentially playing a overdump track.
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
Overdump_Corrupt_PlayMapMusic_Old:
	push hl
	push de
	push bc
	push af
	ld de, MUSIC_NONE
	call Overdump_Corrupt_PlayMusic_Old
	call DelayFrame
	call Unused_SpecialMapMusic_Old
	jr c, .play_music

; _DisableAudio is in a mapper bank, but the bank is not switched in this function.
; Either this function was supposed to be called when in the same bank,
; or this is an oversight, and they meant to call DisableAudio instead (note the lack of underscore).
	call _DisableAudio
.play_music
	call Overdump_Corrupt_PlayMusic_Old
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
Overdump_Corrupt_PlayMapMusic::
	dw $0317
	pop de
	ld a, e
	ld [wMapMusic], a
	call @ - $F6
.jump
	pop af
	pop bc
	pop de
	pop hl
	ret

Overdump_Corrupt_SpecialMapMusic::
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

Overdump_Corrupt_GetMapMusic::
	call Overdump_Corrupt_SpecialMapMusic
	ret c
	ld a, [wMapPermissions]
	cp TOWN
	jr z, .not_route
	cp INDOOR
	jr z, .not_route
	ld de, MUSIC_ROUTE_1
	ret

.not_route
	ld de, MUSIC_VIRIDIAN_CITY
	ret
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

if DEF(_GOLD)
Overdump_Corrupt_AlreadyKnowsMoveText1:
	db "います"
	prompt

Overdump_Corrupt_AlreadyKnowsMoveText2:
	dw wStringBuffer2 ; This is missing the preceeding "text_from_ram" byte
	text "を　おぼえています"
	prompt

	db $28, $3c ; overdump
endc
if DEF(_SILVER)
Overdump_Corrupt_AlreadyKnowsMoveText1:
	db "ぼえています"
	prompt

Overdump_Corrupt_AlreadyKnowsMoveText2:
	db "を　おぼえています"
	prompt

	db $de, $3b ; overdump
endc

Overdump_Corrupt_KnowsMove:
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
Overdump_UnusedLeaderNameGFX:: INCBIN "gfx/trainer_card/unused_leader_name.2bpp"
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
	db -1 ; end

	; early version of KIMONO_GIRL_KOUME?
	db "こうめ@", TRAINERTYPE_ITEM_MOVES
	db  8, DEX_CLEFAIRY, ITEM_NONE
	db -1 ; end
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

if DEF(_DEBUG)

if DEF(_GOLD)
Overdump_Corrupt_LeafyEvosAttacks1:
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
Overdump_Corrupt_LeafyEvosAttacks2:
	db MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
endc

if DEF(_SILVER)
Overdump_Corrupt_LeafyEvosAttacks1:
	db MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
Overdump_Corrupt_LeafyEvosAttacks2:
	db MOVE_ABSORB
	db 35, MOVE_RAZOR_LEAF
	db 42, MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
Overdump_Corrupt_TailEvosAttacks:
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
Overdump_Corrupt_LeafyEvosAttacks3:
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
Overdump_Corrupt_LeafyEvosAttacks4:
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
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
	Overdump_Corrupt_LeafyEvosAttacks1:
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
	Overdump_Corrupt_TailEvosAttacks:
	db  5, MOVE_LEER
	db  9, MOVE_SAND_ATTACK
	db 14, MOVE_PURSUIT
	db 19, MOVE_ENCORE
	db 25, MOVE_SWIFT
	db 31, MOVE_MUD_SLAP
	db 38, MOVE_FURY_SWIPES
	db 45, MOVE_MIMIC
	db 0 ; no more level-up moves
	Overdump_Corrupt_LeafyEvosAttacks2:
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
	Overdump_Corrupt_LeafyEvosAttacks3:
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
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
	ret
Overdump_Corrupt_SilentHillLabBackUnused_ScriptLoader:
	if DEF(_GOLD)
		db $20
		call WriteBackMapScriptNumber + Bank34NonDebugOffset
	endc
	ret
Overdump_Corrupt_SilentHillLabBackUnusedScriptPointers:
	dw Overdump_Corrupt_SilentHillLabBackUnusedScript
	dw Overdump_Corrupt_SilentHillLabBackUnusedNPCIDs

Overdump_Corrupt_SilentHillLabBackUnusedNPCIDs:
	db $FF

Overdump_Corrupt_SilentHillLabBackUnusedSignPointers:
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

Overdump_Corrupt_SilentHillLabBackUnused_TextPointers::
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

Overdump_Corrupt_SilentHillLabBackUnusedScript:
	ld hl, Overdump_Corrupt_SilentHillLabBackUnusedNPCIDs
	ld de, Overdump_Corrupt_SilentHillLabBackUnusedSignPointers
	call CallMapTextSubroutine + Bank34NonDebugOffset - Bank34CorruptOffset
	ret
	if DEF(_GOLD)
	Overdump_Corrupt_Gold_SilentHillLabBackTextString11:
		db "ぜ　<PLAYER>！"
		line "さきに　えらんで！"
		cont "おれは　こころが　ひろいからな"
		done

	Overdump_Corrupt_Gold_SilentHillLabBackTextString12:
		text "<RIVAL>『じゃ　おれは　これ！"
		done

	Overdump_Corrupt_Gold_SilentHillLabBackTextString13:
		text "<RIVAL>は　オーキドから"
		line "@"
		text_from_ram wStringBuffer1
		text "を　もらった！"
		done

	Overdump_Corrupt_Gold_SilentHillLabBackTextString14:
		text "<RIVAL>『<PLAYER>の#"
		line "いいなあ！"
		cont "でも　おれのポケモンも"
		cont "ちょっと　いいだろ？"
		done

	Overdump_Corrupt_Gold_SilentHillLabBackFunc4:
		CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
		jr nz, .bigjump
		ldh a, [hLastTalked]
		sub 2
		ld [wChosenStarter], a
		ld d, 0
		ld e, a
		ld hl, Overdump_Corrupt_Gold_SilentHillLabBackStarterData
		add hl, de
		add hl, de
		add hl, de
		add hl, de
		ld a, [hli]
		ld [wPlayerStarter], a
		push hl
		ld [wNamedObjectIndexBuffer], a
		ld a, $03
		ld hl, StarterDex + Bank34StarterDexOffset
		call FarCall_hl + Bank34NonDebugOffset - Bank34CorruptOffset
		ld a, [wPlayerStarter]
		ld [wNamedObjectIndexBuffer], a
		call GetPokemonName + Bank34NonDebugOffset - Bank34CorruptOffset
		pop hl
		push hl
		ld a, [hli]
		ld h, [hl]
		ld l, a
		call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
		pop hl
		inc hl
		inc hl
		ld a, [hl]
		ld [wRivalStarter], a
		ret
	.bigjump
		ld hl, Overdump_Corrupt_Gold_SilentHillLabBackTextString15
		call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
		ret
	Overdump_Corrupt_Gold_SilentHillLabBackStarterData:
		db DEX_HONOGUMA
		dw @ - $229
		db DEX_KURUSU

		db DEX_KURUSU
		dw @ - $203
		db DEX_HAPPA

		db DEX_HAPPA
		dw @ - $1de
		db DEX_HONOGUMA

	Overdump_Corrupt_Gold_SilentHillLabBackTextString15:
		text "オーキド『これ！"
		line "よくばっちゃ　いかん！"
		done

	Overdump_Corrupt_Gold_SilentHillLabBackTextPointers2:
		dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset
		dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset
		dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset
		dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset
		dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

		map_attributes Overdump_Corrupt_Gold_SilentHillLabBackUnused, SILENT_HILL_LAB_BACK_UNUSED

	Overdump_Corrupt_Gold_SilentHillLabBackUnused_MapEvents::

	Overdump_Corrupt_Gold_SilentHillLabBackUnused_Blocks::
	INCBIN "maps/SilentHillLabBackUnused.blk"

	Overdump_Corrupt_Gold_SilentHillLabBackUnused_ScriptLoader::
		ld hl, Overdump_Corrupt_Gold_SilentHillLabBackUnusedScriptPointers
		call RunMapScript + Bank34NonDebugOffset
		call WriteBackMapScriptNumber + Bank34NonDebugOffset
		ret

	Overdump_Corrupt_Gold_SilentHillLabBackUnusedScriptPointers:
		dw Overdump_Corrupt_Gold_SilentHillLabBackUnusedScript
		dw Overdump_Corrupt_Gold_SilentHillLabBackUnusedNPCIDs

	Overdump_Corrupt_Gold_SilentHillLabBackUnusedNPCIDs:
		db $FF

	Overdump_Corrupt_Gold_SilentHillLabBackUnusedSignPointers:
		dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

	Overdump_Corrupt_Gold_SilentHillLabBackUnused_TextPointers::
		dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

	Overdump_Corrupt_Gold_SilentHillLabBackUnusedScript:
		ld hl, Overdump_Corrupt_Gold_SilentHillLabBackUnusedNPCIDs
		ld de, Overdump_Corrupt_Gold_SilentHillLabBackUnusedSignPointers
		call CallMapTextSubroutine + Bank34NonDebugOffset - Bank34CorruptOffset
		ret
	else
		call CallMapTextSubroutine + Bank34NonDebugOffset - Bank34CorruptOffset
		ret
	Overdump_Corrupt_Silver_SilentHillLabBackTextString6:
		db "おお！　くさのポケモン"
		line "@"
		text_from_ram wStringBuffer1
		text "が　いいんじゃな？@"

		start_asm
		call Overdump_Corrupt_Silver_ConfirmPokemonSelection
		call TextAsmEnd + Bank34NonDebugOffset - Bank34CorruptOffset
		ret

	Overdump_Corrupt_Silver_ConfirmPokemonSelection:
		call YesNoBox
		jr c, .bigJump
		SetEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
		ld a, 1
		ld [wPlayerHouse1FSceneID], a
		ld a, 1
		ld [wPlayerHouse2FSceneID], a
		ld a, 1
		ld [wSilentHillHouseSceneID], a
		ld hl, Overdump_Corrupt_Silver_SilentHillLabBackTextString8
		call PrintText
		ld hl, wJoypadFlags
		set 5, [hl]
		ld a, [wPlayerStarter]
		ld [wCurPartySpecies], a
		ld a, 5
		ld [wCurPartyLevel], a
		ld hl, GivePoke + Bank34StarterDexOffset
		ld a, $03
		call FarCall_hl + Bank34NonDebugOffset - Bank34CorruptOffset
		xor a
		ld [wPartyMon1Item], a
		ld a, 3
		ld [wMapScriptNumber], a
		ret
	.bigJump
		ld hl, Overdump_Corrupt_Silver_SilentHillLabBackTextString7
		call PrintText
		ret

	Overdump_Corrupt_Silver_SilentHillLabBackTextString7:
		text "では"
		line "どれに　するのじゃ？"
		done

	Overdump_Corrupt_Silver_SilentHillLabBackTextString8:
		text "オーキド『この　ポケモンは"
		line "ほんとに　げんきが　いいぞ！"

		para "<PLAYER>は　オーキドはかせから"
		line "@"
		text_from_ram wStringBuffer1
		text "を　もらった！"
		prompt

	Overdump_Corrupt_Silver_SilentHillLabBackTextString9:
		text "オーキド『そうじゃ！"
		line "やせいの　ポケモンが　でて　きても"
		cont "そいつを　たたかわせて　いけば"
		cont "となりまちへ　いける！"
		done

	Overdump_Corrupt_Silver_SilentHillLabBackFunc3:
		CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
		ld hl, Overdump_Corrupt_SilentHillLabBackTextString11
		jr z, .skip
		ld hl, Overdump_Corrupt_SilentHillLabBackTextString14
	.skip
		call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
		ret

	Overdump_Corrupt_Silver_SilentHillLabBackTextString10:
		text "<RIVAL>『あッ！　おれにも！"
		line "じいさん　おれにもくれ"
	endc
Overdump_Corrupt_SilentHillLabBackTextString10:
	db "よう！"
	done

Overdump_Corrupt_SilentHillLabBackTextString11:
	text "<RIVAL>『いいぜ　<PLAYER>！"
	line "さきに　えらんで！"
	cont "おれは　こころが　ひろいからな"
	done

Overdump_Corrupt_SilentHillLabBackTextString12:
	text "<RIVAL>『じゃ　おれは　これ！"
	done

Overdump_Corrupt_SilentHillLabBackTextString13:
	text "<RIVAL>は　オーキドから"
	line "@"
	text_from_ram wStringBuffer1
	text "を　もらった！"
	done

Overdump_Corrupt_SilentHillLabBackTextString14:
	text "<RIVAL>『<PLAYER>の#"
	line "いいなあ！"
	cont "でも　おれのポケモンも"
	cont "ちょっと　いいだろ？"
	done

Overdump_Corrupt_SilentHillLabBackFunc4:
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	jr nz, .bigjump
	ldh a, [hLastTalked]
	sub 2
	ld [wChosenStarter], a
	ld d, 0
	ld e, a
	ld hl, Overdump_Corrupt_SilentHillLabBackStarterData
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wPlayerStarter], a
	push hl
	ld [wNamedObjectIndexBuffer], a
	ld a, $03
	ld hl, StarterDex + Bank34StarterDexOffset
	call FarCall_hl + Bank34NonDebugOffset - Bank34CorruptOffset
	ld a, [wPlayerStarter]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName + Bank34NonDebugOffset - Bank34CorruptOffset
	pop hl
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	pop hl
	inc hl
	inc hl
	ld a, [hl]
	ld [wRivalStarter], a
	ret
.bigjump
	ld hl, Overdump_Corrupt_SilentHillLabBackTextString15
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	ret
Overdump_Corrupt_SilentHillLabBackStarterData:
	db DEX_HONOGUMA
	dw @ - $229
	db DEX_KURUSU

	db DEX_KURUSU
	dw @ - $203
	db DEX_HAPPA

	db DEX_HAPPA
	dw @ - $1de
	db DEX_HONOGUMA

Overdump_Corrupt_SilentHillLabBackTextString15:
	text "オーキド『これ！"
	line "よくばっちゃ　いかん！"
	done

Overdump_Corrupt_SilentHillLabBackTextPointers2:
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset - Bank34OldOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset - Bank34OldOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset - Bank34OldOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset - Bank34OldOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

	map_attributes Overdump_Corrupt2_SilentHillLabBackUnused, SILENT_HILL_LAB_BACK_UNUSED

Overdump_Corrupt2_SilentHillLabBackUnused_MapEvents::

Overdump_Corrupt2_SilentHillLabBackUnused_Blocks::
INCBIN "maps/SilentHillLabBackUnused.blk"

Overdump_Corrupt2_SilentHillLabBackUnused_ScriptLoader::
	ld hl, Overdump_Corrupt2_SilentHillLabBackUnusedScriptPointers
	call RunMapScript + Bank34NonDebugOffset
	call WriteBackMapScriptNumber + Bank34NonDebugOffset
	ret

	map_generic_scriptpointers

Overdump_Corrupt2_SilentHillLabBackUnusedNPCIDs:
	db $FF

Overdump_Corrupt2_SilentHillLabBackUnusedSignPointers:
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

Overdump_Corrupt2_SilentHillLabBackUnused_TextPointers::
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

Overdump_Corrupt2_SilentHillLabBackUnusedScript:
	ld hl, Overdump_Corrupt2_SilentHillLabBackUnusedNPCIDs
	ld de, Overdump_Corrupt2_SilentHillLabBackUnusedSignPointers
	call CallMapTextSubroutine + Bank34NonDebugOffset - Bank34CorruptOffset
	ret

Overdump_Corrupt2_SilentHillLabBackFunc4:
	dw wPlayerStarter
	push hl
	ld [wNamedObjectIndexBuffer], a
	ld a, $03
	ld hl, StarterDex + Bank34StarterDexOffset + $38
	call FarCall_hl + Bank34NonDebugOffset - Bank34CorruptOffset
	ld a, [wPlayerStarter]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName + Bank34NonDebugOffset - Bank34CorruptOffset
	pop hl
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	pop hl
	inc hl
	inc hl
	ld a, [hl]
	ld [wRivalStarter], a
	ret
.bigjump
	ld hl, Overdump_Corrupt2_SilentHillLabBackTextString15
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	ret
Overdump_Corrupt2_SilentHillLabBackStarterData:
	db DEX_HONOGUMA
	dw @ - $229
	db DEX_KURUSU

	db DEX_KURUSU
	dw @ - $203
	db DEX_HAPPA

	db DEX_HAPPA
	dw @ - $1de
	db DEX_HONOGUMA

Overdump_Corrupt2_SilentHillLabBackTextString15:
	text "オーキド『これ！"
	line "よくばっちゃ　いかん！"
	done

Overdump_Corrupt2_SilentHillLabBackTextPointers2:
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

	map_attributes Overdump_Corrupt3_SilentHillLabBackUnused, SILENT_HILL_LAB_BACK_UNUSED

Overdump_Corrupt3_SilentHillLabBackUnused_MapEvents::

Overdump_Corrupt3_SilentHillLabBackUnused_Blocks::
INCBIN "maps/SilentHillLabBackUnused.blk"

Overdump_Corrupt3_SilentHillLabBackUnused_ScriptLoader::
	ld hl, Overdump_Corrupt3_SilentHillLabBackUnusedScriptPointers
	call RunMapScript + Bank34NonDebugOffset
	call WriteBackMapScriptNumber + Bank34NonDebugOffset
	ret

	map_generic_scriptpointers

Overdump_Corrupt3_SilentHillLabBackUnusedNPCIDs:
	db $FF

Overdump_Corrupt3_SilentHillLabBackUnusedSignPointers:
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

Overdump_Corrupt3_SilentHillLabBackUnused_TextPointers::
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

Overdump_Corrupt3_SilentHillLabBackUnusedScript:
	ld hl, Overdump_Corrupt3_SilentHillLabBackUnusedNPCIDs
	ld de, Overdump_Corrupt3_SilentHillLabBackUnusedSignPointers
	call CallMapTextSubroutine + Bank34NonDebugOffset - Bank34CorruptOffset
	ret

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
