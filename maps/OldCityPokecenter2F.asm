INCLUDE "constants.asm"
INCLUDE "hack/text/OldCityPokecenter2F.inc"

SECTION "maps/OldCityPokecenter2F.asm", ROMX

OldCityPokecenter2FScriptLoader: ; 25:4782
	call Unreferenced_Function7e6
	ld hl, OldCityPokecenter2FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenter2FScriptPointers: ; 25:478f
	dw OldCityPokecenter2FScript1
	dw OldCityPokecenter2FNPCIds

OldCityPokecenter2FScript1: ; 25:4793
	ld hl, OldCityPokecenter2FNPCIds
	ld de, OldCityPokecenter2FSignPointers
	call CallMapTextSubroutine
	ret

OldCityPokecenter2FNPCIds: ; 25:479d
	db $00, $01, $02, $03, $ff

OldCityPokecenter2FSignPointers: ; 25:47a2
	dw MapDefaultText

OldCityPokecenter2FTextPointers: ; 25:47a4
	dw OldCityPokecenter2FText1
	dw OldCityPokecenter2FText2
	dw OldCityPokecenter2FText3
	dw OldCityPokecenter2FText4

OldCityPokecenter2FText1: ; 25:47ac
	ld a, $01
	ld [wce37], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callab Function29abf
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText2: ; 25:47c4
	ld a, $02
	ld [wce37], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callab Function29abf
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText3: ; 25:47dc
	ld hl, Text947e3
	call OpenTextbox
	ret

Text947e3: ; 25:47e3
	text_Text947e3

OldCityPokecenter2FText4: ; 25:47e9
	ld hl, OldCityPokecenter2FTextString4
	call OpenTextbox
	callab Function29a1f
	jr c, .asm_9480c
	ld a, $05
	call Function169f ; something related to follow
	jr .asm_9480c
; unreferenced?
	ld hl, Data14824
	ld a, $5
	call Function16fb
	ld hl, $0000
	nop
.asm_9480c
	ret

OldCityPokecenter2FTextString4: ; 25:480d
	text_OldCityPokecenter2FTextString4

; 25:4820
	db $05, $25, $24, $48

Data14824: ; movement data
	db $07, $32

OldCityPokecenter2FPadding:
	textpad_OldCityPokecenter2F
