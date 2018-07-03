include "constants.asm"

SECTION "maps/Map13.asm", ROMX

Map13ScriptLoader:: ; 6078
	ld hl, Map13ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
Map13ScriptPointers: ; 6082
	dw Map13Script
	dw Map13NPCIDs
	
Map13NPCIDs: ; 6086
	db $FF 
	
Map13TextPointers: ; 6087
	dw MapDefaultText
	dw MapDefaultText
	
Map13Script: ; 608B
	ld hl, Map13NPCIDs
	ld de, Map13TextPointers
	call CallMapTextSubroutine
	ret