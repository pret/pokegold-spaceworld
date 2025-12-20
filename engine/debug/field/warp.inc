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

SECTION "engine/debug/field/warp.inc@FieldDebug_ShowWarpToText", ROMX

FieldDebug_ShowWarpToText:
	call .ShowText
	call DoTeleportAnimation
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	scf
	ret

.ShowText:
	call RefreshScreen
	ld a, [wDefaultSpawnPoint]
	call GetLandmarkName
	call CopyStringToStringBuffer2
	ld hl, .WarpToText
	call FieldDebug_ShowTextboxAndExit
	call ScreenCleanup
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

