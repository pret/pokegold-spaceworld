PartyMenu_ClearCursor:
	hlcoord 0, 1
	ld bc, 2 * SCREEN_WIDTH
	ld a, PARTY_LENGTH
.next
	ld [hl], '　'
	add hl, bc
	dec a
	jr nz, .next
	ret
