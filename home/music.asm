SECTION "PlayMapMusic", ROM0[$3de1]

PlayMapMusic: ; 00:3de1
	push hl
	push de
	push bc
	push af
	call GetMapMusic
	ld a, [wMapMusic]
	cp e
	jr z, .dont_play
	push de
	ld de, $0000
	call PlayMusic
	call DelayFrame
	pop de
	ld a, e
	ld [wMapMusic], a
	call PlayMusic

.dont_play
	pop af
	pop bc
	pop de
	pop hl
	ret