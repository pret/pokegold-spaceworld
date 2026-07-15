OldCityPokecenter2F_ScriptLoader:
	call SetBitsForTimeCapsuleRequestIfNotLinked
	ld hl, OldCityPokecenter2FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenter2FScriptPointers::
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
	ld [wTempByteValue], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callfar Link_Receptionist_Intro
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText2:
	ld a, $02
	ld [wTempByteValue], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callfar Link_Receptionist_Intro
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText3:
	ld hl, OldCityPokecenter2FTextString3
	call OpenTextbox
	ret

OldCityPokecenter2FTextString3:
	text "おりゃ！"
	done

OldCityPokecenter2FText4:
	ld hl, OldCityPokecenter2FTextString4
	call OpenTextbox
	callfar CheckTimeCapsuleCompatibility
	jr c, .done
	ld a, $05
	call DeleteMapObject
	jr .done
; unreferenced, replaced by the above 3 lines.
	ld hl, OldCityPokecenter2FMovement1
	ld a, $5
	call LoadMovementDataPointer_KeepStateFlags
	ld hl, NULL
	nop
.done
	ret

OldCityPokecenter2FTextString4:
	text "うしろにあるのは"
	line "タイムマシンです"
	done

; Supposed to be wMovementObject, wMovementDataBank, wMovementDataAddr in order.
OldCityPokecenter2FMovementDataPointer_Old:
	db 5
	db BANK(OldCityPokecenter2FMovement1)
	dw OldCityPokecenter2FMovement1

OldCityPokecenter2FMovement1:
	slow_step RIGHT
	step_end
