include "constants.asm"
INCLUDE "hack/text/Route1Gate1F.inc"

SECTION "Route 1 Gate 1F", ROMX[$4061], BANK[$26]

Route1Gate1FScriptLoader: ;4061
	ld hl, Route1Gate1FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

Route1Gate1FScriptPointers:
	dw Route1Gate1FScript ;>> routine
	dw Route1Gate1FNPCIDs ;>> data

Route1Gate1FNPCIDs: ; 406F
	db $00
	db $01
	db $FF

Route1Gate1FTextPointers:
	dw MapDefaultText ;no signs
	dw Route1Gate1FText1
	dw Route1Gate1FText2

Route1Gate1FScript: ; 4078
	ld hl, Route1Gate1FNPCIDs
	ld de, Route1Gate1FTextPointers
	call CallMapTextSubroutine
	ret

Route1Gate1FText1: ; 4082
	ld hl, Route1Gate1FText1String
	call OpenTextbox
	ret

Route1Gate1FText2: ; 4089
	ld hl, Route1Gate1FText2String
	call OpenTextbox
	ret

Route1Gate1FText1String: ; 4090
	text_Route1Gate1FText1String
	
Route1Gate1FText2String: ; 40AC
	text_Route1Gate1FText2String
	
;ends at 40D9
