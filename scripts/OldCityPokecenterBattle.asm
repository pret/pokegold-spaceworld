INCLUDE "constants.asm"

SECTION "scripts/OldCityPokecenterBattle.asm", ROMX

OldCityPokecenterBattle_ScriptLoader:
	ld hl, OldCityPokecenterBattleScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

OldCityPokecenterBattleScriptPointers:
	dw OldCityPokecenterBattleScript1
	dw OldCityPokecenterBattleNPCIds

OldCityPokecenterBattleScript1:
	ld hl, OldCityPokecenterBattleNPCIds
	ld de, OldCityPokecenterBattleSignPointers
	call CallMapTextSubroutine
	ret

OldCityPokecenterBattleNPCIds:
	db $00, $ff

OldCityPokecenterBattleSignPointers:
	dw MapDefaultText

OldCityPokecenterBattle_TextPointers:
	dw OldCityPokecenterBattleText1

OldCityPokecenterBattleText1:
	ld hl, wJoypadFlags
	set 5, [hl]
	ld hl, OldCityPokecenterBattleTextString1
	call OpenTextbox
	ld hl, wJoypadFlags
	res 5, [hl]
	callab Function28000
	ret

OldCityPokecenterBattleTextString1:
	text "ちょっとまってね！@"
	text_exit
	db "@"
