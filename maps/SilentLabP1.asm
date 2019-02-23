include "constants.asm"
INCLUDE "hack/text/SilentLabP1.inc"

SECTION "Silent Lab P1", ROMX[$4BBC], BANK[$34]

SilentLabP1ScriptLoader:: ; 4BBC
	ld hl, SilentLabP1ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentLabP1ScriptPointers: ; 4BC6
	dw SilentLabP1Script1 
	dw SilentLabP1NPCIDs1 
	
	dw SilentLabP1Script2 
	dw SilentLabP1NPCIDs2 
	
	dw SilentLabP1Script3 
	dw SilentLabP1NPCIDs2 
	
	dw SilentLabP1Script4 
	dw SilentLabP1NPCIDs2 
	
	dw SilentLabP1Conversation1 
	dw SilentLabP1NPCIDs2 
	
	dw SilentLabP1Script6 
	dw SilentLabP1NPCIDs3 
	
	dw SilentLabP1Script7 
	dw SilentLabP1NPCIDs4 
	
	dw SilentLabP1Script8 
	dw SilentLabP1NPCIDs5 
	
	dw SilentLabP1Script9 
	dw SilentLabP1NPCIDs5 
	
	dw SilentLabP1Script10 
	dw SilentLabP1NPCIDs5 
	
	dw SilentLabP1Script11 
	dw SilentLabP1NPCIDs5 
	
	dw SilentLabP1Script12 
	dw SilentLabP1NPCIDs6 
	
	dw SilentLabP1Script13 
	dw SilentLabP1NPCIDs6 
	
	dw SilentLabP1Script14 
	dw SilentLabP1NPCIDs6 
	
	dw SilentLabP1Script15 
	dw SilentLabP1NPCIDs7 
	
	dw SilentLabP1Script16 
	dw SilentLabP1NPCIDs7 
	
	dw SilentLabP1Script17 
	dw SilentLabP1NPCIDs7 
	
	dw SilentLabP1Script18 
	dw SilentLabP1NPCIDs7 
	
	dw SilentLabP1Script19 
	dw SilentLabP1NPCIDs9 
	
SilentLabP1NPCIDs1: ; 4C12
	db $02
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs2: ; 4C16
	db $00 
	db $02 
	db $04 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs3: ; 4C1C
	db $02 
	db $04 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs4: ; 4C21
	db $04 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs5: ; 4C25
	db $01 
	db $03 
	db $05 
	db $06 
	db $07 
	db $08 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs6: ; 4C2E
	db $01 
	db $03 
	db $05 
	db $06 
	db $07 
	db $08 
	db $FF 
SilentLabP1NPCIDs7: ; 4C35
	db $00 
	db $05 
	db $06 
	db $07 
	db $08 
	db $FF 
SilentLabP1NPCIDs8: ; 4C3B (unused?)
	db $00 
	db $03 
	db $05 
	db $06 
	db $07 
	db $08 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs9: ; 4C44
	db $00 
	db $07 
	db $08 
	db $FF
	
SilentLabP1TextPointers1:: ; 4C48
	dw SilentLabP1Text4 
	dw SilentLabP1Text7 
	dw SilentLabP1Text10 
	dw SilentLabP1Text11 
	dw SilentLabP1TextString20 
	dw SilentLabP1Text12 
	dw SilentLabP1Text13 
	dw SilentLabP1Text14 
	dw SilentLabP1Text15 
	dw SilentLabP1Text16 
	dw SilentLabP1Text16 
	
SilentLabP1Script1: ; 4C5E
	call SilentLabP1MoveDown
	ret z
	ld hl, SilentLabP1NPCIDs1
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1MoveDown: ; 4C6C
	ld a, [wXCoord]
	cp 4
	ret nz
	ld a, [wYCoord]
	cp 1
	ret nz
	ldh a, [hJoyState]
	bit 6, a
	jp z, SetFFInAccumulator
	call SilentLabP1Text3
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentLabP1Movement1
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	call ClearAccumulator
	ret
	
