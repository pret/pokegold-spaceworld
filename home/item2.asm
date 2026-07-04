TossItem::
	ldh a, [hROMBank]
	push af
	ld a, BANK(_TossItem)
	call Bankswitch
	push hl
	push de
	push bc
	call _TossItem
	pop bc
	pop de
	pop hl
	pop af
	call Bankswitch
	ret

ReceiveItem::
; function to add an item (in varying quantities) to the player's bag or PC box
; INPUT:
; HL = address of inventory (either wNumBagItems or wNumBoxItems)
; [wCurItem] = item ID
; [wItemQuantity] = item quantity
; sets carry flag if successful, unsets carry flag if unsuccessful
	push bc
	ldh a, [hROMBank]
	push af
	ld a, BANK(_ReceiveItem)
	call Bankswitch
	push hl
	push de
	call _ReceiveItem
	pop de
	pop hl
	pop bc
	ld a, b
	call Bankswitch
	pop bc
	ret
