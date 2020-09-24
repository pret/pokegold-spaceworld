include "constants.asm"
INCLUDE "hack/text/SilentLabP1.inc"

SECTION "scripts/SilentHillLabFront.asm", ROMX

SilentHillLabFront_ScriptLoader::
	ld hl, SilentHillLabFrontScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillLabFrontScriptPointers:
	dw SilentHillLabFrontScript1
	dw SilentHillLabFrontNPCIDs1

	dw SilentHillLabFrontScript2
	dw SilentHillLabFrontNPCIDs2

	dw SilentHillLabFrontScript3
	dw SilentHillLabFrontNPCIDs2

	dw SilentHillLabFrontScript4
	dw SilentHillLabFrontNPCIDs2

	dw SilentHillLabFrontConversation1
	dw SilentHillLabFrontNPCIDs2

	dw SilentHillLabFrontScript6
	dw SilentHillLabFrontNPCIDs3

	dw SilentHillLabFrontScript7
	dw SilentHillLabFrontNPCIDs4

	dw SilentHillLabFrontScript8
	dw SilentHillLabFrontNPCIDs5

	dw SilentHillLabFrontScript9
	dw SilentHillLabFrontNPCIDs5

	dw SilentHillLabFrontScript10
	dw SilentHillLabFrontNPCIDs5

	dw SilentHillLabFrontScript11
	dw SilentHillLabFrontNPCIDs5

	dw SilentHillLabFrontScript12
	dw SilentHillLabFrontNPCIDs6

	dw SilentHillLabFrontScript13
	dw SilentHillLabFrontNPCIDs6

	dw SilentHillLabFrontScript14
	dw SilentHillLabFrontNPCIDs6

	dw SilentHillLabFrontScript15
	dw SilentHillLabFrontNPCIDs7

	dw SilentHillLabFrontScript16
	dw SilentHillLabFrontNPCIDs7

	dw SilentHillLabFrontScript17
	dw SilentHillLabFrontNPCIDs7

	dw SilentHillLabFrontScript18
	dw SilentHillLabFrontNPCIDs7

	dw SilentHillLabFrontScript19
	dw SilentHillLabFrontNPCIDs9

SilentHillLabFrontNPCIDs1:
	db $02
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs2:
	db $00
	db $02
	db $04
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs3:
	db $02
	db $04
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs4:
	db $04
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs5:
	db $01
	db $03
	db $05
	db $06
	db $07
	db $08
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs6:
	db $01
	db $03
	db $05
	db $06
	db $07
	db $08
	db $FF
SilentHillLabFrontNPCIDs7:
	db $00
	db $05
	db $06
	db $07
	db $08
	db $FF
SilentHillLabFrontNPCIDs8: ; (unused?)
	db $00
	db $03
	db $05
	db $06
	db $07
	db $08
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs9:
	db $00
	db $07
	db $08
	db $FF

SilentHillLabFront_TextPointers::
	dw SilentHillLabFrontText4
	dw SilentHillLabFrontText7
	dw SilentHillLabFrontText10
	dw SilentHillLabFrontText11
	dw SilentHillLabFrontTextString20
	dw SilentHillLabFrontText12
	dw SilentHillLabFrontText13
	dw SilentHillLabFrontText14
	dw SilentHillLabFrontText15
	dw SilentHillLabFrontText16
	dw SilentHillLabFrontText16

SilentHillLabFrontScript1:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontNPCIDs1
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontMoveDown:
	ld a, [wXCoord]
	cp 4
	ret nz
	ld a, [wYCoord]
	cp 1
	ret nz
	ldh a, [hJoyState]
	bit 6, a
	jp z, SetFFInAccumulator
	call SilentHillLabFrontText3
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentHillLabFrontMovement1
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	call ClearAccumulator
	ret

SilentHillLabFrontMovement1:
	db $06, $32

SilentHillLabFrontScript2:
	ld a, 2
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontScript3:
	ld a, 6
	call Function17f9
	ld a, 0
	call Function186a
	ld b, 6
	ld c, 0
	call StartFollow
	ld hl, SilentHillLabFrontMovement2
	ld a, 6
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 3
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentHillLabFrontMovement2:
	db 09, 09, 09, 09, 09, 09, 09, 09, 09, 05, 07, 01, $32

SilentHillLabFrontScript4:
	call Function1828
	ld a, 4
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontConversation1:
	ld a, 4
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString20
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString4
	call OpenTextbox
	ld a, 4
	ld d, UP
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString28
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString5
	call OpenTextbox
	ld a, 4
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString29
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString7
	call OpenTextbox
	call SilentHillLabFrontScript5
	ret

SilentHillLabFrontScript5:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 2
	call Function17f9
	ld a, 2
	ld hl, SilentHillLabFrontMovement3
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 5
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentHillLabFrontMovement3:
	db 9, 5, $33

