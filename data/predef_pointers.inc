; Predef routines can be used with the "predef" and "predef_jump" macros.
; This preserves registers bc, de, hl and f.

MACRO add_predef
\1Predef::
	dba \1
ENDM

PredefPointers::
; To YOU who is reading this:
; Please be a peach and nuke the hell out of these:
; WE NEED LABELS!
; Thank youu~
	add_predef Function6445 ; 0
	add_predef IntroDisplayPicCenteredOrUpperRight
	add_predef Function6713
	add_predef Function66b1
	add_predef DebugMenu
	add_predef GetItemAmount
	add_predef HealParty
	add_predef AddBCD
	dba AddBCD ; 8
	dba AddBCD
	add_predef SubBCD
	dba GetItemAmount
	add_predef SmallFarFlagAction
GiveItemPredef::
	dbw 3, GiveItem
	add_predef ComputeHPBarPixels
	add_predef FillPP
	add_predef Functiond886 ; 10
	add_predef Functionda4f
	add_predef Functiondac8
	add_predef Functiondcfc
	add_predef Functiondc16
	add_predef Functiondd5c
	add_predef Functionde79
	add_predef UpdateHPBar
	add_predef CalcMonStats ; 18
	add_predef CalcMonStatC
	add_predef CanLearnTMHMMove
	add_predef GetTMHMMove
	add_predef LinkTextboxAtHL
	add_predef Function2d663
	add_predef UpdatePlayerHUD
	add_predef PlaceGraphic
	add_predef Function3f068 ; 20
	add_predef LoadMonBackPic
	add_predef AnyPartyAlive
	add_predef UpdateEnemyHUD
	add_predef Function3e1a4
	add_predef Function3ef19
	add_predef CalcAndPlaceExpBar
	add_predef Function3e91e
	add_predef Function3e963 ; 28
	add_predef Function421f8
	add_predef FillMoves
	add_predef Function41fa1
	add_predef Function28da4
	add_predef Function28d6e
	add_predef NewPokedexEntry
	add_predef Pokedex
	add_predef ConvertMon_1to2 ; 30
	add_predef CopyMonToTempMon
	add_predef ListMoves
	add_predef Function50bcd
	add_predef PlaceNonFaintStatus
	add_predef Function508c4
	add_predef PartyMenuInBattle_Setup
	add_predef PartyMenuInBattle
	add_predef Function5081f ; 38
	add_predef ListMovePP
	add_predef GetGender
	add_predef Function502b5
	add_predef DrawPlayerHP
	add_predef DrawEnemyHP
	add_predef GetTypeName
	add_predef PrintMoveType
	add_predef PrintMonTypes ; 40
	add_predef GetUnownLetter
	add_predef Functioncb6ff
	add_predef Functioncb710
	add_predef Functioncb733
	add_predef Function145b8
	add_predef Function146dc
	add_predef Function145de
	add_predef ExecuteBGEffects ; 48
	add_predef Function1457a
	add_predef Function143e0
	add_predef CheckSGB
	add_predef LoadSGBLayout
	add_predef Pokedex_GetArea
	add_predef DoBattleTransition
	add_predef Function8c9c6
	add_predef Function8c940 ; 50
	add_predef PlayBattleAnim
	add_predef Functioncc000
	add_predef Functioncc000_2
	add_predef Functionfdb66
	add_predef LoadItemData
	dbw $ff, InexplicablyEmptyFunction ; 56
