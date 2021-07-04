FieldDebug_Warp:
	call DebugMenu_DisplayWarpSubmenu
	jr nc, .do_warp
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.do_warp
	ld a, [wMenuSelection]
	ld [wDefaultSpawnPoint], a
	ld hl, wVramState
	set 6, [hl]
	ldh a, [hROMBank]
	ld hl, FieldDebug_ShowWarpToText
	call QueueScript
	ld de, SFX_22
	call PlaySFX
	call DelayFrame
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

SECTION "engine/debug/field/warp.inc@FieldDebug_ShowWarpToText", ROMX

FieldDebug_ShowWarpToText:
	call .ShowText
	call Functionfcc24
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
	call Function1fea
	ret

.WarpToText:
	text_from_ram wStringBuffer2
	text "に"
	line "ワープします！"
	done

Functionfcc24:
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, .MovementDatafcc49
	call LoadMovementDataPointer
	ld hl, wVramState
	set 7, [hl]

.asm_fcc36
	call Function2c4a
	ld a, [wVramState]
	bit 7, a
	jr nz, .asm_fcc36
	ld a, 0
	ld hl, .MovementDatafcc4b
	call Function16fb
	ret

.MovementDatafcc49:
	db $36
	db $32

.MovementDatafcc4b:
	db $37
	db $32

