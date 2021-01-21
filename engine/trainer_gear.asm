INCLUDE "constants.asm"

SECTION "engine/trainer_gear.asm", ROMX

OpenTrainerGear:
	ld hl, wce5f
	ld a, [hl]
	push af
	set 4, [hl]
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ldh a, [hJoypadSum]
	push af
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	call Function8ae0
	call DelayFrame
.sub_8ac9
	call Function8ba3
	jr nc, .sub_8ac9
	pop af
	ld [wVramState], a
	pop af
	ldh [hJoypadSum], a
	pop af
	ldh [hMapAnims], a
	pop af
	ld [wce5f], a
	call ClearJoypad
	ret

Function8ae0:
	call ClearBGPalettes
	call DisableLCD
	call ClearSprites
	ld b, $13
	call GetSGBLayout
	ld hl, TrainerGearGFX
	ld de, vChars2
	ld bc, $0200
	ld a, $02
	call FarCopyData
	call Function8b2a
	call Function8b7e
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	ld [wJumptableIndex], a
	ld [wFlyDestination], a
	ld a, $ff
	ld [wcb60], a
	ld a, $07
	ldh [hWX], a
	ld a, $08
	call UpdateSoundNTimes
	ld a, $e3
	ldh [rLCDC], a
	call WaitBGMap
	call SetPalettes
	ld a, $e0
	ldh [rOBP1], a
	ret

Function8b2a:
	ld hl, wTileMap
	ld bc, $0168
	ld a, $7f
	call ByteFill
	ld de, wTileMap
	ld hl, Data8b42
	ld bc, $003c
	call CopyBytes
	ret

Data8b42:
	db $0d, $1c, $1d, $0b, $1c, $1d, $0b, $1c
	db $1d, $0c, $01, $05, $05, $05, $05, $05
	db $05, $05, $05, $02, $08, $1e, $1f, $0a
	db $1e, $1f, $0a, $1e, $1f, $07, $08, $7f
	db $7f, $0f, $7f, $7f, $0f, $7f, $7f, $07
	db $03, $06, $06, $09, $06, $06, $09, $06
	db $06, $04, $03, $06, $06, $06, $06, $06
	db $06, $06, $06, $04

Function8b7e:
	coord hl, 1, 0
	ld a, $10
	call Function8b97
	coord hl, 4, 0
	ld a, $14
	call Function8b97
	coord hl, 7, 0
	ld a, $18
	call Function8b97
	ret

Function8b97:
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, $0014
	add hl, bc
	inc a
	ld [hli], a
	inc a
	ld [hld], a
	ret

Function8ba3:
	call UpdateTime
	call GetJoypadDebounced
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .sub_8bc3
	call Function8bfd
	ld a, BANK(EffectObjectJumpNoDelay)
	ld hl, EffectObjectJumpNoDelay
	call FarCall_hl
	call Function8bd5
	call DelayFrame
	and a
	ret
.sub_8bc3
	ld hl, InitEffectObject
	ld a, BANK(InitEffectObject)
	call FarCall_hl
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

Function8bd5:
	coord hl, 11, 1
	ld a, $7f
	ld [hli], a
	ld [hl], a
	ld de, hRTCHours
	coord hl, 11, 1
	ld bc, $0102
	call PrintNumber
	inc hl
	ld de, hRTCMinutes
	ld bc, $8102
	call PrintNumber
	inc hl
	ld de, hRTCSeconds
	ld bc, $8102
	call PrintNumber
	ret

Function8bfd:
	ld a, [wJumptableIndex]
	ld e, a
	ld d, $00
	ld hl, Table8c0c
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Table8c0c:
	dw Function8c21
	dw Function8c49
	dw DrawMap
	dw Function8cab
	dw Function8cb7
	dw Function8d62
	dw Function8e6c
	dw Function8e9e

Function8c1c:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Function8c21:
	ld hl, InitEffectObject
	ld a, BANK(InitEffectObject)
	call FarCall_hl
	ld de, PointerGFX
	ld hl, vChars0 + $7c0
	lb bc, BANK(PointerGFX), $04
	call Request2bpp
	ld a, $29
	ld hl, wTileMapBackup
	ld [hli], a
	ld [hl], $7c
	depixel 4, 3, 4, 4
	ld a, SPRITE_ANIM_INDEX_44
	call InitSpriteAnimStruct
	call Function8c1c
	ret

