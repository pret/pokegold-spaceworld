; Returns carry if user has the item
; and the amount in b
GetItemAmount:
	call CheckAmountInItemPocket
	ret c
	call CheckAmountInKeyItems
	ret c
	ld b, 0
	and a
	ret

; Returns the amount of item b in b
CheckAmountInItemPocket:
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
CheckAmountInKeyItems:
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
