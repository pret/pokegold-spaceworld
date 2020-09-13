INCLUDE "constants.asm"

SECTION "engine/items/inventory.asm@Inventory", ROMX

_ReceiveItem: ; 03:4AA1
	call DoesHLEqualwNumBagItems
	jp nz, PutItemInPocket
	push hl
	callab CheckItemPocket
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	jp CallJumptable
	
.Pockets: ; 03:4ABA
	dw .Item
	dw .KeyItem
	dw .Ball
	dw .TMHM

.Item: ; 03:4AC2
	pop hl
	jp PutItemInPocket

.KeyItem: ; 03:4AC6
	pop hl
	jp ReceiveKeyItem

.Ball: ; 03:4ACA
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetBallIndex
	jp ReceiveBall

.TMHM: ; 03:4AD5
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetTMHMNumber
	jp ReceiveTMHM
	

_TossItem: ; 03:4AE0
	call DoesHLEqualwNumBagItems
	jr nz, .remove_item
	push hl
	callab CheckItemPocket
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	jp CallJumptable
	
.Pockets ; 03:4AF8
	dw .Item
	dw .KeyItem
	dw .Ball
	dw .TMHM
	
.Ball ; 03:4B00
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetBallIndex
	jp TossBall
	
.TMHM ; 03:4B0B
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetTMHMNumber
	jp TossTMHM
	
.KeyItem ; 03:4B16
	pop hl
	jp TossKeyItem
	
.Item ; 03:4B1A
	pop hl

.remove_item ; 03:4B1B
	jp RemoveItemFromPocket


_CheckItem: ; 03:4B1E
	call DoesHLEqualwNumBagItems
	jr nz, .not_bag
	push hl
	callab CheckItemPocket
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	jp CallJumptable
	
.Pockets ; 03:4B36
	dw .Item
	dw .KeyItem
	dw .Ball
	dw .TMHM
	
.Ball ; 03:4B3E
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetBallIndex
	jp CheckBall

.TMHM ; 03:4B49
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetTMHMNumber
	jp CheckTMHM
	
.KeyItem ; 03:4B54
	pop hl
	jp CheckKeyItems
	
.Item ; 03:4B58
	pop hl
	
.not_bag
	jp CheckTheItem


DoesHLEqualwNumBagItems: ; 03:4B5C
	ld a, l
	cp LOW(wNumBagItems)
	ret nz
	ld a, h
	cp HIGH(wNumBagItems)
	ret


PutItemInPocket: ; 03:4B64
	ld d, h
	ld e, l
	inc hl
	ld a, [wCurItem]
	ld c, a
	ld b, 0
	
; will add the item once the total
; available space (b) exceeds the
; amount being added
.loop
	ld a, [hli]
	cp -1
	jr z, .terminator
	cp c
	jr nz, .next
	ld a, 99
	sub [hl]
	add b
	ld b, a
	ld a, [wItemQuantity]
	cp b
	jr z, .can_add
	jr c, .can_add

.next
	inc hl
	jr .loop
	
.terminator
	call GetPocketCapacity
	ld a, [de]
	cp c
	jr c, .can_add
	
	and a
	ret
	
.can_add
	ld h, d
	ld l, e
	ld a, [wCurItem]
	ld c, a
	
.loop2
	inc hl
	ld a, [hli]
	cp a, -1
	jr z, .terminator2
	cp c
	jr nz, .loop2
	
	ld a, [wItemQuantity]
	add [hl]
	cp a, 100
	jr nc, .set_max
	ld [hl], a
	jr .done

; set this slot's quantity to 99,
; and keep iterating through list
; to add remaining amount
.set_max
	ld [hl], 99
	sub 99
	ld [wItemQuantity], a
	jr .loop2
	
.terminator2
	dec hl
	ld a, [wCurItem]
	ld [hli], a
	ld a, [wItemQuantity]
	ld [hli], a
	ld [hl], -1
	ld h, d
	ld l, e
	inc [hl]
	
.done
	scf
	ret

	
GetPocketCapacity: ; 03:4BC1
	ld c, MAX_ITEMS
	ld a, e
	cp a, LOW(wNumBagItems)
	jr nz, .not_bag
	ld a, d
	cp HIGH(wNumBagItems)
	ret z
	
.not_bag
	ld c, MAX_PC_ITEMS
	ret

	
RemoveItemFromPocket: ;03:4BCF
	ld d, h
	ld e, l
	inc hl
	ld a, [wItemIndex]
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	inc hl
	ld a, [wItemQuantity]
	ld b, a
	ld a, [hl]
	sub b
	jr c, .underflow
	
	ld [hl], a
	ld [wItemQuantityBuffer], a
	and a
	jr nz, .done
	
