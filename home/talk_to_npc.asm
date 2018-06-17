include "constants.asm"

if DEBUG
SECTION "Unknown 3025", ROM0 [$3025]
else
SECTION "Unknown 3025", ROM0 [$2fe9]
endc

Function3025::
	ld hl, .Text
	call Function3111
	ret

.Text: ; 00:302c
	text "ゲームフりーク！"
	done

Function3036:: ; 3036
	ld hl, .Text
	ret

.Text: ; 00:303a
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
	ld de, hFFEA ; address if we're talking to an NPC
	jr .PrintNum

.CheckSign: ; 00:3097
	bit 1, a
	jr z, .PrintNum
	ld de, hFFEE ; address if we're talking to a sign

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
	ld a, [wce63]
	bit 1, a
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

Function3111:: ; 00:3111
	push hl
	call PrepareTextbox
	ld a, [wce63]
	bit 1, a
	call nz, PrintTextboxDebugNumbers ; if debug, print text IDs
	pop hl
	call TextboxIdle 
	ret

Function3122:: ; 00:3122
	push hl 
	call PrepareTextbox 
	pop hl

TextboxIdle:: ; 00:3127
	call PrintTextBoxText
.loop
	ld a, [wJoypadFlags]
	bit 5, a
	res 5, a 
	ld [wJoypadFlags], a 
	jr nz, .escape ; if bit 5 of joyflags is set, escape
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .escape ; if A or B are down, escape
	call UpdateTime 
	call UpdateTimeOfDayPalettes
	call DelayFrame
	jr .loop
.escape
	call TextboxCleanup
	ret

PrepareTextbox:: ; 00:314E
	call ClearWindowData
	ldh a, [hROMBank]
	push af 
	ld a, 01 
	call Bankswitch
	call ReanchorBGMap_NoOAMUpdate
	ld hl, $C390 ;in the tilemap in WRAM
	ld b, 04 
	ld c, $12 
	call DrawTextBox
	call WaitBGMap
	call LoadFonts_NoOAMUpdate
	pop af
	call Bankswitch
	ret

TextboxCleanup ; 00:3171
	callab ReanchorBGMap_NoOAMUpdate
	call UpdateSprites
	xor a
	ldh [hBGMapMode], a ;reset this
	ld a, $90
	ldh [hWY], a ;set window Y to $90
	call Function318f 
	ld hl, wToolgearFlags
	res 7, [hl] ; show toolgear
	call InitToolgearBuffer
	ret

Function318f ; 00:318f
	callab Function140ea
	call Function0d02
	ret
	
TurnNPCTalkingTo:: ; 00:319b 
	ldh a, [hObjectStructIndexBuffer] 
	call GetObjectStruct
	ld hl, $0000
	add hl, bc ; bc is the address of the a'th object struct
	ld a, [hl]
	call CheckNonTurningSprite
	jr c, .jump ;if it's a non-turning sprite, skip this
	ld a, [wPlayerWalking] ; shouldn't this be direction?
	xor 04 ; get opposite direction from player
	ld hl, $0007
	add hl, bc ; get NPC's direction
	ld [hl], a ; overwrite it
	push bc
	call UpdateSprites
	pop bc
.jump
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	sub 02
	ldh [hFFEA], a
	ret

Function31C3:: ; 00:31C3
	ret

CheckInlineTrainer:: ; 00:31C4
	; passed de is the start of a map_object struct. if it's an inline trainer, write to relevant wram region.
	ld hl, $0000
	add hl, de
	ld a, [hl]
	call GetObjectStruct ; de is the address of the number of object we want
	call $31EB
	jr nc, .escape ; if c flag isn't set, leave
	ld hl, $000B ; map_object script
	add hl, de
	ld a, [hl]
	cp b
	jr c, .escape ;if action is less than b, return
	ld hl, $0000 ; obj id
	add hl, de
	ld a, [hl]
	add a, a ; objid*2
	ld hl, wCurrMapInlineTrainers 
	add a, l
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld [hl], b ; store bc (distance, direction) in new hl
	inc hl
	ld [hl], c
.escape
	ret

GetInlineMapObject:: ; 00:31EB
	;bc is start of object struct. if c flag set, returns distance in B and direction in C
	ld hl, $0010 ; offset for StandingMapX
	add hl, bc
	ld a, [wPlayerStandingMapX]
	cp [hl]
	jr z, .equalX ; if player x == object x
	ld hl, $0011 ; offset for StandingMapY
	add hl, bc
	ld a, [wPlayerStandingMapY]
	cp [hl]
	jr z, .equalY ; if player y == object y and px != ox, jump
	and a ; clears c for the ret
	ret
.equalX ; player x == object x
	ld hl, $0011
	add hl, bc
	ld a, [wPlayerStandingMapY]
	sub [hl] ; py - oy
	jr z, .reset ; if py == oy, jump
	jr nc, .setDown ; if py > oy, jump
	cpl
	inc a
	ld b, a
	ld c, 01 ; 1 in c means player has smaller Y, same x
	scf ; sets c for the ret
	ret
.setDown ; 3214
	ld b, a ; b is difference in y
	ld c, 00 ; 0 in c means player has bigger Y, same x
	scf ; set c
	ret
.equalY ; 3219 
	ld hl, $0010
	add hl, bc
	ld a, [wPlayerStandingMapX]
	sub [hl]
	jr z, .reset ; if px == ox, jump (this is impossible)
	jr nc, .setRight ; if px > ox, jump
	cpl
	inc a
	ld b, a
	ld c, 02 ; 2 in c means player has smaller x, equal y
	scf
	ret
.setRight ; 322C
	ld b, a
	ld c, 03 ; 3 in c means player has bigger x, equal y
	scf
	ret
.reset ; 3231
	and a ; clear c
	ret
	
CheckAPressedDebug ; 3233
	ld a, [wce63]
	bit 1, a
	ret z ; return if not debug
	ldh a, [hJoyState]
	bit A_BUTTON, a
	ret

ClearAccumulator:: ; 323E
	xor a ; clear a
	ret
	
SetFFInAccumulator:: ; 3240
	xor a
	dec a
	ret
	
; 3243