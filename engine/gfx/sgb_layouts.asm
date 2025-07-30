INCLUDE "constants.asm"

SECTION "engine/gfx/sgb_layouts.asm", ROMX

LoadSGBLayout:
	ld a, b
	cp SGB_RAM
	jr nz, .not_ram
	ld a, [wccd0]
.not_ram
	cp SGB_PARTY_MENU_HP_PALS
	jp z, SGB_ApplyPartyMenuHPPals
	ld l, a
	ld h, 0
	add hl, hl
	ld de, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, _LoadSGBLayout_ReturnFromJumpTable
	push de
	jp hl

.Jumptable:
	dw SGB_BattleGrayscale
	dw SGB_BattleColors
	dw SGB_TownMap
	dw SGB_StatsScreenHPPals
	dw SGB_Pokedex
	dw SGB_SlotMachine
	dw SGB_TitleScreen
	dw SGB_GSIntro
	dw SGB_Diploma
	dw SGB_MapPals
	dw SGB_PartyMenu
	dw SGB_Evolution
	dw SGB_GFIntro
	dw SGB_TrainerCard
	dw SGB_MoveList
	dw SGB_PikachuMinigame
	dw SGB_Pokedex_WaitBGMap
	dw SGB_Poker
	dw SGB12
	dw SGB_TrainerGear
	dw SGB_TrainerGearMap
	dw SGB_TrainerGearRadio

SGB_BattleGrayscale:
	ld hl, PalPacket_BattleGrayscale
	ld de, BlkPacket_Battle
	ret

SGB_BattleColors:
	ld hl, PalPacket_995c
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes

	ld a, [wPlayerSubStatus5]
	ld hl, wBattleMon
	call Function9567
	jr c, .sub_92f7

	ld e, $00
	call Function9599
.sub_92f7
	ld b, a
	ld a, [wEnemySubStatus5]
	ld hl, wTempEnemyMonSpecies
	call Function9567
	jr c, .sub_9308
	ld e, $01
	call Function9599
.sub_9308
	ld c, a
	ld hl, wcce2
	ld a, [wPlayerHPPal]
	add $23
	ld [hli], a
	inc hl
	ld a, [wEnemyHPPal]
	add $23
	ld [hli], a
	inc hl
	ld a, b
	ld [hli], a
	inc hl
	ld a, c
	ld [hl], a
	ld hl, wcce1
	ld de, BlkPacket_Battle
	ld a, $01
	ld [wccd0], a
	ret

SGB_MoveList:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, wcce2
	ld [hl], $10
	inc hl
	inc hl
	ld a, [wPlayerHPPal]
	add $23
	ld [hl], a
	ld hl, wcce1
	ld de, BlkPacket_MoveList
	ret

SGB_TownMap:
	ld hl, PalPacket_TownMap
	ld de, BlkPacket_986c
	ret

SGB_StatsScreenHPPals:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, [wCurPartySpecies]
	call Function956d
	call Function957e
	push af
	ld hl, wcce2
	ld a, [wCurHPPal]
	add $23
	ld [hli], a
	inc hl
	pop af
	ld [hl], a
	ld hl, wcce1
	ld de, BlkPacket_StatsScreen
	ret

SGB_PartyMenu:
	ld hl, PalPacket_PartyMenu
	ld de, wcce2
	ret

SGB_Pokedex:
	ld hl, PalPacket_Pokedex
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, [wCurPartySpecies]
	call Function956d
	ld hl, wcce4
	ld [hl], a
	ld hl, wcce1
	ld de, BlkPacket_Pokedex
	ret

SGB_Pokedex_WaitBGMap:
	ld hl, PalPacket_GSIntroCharizard
	ld de, BlkPacket_986c
	ret

SGB_SlotMachine:
	ld hl, PalPacket_SlotMachine
	ld de, BlkPacket_SlotMachine
	ret

SGB_TitleScreen:
	ld hl, PalPacket_TitleScreen
	ld de, BlkPacket_TitleScreen
	ret

SGB_Diploma:
	ld hl, PalPacket_9a3c
	ld de, BlkPacket_986c
	ret

SGB_GSIntro:
	ld b, 0
	ld hl, .BlkPacketTable
rept 4
	add hl, bc
endr
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.BlkPacketTable:
	dw BlkPacket_986c, PalPacket_GSIntroShellderLapras
	dw BlkPacket_GSIntroJigglypuffPikachu, PalPacket_GSIntroJigglypuffPikachu
	dw BlkPacket_986c, PalPacket_GSIntroBlastoise

