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
	callfar Function29abf
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText2:
	ld a, $02
	ld [wce37], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callfar Function29abf
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
	callfar Function29a1f
	jr c, .asm_9480c
	ld a, $05
	call DeleteMapObject
	jr .asm_9480c
; unreferenced?
	ld hl, OldCityPokecenter2FMovement1
	ld a, $5
	call LoadMovementDataPointer_KeepStateFlags
	ld hl, $0000
	nop
.asm_9480c
	ret

OldCityPokecenter2FTextString4:
	text "うしろにあるのは"
	line "タイムマシンです"
	done

; TODO?: APPEARS to be movement data. These bytes including a set sliding command makes sense
; considering that the Link Cable nurse has no proper walking sprites.
; The latter two bytes, however, are an exact match for the address of OldCityPokecenter2FMovement1,
; so it's hard to be certain.
OldCityPokecenter2FMovement_Unreferenced:
	slow_step UP
	set_sliding
	dw OldCityPokecenter2FMovement1

OldCityPokecenter2FMovement1:
	slow_step RIGHT
	step_end
