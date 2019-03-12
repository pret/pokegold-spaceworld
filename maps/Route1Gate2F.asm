include "constants.asm"
INCLUDE "hack/text/Route1Gate2F.inc"

SECTION "maps/Route1Gate2F.asm", ROMX

Route1Gate2FScriptLoader:: ; 411F
	ld hl, Route1Gate2FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
Route1Gate2FScriptPointers: ; 4129
	dw Route1Gate2FScript 
	dw Route1Gate2FNPCIDs
	
Route1Gate2FNPCIDs: ; 412D
	db 0
	db 1
	db $FF

Route1Gate2FSignPointers: ; 4130
	dw Route1Gate2FTextSign1 
	dw Route1Gate2FTextSign2 
Route1Gate2FTextPointers:: ; 4134
	dw Route1Gate2FTextNPC1 
	dw Route1Gate2FTextNPC2
	
Route1Gate2FScript:: ; 4138
	ld hl, Route1Gate2FNPCIDs
	ld de, Route1Gate2FSignPointers
	call CallMapTextSubroutine
	ret
	
Route1Gate2FTextNPC1: ; 4142
	ld hl, Route1Gate2FTextString1
	call OpenTextbox
	ret
	
Route1Gate2FTextNPC2: ; 4149
	ld hl, Route1Gate2FTextString2
	call OpenTextbox
	ret
	
Route1Gate2FTextSign1: ; 4150
	ld hl, Route1Gate2FTextString3
	call OpenTextbox 
	ret
	
Route1Gate2FTextSign2: ; 4157
	ld hl, Route1Gate2FTextString4
	call OpenTextbox
	ret
	
Route1Gate2FTextString1: ; 415E
	text_Route1Gate2FTextString1
	
Route1Gate2FTextString2: ; 4197
	text_Route1Gate2FTextString2
	
Route1Gate2FTextString3: ; 41D8
	text_Route1Gate2FTextString3
	
Route1Gate2FTextString4: ; 41FF
	text_Route1Gate2FTextString4

Route1Gate2FPadding:
	textpad_Route1Gate2F
	
; 4224