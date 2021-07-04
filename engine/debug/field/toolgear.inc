FieldDebug_Toolgear:
	call OpenToolgearMenu
	jr c, .cancelled
	ld a, [wMenuCursorY]
	dec a
	ld hl, .Jumptable
	jp CallJumptable

.Jumptable:
	dw .EnableToolgearClock
	dw .DisplayCoords
	dw .ChangeRTC
	dw .DayNight60SecondCycle
	dw .ResetDayNightCycle
	dw .DisableToolgearClock

.cancelled
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DayNight60SecondCycle:
	ld hl, wd153
	set OVERWORLD_MINUTE_TIME_F, [hl]
	jr .UpdateDayNightCycle

.ResetDayNightCycle:
	ld hl, wd153
	res OVERWORLD_MINUTE_TIME_F, [hl]
	jr .UpdateDayNightCycle

.ChangeRTC:
	callab SetTime

.UpdateDayNightCycle:
	callab Function8c325
	call UpdateTimePals
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.EnableToolgearClock:
	call EnableToolgear
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.DisableToolgearClock:
	call DisableToolgear
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.DisplayCoords:
	call EnableToolgearCoords
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

EnableToolgearCoords:
	call EnableToolgear
	ld hl, wd153
	set TOOLGEAR_COORDS_F, [hl]
	ret

OpenToolgearMenu:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call .AfterToolgearOpen
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	call CloseWindow
	ret

.AfterToolgearOpen:
	ld a, [wToolgearFlags]
	bit TOOLGEAR_COORDS_F, a
	ld a, FIELDDEBUG_RETURN_CLEANUP
	ret nz
	ld hl, wd153
	bit TOOLGEAR_COORDS_F, [hl]
	ld a, FIELDDEBUG_RETURN_WAIT_INPUT
	ret nz
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 7, 14
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 6
	db "とけい@"
	db "ざひょう@"
	db "アジャスト@"
	db "６０びょう@"
	db "２４じかん@"
	db "けす@"

