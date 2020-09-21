include "constants.asm"

SECTION "scripts/UnusedMap13.asm", ROMX

UnusedMap13ScriptLoader::
	ld hl, UnusedMap13ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

UnusedMap13ScriptPointers:
	dw UnusedMap13Script
	dw UnusedMap13NPCIDs

UnusedMap13NPCIDs:
	db $FF

UnusedMap13SignPointers:
	dw MapDefaultText

UnusedMap13TextPointers::
	dw MapDefaultText

UnusedMap13Script:
	ld hl, UnusedMap13NPCIDs
	ld de, UnusedMap13SignPointers
	call CallMapTextSubroutine
	ret
