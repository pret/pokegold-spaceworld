FieldDebug_Warp:
	call DebugMenu_DisplayWarpSubmenu
	jr nc, .do_warp
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.do_warp
	ld a, [wMenuSelection]
	ld [wDefaultSpawnPoint], a
	ld hl, wStateFlags
	set 6, [hl] ; TODO: ???
	ldh a, [hROMBank]
	ld hl, FieldDebug_ShowWarpToText
	call QueueScript
	ld de, SFX_SAFARI_ZONE_PA
	call PlaySFX
	call DelayFrame
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

DebugMenu_DisplayWarpSubmenu:
	xor a
	ldh [hBGMapMode], a
	call LoadStandardMenuHeader
	ld hl, wTileMap
	ld b, 10
	ld c, 11
	call DrawTextBox
	call UpdateSprites
	ld hl, DebugMenu_WarpMenuHeader
	call CopyMenuHeader
	call ScrollingMenu
	call CloseWindow
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .cancel
	and a
	ret

.cancel
	scf
	ret

DebugMenu_WarpMenuHeader::
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, 11, 10
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db 0 ; flags
	db 4 ; items
	dw $0100 ; ???
	dba WarpMenuOptions
	dba PlaceSelectedMapName
	dba NULL ; placeholder
	dba NULL ; placeholder

PlaceSelectedMapName::
	push de
	ld a, [wMenuSelection]
	call GetLandmarkName
	pop hl
	call PlaceString
	ret

GetLandmarkName::
	dec a
	ld hl, LandmarkNames
	call GetNthString
	ld d, h
	ld e, l
	ret

INCLUDE "data/maps/landmark_names.asm"
INCLUDE "data/maps/debug_warps.asm"

FieldDebug_ShowWarpToText:
	call .ShowText
	call DoTeleportAnimation
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	scf
	ret

.ShowText:
	call ReanchorMap
	ld a, [wDefaultSpawnPoint]
	call GetLandmarkName
	call CopyStringToStringBuffer2
	ld hl, .WarpToText
	call FieldDebug_ShowTextboxAndExit
	call CloseText
	ret

.WarpToText:
	text_from_ram wStringBuffer2
	text "に"
	line "ワープします！"
	done

DoTeleportAnimation:
	ld a, PLAYER_OBJECT
	call FreezeAllOtherObjects
	ld a, PLAYER_OBJECT
	ld hl, .TeleportFrom
	call LoadMovementDataPointer
	ld hl, wStateFlags
	set SCRIPTED_MOVEMENT_STATE_F, [hl]

.loop
	call HandleMapObjects
	ld a, [wStateFlags]
	bit SCRIPTED_MOVEMENT_STATE_F, a
	jr nz, .loop
	ld a, PLAYER_OBJECT
	ld hl, .TeleportTo
	call LoadMovementDataPointer_KeepStateFlags
	ret

.TeleportFrom:
	teleport_from
	step_end

.TeleportTo:
	teleport_to
	step_end