SilentLabP1Movement1: ; 4CA2
	db $06, $32
	
SilentLabP1Script2: ; 4CA4
	ld a, 2
	ld [wMapScriptNumber], a
	ret
	
SilentLabP1Script3: ; 4CAA
	ld a, 6
	call Function17f9
	ld a, 0
	call Function186a
	ld b, 6
	ld c, 0
	call StartFollow
	ld hl, SilentLabP1Movement2
	ld a, 6
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 3
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement2: ; 4CD3
	db 09, 09, 09, 09, 09, 09, 09, 09, 09, 05, 07, 01, $32
	
SilentLabP1Script4: ; 4CE0
	call Function1828
	ld a, 4
	ld [wMapScriptNumber], a 
	ret
	
SilentLabP1Conversation1: ; 4CE9
	ld a, 4
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentLabP1TextString20
	call OpenTextbox
	ld hl, SilentLabP1TextString4
	call OpenTextbox
	ld a, 4
	ld d, UP
	call SetObjectFacing
	ld hl, SilentLabP1TextString28
	call OpenTextbox
	ld hl, SilentLabP1TextString5
	call OpenTextbox
	ld a, 4
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentLabP1TextString29
	call OpenTextbox
	ld hl, SilentLabP1TextString7
	call OpenTextbox
	call SilentLabP1Script5
	ret
	
SilentLabP1Script5: ; 4D26
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 2
	call Function17f9
	ld a, 2
	ld hl, SilentLabP1Movement3
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 5
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement3: ; 4D48
	db 9, 5, $33
	
SilentLabP1Script6: ; 4D4B
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 4
	call Function17f9
	ld a, 4
	ld hl, SilentLabP1Movement4
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 6
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentLabP1Movement4: ; 4D6D
	db $0D, $0D, $0F, $0D, $0D, $33
	
SilentLabP1Script7: ; 4D73
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentLabP1Movement5
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 7
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement5: ; 4D95
	db 09, 09, 09, 05, $32
	
SilentLabP1Script8: ; 4D9A
	ld a, 3
	call Function1989
	ld a, 5
	call Function1989
	ld hl, wJoypadFlags
	set 4, [hl] 
	ld a, 0 
	call Function17f9 
	ld a, 0 
	ld hl, SilentLabP1Movement6
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 8
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement6: ; 4DC6
	db 8, 8, 8, $0A, 6, $32
	
SilentLabP1Script9: ; 4DCC
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call Function17f9
	ld a, 5
	call Function197e
	ld a, 5
	ld hl, SilentLabP1Movement7
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 9
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement7: ; 4DF3
	db $08, $08, $08, $08, $0A, $06, $32
	
SilentLabP1Script10: ; 4DFA
	ld a, 5
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentLabP1TextString21
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
	ld hl, SilentLabP1Movement8
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $0A
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement8: ; 4E3C
	db $08, $04, $32
	
SilentLabP1Script11: ; 4E3F
	ld hl, SilentLabP1TextString8
	call OpenTextbox
	ld hl, SilentLabP1TextString9
	call OpenTextbox
	ld a, $0B
	call Function1617
	ld a, $0C
	call Function1617
	ld hl, SilentLabP1TextString10
	call OpenTextbox
	ld hl, SilentLabP1TextString15
	call OpenTextbox
	ld hl, wd41c
	set 4, [hl]
	call Function20f8
	ld a, $0B
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret
	
SilentLabP1Script12: ; 4E72
	call SilentLabP1MoveDown
	ret z
	call SilentLabP1RivalMovePokemon
	ret z
	ld hl, SilentLabP1NPCIDs6
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1RivalMovePokemon: ; 4E84
	ld a, [wYCoord]
	cp 8
	ret nz
	ld hl, SilentLabP1Movement9
	ld a, [wXCoord]
	cp 3
	jr z, .jump
	cp 4
	ret nz
	ld hl, SilentLabP1Movement10
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
	
SilentLabP1Movement9: ; 4EDE
	db $08, $0B, $0B, $08, $08, $04, $32
	
