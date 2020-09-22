INCLUDE "constants.asm"

SECTION "scripts/OldCityPokecenter2F.asm", ROMX

OldCityPokecenter2F_ScriptLoader:
	call Unreferenced_Function7e6
	ld hl, OldCityPokecenter2FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenter2FScriptPointers:
	dw OldCityPokecenter2FScript1
	dw OldCityPokecenter2FNPCIds

OldCityPokecenter2FScript1:
	ld hl, OldCityPokecenter2FNPCIds
	ld de, OldCityPokecenter2FSignPointers
	call CallMapTextSubroutine
	ret

OldCityPokecenter2FNPCIds:
	db $00, $01, $02, $03, $ff

OldCityPokecenter2FSignPointers:
	dw MapDefaultText

OldCityPokecenter2F_TextPointers:
	dw OldCityPokecenter2FText1
	dw OldCityPokecenter2FText2
	dw OldCityPokecenter2FText3
	dw OldCityPokecenter2FText4

OldCityPokecenter2FText1:
	ld a, $01
	ld [wce37], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callab Function29abf
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText2:
	ld a, $02
	ld [wce37], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callab Function29abf
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText3:
	ld hl, Text947e3
	call OpenTextbox
	ret

Text947e3:
	text "おりゃ！"
	done

OldCityPokecenter2FText4:
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

OldCityPokecenter2FTextString4:
	text "うしろにあるのは"
	line "タイムマシンです"
	done

	db $05, $25, $24, $48

Data14824: ; movement data
	db $07, $32
