INCLUDE "constants.asm"

SECTION "engine/gfx/mon_icons.asm", ROMX

LoadOverworldMonIcon::
	push hl
	push de
	push bc
	push af
	ld hl, wSpriteAnimDict
	ld bc, wSpriteAnimDataEnd - wSpriteAnimData
.loop
	ld [hl], $00
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop

	pop af
	pop bc
	pop de
	pop hl
	ret

LoadMenuMonIcon::
	push hl
	push de
	push bc
	call .LoadIcon
	pop bc
	pop de
	pop hl
	ret

.LoadIcon:
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable
; entries correspond to MONICON_* constants
	dw PartyMenu_InitAnimatedMonIcon    ; MONICON_PARTYMENU
	dw NamingScreen_InitAnimatedMonIcon ; MONICON_NAMINGSCREEN
	dw MoveList_InitAnimatedMonIcon     ; MONICON_MOVES
	dw Trade_LoadMonIconGFX             ; MONICON_TRADE

PartyMenu_InitAnimatedMonIcon:
	ldh a, [hObjectStructIndex]
	ld hl, wPartySpecies
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	call ReadMonMenuIcon
	ld [wCurIcon], a
	call GetMemIconGFX

; y coord (hObjectStructIndex * 4 + 26)
	ldh a, [hObjectStructIndex]
rept 4
	add a
endr
	add 3 * TILE_WIDTH + 2
	ld d, a
; x coord
	ld e, 2 * TILE_WIDTH

	ld a, [wCurIcon]
	call _InitSpriteAnimStruct

; Get the party mon icon's animation speed
	ld hl, wHPPals
	ld d, $00
	ldh a, [hObjectStructIndex]
	ld e, a
	add hl, de
	ld e, [hl]
	ld hl, .speeds
	add hl, de
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_DURATIONOFFSET
	add hl, bc
	ld [hl], a
	ret

.speeds
	db 0  ; HP_GREEN
	db 16 ; HP_YELLOW
	db 32 ; HP_RED

NamingScreen_InitAnimatedMonIcon:
	ld a, [wTempIconSpecies]
	call ReadMonMenuIcon
	ld [wCurIcon], a
	call GetMemIconGFX
	lb de, 36, 32
	ld a, [wCurIcon]
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_FUNC_NULL
	ret

MoveList_InitAnimatedMonIcon:
	ld a, [wTempIconSpecies]
	call ReadMonMenuIcon
	ld [wCurIcon], a
	call GetMemIconGFX
	ld d, 3 * TILE_WIDTH + 2 ; depixel 3, 3, 2, 0
	ld e, 3 * TILE_WIDTH
	ld a, [wCurIcon]
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_FUNC_NULL
	ret

Trade_LoadMonIconGFX:
	ld a, [wTempIconSpecies]
	call ReadMonMenuIcon
	ld [wCurIcon], a
	ld a, $62
	ld [wCurIconTile], a
	call GetMemIconGFX
	ret

GetMemIconGFX:
	call .CheckSpriteAnimDict
	ret c

	ld [hli], a
	ld a, [wCurIconTile]
	ld [hli], a
	ld l, a
	ld h, $00
rept 4
	add hl, hl
endr
	ld de, vChars0
	add hl, de
	ld a, [wCurIcon]
	call LoadSpriteAnimGFX

	ld a, [wCurIconTile]
	add c
	ld [wCurIconTile], a
	ret

; Scroll through SpriteAnimDict for empty slots to put the requested icon in.
; If sprite space is full, or tile requested is too high, returns carry flag.
.CheckSpriteAnimDict:
	push af
	ld d, a
	ld hl, wSpriteAnimDict
	ld e, NUM_SPRITEANIMDICT_ENTRIES
.loop
	ld a, [hl]
	cp d
	jr z, .set_carry_flag

	and a
	jr z, .slot_available

	inc hl
	inc hl
	dec e
	jr z, .set_carry_flag

	jr .loop

.slot_available
; If icon's tile infringes on vChars1, don't get the graphics
	ld a, [wCurIconTile]
	cp $80
	jr nc, .set_carry_flag

	pop af
	and a
	ret

.set_carry_flag
	pop af
	scf
	ret

FreezeMonIcons:
	ld hl, wSpriteAnimationStructs
	ld e, PARTY_LENGTH
	ld a, [wMenuCursorY]
	ld d, a
.loop
	ld a, [hl]
	and a
	jr z, .next
	cp d
	jr z, .loadwithtwo
	ld a, SPRITE_ANIM_FUNC_NULL
	jr .ok

.loadwithtwo
	ld a, SPRITE_ANIM_FUNC_PARTY_MON_SWITCH

.ok
	push hl
	ld c, l
	ld b, h
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], a
	pop hl

.next
	ld bc, wSpriteAnim2 - wSpriteAnim1
	add hl, bc
	dec e
	jr nz, .loop
	ret

UnfreezeMonIcons:
	ld hl, wSpriteAnimationStructs
	ld e, PARTY_LENGTH
	ld a, [wSelectedSwapPosition]
	ld d, a
.loop
	ld a, [hl]
	and a
	jr z, .next
	cp d
	jr z, .loadwithtwo

	ld a, SPRITE_ANIM_FUNC_PARTY_MON_SELECTED
	jr .ok

.loadwithtwo
	ld a, SPRITE_ANIM_FUNC_PARTY_MON_SWITCH
.ok
	push hl
	ld c, l
	ld b, h
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], a
	pop hl
.next:
	ld bc, wSpriteAnim2 - wSpriteAnim1
	add hl, bc
	dec e
	jr nz, .loop
	ret

ReadMonMenuIcon:
	cp DEX_EGG
	jr z, .egg
	dec a
	ld hl, MonMenuIcons
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	ret
.egg
; Even though a proper egg icon exists (ID $1c), the function uses a zeroed-out value as a placeholder
	ld a, $00
	ret

INCLUDE "data/pokemon/menu_icons.inc"
