Unreferenced_Corrupt_DoItemEffect_Old:
	ld a, BANK(_DoItemEffect)
	ld hl, $67C4 ; Early location for _DoItemEffect
	jp Old_FarCallFunctionAddress

Unreferenced_Corrupt_CheckTossableItem_Old:
	push hl
	push de
	push bc
	ld hl, $53E5 ; Early location for _CheckTossableItem
	ld a, BANK(_CheckTossableItem)
	call Old_FarCallFunctionAddress
	pop bc
	pop de
	pop hl
	ret
