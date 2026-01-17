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
	add_predef LearnMove ; 0
	add_predef IntroDisplayPicCenteredOrUpperRight
	add_predef AskName_Old
	add_predef GetItemPrice_Old
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
	add_predef TryAddMonToParty ; 10
	add_predef AddTempmonToParty
	add_predef SendGetMonIntoFromBox
	add_predef DepositBreedmonOrBuffermon
	add_predef RetrieveBreedmonOrBuffermon
	add_predef SendMonIntoBox
	add_predef GiveEgg
	add_predef UpdateHPBar
	add_predef CalcMonStats ; 18
	add_predef CalcMonStatC
	add_predef CanLearnTMHMMove
	add_predef GetTMHMMove
	add_predef LinkTextboxAtHL
	add_predef PrintMoveDescription
	add_predef UpdatePlayerHUD
	add_predef PlaceGraphic
	add_predef Old_ScaleSpriteByTwo ; 20
	add_predef LoadMonBackPic
	add_predef CheckPlayerPartyForFitMon
	add_predef UpdateEnemyHUD
	add_predef DoubleOrHalveSelectedStats_Old
	add_predef StartBattle
	add_predef CalcAndPlaceExpBar
	add_predef GetBattleMonBackpic
	add_predef GetEnemyMonFrontpic ; 28
	add_predef LearnLevelMoves
	add_predef FillMoves
	add_predef EvolveAfterBattle
	add_predef Function28da4
	add_predef Function28d6e
	add_predef NewPokedexEntry
	add_predef Pokedex
	add_predef ConvertMon_1to2 ; 30
	add_predef CopyMonToTempMon
	add_predef ListMoves
	add_predef GetMonBackpic
	add_predef PlaceNonFaintStatus
	add_predef PlacePartyMember
	add_predef OpenPartyMenu_ClearGraphics
	add_predef OpenPartyMenu
	add_predef InitPartyMenuLayout ; 38
	add_predef ListMovePP
	add_predef GetGender
	add_predef StatsScreenMain
	add_predef DrawPlayerHP
	add_predef DrawEnemyHP
	add_predef GetTypeName
	add_predef PrintMoveType
	add_predef PrintMonTypes ; 40
	add_predef GetUnownLetter
	add_predef ChangeBGPalColor0_4Frames
	add_predef PredefShakeScreenVertically
	add_predef PredefShakeScreenHorizontally
	add_predef SavePokemonData
	add_predef TryLoadPokemonData
	add_predef Dummy_SaveBox
	add_predef ExecuteBGEffects ; 48
	add_predef SaveOptionsAndGameData
	add_predef SaveMenu
	add_predef CheckSGB
	add_predef LoadSGBLayout
	add_predef Pokedex_GetArea
	add_predef DoBattleTransition
	add_predef LeaveMapAnim_Old
	add_predef EnterMapAnim_Old ; 50
	add_predef PlayBattleAnim
	add_predef Functioncc000
	add_predef Functioncc000_2
	add_predef Functionfdb66
	add_predef LoadItemData
	dbw $ff, InexplicablyEmptyFunction ; 56
