INCLUDE "constants.asm"

SECTION "engine/items/switch_items.asm", ROMX

SwitchItemsInBag::
	ld a, [wSelectedSwapPosition]
	and a
	jr z, .init
	ld b, a
	ld a, [wScrollingMenuCursorPosition]
	inc a
	cp b
	jr z, .trivial
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [hl]
	cp -1
	ret z
	ld a, [wSelectedSwapPosition]
	dec a
	ld [wSelectedSwapPosition], a
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [hl]
	pop hl
	cp [hl]
	jr z, .combine_stacks
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld a, [wSelectedSwapPosition]
	cp c
	jr c, .above
	jr .below

.init:
	ld a, [wScrollingMenuCursorPosition]
	inc a
	ld [wSelectedSwapPosition], a
	ret

.trivial:
	xor a
	ld [wSelectedSwapPosition], a
	ret

.below:
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_CopyItemToBuffer
	ld a, [wScrollingMenuCursorPosition]
	ld d, a
	ld a, [wSelectedSwapPosition]
	ld e, a
	call ItemSwitch_GetItemOffset
	push bc
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	dec hl
	push hl
	call ItemSwitch_GetItemFormatSize
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	call ItemSwitch_BackwardsCopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_CopyBufferToItem
	xor a
	ld [wSelectedSwapPosition], a
	ret

.above:
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_CopyItemToBuffer
	ld a, [wScrollingMenuCursorPosition]
	ld d, a
	ld a, [wSelectedSwapPosition]
	ld e, a
	call ItemSwitch_GetItemOffset
	push bc
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	call ItemSwitch_GetItemFormatSize
	add hl, bc
	pop bc
	call CopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_CopyBufferToItem
	xor a
	ld [wSelectedSwapPosition], a
	ret

.combine_stacks:
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	inc hl
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld a, [hl]
	pop hl
	add [hl]
	cp MAX_ITEM_STACK + 1
	jr c, .merge_stacks
	sub MAX_ITEM_STACK
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld [hl], MAX_ITEM_STACK
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	xor a
	ld [wSelectedSwapPosition], a
	ret

.merge_stacks:
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSelectedSwapPosition]
	cp [hl]
	jr nz, .not_combining_last_item
	dec [hl]
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	ld [hl], -1 ; end
	xor a
	ld [wSelectedSwapPosition], a
	ret

.not_combining_last_item:
	dec [hl]
	call ItemSwitch_GetItemFormatSize
	push bc
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	pop bc
	push hl
	add hl, bc
	pop de
.copy_loop
	ld a, [hli]
	ld [de], a
	inc de
	cp -1 ; end?
	jr nz, .copy_loop
	xor a
	ld [wSelectedSwapPosition], a
	ret

ItemSwitch_CopyItemToBuffer:
	call ItemSwitch_GetNthItem
	ld de, wSwitchItemBuffer
	call ItemSwitch_GetItemFormatSize
	call CopyBytes
	ret

ItemSwitch_CopyBufferToItem:
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	ld hl, wSwitchItemBuffer
	call ItemSwitch_GetItemFormatSize
	call CopyBytes
	ret

ItemSwitch_GetNthItem:
	push af
	call ItemSwitch_GetItemFormatSize
	ld hl, wMenuDataDisplayFunctionPointer + 1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	pop af
	call AddNTimes
	ret

ItemSwitch_GetItemOffset:
	push hl
	call ItemSwitch_GetItemFormatSize
	ld a, d
	sub e
	jr nc, .dont_negate
	dec a
	cpl
.dont_negate
	ld hl, 0
	call AddNTimes
	ld b, h
	ld c, l
	pop hl
	ret

ItemSwitch_GetItemFormatSize:
	push hl
	ld a, [wMenuData_ScrollingMenuItemFormat]
	ld c, a
	ld b, 0
	ld hl, .item_format_sizes
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	ret

.item_format_sizes:
; entries correspond to SCROLLINGMENU_ITEMS_* constants
	dw 0 ; unused
	dw 1 ; SCROLLINGMENU_ITEMS_NORMAL
	dw 2 ; SCROLLINGMENU_ITEMS_QUANTITY

ItemSwitch_BackwardsCopyBytes:
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret
