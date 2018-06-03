INCLUDE "constants.asm"

if DEBUG
SECTION "Copy functions", ROM0[$32F7]
else
SECTION "Copy functions", ROM0[$32BB]
endc

FarCopyBytes:: ; 32f7
; Copy bc bytes from a:hl to de.
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	call Bankswitch
	call CopyBytes
	pop af
	jp Bankswitch

CopyBytes:: ; 330a
; Copy bc bytes from hl to de
	ld a, b
	and a
	jr z, CopyBytesSmall
	ld a, c
	and a
	jr z, .next
	inc b
.next
	call CopyBytesSmall
	dec b
	jr nz, .next
	ret

CopyBytesSmall:: ; 331a
; Copy c bytes from hl to de
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, CopyBytesSmall
	ret

GetFarByte:: ; 3321
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	call Bankswitch
	ld a, [hl]
	ld [wBuffer], a
	pop af
	call Bankswitch
	ld a, [wBuffer]
	ret

ByteFill:: ; 3339
	push af
	ld a, b
	and a
	jr z, .small_fill
	ld a, c
	and a
	jr z, .start_filling
.small_fill
	inc b
.start_filling
	pop af
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	dec b
	jr nz, .loop
	ret

UncompressSpriteFromDE::
; Decompress pic at a:de.
	ld hl, wSpriteInputPtr
	ld [hl], e
	inc hl
	ld [hl], d
	jp UncompressSpriteData

BackUpTilesToBuffer:: ; 3355
	hlcoord 0, 0
	decoord 0, 0, wTileMapBackup
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	jp CopyBytes

ReloadTilesFromBuffer:: ; 3361
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0, wTileMapBackup
	decoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	call CopyBytes
	ld a, 1
	ldh [hBGMapMode], a
	ret

CopyStringToCD31::
; copies a string from [de] to [wcd31]
	ld hl, wcd31
	; fallthrough

CopyString::
; copies a string from [de] to [hl]
	ld a, [de]
	inc de
	ld [hli], a
	cp "@"
	jr nz, CopyString
	ret
