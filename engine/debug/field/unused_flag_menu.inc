FieldDebug_UnusedFlagMenu: ; unused?
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 7, 10
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 4
	db "フラグ１@"
	db "フラグ２@"
	db "フラグ３@"
	db "フラグ４@"

	call LoadStandardMenuHeader
	bccoord 0, 14
	call .DoCheckFlags
	call WaitBGMap
	ld a, A_BUTTON | B_BUTTON
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DoCheckFlags:
MACRO unused_check_bit
	ld hl, \1
	bit 0, [hl]
	call .CheckBit
	ld hl, \1
	bit 1, [hl]
	call .CheckBit
	ld hl, \1
	bit 2, [hl]
	call .CheckBit
	ld hl, \1
	bit 3, [hl]
	call .CheckBit
	ld hl, \1
	bit 4, [hl]
	call .CheckBit
	ld hl, \1
	bit 5, [hl]
	call .CheckBit
	ld hl, \1
	bit 6, [hl]
	call .CheckBit
	ld hl, \1
	bit 7, [hl]
	call .CheckBit
ENDM

	unused_check_bit wVRAMViewerPage
	unused_check_bit wSwitchMonTo
	unused_check_bit wSwitchMonFrom
	unused_check_bit wReplacementBlock
	unused_check_bit wLinkBattleRNPreamble
	ret

.CheckBit:
	ld a, '０'
	jr z, .not_set
	ld a, '１'
.not_set
	ld [bc], a
	inc bc
	ret
