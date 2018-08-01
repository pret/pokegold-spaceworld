text   EQUS "db $00,"          ; Start writing text.
next   EQUS "db \"<NEXT>\","   ; Move a line down.
line   EQUS "db \"<LINE>\","   ; Start writing at the bottom line.
para   EQUS "db \"<PARA>\","   ; Start a new paragraph.
cont   EQUS "db \"<CONT>\","   ; Scroll to the next line.
done   EQUS "db \"<DONE>\""    ; End a text box.
prompt EQUS "db \"<PROMPT>\""  ; Prompt the player to end a text box (initiating some other event).
text_end EQUS "db $50"         ; End control code for text processor
                               ; different from @

; TODO: determine if these are in
; Pokedex text commands are only used with pokered.
; They are included for compatibility.
page   EQUS "db $50,"     ; Start a new Pokedex page.
dex    EQUS "db $e8, $50" ; End a Pokedex entry.

	enum_start 1
	enum TX_RAM ; $01
text_from_ram: MACRO
	db TX_RAM
	dw \1    ; address
	ENDM

	enum TX_BCD ; $02
text_bcd: macro
	db TX_BCD
	dw \1    ; address
	db \2    ; flags + digits, see PrintBCDNumber
	ENDM

	enum TX_MOVE ; $03
text_move: macro
	db TX_MOVE
	dw \1     ; address
	ENDM

	enum TX_BOX ; $04
text_box: macro
	db TX_BOX
	dw \1     ; address
	db \2, \3 ; width, height
	ENDM

	enum TX_LOW ; $05
text_low: macro
	db TX_LOW
	endm

	enum WAIT_BUTTON ; $06
text_waitbutton: macro
	db WAIT_BUTTON
	endm

	enum TX_SCROLL ; $07
text_scroll: macro
	db TX_SCROLL
	endm

	enum START_ASM ; $08
start_asm: macro
	db START_ASM
	endm

	enum TX_NUM ; $09
deciram: macro
	db TX_NUM
	dw \1     ; address
	dn \2, \3 ; bytes, flags + digits
	endm

	enum TX_EXIT ; $0a
text_exit: macro
	db TX_EXIT
	endm

	enum TX_SOUND_0B ; $0b
sound_dex_fanfare_50_79: macro
	db TX_SOUND_0B
	endm

	enum TX_DOTS ; $0c
text_dots: macro
	db TX_DOTS
	db \1
	endm

	enum TX_LINK_WAIT_BUTTON ; $0d
link_wait_button: macro
	db TX_LINK_WAIT_BUTTON
	endm

	enum TX_SOUND_0E ; $0e
sound_dex_fanfare_20_49: macro
	db TX_SOUND_0E
	endm

	enum TX_SOUND_0F ; $0f
sound_item: macro
	db TX_SOUND_0F
	endm

	enum TX_SOUND_10 ; $10
sound_caught_mon: macro
	db TX_SOUND_10
	endm

	enum TX_SOUND_11 ; $11
sound_dex_fanfare_80_109: macro
	db TX_SOUND_11
	endm

	enum TX_SOUND_12 ; $12
sound_fanfare: macro
	db TX_SOUND_12
	endm

	enum TX_SOUND_13 ; $13
sound_slot_machine_start: macro
	db TX_SOUND_13
	endm

	enum TX_CRY_14 ; $14
cry_nidorina: macro
	db TX_CRY_14
	endm
	
	enum TX_CRY_15 ; $15
cry_pigeot: macro
	db TX_CRY_15
	endm
	
	enum TX_CRY_16 ; $16
cry_jugon: macro
	db TX_CRY_16
	endm