SGB_GFIntro:
	ld hl, PalPacket_GFIntro
	ld de, BlkPacket_986c
	ld a, $08
	ld [wccd0], a
	ret

SGB_PikachuMinigame:
	ld hl, PalPacket_PikachuMinigame
	ld de, BlkPacket_986c
	ret

SGB_Poker:
	ld hl, BlkPacket_986c
	ld de, wc51a
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, PalPacket_Poker
	ld de, BlkPacket_986c
	ret

SGB_MapPals:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	call GetMapPalsIndex
	ld hl, wcce2
	ld [hld], a
	ld de, BlkPacket_986c
	ld a, $09
	ld [wccd0], a
	ret

SGB_Evolution:
	push bc
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop bc
	ld a, c
	and a
	ld a, $0e
	jr nz, .sub_9437
	ld a, [wPlayerHPPal]
	call Function956d
	call Function957e
.sub_9437
	ld [wcce2], a
	ld hl, wcce1
	ld de, BlkPacket_986c
	ret

SGB_TrainerCard:
	ld hl, PalPacket_9a3c
	ld de, BlkPacket_986c
	ret

SGB12:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, BlkPacket_986c
	ld de, wccf1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	call GetMapPalsIndex
	ld hl, wcce2
	ld [hl], a
	ld a, [wCurPartySpecies]
	call Function956d
	ld hl, wcce4
	ld [hl], a
	ld hl, wccf4
	ld a, $05
	ld [hli], a
	ld a, [wMenuBorderLeftCoord]
	ld [hli], a
	ld a, [wMenuBorderTopCoord]
	ld [hli], a
	ld a, [wMenuBorderRightCoord]
	ld [hli], a
	ld a, [wMenuBorderBottomCoord]
	ld [hl], a
	ld hl, wcce1
	ld de, wccf1
	ret

SGB_TrainerGear:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wcce2], a
	ld a, $30
	ld [wcce4], a
	ld hl, wcce1
	ld de, BlkPacket_TrainerGear
	ret

SGB_TrainerGearMap:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wcce2], a
	ld a, $26
	ld [wcce4], a
	ld hl, wcce1
	ld de, BlkPacket_TrainerGear
	ret

SGB_TrainerGearRadio:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wcce2], a
	ld a, $39
	ld [wcce4], a
	ld hl, wcce1
	ld de, BlkPacket_TrainerGear
	ret

GetMapPalsIndex:
	ld a, [wMapPermissions]
	cp ROUTE
	jr z, .is_route
	cp CAVE
	jr z, .is_cave
	cp GATE
	jr z, .is_gate
	cp ENVIRONMENT_5
	jr z, .env5
	cp INDOOR
	jr z, .indoors
	call Function9527
	jr c, .sub_9524
	call Function9543
	ret

.indoors
	call Function9536
	jr c, .sub_9524
	call Function9543
	ret

.is_route
	call Function9527
	jr c, .sub_9524
	ld a, $00
	ret

.is_cave
	call Function9527
	jr c, .sub_9524
	ld a, $0c
	ret

.is_gate
	ld a, $03
	ret

.env5
	ld a, $04
	ret

.sub_9524
	ld a, $0d
	ret

Function9527:
	ld a, [wTimeOfDay]
	and $03
	jr z, .sub_9534
	cp $03
	jr z, .sub_9534
	scf
	ret
.sub_9534
	and a
	ret

Function9536:
	ld a, [wTimeOfDay]
	and $03
	cp $02
	jr nz, .sub_9541
	scf
	ret
.sub_9541
	and a
	ret

Function9543:
	ld a, [wMapGroup]
	ld e, a
	ld d, $00
	ld hl, Data954f
	add hl, de
	ld a, [hl]
	ret

Data954f:
	db $01, $07, $0c, $03, $08, $06, $0b, $04
	db $05, $0a, $02, $03, $02, $02, $09, $01

_LoadSGBLayout_ReturnFromJumpTable:
	push de
	call PushSGBPals
	pop hl
	jp PushSGBPals

Function9567:
	bit 3, a
	ld a, $18
	ret nz
	ld a, [hl]

Function956d:
	and a
	jr z, .sub_957a
	ld e, a
	ld d, $00
	ld hl, PokemonPalettes
	add hl, de
	ld a, [hl]
	and a
	ret
.sub_957a
	ld a, $0f
	scf
	ret

