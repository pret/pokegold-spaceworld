LoadSGBLayout:
	ld a, b
	cp SGB_RAM
	jr nz, .not_ram
	ld a, [wSGBPalBuffer]
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
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes

	ld a, [wPlayerSubStatus5]
	ld hl, wBattleMon
	call DeterminePaletteID_0
	jr c, .pass1

	ld e, $00
	call CheckShininessBattle
.pass1
	ld b, a
	ld a, [wEnemySubStatus5]
	ld hl, wTempEnemyMonSpecies
	call DeterminePaletteID_0
	jr c, .pass2
	ld e, $01
	call CheckShininessBattle
.pass2
	ld c, a
	ld hl, wSGBPals + 1
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
	ld hl, wSGBPals
	ld de, BlkPacket_Battle
	ld a, $01
	ld [wSGBPalBuffer], a
	ret

SGB_MoveList:
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, wSGBPals + 1
	ld [hl], $10
	inc hl
	inc hl
	ld a, [wPlayerHPPal]
	add $23
	ld [hl], a
	ld hl, wSGBPals
	ld de, BlkPacket_MoveList
	ret

SGB_TownMap:
	ld hl, PalPacket_TownMap
	ld de, BlkPacket_Default
	ret

SGB_StatsScreenHPPals:
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, [wCurPartySpecies]
	call DeterminePaletteID
	call CheckShininessMenu
	push af
	ld hl, wSGBPals + 1
	ld a, [wCurHPPal]
	add $23
	ld [hli], a
	inc hl
	pop af
	ld [hl], a
	ld hl, wSGBPals
	ld de, BlkPacket_StatsScreen
	ret

SGB_PartyMenu:
	ld hl, PalPacket_PartyMenu
	ld de, wSGBPals + 1
	ret

SGB_Pokedex:
	ld hl, PalPacket_Pokedex
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, [wCurPartySpecies]
	call DeterminePaletteID
	ld hl, wSGBPals + 3
	ld [hl], a
	ld hl, wSGBPals
	ld de, BlkPacket_Pokedex
	ret

SGB_Pokedex_WaitBGMap:
	ld hl, PalPacket_GSIntroCharizard
	ld de, BlkPacket_Default
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
	ld hl, PalPacket_StartMenu
	ld de, BlkPacket_Default
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
	dw BlkPacket_Default, PalPacket_GSIntroShellderLapras
	dw BlkPacket_GSIntroJigglypuffPikachu, PalPacket_GSIntroJigglypuffPikachu
	dw BlkPacket_Default, PalPacket_GSIntroBlastoise

SGB_GFIntro:
	ld hl, PalPacket_GFIntro
	ld de, BlkPacket_Default
	ld a, SGB_DIPLOMA
	ld [wSGBPalBuffer], a
	ret

SGB_PikachuMinigame:
	ld hl, PalPacket_PikachuMinigame
	ld de, BlkPacket_Default
	ret

SGB_Poker:
	ld hl, BlkPacket_Default
	ld de, wPokerWorkEnd
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, PalPacket_Poker
	ld de, BlkPacket_Default
	ret

SGB_MapPals:
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	call GetMapPalsIndex
	ld hl, wSGBPals + 1
	ld [hld], a
	ld de, BlkPacket_Default
	ld a, SGB_MAP_PALS
	ld [wSGBPalBuffer], a
	ret

SGB_Evolution:
	push bc
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop bc
	ld a, c
	and a
	ld a, PAL_BLACK
	jr nz, .ret
	ld a, [wPlayerHPPal]
	call DeterminePaletteID
	call CheckShininessMenu
.ret
	ld [wSGBPals + 1], a
	ld hl, wSGBPals
	ld de, BlkPacket_Default
	ret

SGB_TrainerCard:
	ld hl, PalPacket_StartMenu
	ld de, BlkPacket_Default
	ret

SGB12:
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, BlkPacket_Default
	ld de, wSGBPals + 16
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	call GetMapPalsIndex
	ld hl, wSGBPals + 1
	ld [hl], a
	ld a, [wCurPartySpecies]
	call DeterminePaletteID
	ld hl, wSGBPals + 3
	ld [hl], a
	ld hl, wSGBPals + 19
	ld a, %00000101
	ld [hli], a
	ld a, [wMenuBorderLeftCoord]
	ld [hli], a
	ld a, [wMenuBorderTopCoord]
	ld [hli], a
	ld a, [wMenuBorderRightCoord]
	ld [hli], a
	ld a, [wMenuBorderBottomCoord]
	ld [hl], a
	ld hl, wSGBPals
	ld de, wSGBPals + 16
	ret

SGB_TrainerGear:
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wSGBPals + 1], a
	ld a, $30
	ld [wSGBPals + 3], a
	ld hl, wSGBPals
	ld de, BlkPacket_TrainerGear
	ret

SGB_TrainerGearMap:
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wSGBPals + 1], a
	ld a, $26
	ld [wSGBPals + 3], a
	ld hl, wSGBPals
	ld de, BlkPacket_TrainerGear
	ret

SGB_TrainerGearRadio:
	ld hl, PalPacket_Battle
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wSGBPals + 1], a
	ld a, $39
	ld [wSGBPals + 3], a
	ld hl, wSGBPals
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
	call CheckTimeNotDay
	jr c, .is_night
	call ApplyMapGroupPalette
	ret

.indoors
	call CheckTimeDarkness
	jr c, .is_night
	call ApplyMapGroupPalette
	ret

.is_route
	call CheckTimeNotDay
	jr c, .is_night
	ld a, PAL_ROUTE
	ret

