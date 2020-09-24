include "constants.asm"
INCLUDE "hack/text/Route1P1.inc"

SECTION "scripts/Route1P1.asm", ROMX

	ret

	dw Textdbb82
Textdbb82:
	text "べんりな　よのなかだね"
	done

	rept 9
	ret
	endr

Route1P1_ScriptLoader::
	ld hl, Route1P1ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

Route1P1ScriptPointers:
	dw Route1P1Script
	dw Route1P1NPCIDs

Route1P1NPCIDs:
	db 0
	db 1
	db $FF

Route1P1SignPointers:
	dw Route1P1TextSign1
	dw Route1P1TextSign2

Route1P1_TextPointers::
	dw Route1P1TextNPC1
	dw Route1P1TextNPC2

Route1P1Script::
	ld hl, Route1P1NPCIDs
	ld de, Route1P1SignPointers
	call CallMapTextSubroutine
	ret

Route1P1TextNPC1:
	ld hl, Route1P1TextString1
	call OpenTextbox
	ret

Route1P1TextNPC2:
	ld hl, Route1P1TextString2
	call OpenTextbox
	ret

Route1P1TextSign1:
	ld hl, Route1P1TextString3
	call OpenTextbox
	ret

Route1P1TextSign2:
	ld hl, Route1P1TextString4
	call OpenTextbox
	ret
	
Route1P1TextString1:
	text_Route1P1TextString1
	
Route1P1TextString2:
	text_Route1P1TextString2
	
Route1P1TextString3:
	text_Route1P1TextString3
	
Route1P1TextString4:; 7C48
	text_Route1P1TextString4

Route1P1Padding:
	textpad_Route1P1
