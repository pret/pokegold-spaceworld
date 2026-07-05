GiveItem::
; Give player quantity c of item b,
; and copy the item's name to wStringBuffer2.
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
