include "constants.asm"
INCLUDE "hack/text/SilentLabP2.inc"

SECTION "maps/SilentHillLabBack.asm", ROMX

SilentHillLabBackScriptLoader:: ; 5C69
	ld hl, SilentHillLabBackScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentHillLabBackScriptPointers: ; 5C73
	dw SilentHillLabBackScript1
	dw SilentHillLabBackNPCIDs1
	dw SilentHillLabBackScript2 
	dw SilentHillLabBackNPCIDs1
	dw SilentHillLabBackScript3
	dw SilentHillLabBackNPCIDs1
	dw SilentHillLabBackRivalChoosePokemon
	dw SilentHillLabBackNPCIDs1
	dw SilentHillLabBackScript5 
	dw SilentHillLabBackNPCIDs1 
	dw SilentHillLabBackScript6 
	dw SilentHillLabBackNPCIDs1 
	dw SilentHillLabBackScript7
	dw SilentHillLabBackNPCIDs1
	
SilentHillLabBackNPCIDs1: ; 5C8F
	db 00, 01, 02, 03, 04, $FF 
SilentHillLabBackNPCIDs2: ; 5C95
	db 00, 01, 04, $FF 
SilentHillLabBackNPCIDs3: ; 5C99
	db 00, 01, 02, $FF 
SilentHillLabBackNPCIDs4: ; 5C9D
	db 00, 01, 03, $FF
	
SilentHillLabBackTextPointers:: ; 5CA1 
	dw SilentHillLabBackText1
	dw SilentHillLabBackFunc3
	dw SilentHillLabBackFunc4 
	dw SilentHillLabBackFunc4
	dw SilentHillLabBackFunc4
	
SilentHillLabBackScript1: ; 5CAB
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentHillLabBackMovement1
	call LoadMovementDataPointer
	ld hl, wd41b
	set 1, [hl]
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentHillLabBackMovement1: ; 5CD2
	db 09, 09, 05, $32
	
SilentHillLabBackScript2: ; 5CD6
	ld hl, wc5ed
	set 6, [hl]
	call Function20f8
	ld a, 3
	ld d, UP
	call SetObjectFacing
	ld hl, SilentHillLabBackTextString1
	call OpenTextbox
	ld hl, SilentHillLabBackTextString10
	call OpenTextbox
	ld hl, SilentHillLabBackTextString2
	call OpenTextbox
	ld a, 2
	ld [wMapScriptNumber], a
	ret
	
SilentHillLabBackScript3: ; 5CFD
	ld hl, SilentHillLabBackNPCIDs1
	ld de, SilentHillLabBackTextPointers2
	call CallMapTextSubroutine
	ret
	
SilentHillLabBackRivalChoosePokemon: ; 5D07
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 3
	call Function17f9
	ld hl, SilentHillLabBackMovementPointers
	ld a, [wChosenStarter]
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld a, 3
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 4
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentHillLabBackMovementPointers: ; 5D34
	dw SilentHillLabBackMovement2+1
	dw SilentHillLabBackMovement2
	dw SilentHillLabBackMovement2+2
	
SilentHillLabBackMovement2: ; 5D3A
	db $0B, $0B, $0B, $0B, $05, $32
	
SilentHillLabBackScript5: ; 5D40
	ld hl, SilentHillLabBackTextString12
	call OpenTextbox
	ld a, [wd266]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, SilentHillLabBackTextString13
	call OpenTextbox
	ld a, 5
	ld [wMapScriptNumber], a
	ret
	
SilentHillLabBackScript6: ; 5D5B
	call Function20f8
	ld hl, wc5ed
	res 6, [hl]
	ld a, 6
	ld[wMapScriptNumber], a
	ret
	
SilentHillLabBackScript7: ; 5D69
	ld hl, SilentHillLabBackNPCIDs1
	ld de, SilentHillLabBackTextPointers2
	call CallMapTextSubroutine
	ret
	
SilentHillLabBackText1: ; 5D73
	ld hl, wd41b
	bit 2, [hl]
	ld hl, SilentHillLabBackTextString3
	jr z, .skip
	ld hl, SilentHillLabBackTextString9