SilentLabP1Movement10: ; 4EC5
	db $08, $0B, $08, $08, $04, $32
	
SilentLabP1Script13: ; 4ECB
	ld hl, SilentLabP1TextString17
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
	
GetLabPokemon: ; 4EE7
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
	
LabPokemon: ; 4EFF
	db DEX_KURUSU 
	db 1 
	db DEX_HAPPA 
	db 2 
	db DEX_HONOGUMA 
	db 3 
	
SilentLabP1Script14: ; 4F05
	ld hl, SilentLabP1TextString19
	ld a, [wcd5d]
	and a
	jr nz, .skip
	ld hl, SilentLabP1TextString18
.skip
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call Function17f9
	ld a, 5
	ld hl, SilentLabP1Movement11
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $0E
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement11: ; 4F36
	db $04, $08, $08, $08, $33
	
SilentLabP1Script15: ; 4F3B
	call Function20f8
	ld a, $0F
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret
	
SilentLabP1Script16: ; 4F47
	call SilentLabP1MoveDown
	ret z
	call SilentLabP1MoveRivalLeave
	ret z
	ld hl, SilentLabP1NPCIDs7
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1MoveRivalLeave: ; 4F59
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
	
Movememt12:; 4F93
	db $07, $07, $07, $05, $32
	
SilentLabP1Script17: ; 4F98
	ld hl, SilentLabP1TextString23
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
	
SilentLabP1Script18: ; 4FBC
	call SilentLabP1MoveDown
	ret z
	ld hl, SilentLabP1NPCIDs7
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1Script19: ; 4FCA
	call SilentLabP1MoveDown
	ret z
	ld hl, SilentLabP1NPCIDs9
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1TextPointers2: ; 4FD8
	dw SilentLabP1Text1
	dw SilentLabP1Text2 
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
	dw SilentLabP1Text3 
	
SilentLabP1Text1: ; 4FF6
	ld hl, SilentLabP1TextString1
	call OpenTextbox
	ret
	
SilentLabP1TextString1: ; 4FFD
	text_SilentLabP1TextString1
	
SilentLabP1Text2: ; 50B3
	ld hl, wd39d
	bit 0, [hl]
	set 0, [hl]
	jr z, .jump
	res 0, [hl]
	ld hl, SilentLabP1TextString2A
	jr .skip
.jump
	ld hl, SilentLabP1TextString2B
.skip
	call OpenTextbox
	ret
	
SilentLabP1TextString2A: ; 50CA
	text_SilentLabP1TextString2A
	
SilentLabP1TextString2B: ; 50EA
	text_SilentLabP1TextString2B
	
SilentLabP1Text3: ; 5108
	ld hl, SilentLabP1TextString3
	call OpenTextbox
	ret
	
SilentLabP1TextString3: ; 510F
	text_SilentLabP1TextString3
	
SilentLabP1Text4: ; 511B
	ld a, [wMapScriptNumber]
	cp $0E
	jp nc, SilentLabP1Text7
	ld hl, SilentLabP1TextString4
	call OpenTextbox
	ret
	
SilentLabP1TextString4: ; 512A
	text_SilentLabP1TextString4
	
SilentLabP1TextString5: ; 5138
	text_SilentLabP1TextString5
	db $08
	
SilentLabP1Text6: ; 5192
	call YesNoBox
	jr c, .jump
.loop
	ld hl, SilentLabP1TextString6A
	call PrintText
	call Function3036
	ret

.jump
	ld hl, SilentLabP1TextString6B
	call PrintText
	call YesNoBox
	jr c, .jump
	jr .loop
	
SilentLabP1TextString6A: ; 51AE
	text_SilentLabP1TextString6A
	
SilentLabP1TextString6B: ; 5332
	text_SilentLabP1TextString6B
	
SilentLabP1TextString7: ; 538D
	text_SilentLabP1TextString7
	
SilentLabP1Text7: ; 53AA
	ld a, [wMapScriptNumber]
	cp $12
	jr z, .jump
	ld hl, SilentLabP1TextString11A
	call OpenTextbox
	ret

