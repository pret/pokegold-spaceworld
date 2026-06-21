INCLUDE "constants.asm"

SECTION "home/trainers.asm@Bank 03", ROMX

_CheckTrainerBattle:
	xor a
	ld bc, NUM_OBJECTS * 2
	ld hl, wCurrMapInlineTrainers
	call ByteFill
	ld de, wMap2Object
	ld a, 2 ; next the player
.loop
	push af
	push de

; Is a trainer
	ld hl, MAPOBJECT_TYPE
	add hl, de
	ld a, [hl]
	cp 0 ; 1 or greater == not a trainer
	jr nz, .next

; Is visible on the map
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .next
	call .check_inline_trainer

.next
	pop de
	ld hl, MAPOBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.check_inline_trainer
	jp CheckInlineTrainer

SECTION "home/trainers.asm", ROM0

Unreferenced_CheckTrainerBattle::
	ret

CheckInlineTrainer::
; Passed de is the pointer to a map_object struct. If it's an inline trainer, write to relevant wram region.
; Is visible on the map
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]

; Is facing the player...
	call GetObjectStruct
	call FacingPlayerDistance
	jr nc, .next
; ...within their sight range
	ld hl, MAPOBJECT_SIGHT_RANGE
	add hl, de
	ld a, [hl]
	cp b
	jr c, .next

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	add a, a
	ld hl, wCurrMapInlineTrainers
	add a, l
	ld l, a
	jr nc, .startbattle

	inc h
.startbattle
	ld [hl], b
	inc hl
	ld [hl], c
.next
	ret

FacingPlayerDistance::
	;bc is start of object struct. if c flag set, returns distance in B and direction in C
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [wPlayerMapX]
	cp [hl]
	jr z, .EqualX
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [wPlayerMapY]
	cp [hl]
	jr z, .EqualY
	and a
	ret
.EqualX
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [wPlayerMapY]
	sub [hl]
	jr z, .Reset
	jr nc, .SetDown
	cpl
	inc a
	ld b, a
	ld c, UP
	scf
	ret
.SetDown
	ld b, a
	ld c, DOWN
	scf
	ret
.EqualY
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [wPlayerMapX]
	sub [hl]
	jr z, .Reset ; (this condition is impossible to meet)
	jr nc, .SetRight
	cpl
	inc a
	ld b, a
	ld c, LEFT
	scf
	ret
.SetRight
	ld b, a
	ld c, RIGHT
	scf
	ret
.Reset
	and a
	ret

CheckBPressedDebug:
	; If in debug mode, returns a check on the B button.
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	ret z
	ldh a, [hJoyState]
	bit B_BUTTON_F, a
	ret

xor_a::
	xor a
	ret

xor_a_dec_a::
	xor a
	dec a
	ret
