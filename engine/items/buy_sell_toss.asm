INCLUDE "constants.asm"

SECTION "engine/items/buy_sell_toss.asm", ROMX

SelectQuantityToToss::
	ld hl, TossItem_MenuHeader
	call LoadMenuHeader
	call Toss_Sell_Loop
	ret

SelectQuantityToBuy::
	callfar GetItemPrice
	ld a, d
	ld [wBuySellItemPrice], a
	ld a, e
	ld [wBuySellItemPrice + 1], a
	ld hl, BuyItem_MenuHeader
	call LoadMenuHeader
	call Toss_Sell_Loop
	ret

Toss_Sell_Loop:
	ld a, 1
	ld [wItemQuantity], a
.preloop
; It won't progress if you're holding the A Button...
	call GetJoypad
	ldh a, [hJoyState]
	bit A_BUTTON_F, a
	jr nz, .preloop

.loop
	call BuySellToss_UpdateQuantityDisplayAndPrice
	call BuySellToss_InterpretJoypad
	jr nc, .loop
	cp -1
	jr nz, .nope ; pressed B
	scf
	ret

.nope
	and a
	ret

BuySellToss_InterpretJoypad:
.loop
	call DelayFrame
	ldh a, [hInMenu]
	push af
	ld a, 1
	ldh [hInMenu], a
	call GetJoypadDebounced
	pop af
	ldh [hInMenu], a

	ldh a, [hJoyDown]
	bit B_BUTTON_F, a
	jr nz, .b
	bit A_BUTTON_F, a
	jr nz, .a

	ldh a, [hJoySum]
	bit D_DOWN_F, a
	jr nz, .down
	bit D_UP_F, a
	jr nz, .up
	bit D_LEFT_F, a
	jr nz, .left
	bit D_RIGHT_F, a
	jr nz, .right
	jr .loop
.b
	ld a, -1
	scf
	ret

.a
	scf
	ret

.down
	ld hl, wItemQuantity
	dec [hl]
	jr nz, .finish_down
	ld a, [wItemQuantityBuffer]
	ld [hl], a

.finish_down
	and a
	ret

.up
	ld hl, wItemQuantity
	inc [hl]
	ld a, [wItemQuantityBuffer]
	cp [hl]
	jr nc, .finish_up
	ld [hl], 1

.finish_up
	and a
	ret

.left
	ld a, [wItemQuantity]
	sub 10
	jr c, .load_1
	jr z, .load_1
	jr .finish_left

.load_1
	ld a, 1

.finish_left
	ld [wItemQuantity], a
	and a
	ret

.right
	ld a, [wItemQuantity]
	add 10
	ld b, a
	ld a, [wItemQuantityBuffer]
	cp b
	jr nc, .finish_right
	ld b, a

.finish_right
	ld a, b
	ld [wItemQuantity], a
	and a
	ret

BuySellToss_UpdateQuantityDisplayAndPrice:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld [hl], '×'
	inc hl
	ld de, wItemQuantity
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	ld a, [wMenuDataPointer]
	cp -1
	ret nz

	xor a
	ldh [hMultiplicand], a
	ld a, [wBuySellItemPrice]
	ldh [hMultiplicand + 1], a
	ld a, [wBuySellItemPrice + 1]
	ldh [hMultiplicand + 2], a
	ld a, [wItemQuantity]
	ldh [hMultiplier], a
	push hl
	call Multiply

	ld hl, hMoneyTemp
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl
	inc hl
	ld de, hMoneyTemp
	lb bc, 4, 6
	call PrintNumber
	ld [hl], '円'
	call WaitBGMap
	ret

TossItem_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 15, 9, $13, 11
	dw NULL
	db 0

BuyItem_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 15, $13, $11
	dw $ff
	db $ff
