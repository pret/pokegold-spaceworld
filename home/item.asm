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