SilentHillLabFrontScript6:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 4
	call Function17f9
	ld a, 4
	ld hl, SilentHillLabFrontMovement4
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 6
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentHillLabFrontMovement4:
	db $0D, $0D, $0F, $0D, $0D, $33

SilentHillLabFrontScript7:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentHillLabFrontMovement5
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 7
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentHillLabFrontMovement5:
	db 09, 09, 09, 05, $32

SilentHillLabFrontScript8:
	ld a, 3
	call Function1989
	ld a, 5
	call Function1989
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentHillLabFrontMovement6
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 8
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentHillLabFrontMovement6:
	db 8, 8, 8, $0A, 6, $32

SilentHillLabFrontScript9:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call Function17f9
	ld a, 5
	call Function197e
	ld a, 5
	ld hl, SilentHillLabFrontMovement7
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 9
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentHillLabFrontMovement7:
	db $08, $08, $08, $08, $0A, $06, $32

SilentHillLabFrontScript10:
	ld a, 5
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString21
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	ld d, RIGHT
	call SetObjectFacing
	ld a, 5
	ld d, RIGHT
	call SetObjectFacing
	ld a, 3
	call Function17f9
	ld a, 3
	call Function197e
	ld a, 3
	ld hl, SilentHillLabFrontMovement8
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $0A
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentHillLabFrontMovement8:
	db $08, $04, $32

SilentHillLabFrontScript11:
	ld hl, SilentHillLabFrontTextString8
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString9
	call OpenTextbox
	ld a, $0B
	call Function1617
	ld a, $0C
	call Function1617
	ld hl, SilentHillLabFrontTextString10
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString15
	call OpenTextbox
	ld hl, wd41c
	set 4, [hl]
	call Function20f8
	ld a, $0B
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret

SilentHillLabFrontScript12:
	call SilentHillLabFrontMoveDown
	ret z
	call SilentHillLabFrontRivalMovePokemon
	ret z
	ld hl, SilentHillLabFrontNPCIDs6
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontRivalMovePokemon:
	ld a, [wYCoord]
	cp 8
	ret nz
	ld hl, SilentHillLabFrontMovement9
	ld a, [wXCoord]
	cp 3
	jr z, .jump
	cp 4
	ret nz
	ld hl, SilentHillLabFrontMovement10
.jump
	push hl
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call Function17f9
	pop hl
	ld a, 5
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $0C
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	call ClearAccumulator
	ret

SilentHillLabFrontMovement9:
	db $08, $0B, $0B, $08, $08, $04, $32

SilentHillLabFrontMovement10:
	db $08, $0B, $08, $08, $04, $32

SilentHillLabFrontScript13:
	ld hl, SilentHillLabFrontTextString17
	call OpenTextbox
	call GetLabPokemon
	ld hl, wc5ed
	set 7, [hl]
	ld a, 8
	ld [wd637], a
	ld a, $0D
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret

GetLabPokemon:
	ld hl, LabPokemon
	ld a, [wd266]
	ld b, a
.loop
	ld a, [hl+]
	cp b
	jr nz, .jump
	ld a, [hl]
	ld [wce05], a
	ld a, 9
	ld [wce02], a
	ret
.jump
	inc hl
	jr .loop

LabPokemon:
	db DEX_KURUSU
	db 1
	db DEX_HAPPA
	db 2
	db DEX_HONOGUMA
	db 3

SilentHillLabFrontScript14:
	ld hl, SilentHillLabFrontTextString19
	ld a, [wcd5d]
	and a
	jr nz, .skip
	ld hl, SilentHillLabFrontTextString18
.skip
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call Function17f9
	ld a, 5
	ld hl, SilentHillLabFrontMovement11
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $0E
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentHillLabFrontMovement11:
	db $04, $08, $08, $08, $33

SilentHillLabFrontScript15:
	call Function20f8
	ld a, $0F
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret

SilentHillLabFrontScript16:
	call SilentHillLabFrontMoveDown
	ret z
	call SilentHillLabFrontMoveRivalLeave
	ret z
	ld hl, SilentHillLabFrontNPCIDs7
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontMoveRivalLeave:
	ld a, [wYCoord]
	cp $0B
	ret nz
	ld hl, Movememt12+1
	ld a, [wXCoord]
	cp 3
	jr z, .jump
	cp 4
	ret nz
	ld hl, Movememt12
.jump
	push hl
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 8
	call Function17f9
	pop hl
	ld a, 8
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $10
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	call ClearAccumulator
	ret

Movememt12:
	db $07, $07, $07, $05, $32

SilentHillLabFrontScript17:
	ld hl, SilentHillLabFrontTextString23
	call OpenTextbox
	ld hl, wd41d
	set 2, [hl]
	ld hl, wNumBagItems
	ld a, 5
	ld [wCurItem], a
	ld a, 6
	ld [wItemQuantity], a
	call ReceiveItem
	call Function20f8
	ld a, $11
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontScript18:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontNPCIDs7
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontScript19:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontNPCIDs9
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontTextPointers2:
	dw SilentHillLabFrontText1
	dw SilentHillLabFrontText2
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw Function3899
	dw SilentHillLabFrontText3