; if the remaining quantity is zero
; then erase the slot by shifting
; the subsequent data upwards
	dec hl
	ld b, h
	ld c, l
	inc hl
	inc hl
	
.loop
	ld a, [hli]
	ld [bc], a
	inc bc
	cp -1
	jr nz, .loop
	ld h, d
	ld l, e
	dec [hl]
	
.done
	scf
	ret
	
.underflow
	and a
	ret
	
	
CheckTheItem: ; 03:4BFD
	ld a, [wCurItem]
	ld c, a
	
.loop
	inc hl
	ld a, [hli]
	cp -1
	jr z, .fail
	cp c
	jr nz, .loop
	
	scf
	ret
	
.fail
	and a
	ret

	
ReceiveKeyItem: ; 03:4C0E
	ld hl, wNumKeyItems
	ld a, [hli]
	cp a, MAX_KEY_ITEMS
	jr nc, .full_pack
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurItem]
	ld [hli], a
	ld [hl], -1
	ld hl, wNumKeyItems
	inc [hl]
	scf
	ret
	
.full_pack
	and a
	ret
	
	
TossKeyItem: ; 03:4C28
	ld hl, wNumKeyItems
	dec [hl]
	inc hl
	ld a, [wItemIndex]
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	inc hl
	
; erase this item by shifting
; all subsequent data upwards
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr nz, .loop
	scf
	ret
	
	
CheckKeyItems: ; 03:4C40
	ld a, [wCurItem]
	ld c, a
	ld hl, wKeyItems
	
.loop
	ld a, [hli]
	cp c
	jr z, .done
	cp -1
	jr nz, .loop

	and a
	ret
	
.done
	scf
	ret
	
	
; get index of ball item id c from BallItems
GetBallIndex: ; 03:4C53
	ld a, c
	push hl
	push de
	push bc
	ld hl, BallItems
	ld de, 1
	call FindItemInTable
	ld a, b
	pop bc
	pop de
	pop hl
	ld c, a
	ret
	
	
; get ball item id at index c in BallItems
GetBallByIndex: ; 03:4c66
	push bc
	push hl
	ld b, 0
	ld hl, BallItems
	add hl, bc
	ld a, [hl]
	pop hl
	pop bc
	ld c, a
	ret
	
	
BallItems: ; 03:4C73
	db ITEM_MASTER_BALL
	db ITEM_ULTRA_BALL
	db ITEM_GREAT_BALL
	db ITEM_POKE_BALL
	db -1


; empties the ball pocket by setting the
; terminator immediately after wNumBallItems

	; Note, the ball pocket appears to be
	; a fixed length, not -1 terminated
EmptyBallPocket: ; 03:4C78
	ld hl, wNumBallItems
	xor a
	ld [hli], a
	ld [hl], -1
	ret
	

ReceiveBall: ; 03:4C80
	ld hl, wBallQuantities
	ld b, 0
	add hl, bc
	ld a, [wItemQuantity]
	add [hl]
	cp 100
	jr nc, .overflow
	ld b, a
	ld a, [hl]
	and a
	jr nz, .done
	
; increase the ball pocket size if
; this ball's previous quantity was 0
	ld a, [wNumBallItems]
	inc a
	ld [wNumBallItems], a
	
.done
	ld [hl], b
	scf
	ret
	
.overflow
	and a
	ret
	

TossBall: ; 03:4C9F
	ld hl, wBallQuantities
	ld b, 0
	add hl, bc
	ld a, [wItemQuantity]
	ld b, a
	ld a, [hl]
	sub b
	jr c, .underflow
	jr nz, .done
	
; increase the ball pocket size if
; this ball's new quantity is 0
	ld b, a
	ld a, [wNumBallItems]
	dec a
	ld [wNumBallItems], a
	ld a, b
	
.done
	ld [hl], a
	ld [wItemQuantityBuffer], a
	scf
	ret
	
.underflow
	and a
	ret
	
	
CheckBall: ; 03:4CC0
	ld hl, wBallQuantities
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	ret z
	scf
	ret

	
ReceiveTMHM: ; 03:4CCB
	ld b, 0
	ld hl, wTMsHMs
	add hl, bc
	ld a, [wItemQuantity]
	add [hl]
	cp 100
	jr nc, .overflow
	ld [hl], a
	scf
	ret
	
.overflow
	and a
	ret
	
	
