include "constants.asm"
INCLUDE "hack/text/PlayersHouse1F.inc"

SECTION "scripts/PlayerHouse1F.asm", ROMX

PlayerHouse1F_ScriptLoader::
	ld hl, PlayerHouse1FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

PlayerHouse1FScriptPointers:
	dw PlayerHouse1FScript1
	dw PlayerHouse1FNPCIDs1
	dw PlayerHouse1FScript2
	dw PlayerHouse1FNPCIDs2

PlayerHouse1FNPCIDs1:
	db $FF

PlayerHouse1FNPCIDs2:
	db 0
	db $FF

PlayerHouse1FScript1:
	ld hl, PlayerHouse1FNPCIDs1
	ld de, PlayerHouse1FSignPointers
	call CallMapTextSubroutine
	ret

PlayerHouse1FScript2:
	ld hl, PlayerHouse1FNPCIDs2
	ld de, PlayerHouse1FSignPointers
	call CallMapTextSubroutine
	ret

PlayerHouse1FSignPointers:
	dw Function38ab
	dw Function38b4
	dw Function38a2
	dw Function38bd
	dw Function3899
PlayerHouse1F_TextPointers::
	dw PlayerHouse1FNPCText1

PlayerHouse1FNPCText1:
	ld hl, PlayerHouse1FTextString1
	call OpenTextbox
	ret
	
PlayerHouse1FTextString1:
	text_PlayersHouse1FTextString1

PlayerHouse1FPadding:
	textpad_PlayersHouse1F
