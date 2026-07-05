FieldDebug_TownMap:
	call LoadStandardMenuHeader
	call ClearSprites
	callfar FlyMap
	call ClearPalettes
	call ReloadSpritesAndFont
	call LoadFontExtra
	call CloseWindow
	call GetMemSGBLayout
	call SetPalettes
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/sprite_viewer.inc"

FieldDebug_NamePlayer:
	call LoadStandardMenuHeader
	ld de, wPlayerName
	ld b, 1
	callfar NamingScreen
	call ClearBGPalettes
	call ClearTileMap
	call CloseWindow
	call ClearSprites
	call GetMemSGBLayout
	call SetPalettes
	ld hl, wOptions
	res NO_TEXT_SCROLL_F, [hl]
	call LoadFontExtra
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/toolgear.inc"

FieldDebug_HealPokemon:
	predef HealParty
	ld hl, .HealedText
	call MenuTextBoxBackup
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.HealedText:
	text "#の　たいりょくを"
	line "かいふくしました"
	prompt

FieldDebug_CableClub:
	callfar Link_Receptionist_Intro
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/npc_movement_test.inc"

INCLUDE "engine/debug/field/mon_following.inc"

INCLUDE "engine/debug/field/follow_npc_test.inc"

INCLUDE "engine/debug/field/warp.inc"

INCLUDE "engine/debug/field/toggle_npc_movement.inc"

INCLUDE "engine/debug/field/field_cut.inc"

INCLUDE "engine/debug/field/check_tile.inc"

INCLUDE "engine/debug/field/move_to_entrance.inc"

FieldDebug_TrainerGear:
	call .OpenTrainerGear
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.OpenTrainerGear:
	call LoadStandardMenuHeader
	callfar OpenTrainerGear
	call ClearPalettes
	callfar StartMenuLoadSprites
	call CloseWindow
	ret

INCLUDE "engine/debug/field/map_viewer.inc"

INCLUDE "engine/debug/field/item_test.inc"

FieldDebug_PCMenu:
	callfar PokemonCenterPC
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/pokemart_menu.inc"

INCLUDE "engine/debug/field/teleport.inc"

INCLUDE "engine/debug/field/minigames.inc"

FieldDebug_VRAMViewer:
	call FieldDebug_DoVRAMViewer
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_ClearEventFlags:
	call FieldDebug_DoClearEventFlags
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/unused_flag_menu.inc"

INCLUDE "engine/debug/field/unused_show_mon.inc"

INCLUDE "engine/debug/field/unused_priority_menu.inc"

INCLUDE "engine/debug/field/vram_viewer.inc"
