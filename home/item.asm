INCLUDE "constants.asm"

SECTION "home/item.asm", ROM0

DoItemEffect::
	farjp _DoItemEffect

CheckTossableItem::
	push hl
	push de
	push bc
	callfar _CheckTossableItem
	pop bc
	pop de
	pop hl
	ret

SECTION "home/item.asm@TossItem", ROM0

TossItem:
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

SECTION "home/item.asm@GiveItem", ROM0

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
	call ReceiveItem
	ret nc
	call GetItemName
	call CopyStringToStringBuffer2
	scf
	ret

GiveMonToPlayer::
; Give to the player Pokemon of species b at level c.
	ld a, b
	ld [wCurPartySpecies], a
	ld a, c
	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a
	farjp _AddEnemyMonToPlayerParty

SECTION "home/item.asm@Call_GetItemAmount", ROM0

Call_GetItemAmount::
	predef GetItemAmount
	ld a, b
	and a
	ret
