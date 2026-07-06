; Predef routines can be used with the "predef" and "predef_jump" macros.
; This preserves registers bc, de, hl and f.

MACRO add_predef
\1Predef::
if _NARG == 2
	db \2
	dw \1
else
	dba \1
endc
ENDM

PredefPointers::
	add_predef LearnMove
	add_predef IntroDisplayPicCenteredOrUpperRight
	add_predef AskName_Old
	add_predef GetItemPrice_Old
	add_predef DebugMenu
	add_predef GetItemAmount
	add_predef HealParty
	add_predef AddBCD
	dba AddBCD ; duplicate
	dba AddBCD ; duplicate
	add_predef SubBCD
	dba GetItemAmount ; duplicate
	add_predef SmallFarFlagAction
	add_predef GiveItem, 3 ; wrong bank
	add_predef ComputeHPBarPixels
	add_predef FillPP
	add_predef TryAddMonToParty
	add_predef AddTempmonToParty
	add_predef SendGetMonIntoFromBox
	add_predef DepositBreedmonOrBuffermon
	add_predef RetrieveBreedmonOrBuffermon
	add_predef SendMonIntoBox
	add_predef GiveEgg
	add_predef UpdateHPBar
	add_predef CalcMonStats
	add_predef CalcMonStatC
	add_predef CanLearnTMHMMove
	add_predef GetTMHMMove
	add_predef LinkTextboxAtHL
	add_predef PrintMoveDescription
	add_predef UpdatePlayerHUD
	add_predef PlaceGraphic
	add_predef Old_ScaleSpriteByTwo
	add_predef LoadMonBackPic
	add_predef CheckPlayerPartyForFitMon
	add_predef UpdateEnemyHUD
	add_predef DoubleOrHalveSelectedStats_Old
	add_predef StartBattle
	add_predef CalcAndPlaceExpBar
	add_predef GetBattleMonBackpic
	add_predef GetEnemyMonFrontpic
	add_predef LearnLevelMoves
	add_predef FillMoves
	add_predef EvolveAfterBattle
	add_predef TradeAnimationPlayer2
	add_predef TradeAnimation
	add_predef NewPokedexEntry
	add_predef Pokedex
	add_predef ConvertMon_1to2
	add_predef CopyMonToTempMon
	add_predef ListMoves
	add_predef GetMonBackpic
	add_predef PlaceNonFaintStatus
	add_predef PlacePartyMember
	add_predef OpenPartyMenu_ClearGraphics
	add_predef OpenPartyMenu
	add_predef InitPartyMenuLayout
	add_predef ListMovePP
	add_predef GetGender
	add_predef StatsScreenMain
	add_predef DrawPlayerHP
	add_predef DrawEnemyHP
	add_predef GetTypeName
	add_predef PrintMoveType
	add_predef PrintMonTypes
	add_predef GetUnownLetter
	add_predef ChangeBGPalColor0_4Frames
	add_predef PredefShakeScreenVertically
	add_predef PredefShakeScreenHorizontally
	add_predef SavePokemonData
	add_predef TryLoadPokemonData
	add_predef Dummy_SaveBox
	add_predef ExecuteBGEffects
	add_predef SaveOptionsAndGameData
	add_predef SaveMenu
	add_predef CheckSGB
	add_predef LoadSGBLayout
	add_predef Pokedex_GetArea
	add_predef DoBattleTransition
	add_predef LeaveMapAnim_Old
	add_predef EnterMapAnim_Old
	add_predef PlayBattleAnim
	add_predef AnimationSlideEnemyMonOff ; dummied out
	add_predef AnimationSubstitute ; dummied out
	add_predef FightDebugMenu
	add_predef LoadItemData
	dbw $ff, DummyEndPredef
