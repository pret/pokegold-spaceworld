INCLUDE "constants.asm"

SECTION "Main Menu Definition", ROMX[$5418], BANK[$01]

MainMenuHeader:
	db $40
	db $00, $00, $07, $0d
	dw .data
	db 1 ; default option

.data ; 01:5420
	db $80
	db 0 ; number of options

	dw $5461 ; MainMenuItems in retail
	db $8a, $1f
	dw MainMenuStrings

MainMenuStrings: ; 01:5428
    db "つづきから　はじめる@"
    db "さいしょから　はじめる@"
    db "せっていを　かえる@"
    db "#を　あそぶ@"
    db "じかんセット@"
; 01:5457

CONTINUE	EQU 0
NEW_GAME	EQU 1
OPTION		EQU 2
PLAY_POKEMON	EQU 3
SET_TIME	EQU 4

MainMenuItems:
	db 2
	db NEW_GAME
	db OPTION
	db -1
	
	db 3
	db CONTINUE
	db NEW_GAME
	db OPTION
	db -1
	
	db 2
	db PLAY_POKEMON
	db OPTION
	db -1
	
	db 3
	db PLAY_POKEMON
	db OPTION
	db SET_TIME
	db -1
