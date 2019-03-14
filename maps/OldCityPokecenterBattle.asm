INCLUDE "constants.asm"
INCLUDE "hack/text/OldCityPokecenterBattle.inc"

SECTION "maps/OldCityPokecenterBattle.asm", ROMX

OldCityPokecenterBattleScriptLoader: ; 25:48eb
	ld hl, OldCityPokecenterBattleScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenterBattleScriptPointers: ; 25:48f5
	dw OldCityPokecenterBattleScript1
	dw OldCityPokecenterBattleNPCIds

OldCityPokecenterBattleScript1: ; 25:48f9
	ld hl, OldCityPokecenterBattleNPCIds
	ld de, OldCityPokecenterBattleSignPointers
	call CallMapTextSubroutine
	ret

OldCityPokecenterBattleNPCIds: ; 25:4903
	db $00, $ff

OldCityPokecenterBattleSignPointers: ; 25:4905
	dw MapDefaultText

OldCityPokecenterBattleTextPointers: ; 25:4907
	dw OldCityPokecenterBattleText1

OldCityPokecenterBattleText1: ; 25:4909
	ld hl, wJoypadFlags
	set 5, [hl]
	ld hl, OldCityPokecenterBattleTextString1
	call OpenTextbox
	ld hl, wJoypadFlags
	res 5, [hl]
	callab Function28000
	ret

OldCityPokecenterBattleTextString1: ; 25:4922
	text_OldCityPokecenterBattleTextString1
	text_exit
	db "@"

OldCityPokecenterBattlePadding:
	textpad_OldCityPokecenterBattle

; 25:492f
