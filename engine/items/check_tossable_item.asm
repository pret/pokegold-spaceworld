; Return 1 in wItemAttributeValue and
; carry if wCurItem can't be removed from the bag.
_CheckTossableItem::
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_TOSS_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

; Return 1 in wItemAttributeValue
; and carry if wCurItem can't be selected.
CheckSelectableItem:
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_SELECT_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

; Return the pocket for wCurItem in wItemAttributeValue.
CheckItemPocket:
	ld a, ITEMATTR_POCKET
	call GetItemAttr
	and $f
	ld [wItemAttributeValue], a
	ret

; Return the context for wCurItem in wItemAttributeValue.
CheckItemContext:
	ld a, ITEMATTR_HELP
	call GetItemAttr
	and $f
	ld [wItemAttributeValue], a
	ret

; Return the menu for wCurItem in wItemAttributeValue.
CheckItemMenu:
	ld a, ITEMATTR_HELP
	call GetItemAttr
	swap a
	and $f
	ld [wItemAttributeValue], a
	ret

; Get attribute a of wCurItem.
GetItemAttr:
	push hl
	push bc
	ld hl, ItemAttributes
	ld c, a
	ld b, 0
	add hl, bc
	xor a
	ld [wItemAttributeValue], a
	ld a, [wCurItem]
	dec a
	ld c, a
	ld a, ITEMATTR_STRUCT_LENGTH
	call AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarByte
	pop bc
	pop hl
	ret

ItemAttr_ReturnCarry:
	ld a, 1
	ld [wItemAttributeValue], a
	scf
	ret

; Return the price of wCurItem in de.
GetItemPrice:
	push hl
	push bc
	ld a, ITEMATTR_PRICE_LO
	call GetItemAttr
	ld e, a
	ld a, ITEMATTR_PRICE_HI
	call GetItemAttr
	ld d, a
	pop bc
	pop hl
	ret

Unreferenced_TossItem_Old:
	push hl
	call Unused_IsKeyItem_Old
	ld a, [wItemAttributeValue]
	and a
	jr nz, .cant_toss

	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld hl, .ItemsThrowAwayText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr c, .cancel

	ld a, [wItemIndex]
	pop hl
	call TossItem
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld hl, .ItemsDiscardedText
	call MenuTextBox
	call CloseWindow

	and a
	ret

.cant_toss
	ld hl, .ItemsTooImportantText
	call MenuTextBox
	call CloseWindow
.cancel
	pop hl
	scf
	ret

.ItemsDiscardedText:
	text_from_ram wStringBuffer1
	text "を" ; "Threw away"
	line "すてました！" ; "(item?)!"
	prompt

.ItemsThrowAwayText:
	text_from_ram wStringBuffer2
	text "を　すてます" ; "Are you sure you want"
	line "ほんとに　よろしいですか？" ; "to throw (item?) away?"
	prompt

.ItemsTooImportantText:
	text "それは　とても　たいせつなモノです" ; "You can't throw away"
	line "すてることは　できません！" ; "something that special!"
	prompt

Unused_IsKeyItem_Old:
	push hl
	push bc
	ld a, 1
	ld [wItemAttributeValue], a
	ld a, [wCurItem]
	cp ITEM_HM01_RED
	jr nc, .check_if_hm
	ld hl, ItemAttributes + ITEMATTR_PERMISSIONS
	dec a
	ld c, a
	ld b, 0
rept 5
	add hl, bc
endr
	ld a, BANK(ItemAttributes)
	call GetFarByte
	bit 0, a
	jr nz, .cant_toss
	jr .can_toss

.check_if_hm
	ld a, [wCurItem]
	call IsHM
	jr c, .cant_toss

.can_toss
	xor a
	ld [wItemAttributeValue], a
.cant_toss
	pop bc
	pop hl
	ret
