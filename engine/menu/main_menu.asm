INCLUDE "constants.asm"

SECTION "Main Menu Definition", ROMX[$5418], BANK[$01]

MainMenuHeader:
	db $40
	db $00, $00, $07, $0d
	dw .data
	db 1 ; default option

.data
	db $80
	db 0 ; number of options

	dw $5461
	db $8a, $1f
	dw MainMenuStrings

MainMenuStrings: ; 01:5428
    db "つづきから　はじめる@"
    db "さいしょから　はじめる@"
    db "せっていを　かえる@"
    db "#を　あそぶ@"
    db "じかんセット@"
; 01:5457
