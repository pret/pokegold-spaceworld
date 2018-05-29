INCLUDE "constants.asm"

SECTION "Main Menu Definition", ROMX[$53cc], BANK[$01]

MainMenu:
	ld hl, $d4a9
	res 0, [hl]
	call $0e2a
	call $363c
	call $0d1a
	call $0d0a
	call $1f9e
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
	call $1d49
	call $1e58
	call $1c4c
	jp c, $5dae
	ld hl, MainMenuJumptable
	ld a, [$cbf5]
	jp $35cd

MainMenuHeader:
	db $40
	menu_coords 0, 0, 14, 7
	dw .MenuData
	db 1 ; default option

.MenuData: ; 01:5420
	db $80
	db 0 ; items
	dw MainMenuItems
	db $8a, $1f
	dw .Strings

.Strings: ; 01:5428
	db "CONTINUE@"
	db "NEW GAME@"
	db "OPTIONS@"
	db "PLAY POKéMON@"
	db "TIME@"
	db "@@@" 

MainMenuJumptable: ; 01:5457
	dw $547c
	dw $555c
	dw $5cf3
	dw $555c
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
