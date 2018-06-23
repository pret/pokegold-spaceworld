INCLUDE "constants.asm"

SECTION "Main Menu Definition", ROMX[$53cc], BANK[$01]

MainMenu:
	ld hl, wd4a9
	res 0, [hl]
	call ClearTileMap
	call GetMemSGBLayout
	call LoadFontExtra
	call LoadFont
	call ClearWindowData
	call $5388
	ld hl, $ce60
	bit 0, [hl]
	jr nz, .skip1
	xor a ; new game
	jr .next1
.skip1
	ld a, 1 ; continue
.next1
	ld a, [$ffa3]
	and $83
	cp $83
	jr nz, .skip2
	ld a, 3 ; play pokemon, set time
	jr .next2
.skip2
	ld a, 2 ; play pokemon
.next2
	ld [$cbf7],a
	ld hl, MainMenuHeader
	call LoadMenuHeader
	call OpenMenu
	call CloseWindow
	jp c, $5dae
	ld hl, MainMenuJumptable
	ld a, [$cbf5]
	jp CallJumptable

MainMenuHeader:
	db $40
	menu_coords 0, 0, 13, 7
	dw .MenuData
	db 1 ; default option

.MenuData: ; 01:5420
	db $80
	db 0 ; items
	dw MainMenuItems
	db $8a, $1f
	dw .Strings

.Strings: ; 01:5428
	db "つづきから　はじめる@"
	db "さいしょから　はじめる@"
	db "せっていを　かえる@"
	db "#を　あそぶ@"
	db "じかんセット@"

MainMenuJumptable: ; 01:5457
	dw $547c
	dw NewGame
	dw $5cf3
	dw NewGame
	dw $5473

CONTINUE     EQU 0
NEW_GAME     EQU 1
OPTION       EQU 2
PLAY_POKEMON EQU 3
SET_TIME     EQU 4

MainMenuItems:

NewGameMenu:
	db 2
	db NEW_GAME
	db OPTION
	db -1

ContinueMenu:
	db 3
	db CONTINUE
	db NEW_GAME
	db OPTION
	db -1

PlayPokemonMenu:
	db 2
	db PLAY_POKEMON
	db OPTION
	db -1

PlayPokemonSetTimeMenu:
	db 3
	db PLAY_POKEMON
	db OPTION
	db SET_TIME
	db -1

SECTION "Oak Speech", ROMX[$555c], BANK[$01]

NewGame:
	ld de, 0
	call PlayMusic
	ld de, 3
	call PlayMusic
	call LoadFontExtra
	xor a
	ld [$ffde], a
	ld a, 1
	ld hl, $52f9
	call FarCall_hl
	call ClearTileMap
	call ClearWindowData
	xor a
	ld [$ffe8], a
	ld a, [wce63]
	bit 1, a
	jp z, .OakSpeechPlayPokemon
	call Function5715
	jp .PlayerShrink

.OakSpeechPlayPokemon
	ld de, OakPic
	lb bc, BANK(OakPic), 0
	call $5d27
	call $5cf7
	ld hl, $587b
	call PrintText
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, ProtagonistPic
	lb bc, BANK(ProtagonistPic), 0
	call $5d27
	call $5d0e
	ld a, $d0
	ld [$ff48], a
	call $5849
	jp .PlayerShrink

.OakSpeechNewGame
	ld de, OakPic
	lb bc, BANK(OakPic), 0
	call $5d27
	call $5cf7
	ld hl, $5956
	call PrintText
	call RotateThreePalettesRight
	call ClearTileMap
	ld a, DEX_YADOKING
	ld [$cb5b], a
	ld [$cd78], a
	call GetMonHeader
	ld hl, $c2f6
	ld hl, $c2f6
	call PrepMonFrontpic
	call $5d0e
	ld hl, $599f
	call PrintText
	ld a, DEX_YADOKING
	call PlayCry
	ld hl, $59e8
	call PrintText
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, ProtagonistPic
	lb bc, BANK(ProtagonistPic), 0
	call $5d27
	call $5d0e
	ld hl, $5a35
	call PrintText
	call $5b25 ; naming screen
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, RivalPic
	lb bc, BANK(RivalPic), 0
	call $5d27
	call $5cf7
	ld hl, $5a52
	call PrintText
	call $5ba9 ; naming screen
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, OakPic
	lb bc, BANK(OakPic), 0
	call $5d27
	call $5cf7
	ld hl, $5a8f
	call PrintText
	ld a, $24
	ld hl, $4000
	call FarCall_hl
	call Function04ac
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, ProtagonistPic
	lb bc, BANK(ProtagonistPic), 0
	call $5d27
	call RotateThreePalettesLeft
	ld hl, $5ac2
	call PrintText
	ld a, [$ff98]
	push af
	ld a, $20
	ld [$c1a5], a
	ld de, 0
	ld a, e
	ld [$c1a7], a
	ld a, d
	ld [$c1a8], a
	ld de, $b
	call PlaySFX
	pop af
	call Bankswitch
	ld c, 4
	call DelayFrames
.PlayerShrink
	ld de, $4743
	ld bc, $400
	call $5d27
	ld c, 4
	call DelayFrames
	ld de, $479d
	ld bc, $400
	call $5d27
	ld c, 20
	call DelayFrames
	ld hl, $c30a
	ld b, 7
	ld c, 7
	call ClearBox
	ld c, 20
	call DelayFrames
	call $5d5d
	call LoadFontExtra
	ld c, 50
	call DelayFrames
	call RotateThreePalettesRight
	call ClearTileMap
	call Function0502
	ld a, 0
	ld [$d638], a
	ld [$d637], a
	call Function56e8
	ld hl, wce63
	bit 2, [hl]
	call z, Function15b5
	ld hl, wd4a9
	set 0, [hl]
	jp Function2a85

Function56e8:
	ld a, 4
	ld [$d65e], a
	ld a, $f2
	ld [$ff9a], a
	ld hl, $ce63
	bit 2, [hl]
	ret nz
	ld a, $f1
	ld [$ff9a], a
	ld a, 0
	ld [$cc39], a
	ld hl, .Data
	ld de, $d656
	ld bc, 8
	call CopyBytes
	ret
.Data
	db $01, $09, $33, $c6, $04, $04, $00, $01

Function5715:
