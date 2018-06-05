INCLUDE "constants.asm"

if DEBUG
SECTION "AddItemToInventory", ROM0[$3259]
else
SECTION "AddItemToInventory", ROM0[$321D]
endc

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