.is_cave
	call CheckTimeNotDay
	jr c, .is_night
	ld a, PAL_TOWN_OLDCITY
	ret

.is_gate
	ld a, PAL_TOWN_WEST
	ret

.env5
	ld a, PAL_TOWN_NEWTYPE
	ret

.is_night
	ld a, PAL_NIGHTTIME
	ret

CheckTimeNotDay:
	ld a, [wTimeOfDay]
	and $03
	jr z, .is_day
	cp MORN_F
	jr z, .is_day
	scf
	ret
.is_day
	and a
	ret

CheckTimeDarkness:
	ld a, [wTimeOfDay]
	and $03
	cp DARKNESS_F
	jr nz, .is_not_darkness
	scf
	ret
.is_not_darkness
	and a
	ret

ApplyMapGroupPalette:
	ld a, [wMapGroup]
	ld e, a
	ld d, $00
	ld hl, MapGroupPalettes ; BUG: MapGroupPalettes overflows if "wMapGroup" reaches "MISC". This only
	add hl, de              ; affects the Power Plant and Office maps which are normally incessible.
	ld a, [hl]
	ret

MapGroupPalettes:
	table_width 1
	db PAL_TOWN_NORTH ; 00
	db PAL_TOWN_SILENTHILL ; Silent Hill
	db PAL_TOWN_OLDCITY ; Old City
	db PAL_TOWN_WEST ; West
	db PAL_TOWN_HIGHTECH ; HighTech
	db PAL_TOWN_FONT ; Font
	db PAL_TOWN_BIRDON ; Birdon
	db PAL_TOWN_NEWTYPE ; Newtype
	db PAL_TOWN_SUGAR ; Sugar
	db PAL_TOWN_BLUE ; Blue
	db PAL_TOWN_STAND ; Stand
	db PAL_TOWN_WEST ; Kanto
	db PAL_TOWN_STAND ; Prince
	db PAL_TOWN_STAND ; Mt.Fuji
	db PAL_TOWN_SOUTH ; South
	db PAL_TOWN_NORTH ; North
	assert_table_length NUM_MAP_GROUPS - 1 ; BUG: MISC and EMPTY are unaccounted for.

_LoadSGBLayout_ReturnFromJumpTable:
	push de
	call PushSGBPals
	pop hl
	jp PushSGBPals

DeterminePaletteID_0:
	bit 3, a
	ld a, PAL_GRAYMON
	ret nz

	ld a, [hl]
DeterminePaletteID:
	and a
	jr z, .trainer
	ld e, a
	ld d, $00
	ld hl, PokemonPalettes
	add hl, de
	ld a, [hl]
	and a
	ret
.trainer
	ld a, PAL_MEWMON
	scf
	ret

CheckShininessMenu:
	push bc
	push af

	ld hl, wPartyMon1DVs
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	call CheckShininess
	ld b, $00
	jr nc, .pass
	ld b, PAL_SHINY_MEWMON - PAL_MEWMON
.pass
	pop af
	add b
	pop bc
	ret

CheckShininessBattle:
	push bc
	push af

	ld a, e
	and a
	ld a, [wMonSGBPaletteFlagsBuffer]
	jr z, .player_mon_is_shiny

	srl a
.player_mon_is_shiny
	srl a

	ld b, $00
	jr nc, .pass
	ld b, PAL_SHINY_MEWMON - PAL_MEWMON
.pass
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
	ld de, wSGBPals + 1
	ld bc, 6 palettes
	jp CopyBytes

SGB_ApplyPartyMenuHPPals:
	ld hl, wHPPals
	ld a, [wSGBPals]
	ld e, a
	ld d, $00
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	and a
	ld e, %00000101
	jr z, .next
	dec a
	ld e, %00001010
	jr z, .next
	ld e, %00001111
.next
	push de
	ld hl, wSGBPals + 10
	ld bc, 6
	ld a, [wSGBPals]
	call AddNTimes
	pop de
	ld [hl], e
	ret

LoadMagikarpPalettes_Intro:
	ld hl, PalPacket_MagikarpIntro
	jp PushSGBPals

LoadForestPalettes2_Intro:
	ld hl, BlkPacket_Default
	jp PushSGBPals

LoadVenusaurPalettes_Intro:
	ld hl, PalPacket_GSIntroVenusaur
	jp PushSGBPals

LoadCharizardPalettes_Intro:
	ld hl, PalPacket_GSIntroCharizard
	jp PushSGBPals

LoadPokerCardPalettes:
	ld hl, wPokerWorkEnd
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
	ld hl, STARTOF(VRAM)
	ld bc, SIZEOF(VRAM)
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
	ld bc, $100 tiles
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

INCLUDE "data/sgb/blk_packets.asm"
INCLUDE "data/sgb/pal_packets.asm"
INCLUDE "data/sgb/ctrl_packets.asm"

INCLUDE "data/pokemon/palettes.asm"
INCLUDE "data/sgb/super_palettes.asm"

if DEF(_GOLD)
AlternateSGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_alt_gold.sgb.tilemap"

AlternateSGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_alt_gold.pal"

AlternateSGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_alt.2bpp"

SGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_gold.sgb.tilemap"

SGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_gold.pal"

SGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_gold.2bpp"
endc

if DEF(_SILVER)
AlternateSGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_alt_silver.sgb.tilemap"

AlternateSGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_alt_silver.pal"

AlternateSGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_alt.2bpp"

SGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_silver.sgb.tilemap"

SGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_silver.pal"

SGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_silver.2bpp"
endc
