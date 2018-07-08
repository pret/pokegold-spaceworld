include "constants.asm"

SECTION "maps/UnusedMap13.asm", ROMX

UnusedMap13ScriptLoader:: ; 6078
	ld hl, UnusedMap13ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
UnusedMap13ScriptPointers: ; 6082
	dw UnusedMap13Script
	dw UnusedMap13NPCIDs
	
UnusedMap13NPCIDs: ; 6086
	db $FF 
	
UnusedMap13SignPointers: ; 6087
	dw MapDefaultText

UnusedMap13TextPointers:: ; 6089
	dw MapDefaultText
	
UnusedMap13Script: ; 608B
	ld hl, UnusedMap13NPCIDs
	ld de, UnusedMap13SignPointers
	call CallMapTextSubroutine
	ret