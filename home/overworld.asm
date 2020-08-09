INCLUDE "constants.asm"

SECTION "home/overworld.asm@Startmenu and Select Button Check", ROM0

OverworldStartButtonCheck:: ; 2c05 (0:2c05)
	ldh a, [hJoyState]
	bit START_F, a
	ret z
	and (START | B_BUTTON)
	cp (START | B_BUTTON)
	jr nz, .regularMenu
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	ret z              ; debug disabled
	callba InGameDebugMenu
	jr CheckStartmenuSelectHook
.regularMenu
	callba DisplayStartMenu
	jr CheckStartmenuSelectHook
SelectButtonFunction:: ; 2c2a (0:2c2a)
	callab CheckRegisteredItem
CheckStartmenuSelectHook:
	ldh a, [hStartmenuCloseAndSelectHookEnable]
	and a
	ret z          ; hook is disabled
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	call FarCall_hl
	ld hl, hStartmenuCloseAndSelectHookEnable
	xor a
	ld [hli], a    ; clear hook enable and ???
	ld [hl], a
	dec a
	ret

Function2c4a: ; 2c4a (0:2c4a)
; copy of Function2ba8
; calling Functiond4e6 instead of Functiond6e4
.loop
	call Function2c5a
	and a
	ld a, [$cb6e]
	bit 5, a
	ret z
	bit 6, a
	jr z, .loop
	scf
	ret

Function2c5a: ; 2c5a (0:2c5a)
	ldh a, [hROMBank]
	push af
	ld a, BANK(Function50b9)
	call Bankswitch
	call Function50b9
	call Function18a0
	ld a, BANK(Functiond4e6)
	call Bankswitch
	call Functiond4e6
	ld a, BANK(_UpdateSprites)
	call Bankswitch
	call _UpdateSprites
	call DelayFrame
	call UpdateToolgear
	ld hl, wToolgearFlags
	set 2, [hl]
	call DelayFrame
	pop af
	call Bankswitch
	ret

UpdateAndTransferToolgear: ; 2c8b (0:2c8b)
	call DelayFrame
	call UpdateToolgear
	ld hl, wToolgearFlags
	set 2, [hl] ;  ; transfer toolgear to window
	call DelayFrame
	ret

ScheduleNorthRowRedraw: ; 2c9a (0:2c9a)
	coord hl, 0, 0
	call CopyToRedrawRowOrColumnSrcTiles
	ld a, [wBGMapAnchor]
	ldh [hRedrawRowOrColumnDest], a
	ld a, [wBGMapAnchor + 1]
	ldh [hRedrawRowOrColumnDest + 1], a
	ld a, REDRAW_ROW
	ldh [hRedrawRowOrColumnMode], a
	ret

ScheduleSouthRowRedraw: ; 2caf (0:2caf)
	coord hl, 0, SCREEN_HEIGHT - 2
	call CopyToRedrawRowOrColumnSrcTiles
	ld a, [wBGMapAnchor]
	ld l, a
	ld a, [wBGMapAnchor + 1]
	ld h, a
	ld bc, BG_MAP_WIDTH * (SCREEN_HEIGHT - 2)
	add hl, bc
	; the following 4 lines wrap us from bottom to top if necessary
	ld a, h
	and HIGH(vBGMap1 - vBGMap0 - $01)
	or HIGH(vBGMap0)
	ldh [hRedrawRowOrColumnDest + 1], a
	ld a, l
	ldh [hRedrawRowOrColumnDest], a
	ld a, REDRAW_ROW
	ldh [hRedrawRowOrColumnMode], a
	ret

ScheduleEastColumnRedraw: ; 2cd0 (0:2cd0)
	coord hl, SCREEN_WIDTH - 2, 0
	call ScheduleColumnRedrawHelper
	ld a, [wBGMapAnchor]
	ld c, a
	and ($FF ^ (BG_MAP_WIDTH - 1))  ; mask upper address bits
	ld b, a
	ld a, c
	add SCREEN_WIDTH - 2
	and BG_MAP_WIDTH - 1            ; mask lower address bits
	or b
	ldh [hRedrawRowOrColumnDest], a
	ld a, [wBGMapAnchor + 1]
	ldh [hRedrawRowOrColumnDest + 1], a
	ld a, REDRAW_COL
	ldh [hRedrawRowOrColumnMode], a
	ret

ScheduleWestColumnRedraw: ; 2cef (0:2cef)
	coord hl, 0, 0
	call ScheduleColumnRedrawHelper
	ld a, [wBGMapAnchor]
	ldh [hRedrawRowOrColumnDest], a
	ld a, [wBGMapAnchor + 1]
	ldh [hRedrawRowOrColumnDest + 1], a
	ld a, REDRAW_COL
	ldh [hRedrawRowOrColumnMode], a
	ret

CopyToRedrawRowOrColumnSrcTiles: ; 2d04 (0:2d04)
	ld de, wRedrawRowOrColumnSrcTiles
	ld c, 2 * SCREEN_WIDTH
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

ScheduleColumnRedrawHelper: ; 2d10 (0:2d10)
	ld de, wRedrawRowOrColumnSrcTiles
	ld c, SCREEN_HEIGHT
.loop
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, SCREEN_WIDTH - 1
	add l
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	dec c
	jr nz, .loop
	ret

SECTION "home/overworld.asm@QueueScript", ROM0

QueueScript::
; Install a function that is called as soon as
; the start menu is closed or directly after
; the select button function ran
	ld [wQueuedScriptBank], a
	ld a, l
	ld [wQueuedScriptAddr], a
	ld a, h
	ld [wQueuedScriptAddr + 1], a
	ret