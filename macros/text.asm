text   EQUS "db $00,"          ; Start writing text.
next   EQUS "db \"<NEXT>\","   ; Move a line down.
line   EQUS "db \"<LINE>\","   ; Start writing at the bottom line.
para   EQUS "db \"<PARA>\","   ; Start a new paragraph.
cont   EQUS "db \"<CONT>\","   ; Scroll to the next line.
done   EQUS "db \"<DONE>\""    ; End a text box.
prompt EQUS "db \"<PROMPT>\""  ; Prompt the player to end a text box (initiating some other event).

; TextCommands indexes (see home/text.asm)
	const_def 1

	const TX_RAM ; $01
MACRO text_from_ram
	db TX_RAM
	dw \1    ; address
endm

	const TX_BCD ; $02
MACRO text_bcd
	db TX_BCD
	dw \1    ; address
	db \2    ; flags + digits, see PrintBCDNumber
endm

	const TX_MOVE ; $03
MACRO text_move
	db TX_MOVE
	dw \1     ; address
endm

	const TX_BOX ; $04
MACRO text_box
	db TX_BOX
	dw \1     ; address
	db \2, \3 ; width, height
endm

	const TX_LOW ; $05
MACRO text_low
	db TX_LOW
endm

	const WAIT_BUTTON ; $06
MACRO text_waitbutton
	db WAIT_BUTTON
endm

	const TX_SCROLL ; $07
MACRO text_scroll
	db TX_SCROLL
endm

	const START_ASM ; $08
MACRO start_asm
	db START_ASM
endm

	const TX_NUM ; $09
MACRO deciram
	db TX_NUM
	dw \1     ; address
	dn \2, \3 ; bytes, flags + digits
endm

	const TX_EXIT ; $0a
MACRO text_exit
	db TX_EXIT
endm

	const TX_SOUND_0B ; $0b
MACRO sound_dex_fanfare_50_79
	db TX_SOUND_0B
endm

	const TX_DOTS ; $0c
MACRO text_dots
	db TX_DOTS
	db \1
endm

	const TX_LINK_WAIT_BUTTON ; $0d
MACRO link_wait_button
	db TX_LINK_WAIT_BUTTON
endm

	const TX_SOUND_0E ; $0e
MACRO sound_dex_fanfare_20_49
	db TX_SOUND_0E
endm

	const TX_SOUND_0F ; $0f
MACRO sound_item
	db TX_SOUND_0F
endm

	const TX_SOUND_10 ; $10
MACRO sound_caught_mon
	db TX_SOUND_10
endm

	const TX_SOUND_11 ; $11
MACRO sound_dex_fanfare_80_109
	db TX_SOUND_11
endm

	const TX_SOUND_12 ; $12
MACRO sound_fanfare
	db TX_SOUND_12
endm

	const TX_SOUND_13 ; $13
MACRO sound_slot_machine_start
	db TX_SOUND_13
endm

	const TX_CRY_14 ; $14
MACRO cry_nidorina
	db TX_CRY_14
endm

	const TX_CRY_15 ; $15
MACRO cry_pidgeot
	db TX_CRY_15
endm

	const TX_CRY_16 ; $16
MACRO cry_dewgong
	db TX_CRY_16
endm

	const_next $50

	const TX_END ; $50
MACRO text_end
	db TX_END
endm