Function8c49:
	ld hl, hJoySum
	ld a, [hl]
	and $02
	jr nz, .sub_8c59
	ld a, [hl]
	and $01
	ret z
	call Function8c5f
	ret
.sub_8c59
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Function8c5f:
	ld a, [wFlyDestination]
	ld hl, wcb60
	cp [hl]
	ret z
	ld [wcb60], a
	and $03
	ld e, a
	ld d, $00
	ld hl, Unknown8c78
	add hl, de
	ld a, [hl]
	ld [wJumptableIndex], a
	ret

Unknown8c78:
	db $02, $04, $06, $02

DrawMap:
	call Function8c1c
	call Function8eaa
	call WaitForAutoBgMapTransfer
	ld b, $14
	call GetSGBLayout
	ld de, TownMapGFX
	ld hl, vTilesetEnd
	lb bc, BANK(TownMapGFX), ((TownMapGFX.End - TownMapGFX) / LEN_2BPP_TILE - 1)
	call Request2bpp
	coord hl, 0, 3
	call DecompTownMapTilemap
	call WaitBGMap
	call Function886a
	ld hl, $0005
	add hl, bc
	ld a, [hl]
	add $18
	ld [hl], a
	ret

Function8cab:
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

Function8cb7:
	call Function8c1c
	call Function8eaa
	call WaitForAutoBgMapTransfer
	ld b, $15
	call GetSGBLayout
	ld de, RadioGFX
	ld hl, vTilesetEnd
	lb bc, BANK(RadioGFX), $09
	call Request2bpp
	ld de, VerticalPipeGFX
	ld hl, vChars0
	lb bc, BANK(VerticalPipeGFX), $01
	call Request2bpp
	coord hl, 0, 3
	ld bc, $00b4
	ld a, $0e
	call ByteFill
	coord hl, 1, 8
	ld bc, $0412
	call Function8ef9
	coord hl, 4, 3
	ld bc, $060e
	call Function8ef9
	ld a, $05
	coord hl, 0, 11
	ld [hl], a
	coord hl, 19, 11
	ld [hl], a
	coord hl, 2, 5
	ld a, $60
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, $0014
	add hl, bc
	ld [hli], a
	inc a
	ld [hld], a
	coord hl, 2, 4
	ld a, $64
	ld [hli], a
	inc a
	ld [hl], a
	coord hl, 5, 5
	ld bc, $000c
	ld a, $66
	call ByteFill
	coord hl, 5, 6
	ld bc, $000c
	ld a, $67
	call ByteFill
	ld hl, Text91c2
	call PrintText
	call WaitBGMap
	depixel 9, 4, 4, 3
	ld a, SPRITE_ANIM_INDEX_44
	call InitSpriteAnimStruct
	ld hl, $0002
	add hl, bc
	ld [hl], $00
	ld hl, $0003
	add hl, bc
	ld [hl], $7c
	depixel 8, 6
	ld a, SPRITE_ANIM_INDEX_4B
	call InitSpriteAnimStruct
	ld hl, $0003
	add hl, bc
	ld [hl], $00
	xor a
	ld [wcb61], a
	ret

Function8d62:
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

Function8d6e:
	ld hl, wcb61
	ld e, [hl]
	ld d, $00
	ld hl, Table8d7d
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Table8d7d:
	dw Function8d85
	dw Function8d91
	dw Function8d85
	dw Function8db9

Function8d85:
	ld hl, hJoyDown
	ld a, [hl]
	and $01
	ret z
	ld hl, wcb61
	inc [hl]
	ret

Function8d91:
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .sub_8da6
	call Function8dfd
	jr c, .sub_8db1
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_8dab
.sub_8da6
	ld hl, hFFC0
	jr Function8de3
.sub_8dab
	ld a, $03
	ld [wcb61], a
	ret
.sub_8db1
	call .sub_8da6
	xor a
	ld [wcb61], a
	ret

