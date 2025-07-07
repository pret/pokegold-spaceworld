INCLUDE "constants.asm"

SECTION "engine/items/item_prices_old.asm", ROMX

; This function is wildly out of date. It assumes wItemAttributesPointer uses either an early layout,
; or an updated version of Generation I's ItemPrices. The final game stores prices with the rest of
; the ItemAttributes anyway, so this function is pointless now.
; Stores item's price as BCD at hItemPrice_Old (3 bytes).
; Input: [wCurItem] = item id.
GetItemPrice_Old::
	ld hl, wItemAttributesPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurItem]
	cp ITEM_HM01_RED
	jr nc, .get_tm_price

	dec a
	ld c, a
	ld b, 0
rept 4 ; Appears to be an earlier length for ItemAttributes?
	add hl, bc
endr
	inc hl
	ld a, [hld]
	ldh [hItemPrice_Old + 2], a
	ld a, [hld]
	ldh [hItemPrice_Old + 1], a
	ld a, [hl]
	ldh [hItemPrice_Old], a
	jr .done

.get_tm_price
	call GetMachinePrice_Old
.done
	ld de, hItemPrice_Old
	ret

GetMachinePrice_Old:
	ld a, [wCurItem]
	sub ITEM_TM01_RED
	ret c ; HMs are priceless
	ld d, a
	ld hl, TechnicalMachinePrices_Old
	srl a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	srl d
	jr nc, .odd_numbered_machine
	swap a
.odd_numbered_machine
	and $f0
	ldh [hItemPrice_Old + 1], a
	xor a
	ldh [hItemPrice_Old], a
	ldh [hItemPrice_Old + 2], a
	ret

; In thousands (nybbles).
TechnicalMachinePrices_Old:
	nybble_array
	nybble 3 ; TM01
	nybble 2 ; TM02
	nybble 2 ; TM03
	nybble 1 ; TM04
	nybble 3 ; TM05
	nybble 4 ; TM06
	nybble 2 ; TM07
	nybble 4 ; TM08
	nybble 3 ; TM09
	nybble 4 ; TM10
	nybble 2 ; TM11
	nybble 1 ; TM12
	nybble 4 ; TM13
	nybble 5 ; TM14
	nybble 5 ; TM15
	nybble 5 ; TM16
	nybble 3 ; TM17
	nybble 2 ; TM18
	nybble 3 ; TM19
	nybble 2 ; TM20
	nybble 5 ; TM21
	nybble 5 ; TM22
	nybble 5 ; TM23
	nybble 2 ; TM24
	nybble 5 ; TM25
	nybble 4 ; TM26
	nybble 5 ; TM27
	nybble 2 ; TM28
	nybble 4 ; TM29
	nybble 1 ; TM30
	nybble 2 ; TM31
	nybble 1 ; TM32
	nybble 1 ; TM33
	nybble 2 ; TM34
	nybble 4 ; TM35
	nybble 2 ; TM36
	nybble 2 ; TM37
	nybble 5 ; TM38
	nybble 2 ; TM39
	nybble 4 ; TM40
	nybble 2 ; TM41
	nybble 2 ; TM42
	nybble 5 ; TM43
	nybble 2 ; TM44
	nybble 2 ; TM45
	nybble 4 ; TM46
	nybble 3 ; TM47
	nybble 4 ; TM48
	nybble 4 ; TM49
	nybble 2 ; TM50
	end_nybble_array NUM_TMS
