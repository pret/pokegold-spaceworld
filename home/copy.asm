INCLUDE "constants.asm"

SECTION "home/copy.asm", ROM0

FarCopyBytes::
; Copy bc bytes from a:hl to de.
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	call Bankswitch
	call CopyBytes
	pop af
	jp Bankswitch

CopyBytes::
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

CopyBytesSmall::
; Copy c bytes from hl to de
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, CopyBytesSmall
	ret

GetFarByte::
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

ByteFill::
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

; TODO: Rename to LoadTilemapToTempTilemap
BackUpTilesToBuffer::
	hlcoord 0, 0
	decoord 0, 0, wTileMapBackup
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	jp CopyBytes

; TODO: Rename to SafeLoadTempTilemapToTilemap
ReloadTilesFromBuffer::
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0, wTileMapBackup
	decoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	call CopyBytes
	ld a, 1
	ldh [hBGMapMode], a
	ret

CopyStringToStringBuffer2::
; copies a string from [de] to [wStringBuffer2]
	ld hl, wStringBuffer2
	; fallthrough

CopyString::
; copies a string from [de] to [hl]
	ld a, [de]
	inc de
	ld [hli], a
	cp '@'
	jr nz, CopyString
	ret
