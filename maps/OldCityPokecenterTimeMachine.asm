INCLUDE "constants.asm"

SECTION "maps/OldCityPokecenterTimeMachine.asm", ROMX

OldCityPokecenterTimeMachineScriptLoader: ; 25:497e
	call Unreferenced_Function7e6
	ld hl, OldCityPokecenterTimeMachineScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenterTimeMachineScriptPointers: ; 25:498b
	dw OldCityPokecenterTimeMachineScript1
	dw OldCityPokecenterTimeMachineNPCIds

OldCityPokecenterTimeMachineScript1: ; 25:498f
	ld hl, OldCityPokecenterTimeMachineNPCIds
	ld de, OldCityPokecenterTimeMachineSignPointers
	call CallMapTextSubroutine
	ret

OldCityPokecenterTimeMachineNPCIds: ; 25:4999
	db $00, $ff

OldCityPokecenterTimeMachineSignPointers: ; 25:499b
	dw MapDefaultText

OldCityPokecenterTimeMachineTextPointers: ; 25:499d
	dw OldCityPokecenterTimeMachineText1

OldCityPokecenterTimeMachineText1: ; 25:499f
	xor a
	ld [wce37], a
	callab Function29abf
	ret

; 25:49ac