TossTMHM: ; 03:4CDE
	ld b, 0
	ld hl, wTMsHMs
	add hl, bc
	ld a, [wItemQuantity]
	ld b, a
	ld a, [hl]
	sub b
	jr c, .underflow
	
	ld [hl], a
	ld [wItemQuantityBuffer], a
	scf
	ret

.underflow
	and a
	ret

	
CheckTMHM: ; 03:4CF4
	ld b, 0
	ld hl, wTMsHMs
	add hl, bc
	ld a, [hl]
	and a
	ret z
	scf
	ret

GetTMHMNumber: ; 03:4CFF
	ld a, c
	ld c, 0
	
	sub ITEM_TM01
	jr c, .not_machine
	
	cp ITEM_C8 - ITEM_TM01
	jr z, .not_machine
	jr c, .finish
	
	inc c
	cp ITEM_E1 - ITEM_TM01
	jr z, .not_machine
	
	jr c, .finish
	inc c

; c represents the amount of non-TMs which
; appear ahead of this item in the list
; so subtract that value before exiting
.finish
	sub c
	ld c, a
	scf
	ret
	
.not_machine
	and a
	ret

GetNumberedTMHM: ; 03:4D1A
; Return the item id of a TM/HM by number c.
	ld a, c
	ld c, 0
; Adjust for any dummy items.
	cp ITEM_C8 - ITEM_TM01 ; TM01-04
	jr c, .finish
	inc c
	cp ITEM_E1 - ITEM_TM01 - 1 ; TM05-28
	jr c, .finish
	inc c
	cp ITEM_FF - ITEM_TM01 - 2 ; End of list
	jr nc, .not_machine
.finish
	add c
	add ITEM_TM01
	ld c, a
	scf
	ret
.not_machine
	and a
	ret

SECTION "engine/items/inventory.asm@GetItemAmount", ROMX

; Returns carry if user has the item
; and the amount in b
GetItemAmount: ; 03:4e10
	call CheckAmountInItemPocket
	ret c
	call CheckAmountInKeyItems
	ret c
	ld b, 0
	and a
	ret
	
; Returns the amount of item b in b
CheckAmountInItemPocket: ; 03:4E1C
	ld hl, wItems
.loop
	inc hl
	ld a, [hli]
	cp -1
	ret z
	cp b
	jr nz, .loop

	ld a, [hl]
	ld b, a
	scf
	ret

; Returns the amount of item b in b
CheckAmountInKeyItems: ; 03:4E2B
	ld hl, wNumKeyItems
	ld a, [hli]
	and a
	ret z

.loop
	ld a, [hli]
	cp -1
	ret z
	cp b
	jr nz, .loop
	ld b, 1
	scf
	ret
	
SECTION "engine/items/inventory.asm@_CheckTossableItem", ROMX

; Return 1 in wItemAttributeParamBuffer and
; carry if wCurItem can't be removed from the bag.
_CheckTossableItem: ; 03:53AD
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_TOSS_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

; Return 1 in wItemAttributeParamBuffer
; and carry if wCurItem can't be selected.
CheckSelectableItem: ; 03:53B8
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_SELECT_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

; Return the pocket for wCurItem in wItemAttributeParamBuffer.
CheckItemPocket: ; 03:53C3
	ld a, ITEMATTR_POCKET
	call GetItemAttr
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

; Return the context for wCurItem in wItemAttributeParamBuffer.
CheckItemContext: ; 03:53CE
	ld a, ITEMATTR_HELP
	call GetItemAttr
	and $f
	ld [wItemAttributeParamBuffer], a
	ret

; Return the menu for wCurItem in wItemAttributeParamBuffer.
CheckItemMenu: ; 03:53D9
	ld a, ITEMATTR_HELP
	call GetItemAttr
	swap a
	and $f
	ld [wItemAttributeParamBuffer], a
	ret
	
; Get attribute a of wCurItem.
GetItemAttr: ; 03:53E6
	push hl
	push bc
	ld hl, ItemAttributes
	ld c, a
	ld b, 0
	add hl, bc
	xor a
	ld [wItemAttributeParamBuffer], a
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

ItemAttr_ReturnCarry: ; 03:5405
	ld a, 1
	ld [wItemAttributeParamBuffer], a
	scf
	ret
	
; Return the price of wCurItem in de.
GetItemPrice: ; 03:540C
	push hl
	push bc
	ld a, ITEMATTR_PRICE
	call GetItemAttr
	ld e, a
	ld a, ITEMATTR_PRICE_HI
	call GetItemAttr
	ld d, a
	pop bc
	pop hl
	ret
