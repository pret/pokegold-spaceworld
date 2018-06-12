INCLUDE "constants.asm"

if DEBUG
SECTION "AddOrRemoveItemToInventory", ROM0[$3243]
else
SECTION "AddOrRemoveItemToInventory", ROM0[$3207]
endc

RemoveItemFromInventory:: ; 3243
; function to remove an item (in varying quantities) to the player's bag or PC box
; INPUT:
; HL = address of inventory (either wNumBagItems or wNumBoxItems)
; [wCurItem] = item ID
; [wItemQuantity] = item quantity
; success state is not returned
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

AddItemToInventory:: ; 3259
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

if DEBUG
SECTION "GiveItem", ROM0[$366C]
else
SECTION "GiveItem", ROM0[$3630]
endc

GiveItem::
; Give player quantity c of item b,
; and copy the item's name to wcf4b.
; Return carry on success.
	ld a, b
	ld [wNamedObjectIndexBuffer], a
	ld [wCurItem], a
	ld a, c
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call AddItemToInventory
	ret nc
	call GetItemName
	call CopyStringToCD31
	scf
	ret
