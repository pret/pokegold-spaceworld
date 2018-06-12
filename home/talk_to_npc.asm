include "constants.asm"

if DEBUG
SECTION "Unknown 3025", ROM0 [$3025]
else
SECTION "Unknown 3025", ROM0 [$2fe9]
endc

Function3025::
	ld hl, .Text
	call PrintFieldText
	ret

.Text: ; 00:302c
	text "ゲームフりーク！"
	done

Function3036:: ; 3036
	ld hl, .Text
	ret

.Text: ; 00:303a
	db "@"

CallMapTextSubroutine::
	ld a, [wcdb0]
	bit 0, a
	jr z, asm_3062
	call Function3055
	ret z
	ld hl, hCurMapTextSubroutinePtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .Return
	push de
	jp hl

.Return: ; 00:3051
	call Function307a
	ret

Function3055:: ; 00:3055
	ldh a, [hFFEA]
	ld b, a
.asm_3058: ; 00:3058
	ld a, [hli]
	cp $ff
	ret z
	cp b
	jp z, Function3240
	jr .asm_3058

asm_3062: ; 00:3062
	ld a, [wcdb0]
	bit 1, a
	ret z
	ld h, d
	ld l, e
	ldh a, [hFFEE]
	dec a
	ld d, $0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, Function307a
	push de
	jp hl

Function307a:: ; 00:307a
	ld hl, wcdb0
	res 0, [hl]
	res 1, [hl]
	call Function3240
	ret

Debug_PrintScriptMapAndNumber:: ; 00:3085
	push hl
	push de
	push bc
	ld de, $99
	ld a, [wcdb0]
	bit 0, a
	jr z, .asm_3097
	ld de, hFFEA
	jr .asm_309e

.asm_3097: ; 00:3097
	bit 1, a
	jr z, .asm_309e
	ld de, hFFEE
.asm_309e: ; 00:309e
	hlcoord 4, 12
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	ld de, wMapScriptNumber
	hlcoord 1, 12
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	pop bc
	pop de
	pop hl
	ret

QueueMapTextSubroutine::
	ldh a, [hJoyState]
	bit A_BUTTON_F, a
	jp z, Function323e
	call GetFacingPersonText
	jp nc, Function30e8
	ld d, $0
	ld e, a
	ld a, [wce63]
	bit 1, a
	call nz, Debug_PrintScriptMapAndNumber
	ld hl, wMapTextPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	add hl, de
	ld de, hCurMapTextSubroutinePtr
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, wcdb0
	set 0, [hl]
	call Function3240
	ret

Function30e8:: ; 00:30e8
	call GetFacingSignpost
	jp nc, Function323e
	ld a, e
	ldh [hFFEB], a
	ld a, d
	ldh [hFFEC], a
	ld a, b
	ldh [hFFED], a
	ld a, [hl]
	ldh [hFFEE], a
	ld hl, wcdb0
	set 1, [hl]
	call Function3240
	ret

GetFacingPersonText:: ; 00:3103
	callba Function776e
	ret nc
	call Function319b
	scf
	ret

PrintFieldText:: ; 00:3111
	push hl
	call DrawFieldTextbox
	ld a, [wce63]
	bit 1, a
	call nz, Debug_PrintScriptMapAndNumber
	pop hl
	call PrintFieldText_
	ret

PrintFieldText_NoDebug:: ; 3124
	push hl
	call DrawFieldTextbox
	pop hl
PrintFieldText_:: ; 00:3127
	call PrintTextBoxText
.asm_312a: ; 00:312a
	ld a, [wJoypadFlags]
	bit 5, a
	res 5, a
	ld [wJoypadFlags], a
	jr nz, .asm_314a
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .asm_314a
	call UpdateTime
	call UpdateTimeOfDayPalettes
	call DelayFrame
	jr .asm_312a

.asm_314a: ; 00:314a
	call Function3171
	ret

DrawFieldTextbox:: ; 00:314e
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate)
	call Bankswitch
	call ReanchorBGMap_NoOAMUpdate
	hlcoord 0, 12
	ld b, $4
	ld c, $12
	call DrawTextBox
	call WaitBGMap
	call LoadFonts_NoOAMUpdate
	pop af
	call Bankswitch
	ret

Function3171:: ; 00:3171
	callab ReanchorBGMap_NoOAMUpdate
	call UpdateSprites
	xor a
	ldh [hBGMapMode], a
	ld a, $90
	ldh [hWY], a
	call Function318f
	ld hl, wd14f
	res 7, [hl]
	call Function202c
	ret

Function318f:: ; 00:318f
	callab Function140ea
	call Function0d02
	ret

Function319b:: ; 00:319b
	ldh a, [hObjectStructIndexBuffer]
	call GetObjectStruct
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	call Function17de
	jr c, .asm_31b9
	ld a, [wPlayerWalking]
	xor $4
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], a
	push bc
	call UpdateSprites
	pop bc
.asm_31b9: ; 00:31b9
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	sub $2
	ldh [hFFEA], a
	ret

Function31c3::
	ret

Function31c4:: ; 31c4
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	call GetObjectStruct
	call GetVectorFromNPCToPlayer
	jr nc, .asm_31ea
	ld hl, OBJECT_ACTION
	add hl, de
	ld a, [hl]
	cp b
	jr c, .asm_31ea
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	add a
	ld hl, wd5f7
	add l
	ld l, a
	jr nc, .asm_31e7
	inc h
.asm_31e7: ; 00:31e7
	ld [hl], b
	inc hl
	ld [hl], c
.asm_31ea: ; 00:31ea
	ret

GetVectorFromNPCToPlayer:: ; 00:31eb
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [wPlayerStandingMapX]
	cp [hl]
	jr z, .asm_3201
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [wPlayerStandingMapY]
	cp [hl]
	jr z, .asm_3219
	and a
	ret

.asm_3201: ; 00:3201
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [wPlayerStandingMapY]
	sub [hl]
	jr z, .asm_3231
	jr nc, .asm_3214
	cpl
	inc a
	ld b, a
	ld c, UP
	scf
	ret

.asm_3214: ; 00:3214
	ld b, a
	ld c, DOWN
	scf
	ret

.asm_3219: ; 00:3219
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [wPlayerStandingMapX]
	sub [hl]
	jr z, .asm_3231
	jr nc, .asm_322c
	cpl
	inc a
	ld b, a
	ld c, LEFT
	scf
	ret

.asm_322c: ; 00:322c
	ld b, a
	ld c, RIGHT
	scf
	ret

.asm_3231: ; 00:3231
	and a
	ret

Function3233:: ; 00:3233
	ld a, [wce63]
	bit 1, a
	ret z
	ldh a, [hJoyState]
	bit B_BUTTON_F, a
	ret

Function323e:: ; 00:323e
	xor a
	ret

Function3240:: ; 00:3240
	xor a
	dec a
	ret
