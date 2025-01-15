INCLUDE "constants.asm"

SECTION "home/cry.asm", ROM0

PlayStereoCry::
	push af
	ld a, $1
	ld [wStereoPanningMask], a
	pop af
	jr _PlayCry

PlayCry::
	push af
	xor a
	ld [wStereoPanningMask], a
	ld [wCryTracks], a
	pop af
_PlayCry:
	push hl
	push de
	push bc
	call GetCryIndex
	ld e, c
	ld d, b
	call PlayCryHeader
	call WaitSFX
	pop bc
	pop de
	pop hl
	ret

LoadCryHeader::
	call GetCryIndex
	ldh a, [hROMBank]
	push af
	ld a, BANK(PokemonCries)
	call Bankswitch
	ld hl, PokemonCries
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld [wCryPitch], a
	ld a, [hli]
	ld [wCryPitch + 1], a
	ld a, [hli]
	ld [wCryLength], a
	ld a, [hl]
	ld [wCryLength + 1], a
	pop af
	call Bankswitch
	ret

GetCryIndex::
	ld d, a
	ld a, [wce37]
	push af
	ld a, d
	ld [wce37], a
	farcall ConvertMon_2to1
	ld a, [wce37]
	dec a
	ld c, a
	ld b, $0
	pop af
	ld [wce37], a
	ret

PrintLevel::
	ld a, $6e ; ":L"
	ld [hli], a
	ld c, 2
	ld a, [wTempMonLevel]
	cp 100
	jr c, _PrintLevelCommon
	dec hl
	inc c
	jr _PrintLevelCommon

PrintLevelFullWidth::
	ld a, $6e ; ":L"
	ld [hli], a
	ld c, 3
	ld a, [wTempMonLevel]
_PrintLevelCommon:
	ld [wce37], a
	ld de, wce37
	ld b, PRINTNUM_RIGHTALIGN | 1
	jp PrintNumber

GetNthMove:: ; unreferenced?
	ld hl, wListMoves_MoveIndicesBuffer
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ret
