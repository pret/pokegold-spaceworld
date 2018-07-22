include "constants.asm"

; if DEBUG
SECTION "home/talk_to_npc.asm", ROM0
; else
; SECTION "Unknown 3025", ROM0 [$2fe9]
; endc

MapDefaultText::
	ld hl, GameplayText
	call OpenTextbox
	ret

GameplayText:: ; 00:302c
	text "ゲームフりーク！"
	done

Function3036:: ; 3036
	ld hl, EmptyText
	ret

EmptyText:: ; 00:303a
	db "@"

CallMapTextSubroutine:: ; 00:303b
	ld a, [wTalkingTargetType]
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
.Loop: ; 00:3058
	ld a, [hli]
	cp $ff
	ret z
	cp b
	jp z, SetFFInAccumulator
	jr .Loop

asm_3062: ; 00:3062
	ld a, [wTalkingTargetType]
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
	ld hl, wTalkingTargetType
	res 0, [hl]
	res 1, [hl]
	call SetFFInAccumulator
	ret

PrintTextboxDebugNumbers:: ; 00:3085
	push hl
	push de
	push bc
	ld de, $0099 ; default address to print from (not a sign or NPC)
	ld a, [wTalkingTargetType]
	bit 0, a
	jr z, .CheckSign
	ld de, hFFEA
	jr .PrintNum

.CheckSign: ; 00:3097
	bit 1, a
	jr z, .PrintNum
	ld de, hFFEE

.PrintNum: ; 00:309e
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

QueueMapTextSubroutine:: ; 00:30b7
	ldh a, [hJoyState]
	bit A_BUTTON_F, a
	jp z, ClearAccumulator ; if we didn't press a
	call GetFacingPersonText
	jp nc, Function30e8 ; if not talking to a person
	ld d, $0
	ld e, a
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	call nz, PrintTextboxDebugNumbers ; if debug, print these
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
	ld hl, wTalkingTargetType
	set 0, [hl] ; we're talking to an NPC
	call SetFFInAccumulator
	ret

Function30e8:: ; 00:30e8
	call GetFacingSignpost
	jp nc, ClearAccumulator ; if not facing person or sign
	ld a, e
	ldh [hFFEB], a
	ld a, d
	ldh [hFFEC], a
	ld a, b
	ldh [hFFED], a
	ld a, [hl]
	ldh [hFFEE], a
	ld hl, wTalkingTargetType
	set 1, [hl] ; we're talking to a sign
	call SetFFInAccumulator
	ret

GetFacingPersonText:: ; 00:3103
	callba Function776e
	ret nc
	call TurnNPCTalkingTo
	scf
	ret

OpenTextbox:: ; 00:3111
	; Opens a textbox and waits for input
	push hl
	call PrepareTextbox
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	call nz, PrintTextboxDebugNumbers
	pop hl
	call TextboxIdle 
	ret

OpenTextboxNoInput:: ; 00:3122
	push hl 
	call PrepareTextbox 
	pop hl

TextboxIdle:: ; 00:3127
	; Prints text, then waits for A or B to be pressed, unless bit 5 of JoypadFlags is set.
	call PrintTextBoxText
.Loop
	ld a, [wJoypadFlags]
	bit 5, a
	res 5, a 
	ld [wJoypadFlags], a 
	jr nz, .Escape
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .Escape 
	call UpdateTime 
	call UpdateTimeOfDayPalettes
	call DelayFrame
	jr .Loop
.Escape
	call TextboxCleanup
	ret

PrepareTextbox:: ; 00:314E
	call ClearWindowData
	ldh a, [hROMBank]
	push af 
	ld a, 01 
	call Bankswitch
	call ReanchorBGMap_NoOAMUpdate
	hlcoord 0, 12 ;in the tilemap in WRAM
	ld b, 04 
	ld c, $12 
	call DrawTextBox
	call WaitBGMap
	call LoadFonts_NoOAMUpdate
	pop af
	call Bankswitch
	ret

TextboxCleanup: ; 00:3171
	callab ReanchorBGMap_NoOAMUpdate
	call UpdateSprites
	xor a
	ldh [hBGMapMode], a
	ld a, $90
	ldh [hWY], a
	call Function318f 
	ld hl, wToolgearFlags
	res 7, [hl]
	call InitToolgearBuffer
	ret

Function318f: ; 00:318f
	callab Function140ea
	call RedrawPlayerSprite
	ret
	
TurnNPCTalkingTo:: ; 00:319b 
	; If an NPC is allowed to turn when talked to, turn it.
	ldh a, [hObjectStructIndexBuffer] 
	call GetObjectStruct
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	call IsAnimatedSprite
	jr c, .Jump
	ld a, [wPlayerWalking]
	xor 04
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], a
	push bc
	call UpdateSprites
	pop bc
.Jump
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	sub 02
	ldh [hFFEA], a
	ret

Function31C3:: ; 00:31C3
	ret

CheckInlineTrainer:: ; 00:31C4
	; Passed de is the pointer to a map_object struct. If it's an inline trainer, write to relevant wram region.
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	call GetObjectStruct
	call GetInlineMapObject
	jr nc, .Escape 
	ld hl, MAPOBJECT_POINTER_HI
	add hl, de
	ld a, [hl]
	cp b
	jr c, .Escape
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	add a, a
	ld hl, wCurrMapInlineTrainers 
	add a, l
	ld l, a
	jr nc, .NoCarry
	inc h
.NoCarry
	ld [hl], b
	inc hl
	ld [hl], c
.Escape
	ret

GetInlineMapObject:: ; 00:31EB
	;bc is start of object struct. if c flag set, returns distance in B and direction in C
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [wPlayerNextMapX]
	cp [hl]
	jr z, .EqualX
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [wPlayerNextMapY]
	cp [hl]
	jr z, .EqualY
	and a 
	ret
.EqualX 
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [wPlayerNextMapY]
	sub [hl]
	jr z, .Reset 
	jr nc, .SetDown 
	cpl
	inc a
	ld b, a
	ld c, UP
	scf
	ret
.SetDown ; 3214
	ld b, a
	ld c, DOWN
	scf
	ret
.EqualY ; 3219 
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [wPlayerNextMapX]
	sub [hl]
	jr z, .Reset ; (this condition is impossible to meet)
	jr nc, .SetRight
	cpl
	inc a
	ld b, a
	ld c, LEFT
	scf
	ret
.SetRight ; 322C
	ld b, a
	ld c, RIGHT
	scf
	ret
.Reset ; 3231
	and a
	ret
	
CheckBPressedDebug: ; 3233
	; If in debug mode, returns a check on the B button.
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	ret z
	ldh a, [hJoyState]
	bit B_BUTTON_F, a
	ret

ClearAccumulator:: ; 323E
	xor a
	ret
	
SetFFInAccumulator:: ; 3240
	xor a
	dec a
	ret
	
; 3243