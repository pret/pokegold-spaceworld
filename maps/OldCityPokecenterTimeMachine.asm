INCLUDE "constants.asm"

SECTION "maps/OldCityPokecenterTimeMachine.asm", ROMX

OldCityPokecenterTimeMachineScriptLoader:
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

OldCityPokecenterTimeMachineTextPointers:
	dw OldCityPokecenterTimeMachineText1

OldCityPokecenterTimeMachineText1:
	xor a
	ld [wce37], a
	callab Function29abf
	ret