Function957e:
	push bc
	push af
	ld hl, wPartyMon1DVs
	ld a, [wCurPartyMon]
	ld bc, $0030
	call AddNTimes
	call CheckShininess
	ld b, $00
	jr nc, .sub_9595
	ld b, $0a
.sub_9595
	pop af
	add b
	pop bc
	ret

Function9599:
	push bc
	push af
	ld a, e
	and a
	ld a, [wMonSGBPaletteFlagsBuffer]
	jr z, .sub_95a4
	srl a
.sub_95a4
	srl a
	ld b, $00
	jr nc, .sub_95ac
	ld b, $0a
.sub_95ac
	pop af
	add b
	pop bc
	ret

; Check if a mon is shiny by DVs at hl.
; Only used in vanilla for setting palettes.
CheckShininess:
	; Attack DV
	ld a, [hl]
	cp $a0
	jr c, .not_shiny

	; Defense DV
	ld a, [hli]
	and $0f
	cp $0a
	jr c, .not_shiny

	; Speed DV
	ld a, [hl]
	cp $a0
	jr c, .not_shiny

	; Special DV
	ld a, [hl]
	and $0f
	cp $0a
	jr c, .not_shiny
	scf
	ret
.not_shiny
	and a
	ret

; TODO: Come up with a better name for this.
GetMonSGBPaletteFlags:
	ld hl, wEnemyMonDVs
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_turn
	ld hl, wBattleMonDVs
.enemy_turn
	call CheckShininess
	ld hl, wMonSGBPaletteFlagsBuffer
	jr nc, .not_shiny

	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_shiny

	set 0, [hl]
	jr .return
.enemy_shiny
	set 1, [hl]
	jr .return

.not_shiny
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_not_shiny

	res 0, [hl]
	jr .return

.enemy_not_shiny
	res 1, [hl]
.return
	ret

InitPartyMenuPalettes:
	ld hl, BlkPacket_PartyMenu
	ld de, wcce2
	ld bc, $0030
	jp CopyBytes

SGB_ApplyPartyMenuHPPals:
	ld hl, wHPPals
	ld a, [wcce1]
	ld e, a
	ld d, $00
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	and a
	ld e, $05
	jr z, .sub_961d
	dec a
	ld e, $0a
	jr z, .sub_961d
	ld e, $0f
.sub_961d
	push de
	ld hl, wcceb
	ld bc, $0006
	ld a, [wcce1]
	call AddNTimes
	pop de
	ld [hl], e
	ret

LoadMagikarpPalettes_Intro:
	ld hl, PalPacket_MagikarpIntro
	jp PushSGBPals

LoadForestPalettes2_Intro:
	ld hl, BlkPacket_986c
	jp PushSGBPals

LoadVenusaurPalettes_Intro:
	ld hl, PalPacket_GSIntroVenusaur
	jp PushSGBPals

LoadCharizardPalettes_Intro:
	ld hl, PalPacket_GSIntroCharizard
	jp PushSGBPals

Function9645:
	ld hl, wc51a
	jp PushSGBPals

PushSGBPals:
	ld a, [wJoypadFlags]
	push af
	set 7, a
	ld [wJoypadFlags], a
	call _PushSGBPals
	pop af
	ld [wJoypadFlags], a
	ret

_PushSGBPals:
	ld a, [hl]
	and $7
	ret z
	ld b, a
.loop
	push bc
	xor a
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	ld b, $10
.loop2
	ld e, $08
	ld a, [hli]
	ld d, a
.loop3
	bit 0, d
	ld a, $10
	jr nz, .ok
	ld a, $20
.ok
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	rr d
	dec e
	jr nz, .loop3
	dec b
	jr nz, .loop2
	ld a, $20
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	call SGBDelayCycles
	pop bc
	dec b
	jr nz, .loop
	ret

CheckSGB:
	ld a, [wJoypadFlags]
	push af
	set 7, a
	ld [wJoypadFlags], a

	xor a
	ldh [rJOYP], a
	ld [wSGB], a
	call PushSGBBorderPalsAndWait
	jr nc, .skip
	ld a, 1
	ld [wSGB], a
	call _InitSGBBorderPals
	call PushSGBBorder
	call SGBBorder_PushBGPals
	call SGB_ClearVRAM
	ld hl, MaskEnCancelPacket
	call _PushSGBPals
.skip
	pop af
	ld [wJoypadFlags], a
	ret

_InitSGBBorderPals:
	ld hl, .PacketPointerTable
	ld c, 9

.loop
	push bc
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call _PushSGBPals
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

