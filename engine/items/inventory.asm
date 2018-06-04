INCLUDE "constants.asm"

SECTION "AddItemToInventory_", ROMX[$4AA1], BANK[$03]

_ReceiveItem: ; 03:4AA1
	call DoesHLEqualwNumBagItems
	jp nz, PutItemInPocket ; not bag (so it's the pc)
	push hl
	ld hl, CheckItemPocket
	ld a, BANK( CheckItemPocket )
	call FarCall_hl
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
	call GetBallIndex ; get the index of the ball being added
	jp ReceiveBall ; increase the quantity at that index

.TMHM: ; 03:4AD5
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetTMHMNumber
	jp ReceiveTMHM
	
_TossItem: ; 03:4AE0
	call DoesHLEqualwNumBagItems
	jr nz, .removeItem
	push hl
	ld hl, CheckItemPocket
	ld a, BANK( CheckItemPocket )
	call FarCall_hl
	ld a, [wItemAttributeParamBuffer]
	dec a
	ld hl, .Pockets
	jp CallJumptable
	
.Pockets ; 03:4AF8
	dw .Item
	dw .KeyItem
	dw .Ball
	dw .TMHM
	
.Ball
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetBallIndex
	jp TossBall
	
.TMHM
	pop hl
	ld a, [wCurItem]
	ld c, a
	call GetTMHMNumber
	jp TossTMHM
	
.KeyItem
	pop hl
	jp TossKeyItem
	
.Item
	pop hl

.removeItem
	jp RemoveItemFromPocket

SECTION "DoesHLEqualwNumBagItems", ROMX[$4B5C], BANK[$03]
	
; Zero flag is set if hl = wNumBagItems
DoesHLEqualwNumBagItems: ; 03:4B5C
	ld a, l
	cp LOW(wNumBagItems)
	ret nz
	ld a, h
	cp HIGH(wNumBagItems)
	ret

PutItemInPocket: ; 03:4B64
	ld d, h
	ld e, l ; de = pc inventory address
	inc hl
	ld a, [wCurItem]
	ld c, a
	ld b, 0
	
.findItemLoop
	ld a, [hli]
	cp $FF ; was the end of the list reached?
	jr z, .checkIfInventoryFull ; if so, check if it can be added to the end
	cp c ; does the item match?
	jr nz, .checkNextItem ; if not, move to the next item
	ld a, 99 ; max amount of an item
	sub [hl] ; subtract the current amount of items, so a = max number that can be added
	add b ; ? why is this done? b = 0
	ld b, a ; b = max number of items which can be added
	ld a, [wItemQuantity]
	cp b ; compare the to-add quantity to the max quantity
	jr z, .itemCanBeAdded  ; if the number is equal, then add the item
	jr c, .itemCanBeAdded  ; if the number is less than the max, then add the item

.checkNextItem
	inc hl ; move to the next item in the list
	jr .findItemLoop
	
.checkIfInventoryFull
	call GetPocketCapacity
	ld a, [de] ; get the current size of the inventory
	cp c ; compare to the maximum
	jr c, .itemCanBeAdded ; if its not at the maximum, then an item can be added
	and a ; unset the carry flag to indicate failure
	ret
	
.itemCanBeAdded
	ld h, d
	ld l, e ; hl = address of start of pocket
	ld a, [wCurItem]
	ld c, a ; c = item id
	
.findItemToAddLoop
	inc hl
	ld a, [hli]
	cp a, $FF ; was the end of the list reached?
	jr z, .addNewItem ; if so, add the item to the end
	cp c ; is this the item to add?
	jr nz, .findItemToAddLoop ;if not, then move to the next item
	
	ld a, [wItemQuantity]
	add [hl] ; a = new item quantity
	cp a, 100 ; does it exceed 99?
	jr nc, .setMax ; if it exceeds, then only increase quantity to the max
	ld [hl], a ; store the new item quantity
	jr .success

; set the inventory quantity to 99, and then add the remainder to the list
.setMax
	ld [hl], 99 ; set the quantity to be the maximum
	sub 99 ; a = remaining quantity
	ld [wItemQuantity], a ; update the item quantity
	jr .findItemToAddLoop ; continue iterating through the list
	
; add the item to the end of the list
.addNewItem
	dec hl
	ld a, [wCurItem]
	ld [hli], a ; store the id
	ld a, [wItemQuantity]
	ld [hli], a ; store the quantity
	ld [hl], $FF ; add the terminator
	ld h, d
	ld l, e ; hl = inventory size
	inc [hl] ; increase the size
.success
	scf ; set the carry flag to indicate success
	ret

; Store the inventory size into c
GetPocketCapacity: ; 03:4BC1
	ld c, MAX_ITEMS
	ld a, e
	cp a, LOW(wNumBagItems)
	jr nz, .notBag
	ld a, d
	cp HIGH(wNumBagItems)
	ret z
.notBag
	ld c, MAX_PC_ITEMS
	ret
	
RemoveItemFromPocket: ;03:4BCF
	ld d, h
	ld e, l
	inc hl ; hl = start of item list
	ld a, [wItemIndex]
	ld c, a ; c = item index
	ld b, 0
	add hl, bc
	add hl, bc ; hl = address of item at given index
	inc hl
	ld a, [wItemQuantity]
	ld b, a ; b = to-remove amount
	ld a, [hl] ; a = current amount
	sub b ; a = new amount
	jr c, .fail ; if trying to remove too many, then fail
	
	ld [hl],a ; store new amount
	ld [wItemQuantityBuffer], a
	and a ; is the new amount 0?
	jr nz, .success ; if not, then dont shift items upwards
	
	dec hl
	ld b, h
	ld c, l ; bc = item to remove
	inc hl
	inc hl ; hl = next item in list
	
.shift
	ld a, [hli]
	ld [bc], a
	inc bc ; overwrite the previous item value with the next item value
	cp $FF ; reached the end of the list?
	jr nz, .shift ; if not, shift the next row
	
	ld h, d
	ld l, e ; hl = inventory size
	
	dec [hl] ; decrease the inventory size
	
.success
	scf ; set carry flag to indicate success
	ret
	
.fail
	and a ; unset carry flag to indicate fail
	ret
	
; sets carry flag if item is in the list
CheckTheItem: ; 03:4BFD
	ld a, [wCurItem]
	ld c, a
	
.loop
	inc hl
	ld a, [hli] ; a = next item in list
	cp $FF ; is it the terminator?
	jr z, .fail ; if so, then fail
	cp c ; is it the item?
	jr nz, .loop ; if not, check the next item
	
	scf ; set carry flag to indicate success
	ret
	
.fail
	and a ; unset carry flag to indicate fail
	ret

ReceiveKeyItem: ; 03:4C0E
	ld hl, wNumKeyItems
	ld a, [hli] ; a = size of bag
	cp a, MAX_KEY_ITEMS ; is the bag full
	jr nc, .fail ; then fail
	ld c, a
	ld b, 0
	add hl, bc ; hl = address to store the item, end if the list
	ld a, [wCurItem]
	ld [hli], a ; store item ID
	ld [hl], $FF ; store terminator
	ld hl, wNumKeyItems
	inc [hl] ; increase the inventory size
	scf ; set the carry flag to indicate success
	ret
	
; unset the carry flag to indicate failure
.fail
	and a
	ret
	
; Remove key item with list index of wItemIndex
TossKeyItem: ; 03:4C28
	ld hl, wNumKeyItems
	dec [hl] ; decrease the size
	inc hl
	ld a, [wItemIndex]
	ld e, a
	ld d, 0
	add hl, de ; hl = address of item to remove
	ld d, h
	ld e, l ; store hl into de
	inc hl
	
.shift
	ld a, [hli]
	ld [de], a ; shift item up one slot
	inc de
	cp $FF ; end of list reached?
	jr nz, .shift ; shift the next item if not
	
	scf
	ret
	
; Checks to see if the given item is in D1C8
; carry = item is in list
CheckKeyItems: ; 03:4C40
	ld a, [wCurItem]
	ld c, a ; c = item id
	ld hl, wKeyItems
	
.loop
	ld a, [hli] ; a = next item in list
	cp c ; does it match the input item?
	jr z, .matchFound ; if so, set the carry flag
	cp $FF ; was the end of the list reached?
	jr nz, .loop ; if not, go to the next item
	
	and a
	ret
	
.matchFound
	scf
	ret
	
; Returns the index of the given item in the Ball Items List
; Input:
; c = item to search for
; Output:
; c = index of item in table
GetBallIndex: ; 03:4C53
	ld a, c
	push hl
	push de
	push bc
	ld hl, BallItems
	ld de, 1 ; size of each row in the table
	call FindItemInTable
	ld a, b ; store the row index into a
	pop bc
	pop de
	pop hl
	ld c, a ; store the row index to c
	ret
	
; Returns the item at the given index in the Ball Items List
; Inputs:
; c = index in table
; Outputs:
; c = value in table
GetBallByIndex: ; 03:4c66
	push bc
	push hl
	ld b, 0
	ld hl, BallItems
	add hl, bc ; hl = address of row in table
	ld a, [hl] ; a = item at that index
	pop hl
	pop bc
	ld c, a ; c = item at that index
	ret
	
BallItems: ; 03:4C73
	db ITEM_MASTER_BALL
	db ITEM_ULTRA_BALL
	db ITEM_GREAT_BALL
	db ITEM_POKE_BALL
	db $FF
	

; To empty out the ball pocket
; TODO - Is this buggy?
; The ball pocket just is a set length, not $FF terminated
EmptyBallPocket: ; 03:4C78
	ld hl, wNumBallItems
	xor a
	ld [hli], a ; set size to 0
	ld [hl], $FF ; add terminator
	ret
	
; The Ball pocket is just a list of quantities, which directly map to BallItems
; c = item index in table
; wItemQuantity = amount to add
; Sets carry flag if successful
ReceiveBall: ; 03:4C80
	ld hl, wBallQuantities
	ld b, 0
	add hl, bc ; hl = address of item quantity in table
	ld a, [wItemQuantity]
	add [hl] ; add the current item quantity to the to-add quantity
	cp 100 ; does it exceed 99?
	jr nc, .fail ; if so, fail
	ld b, a ; b = new quantity
	ld a, [hl] ; a = old quantity
	and a ; is old quantity zero?
	jr nz, .dontIncreaseInventorySize ; if not, dont increase the inventory size
	ld a, [wNumBallItems]
	inc a
	ld [wNumBallItems], a ; increase the inventory size
	
.dontIncreaseInventorySize
	ld [hl], b ; store the new quantity
	scf ; set the carry flag to indicate success
	ret
	
.fail
	and a ; unset the carry flag to indicate failure
	ret
	
; Inputs:
; c = index of item in table
; wItemQuantity = amount to remove
; Sets carry flag if successful
TossBall: ; 03:4C9F
	ld hl, wBallQuantities
	ld b, 0
	add hl, bc ; hl = index for this item
	ld a, [wItemQuantity]
	ld b, a ; b = to-remove quantity
	ld a, [hl] ; a = old quantity 
	sub b ; a = new quantity
	jr c, .fail ; if to-remove exceeds the current quantity, then fail
	jr nz, .dontDecreaseInventorySize ; if the new quantity is not 0, then dont decrease the inventory size
	ld b, a
	ld a, [wNumBallItems]
	dec a
	ld [wNumBallItems], a ; decrease the inventory size
	ld a, b
	
.dontDecreaseInventorySize
	ld [hl], a ; store the new quantity
	ld [wItemQuantityBuffer], a
	scf ; set carry flag to indicate success
	ret
	
.fail
	and a ; unset the carry flag to indicate fail
	ret
	
; Inputs
; c = index of item
; Outputs
; carry if item is in list
CheckBall: ; 03:4CC0
	ld hl, wBallQuantities
	ld b, 0
	add hl, bc ; hl = address of item quantity
	ld a, [hl] ; get the quantity for this item
	and a
	ret z
	scf
	ret

; Inputs:
; c = TMHM index
; carry if success
ReceiveTMHM: ; 03:4CCB
	ld b, 0
	ld hl, wTMsHMs
	add hl, bc ; hl = address of TMHM quantity
	ld a, [wItemQuantity] ; a = quantity to add
	add [hl] ; a = new item quantity
	cp 100 ; does it exceed 99?
	jr nc, .fail ; if so, fail
	ld [hl], a ; store the new quantity
	scf ; set carry flag to indicate success
	ret
	
.fail
	and a ; unset carry flag to indicate failure
	ret
	
TossTMHM: ; 03:4CDE
	ld b, 0
	ld hl, wTMsHMs
	add hl, bc
	ld a, [wItemQuantity]
	ld b, a ; b = amount to remove
	ld a, [hl] ; a = current amount
	sub b ; get the new amount
	jr c, .fail ; if the amount to remove exceeds the current amount, then fail
	ld [hl], a ; store the new item count
	ld [wItemQuantityBuffer], a
	
	scf ; set carry flag to indicate success
	ret

.fail
	and a ; unset carry flag to indicate failure
	ret

CheckTMHM: ; 03:4CF4
; Returns whether or not inventory contains TMHM in c
	ld b, 0
	ld hl, wTMsHMs
	add hl, bc
	ld a, [hl]
	and a
	ret z
	scf
	ret

GetTMHMNumber: ; 03:4CFF
; Return the item id of a TM/HM by number c.
	ld a, c
	ld c, 0 ; initialize the non-TM count to 0
	
	sub ITEM_TM01 ; a = TM index (if TM)
	jr c, .notMachine
	cp ITEM_C8 - ITEM_TM01 ; is the item ITEM_C8 ?
	jr z, .notMachine ; If so, fail
	jr c, .finish ; If the TM index is below, then finish
	
	inc c ; increase the non-TM count
	cp ITEM_E1 - ITEM_TM01 ; is the item ITEM_E1?
	jr z, .notMachine ; if so, fail
	
	jr c, .finish ; If the TM index is below, then finish
	inc c ; otherwise, increase the non-TM count

.finish
	sub c ; subtract the amount of non TM-items that appear before this to get the true TM index
	ld c, a ; store into c
	
	scf ; set the carry flag to indicate success
	ret
	
.notMachine
	and a ; unset the carry flag to indicate failure
	ret
	
SECTION "_CheckTossableItem", ROMX[$53AD], BANK[$03]

_CheckTossableItem:: ; 03:53AD
; Return 1 in wItemAttributeParamBuffer and carry if wCurItem can't be removed from the bag.
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_TOSS_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

CheckSelectableItem: ; 03:53B8
; Return 1 in wItemAttributeParamBuffer and carry if wCurItem can't be selected.
	ld a, ITEMATTR_PERMISSIONS
	call GetItemAttr
	bit CANT_SELECT_F, a
	jr nz, ItemAttr_ReturnCarry
	and a
	ret

CheckItemPocket: ; 03:53C3
; Return the pocket for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_POCKET
	call GetItemAttr
	and $0F
	ld [wItemAttributeParamBuffer], a
	ret

CheckItemContext: ; 03:53CE
; Return the context for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_HELP
	call GetItemAttr
	and $0F
	ld [wItemAttributeParamBuffer], a
	ret

CheckItemMenu: ; 03:53D9
; Return the menu for wCurItem in wItemAttributeParamBuffer.
	ld a, ITEMATTR_HELP
	call GetItemAttr
	swap a
	and $f
	ld [wItemAttributeParamBuffer], a
	ret
	
GetItemAttr: ; 03:53E6
; Get attribute a of wCurItem.
	push hl
	push bc
	
	ld hl, ItemAttributes
	ld c, a ; c = item data byte index to retrieve
	ld b, 0
	add hl, bc ; hl = address for item
	
	xor a
	ld [wItemAttributeParamBuffer], a ; set the item param value to 0
	
	ld a, [wCurItem] ; a = item id
	dec a
	ld c, a ; c = item id - 1
	ld a, ITEMATTR_STRUCT_LENGTH ; size of each item attribute data set
	call AddNTimes ; Go to the row for this item
	
	ld a, BANK( ItemAttributes )
	call GetFarByte ; Get the byte from the table
	
	pop bc
	pop hl
	ret

ItemAttr_ReturnCarry: ; 03:5405
	ld a, 1
	ld [wItemAttributeParamBuffer], a
	scf
	ret
	
GetItemPrice: ; 03:540C
; Return the price of wCurItem in de.
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