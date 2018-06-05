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
	ld [wce37], a
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

if DEBUG
SECTION "GetItemName", ROM0[$376F]
else
SECTION "GetItemName", ROM0[$3733]
endc

GetItemName:: ; 376F
; given an item ID at [wce37], store the name of the item into a string
; starting at wcd26
	push hl
	push bc
	ld a, [wce37]
	cp ITEM_HM01_RED
	jr nc, .machine

	ld [wcb5b], a
	ld a, ITEM_NAME
	ld [wNameCategory], a
	call GetName
	jr .finish

.machine
    call GetMachineName
.finish
	ld de, wcd26 ; pointer to where item name is stored in RAM
	pop bc
	pop hl
	ret

if DEBUG
SECTION "GetMachineName", ROM0[$378E]
else
SECTION "GetMachineName", ROM0[$3752]
endc

GetMachineName::
; copies the name of the TM/HM in [wce37] to wcd26
	push hl
	push de
	push bc
	ld a, [wce37]
	push af
	cp ITEM_TM01_RED
	jr nc, .WriteTM
; if HM, then write "HM" and add 5 to the item ID, so we can reuse the
; TM printing code
	add 5
	ld [wce37], a
	ld hl, HiddenPrefix
	ld bc, 6
	jr .WriteMachinePrefix
.WriteTM
	ld hl, TechnicalPrefix
	ld bc, 5
.WriteMachinePrefix
	ld de, wcd26
	call CopyBytes
; now get the machine number and convert it to text
	ld a, [wce37]
	sub ITEM_TM01_RED - 1
	ld b, "０"
.FirstDigit
	sub 10
	jr c, .SecondDigit
	inc b
	jr .FirstDigit
.SecondDigit
	add 10
	push af
	ld a, b
	ld [de], a
	inc de
	pop af
	ld b, "０"
	add b
	ld [de], a
	inc de
	ld a, "@"
	ld [de], a
	pop af
	ld [wce37], a
	pop bc
	pop de
	pop hl
	ret

TechnicalPrefix:
	db "わざマシン@"

HiddenPrefix:
	db "ひでんマシン@"