SilentHillLabFrontText1:
	ld hl, SilentHillLabFrontTextString1
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString1:
	text_SilentLabP1TextString1
	
SilentHillLabFrontText2:
	ld hl, wd39d
	bit 0, [hl]
	set 0, [hl]
	jr z, .jump
	res 0, [hl]
	ld hl, SilentHillLabFrontTextString2A
	jr .skip
.jump
	ld hl, SilentHillLabFrontTextString2B
.skip
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString2A:
	text_SilentLabP1TextString2A
	
SilentHillLabFrontTextString2B:
	text_SilentLabP1TextString2B
	
SilentHillLabFrontText3:
	ld hl, SilentHillLabFrontTextString3
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString3:
	text_SilentLabP1TextString3
	
SilentHillLabFrontText4:
	ld a, [wMapScriptNumber]
	cp $0E
	jp nc, SilentHillLabFrontText7
	ld hl, SilentHillLabFrontTextString4
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString4:
	text_SilentLabP1TextString4
	
SilentHillLabFrontTextString5:
	text_SilentLabP1TextString5
	db $08

SilentHillLabFrontText6:
	call YesNoBox
	jr c, .jump
.loop
	ld hl, SilentHillLabFrontTextString6A
	call PrintText
	call Function3036
	ret

.jump
	ld hl, SilentHillLabFrontTextString6B
	call PrintText
	call YesNoBox
	jr c, .jump
	jr .loop
	
SilentHillLabFrontTextString6A:
	text_SilentLabP1TextString6A
	
SilentHillLabFrontTextString6B:
	text_SilentLabP1TextString6B
	
SilentHillLabFrontTextString7:
	text_SilentLabP1TextString7
	
SilentHillLabFrontText7:
	ld a, [wMapScriptNumber]
	cp $12
	jr z, .jump
	ld hl, SilentHillLabFrontTextString11A
	call OpenTextbox
	ret

.jump
	ld hl, SilentHillLabFrontTextString11B
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString8:
	text_SilentLabP1TextString8
	
SilentHillLabFrontTextString9:
	text_SilentLabP1TextString9
	
SilentHillLabFrontTextString10:
	text_SilentLabP1TextString10
	
SilentHillLabFrontTextString11A:
	text_SilentLabP1TextString11A
	
SilentHillLabFrontTextString11B:
	text_SilentLabP1TextString11B
	
SilentHillLabFrontText8:
	ld hl, SilentHillLabFrontTextString12
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString12:
	text_SilentLabP1TextString12
	
SilentHillLabFrontText9:
	ld hl, SilentHillLabFrontTextString13
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString13:
	text_SilentLabP1TextString13
	
SilentHillLabFrontText10:
	ld hl, SilentHillLabFrontTextString14
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString14:
	text_SilentLabP1TextString14
	
SilentHillLabFrontText11:
	ld hl, SilentHillLabFrontTextString16
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString15:
	text_SilentLabP1TextString15
	
SilentHillLabFrontTextString16:
	text_SilentLabP1TextString16
	
SilentHillLabFrontTextString17:
	text_SilentLabP1TextString17
	
SilentHillLabFrontTextString18:
	text_SilentLabP1TextString18
	
SilentHillLabFrontTextString19:
	text_SilentLabP1TextString19
	
SilentHillLabFrontTextString20:
	text_SilentLabP1TextString20
	
SilentHillLabFrontTextString21:
	text_SilentLabP1TextString21
	
SilentHillLabFrontText12:
	ld hl, SilentHillLabFrontTextString22
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString22:
	text_SilentLabP1TextString22
	
SilentHillLabFrontText13:
	ld hl, SilentHillLabFrontTextString24
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString23:
	text_SilentLabP1TextString23
	
SilentHillLabFrontTextString24:
	text_SilentLabP1TextString24
	
SilentHillLabFrontText14:
	ld hl, SilentHillLabFrontTextString25
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString25:
	text_SilentLabP1TextString25
	
SilentHillLabFrontText15:
	ld hl, SilentHillLabFrontTextString26
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString26:
	text_SilentLabP1TextString26
	
SilentHillLabFrontText16:
	ld hl, SilentHillLabFrontTextString27
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString27:
	text_SilentLabP1TextString27
	
SilentHillLabFrontText17:
	ld hl, SilentHillLabFrontTextString28
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString28:
	text_SilentLabP1TextString28
	
SilentHillLabFrontTextString29:
	text_SilentLabP1TextString29
	
SilentHillLabFrontText18:
	ld hl, SilentHillLabFrontTextString30
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString30:
	text_SilentLabP1TextString30
	
SilentHillLabFrontText19:
	ld hl, SilentHillLabFrontTextString31
	call OpenTextbox
	ret
	
SilentHillLabFrontTextString31:
	text_SilentLabP1TextString31

SilentHillLabFrontPadding:
	textpad_SilentLabP1