.skip
	call OpenTextbox
	ret
	
SilentHillLabBackTextString1: ; 5D84
	text_SilentLabP2TextString1
	
SilentHillLabBackTextString2: ; 5DCD
	text_SilentLabP2TextString2
	
SilentHillLabBackTextString3: ; 5DEF
	text_SilentLabP2TextString3
	
SilentHillLabBackTextString4: ; 5E1C
	text_SilentLabP2TextString4_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString4_2
	db 08
	call ConfirmPokemonSelection 
	call Function3036
	ret
	
SilentHillLabBackTextString5: ; 5E32
	text_SilentLabP2TextString5_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString5_2
	db 08
	call ConfirmPokemonSelection 
	call Function3036
	ret
	
SilentHillLabBackTextString6: ; 5E6E
	text_SilentLabP2TextString6_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString6_2
	db 08
	call ConfirmPokemonSelection 
	call Function3036
	ret
	
ConfirmPokemonSelection: ; 5E85
	call YesNoBox
	jr c, .bigJump
	ld hl, wd41b
	set 2, [hl]
	ld a, 1
	ld [wd29b], a
	ld a, 1
	ld [wd29a], a
	ld a, 1
	ld [wd2a0], a
	ld hl, SilentHillLabBackTextString8
	call PrintText
	ld hl, wJoypadFlags
	set 5, [hl]
	ld a, [wd265]
	ld [wMonDexIndex], a
	ld a, 5
	ld [wCurPartyLevel], a
	callab Function60a0
	xor a
	ld [wPartyMon1 + 1], a
	ld a, 3
	ld [wMapScriptNumber], a
	ret
.bigJump ; 5EC6
	ld hl, SilentHillLabBackTextString7
	call PrintText 
	ret
	
SilentHillLabBackTextString7: ; 5ECD
	text_SilentLabP2TextString7
	
SilentHillLabBackTextString8: ; 5EDC
	text_SilentLabP2TextString8_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString8_2
	
SilentHillLabBackTextString9: ; 5F14
	text_SilentLabP2TextString9
	
SilentHillLabBackFunc3: ; 5F4E
	ld hl, wd41b
	bit 2, [hl]
	ld hl, SilentHillLabBackTextString11
	jr z, .skip
	ld hl, SilentHillLabBackTextString14
.skip
	call OpenTextbox
	ret
	
SilentHillLabBackTextString10: ; 5F5F
	text_SilentLabP2TextString10
	
SilentHillLabBackTextString11: ; 5F7B
	text_SilentLabP2TextString11
	
SilentHillLabBackTextString12: ; 5F9F
	text_SilentLabP2TextString12
	
SilentHillLabBackTextString13: ; 5FAD
	text_SilentLabP2TextString13_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString13_2
	
SilentHillLabBackTextString14: ; 5FC5
	text_SilentLabP2TextString14
	
SilentHillLabBackFunc4: ; 5FE9
	ld hl, wd41b
	bit 2, [hl]
	jr nz, .bigjump
	ldh a, [hFFEA]
	sub 2
	ld [wChosenStarter], a
	ld d, 0
	ld e, a
	ld hl, SilentHillLabBackStarterData
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl+]
	ld [wd265], a
	push hl
	ld [wNamedObjectIndexBuffer], a
	callba Function6734
	ld a, [wd265]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	pop hl
	push hl
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	call OpenTextbox
	pop hl
	inc hl
	inc hl
	ld a, [hl]
	ld [wd266], a
	ret
.bigjump
	ld hl, SilentHillLabBackTextString15
	call OpenTextbox
	ret
	
SilentHillLabBackStarterData: ; 6031
	db DEX_HONOGUMA 
	dw $5E09 
	db DEX_KURUSU 
	
	db DEX_KURUSU 
	dw $5E33 
	db DEX_HAPPA

	db DEX_HAPPA 
	dw $5E5C 
	db DEX_HONOGUMA
	
SilentHillLabBackTextString15: ; 603D
	text_SilentLabP2TextString15
	
SilentHillLabBackTextPointers2: ; 6053
	dw Function3899 
	dw Function3899
	dw Function3899
	dw Function3899
	dw MapDefaultText
	
; 605D