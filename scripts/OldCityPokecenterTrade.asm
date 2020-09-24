INCLUDE "constants.asm"
INCLUDE "hack/text/OldCityPokecenterTrade.inc"

SECTION "scripts/OldCityPokecenterTrade.asm", ROMX

OldCityPokecenterTrade_ScriptLoader:
	ld hl, OldCityPokecenterTradeScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenterTradeScriptPointers:
	dw OldCityPokecenterTradeScript1
	dw OldCityPokecenterTradeNPCIds

OldCityPokecenterTradeScript1:
	ld hl, OldCityPokecenterTradeNPCIds
	ld de, OldCityPokecenterTradeSignPointers
	call CallMapTextSubroutine
	ret

OldCityPokecenterTradeNPCIds:
	db $00, $ff

OldCityPokecenterTradeSignPointers:
	dw MapDefaultText

OldCityPokecenterTrade_TextPointers:
	dw OldCityPokecenterTradeText1

OldCityPokecenterTradeText1:
	ld hl, wJoypadFlags
	set 5, [hl]
	ld hl, OldCityPokecenterTradeTextString1
	call OpenTextbox
	ld hl, wJoypadFlags
	res 5, [hl]
	callab Function28000
	ret

OldCityPokecenterTradeTextString1:
	text_OldCityPokecenterTradeTextString1
	text_exit
	text_exit
	text_exit
	db "@"

OldCityPokecenterTradePadding:
	textpad_OldCityPokecenterTrade
