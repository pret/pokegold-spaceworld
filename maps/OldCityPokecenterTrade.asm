INCLUDE "constants.asm"
INCLUDE "hack/text/OldCityPokecenterTrade.inc"

SECTION "maps/OldCityPokecenterTrade.asm", ROMX

OldCityPokecenterTradeScriptLoader: ; 25:4866
	ld hl, OldCityPokecenterTradeScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenterTradeScriptPointers: ; 25:4870
	dw OldCityPokecenterTradeScript1
	dw OldCityPokecenterTradeNPCIds

OldCityPokecenterTradeScript1: ; 25:4874
	ld hl, OldCityPokecenterTradeNPCIds
	ld de, OldCityPokecenterTradeSignPointers
	call CallMapTextSubroutine
	ret

OldCityPokecenterTradeNPCIds: ; 25:487e
	db $00, $ff

OldCityPokecenterTradeSignPointers: ; 25:4880
	dw MapDefaultText

OldCityPokecenterTradeTextPointers: ; 25:4882
	dw OldCityPokecenterTradeText1

OldCityPokecenterTradeText1: ; 25:4884
	ld hl, wJoypadFlags
	set 5, [hl]
	ld hl, OldCityPokecenterTradeTextString1
	call OpenTextbox
	ld hl, wJoypadFlags
	res 5, [hl]
	callab Function28000
	ret

OldCityPokecenterTradeTextString1: ; 25:489d
	text_OldCityPokecenterTradeTextString1
	text_exit
	text_exit
	text_exit
	db "@"

OldCityPokecenterTradePadding:
	textpad_OldCityPokecenterTrade

; 25:48ac
