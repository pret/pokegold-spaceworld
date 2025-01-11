INCLUDE "constants.asm"

SECTION "scripts/OldCityPokecenterTimeMachine.asm", ROMX

OldCityPokecenterTimeMachine_ScriptLoader:
	call Unreferenced_Function7e6
	ld hl, OldCityPokecenterTimeMachineScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenterTimeMachineScriptPointers:
	dw OldCityPokecenterTimeMachineScript1
	dw OldCityPokecenterTimeMachineNPCIds

OldCityPokecenterTimeMachineScript1:
	ld hl, OldCityPokecenterTimeMachineNPCIds
	ld de, OldCityPokecenterTimeMachineSignPointers
	call CallMapTextSubroutine
	ret

OldCityPokecenterTimeMachineNPCIds:
	db $00, $ff

OldCityPokecenterTimeMachineSignPointers:
	dw MapDefaultText

OldCityPokecenterTimeMachine_TextPointers:
	dw OldCityPokecenterTimeMachineText1

OldCityPokecenterTimeMachineText1:
	xor a
	ld [wce37], a
	callfar Function29abf
	ret
