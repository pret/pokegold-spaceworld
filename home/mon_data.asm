include "constants.asm"

SECTION "Mon Data Home", ROM0 [$3A1F]

PrintLevel:: ; 3a1f
	ld a, $6e
	ld [hli], a
	ld c, 2
	ld a, [wcd9e]
	cp 100
	jr c, asm_3a37
	dec hl
	inc c
	jr asm_3a37

PrintLevelFullWidth::
	ld a, $6e
	ld [hli], a
	ld c, 3
	ld a, [wcd9e]
asm_3a37: ; 00:3a37
	ld [wce37], a
	ld de, wce37
	ld b, PRINTNUM_RIGHTALIGN | 1
	jp PrintNumber

GetNthMove:: ; 3a42
	ld hl, wListMoves_MoveIndicesBuffer
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ret

GetMonHeader:: ; 3a4b (0:3a4b)
; copies the base stat data of a pokemon to wMonHeader
; INPUT:
; [wCurSpecies] = pokemon ID in dex order
	push bc
	push de
	push hl
	ldh a, [hROMBank]
	push af
	ld a, BANK(MonBaseStats)
	call Bankswitch
	ld a, [wCurSpecies]
	cp DEX_FD
	jr z, .egg
	dec a
	ld bc, MonBaseStatsEnd - MonBaseStats
	ld hl, MonBaseStats
	call AddNTimes
	ld de, wMonHeader
	ld bc, MonBaseStatsEnd - MonBaseStats
	call CopyBytes
	jr .done
.egg
	ld de, EggPicFront
	ln b, 5, 5 ; egg sprite dimension
	ld hl, wMonHSpriteDim
	ld [hl], b
	ld hl, wMonHFrontSprite
	ld [hl], e
	inc hl
	ld [hl], d
	jr .done
.done
	ld a, [wCurSpecies]
	ld [wMonHIndex], a
	pop af
	call Bankswitch
	pop hl
	pop de
	pop bc
	ret

GetCurNick:: ; 3a91
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames

GetNick:: ; 3a97
; Get nickname a from list hl
	push hl
	push bc

	call SkipNames
	ld de, wStringBuffer1

	push de
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop de

	callab CorrectNickErrors

	pop bc
	pop hl
	ret