.jump	
	ld hl, SilentLabP1TextString11B
	call OpenTextbox
	ret
	
SilentLabP1TextString8: ; 53BF
	text_SilentLabP1TextString8
	
SilentLabP1TextString9: ; 53DE
	text_SilentLabP1TextString9
	
SilentLabP1TextString10: ; 53F5
	text_SilentLabP1TextString10
	
SilentLabP1TextString11A: ; 54C3
	text_SilentLabP1TextString11A
	
SilentLabP1TextString11B: ; 54E3
	text_SilentLabP1TextString11B
	
SilentLabP1Text8: ; 5560
	ld hl, SilentLabP1TextString12
	call OpenTextbox
	ret
	
SilentLabP1TextString12: ; 5567
	text_SilentLabP1TextString12
	
SilentLabP1Text9: ; 559A
	ld hl, SilentLabP1TextString13
	call OpenTextbox
	ret
	
SilentLabP1TextString13: ; 55A1
	text_SilentLabP1TextString13
	
SilentLabP1Text10: ; 561A
	ld hl, SilentLabP1TextString14
	call OpenTextbox
	ret
	
SilentLabP1TextString14: ; 5621
	text_SilentLabP1TextString14
	
SilentLabP1Text11: ; 5658
	ld hl, SilentLabP1TextString16
	call OpenTextbox
	ret
	
SilentLabP1TextString15: ; 565F
	text_SilentLabP1TextString15
	
SilentLabP1TextString16: ; 5678
	text_SilentLabP1TextString16
	
SilentLabP1TextString17: ; 56A4
	text_SilentLabP1TextString17
	
SilentLabP1TextString18: ; 56D4
	text_SilentLabP1TextString18
	
SilentLabP1TextString19: ; 56EE
	text_SilentLabP1TextString19
	
SilentLabP1TextString20: ; 571F
	text_SilentLabP1TextString20
	
SilentLabP1TextString21: ; 5730
	text_SilentLabP1TextString21
	
SilentLabP1Text12: ; 5814
	ld hl, SilentLabP1TextString22
	call OpenTextbox
	ret
	
SilentLabP1TextString22: ; 581B
	text_SilentLabP1TextString22
	
SilentLabP1Text13: ; 583F
	ld hl, SilentLabP1TextString24
	call OpenTextbox
	ret
	
SilentLabP1TextString23: ; 5846
	text_SilentLabP1TextString23
	
SilentLabP1TextString24: ; 5A23
	text_SilentLabP1TextString24
	
SilentLabP1Text14: ; 5A36
	ld hl, SilentLabP1TextString25
	call OpenTextbox
	ret
	
SilentLabP1TextString25: ; 5A3D
	text_SilentLabP1TextString25
	
SilentLabP1Text15: ; 5A90
	ld hl, SilentLabP1TextString26
	call OpenTextbox
	ret
	
SilentLabP1TextString26: ; 5A97
	text_SilentLabP1TextString26
	
SilentLabP1Text16: ; 5AEA
	ld hl, SilentLabP1TextString27
	call OpenTextbox
	ret
	
SilentLabP1TextString27: ; 5AF1
	text_SilentLabP1TextString27
	
SilentLabP1Text17: ; 5B05
	ld hl, SilentLabP1TextString28
	call OpenTextbox
	ret
	
SilentLabP1TextString28: ; 5B0D
	text_SilentLabP1TextString28
	
SilentLabP1TextString29: ; 5B4F
	text_SilentLabP1TextString29
	
SilentLabP1Text18: ; 5B68
	ld hl, SilentLabP1TextString30
	call OpenTextbox
	ret
	
SilentLabP1TextString30: ; 5B6F
	text_SilentLabP1TextString30
	
SilentLabP1Text19: ; 5BA7
	ld hl, SilentLabP1TextString31
	call OpenTextbox
	ret
	
SilentLabP1TextString31: ; 5BAE
	text_SilentLabP1TextString31
	
; 5BE6