.PacketPointerTable:
	dw MaskEnFreezePacket
	dw DataSndPacket1
	dw DataSndPacket2
	dw DataSndPacket3
	dw DataSndPacket4
	dw DataSndPacket5
	dw DataSndPacket6
	dw DataSndPacket7
	dw DataSndPacket8

UpdateSGBBorder:
	ld a, [wSGB]
	ret z
	di
	xor a
	ldh [rJOYP], a
	ld hl, MaskEnFreezePacket
	call _PushSGBPals
	call PushSGBBorder
	ld hl, MaskEnCancelPacket
	call _PushSGBPals
	ei
	ret

PushSGBBorder:
	call .LoadSGBBorderPointers
	push de
	call SGBBorder_YetMorePalPushing
	pop hl
	call SGBBorder_MorePalPushing
	ret

.LoadSGBBorderPointers:
	ld a, [wOptions]
	bit SGB_BORDER_F, a
	jr nz, .spaceworld_border

; load alternate border
	ld hl, AlternateSGBBorderGFX
	ld de, AlternateSGBBorderTilemap
	ret

.spaceworld_border
	ld hl, SGBBorderGFX
	ld de, SGBBorderTilemap
	ret

SGB_ClearVRAM:
	ld hl, vChars0
	ld bc, $2000
	xor a
	call ByteFill
	ret

PushSGBBorderPalsAndWait:
	ld hl, MltReq2Packet
	call _PushSGBPals
	call SGBDelayCycles
	ldh a, [rJOYP]
	and $3
	cp $3
	jr nz, .carry
	ld a, $20
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $30
	ldh [rJOYP], a
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $10
	ldh [rJOYP], a
rept 6
	ldh a, [rJOYP]
endr
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $30
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	call SGBDelayCycles
	call SGBDelayCycles
	ldh a, [rJOYP]
	and $3
	cp $3
	jr nz, .carry
	call .FinalPush
	and a
	ret

.carry
	call .FinalPush
	scf
	ret

.FinalPush:
	ld hl, MltReq1Packet
	call _PushSGBPals
	jp SGBDelayCycles

SGBBorder_PushBGPals:
	call DisableLCD
	ld a, %11100100
	ldh [rBGP], a
	ld hl, SuperPalettes
	ld de, vChars1
	ld bc, $1000
	call CopyData
	call DrawDefaultTiles
	ld a, $e3
	ldh [rLCDC], a
	ld hl, PalTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

SGBBorder_MorePalPushing:
	call DisableLCD
	ld a, %11100100
	ldh [rBGP], a
	ld de, vChars1
	ld bc, (6 + SCREEN_WIDTH + 6) * 5 * 2
	call CopyData
	ld b, SCREEN_HEIGHT
.loop
	push bc
	ld bc, 6 * 2
	call CopyData
	ld bc, SCREEN_WIDTH * 2
	call ClearBytes
	ld bc, 6 * 2
	call CopyData
	pop bc
	dec b
	jr nz, .loop
	ld bc, (6 + SCREEN_WIDTH + 6) * 5 * 2
	call CopyData
	ld bc, $100
	call ClearBytes
	ld bc, $80
	call CopyData
	call DrawDefaultTiles
	ld a, $e3
	ldh [rLCDC], a
	ld hl, PctTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

SGBBorder_YetMorePalPushing:
	call DisableLCD
	ld a, $e4
	ldh [rBGP], a
	ld de, vChars1
	ld b, $80
.loop
	push bc
	ld bc, $10
	call CopyData
	ld bc, $10
	call ClearBytes
	pop bc
	dec b
	jr nz, .loop
	call DrawDefaultTiles
	ld a, $e3
	ldh [rLCDC], a
	ld hl, ChrTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

CopyData:
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, CopyData
	ret

ClearBytes:
	xor a
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, ClearBytes
	ret

DrawDefaultTiles:
	hlbgcoord 0, 0
	ld de, BG_MAP_WIDTH - SCREEN_WIDTH
	ld a, $80
	ld c, 12 + 1
.line
	ld b, SCREEN_WIDTH
.tile
	ld [hli], a
	inc a
	dec b
	jr nz, .tile
	add hl, de
	dec c
	jr nz, .line
	ret

SGBDelayCycles:
	ld de, 7000
.wait
	nop
	nop
	nop
	dec de
	ld a, d
	or e
	jr nz, .wait
	ret

INCLUDE "data/sgb/blk_packets.inc"
INCLUDE "data/sgb/pal_packets.inc"
INCLUDE "data/sgb/ctrl_packets.inc"