Function8db9:
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .sub_8dcf
	call Function8dfd
	jr c, .sub_8dda
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	cp $60
	jr z, .sub_8dd4
.sub_8dcf
	ld hl, $0040
	jr Function8de3
.sub_8dd4
	ld a, $01
	ld [wcb61], a
	ret
.sub_8dda
	call .sub_8dcf
	ld a, $02
	ld [wcb61], a
	ret

Function8de3:
	push hl
	ld hl, $0006
	add hl, bc
	ld d, [hl]
	ld hl, $000c
	add hl, bc
	ld e, [hl]
	pop hl
	add hl, de
	ld e, l
	ld d, h
	ld hl, $000c
	add hl, bc
	ld [hl], e
	ld hl, $0006
	add hl, bc
	ld [hl], d
	ret

Function8dfd:
	ld hl, $0006
	add hl, bc
	push bc
	ld c, [hl]
	ld a, [wMapGroup]
	ld e, a
	ld d, $00
	ld hl, Table8e2f
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
.sub_8e11
	ld a, [hl]
	and a
	jr z, .sub_8e1e
	cp c
	jr z, .sub_8e21
	ld de, $0006
	add hl, de
	jr .sub_8e11
.sub_8e1e
	pop bc
	and a
	ret
.sub_8e21
	ld de, Function8e2c
	push de
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Function8e2c:
	pop bc
	scf
	ret

Table8e2f:
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d

Data8e4d:
	db $10, $02
	dw Function8e66
	dw Function8e66

	db $20, $05
	dw Function8e66
	dw Function8e66

	db $40, $07
	dw Function8e66
	dw Function8e66

	db $48, $09
	dw Function8e66
	dw Function8e66

	db $00

Function8e66:
	ld d, $00
	call PlayMusic
	ret

Function8e6c:
	call Function8c1c
	call Function8eaa
	call WaitForAutoBgMapTransfer
	ld b, $13
	call GetSGBLayout
	call LoadFontExtra
	ld de, Text8e90
	coord hl, 7, 7
	call PlaceString
	ld hl, Text8e95
	call PrintText
	call WaitBGMap
	ret

Text8e90:
	db "けんがい@"

Text8e95:
	text "ちぇっ⋯⋯⋯⋯"
	done

Function8e9e:
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

Function8eaa:
	ld hl, InitEffectObject
	ld a, BANK(InitEffectObject)
	call FarCall_hl
	call ClearSprites
	call WaitForAutoBgMapTransfer
	coord hl, 0, 3
	ld bc, $012c
	ld a, $7f
	call ByteFill
	call WaitBGMap
	call WaitBGMap
	ret

Function8eca:
	ld hl, wFlyDestination
	ld de, hJoySum
	ld a, [de]
	and $20
	jr nz, .sub_8edc
	ld a, [de]
	and $10
	jr nz, .sub_8ee2
	jr .sub_8ee7
.sub_8edc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	jr .sub_8ee7
.sub_8ee2
	ld a, [hl]
	cp $02
	ret nc
	inc [hl]
.sub_8ee7
	ld e, [hl]
	ld d, $00
	ld hl, Data8ef5
	add hl, de
	ld a, [hl]
	ld hl, $0006
	add hl, bc
	ld [hl], a
	ret

Data8ef5:
	db $00, $18, $30, $00

Function8ef9:
	dec c
	dec c
	dec b
	dec b
	ld de, $0014
	push bc
	push hl
	ld a, $01
	ld [hli], a
	ld a, $05
.sub_8f07
	ld [hli], a
	dec c
	jr nz, .sub_8f07
	ld a, $02
	ld [hl], a
	pop hl
	pop bc
	add hl, de
.sub_8f11
	push bc
	push hl
	ld a, $08
	ld [hli], a
	ld a, $7f
.sub_8f18
	ld [hli], a
	dec c
	jr nz, .sub_8f18
	ld a, $07
	ld [hli], a
	pop hl
	add hl, de
	pop bc
	dec b
	jr nz, .sub_8f11
	ld a, $03
	ld [hli], a
	ld a, $06
.sub_8f2a
	ld [hli], a
	dec c
	jr nz, .sub_8f2a
	ld a, $04
	ld [hli], a
	ret
