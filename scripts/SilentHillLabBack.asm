include "constants.asm"
INCLUDE "hack/text/SilentLabP2.inc"

SECTION "scripts/SilentHillLabBack.asm", ROMX

SilentHillLabBack_ScriptLoader::
	ld hl, SilentHillLabBackScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillLabBackScriptPointers:
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

SilentHillLabBackNPCIDs1:
	db 00, 01, 02, 03, 04, $FF
SilentHillLabBackNPCIDs2:
	db 00, 01, 04, $FF
SilentHillLabBackNPCIDs3:
	db 00, 01, 02, $FF
SilentHillLabBackNPCIDs4:
	db 00, 01, 03, $FF

SilentHillLabBack_TextPointers::
	dw SilentHillLabBackText1
	dw SilentHillLabBackFunc3
	dw SilentHillLabBackFunc4
	dw SilentHillLabBackFunc4
	dw SilentHillLabBackFunc4

SilentHillLabBackScript1:
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

SilentHillLabBackMovement1:
	db 09, 09, 05, $32

SilentHillLabBackScript2:
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

SilentHillLabBackScript3:
	ld hl, SilentHillLabBackNPCIDs1
	ld de, SilentHillLabBackTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabBackRivalChoosePokemon:
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

SilentHillLabBackMovementPointers:
	dw SilentHillLabBackMovement2+1
	dw SilentHillLabBackMovement2
	dw SilentHillLabBackMovement2+2

SilentHillLabBackMovement2:
	db $0B, $0B, $0B, $0B, $05, $32

SilentHillLabBackScript5:
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

SilentHillLabBackScript6:
	call Function20f8
	ld hl, wc5ed
	res 6, [hl]
	ld a, 6
	ld[wMapScriptNumber], a
	ret

SilentHillLabBackScript7:
	ld hl, SilentHillLabBackNPCIDs1
	ld de, SilentHillLabBackTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabBackText1:
	ld hl, wd41b
	bit 2, [hl]
	ld hl, SilentHillLabBackTextString3
	jr z, .skip
	ld hl, SilentHillLabBackTextString9
.skip
	call OpenTextbox
	ret
	
SilentHillLabBackTextString1:
	text_SilentLabP2TextString1
	
SilentHillLabBackTextString2:
	text_SilentLabP2TextString2
	
SilentHillLabBackTextString3:
	text_SilentLabP2TextString3
	
SilentHillLabBackTextString4:
	text_SilentLabP2TextString4_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString4_2
	db 08
	call ConfirmPokemonSelection
	call Function3036
	ret
	
SilentHillLabBackTextString5:
	text_SilentLabP2TextString5_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString5_2
	db 08
	call ConfirmPokemonSelection
	call Function3036
	ret
	
SilentHillLabBackTextString6:
	text_SilentLabP2TextString6_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString6_2
	db 08
	call ConfirmPokemonSelection
	call Function3036
	ret

ConfirmPokemonSelection:
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
.bigJump
	ld hl, SilentHillLabBackTextString7
	call PrintText
	ret
	
SilentHillLabBackTextString7:
	text_SilentLabP2TextString7
	
SilentHillLabBackTextString8:
	text_SilentLabP2TextString8_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString8_2
	
SilentHillLabBackTextString9:
	text_SilentLabP2TextString9
	
SilentHillLabBackFunc3:
	ld hl, wd41b
	bit 2, [hl]
	ld hl, SilentHillLabBackTextString11
	jr z, .skip
	ld hl, SilentHillLabBackTextString14
.skip
	call OpenTextbox
	ret
	
SilentHillLabBackTextString10:
	text_SilentLabP2TextString10
	
SilentHillLabBackTextString11:
	text_SilentLabP2TextString11
	
SilentHillLabBackTextString12:
	text_SilentLabP2TextString12
	
SilentHillLabBackTextString13:
	text_SilentLabP2TextString13_1
	ld bc, wStringBuffer1
	text_SilentLabP2TextString13_2
	
SilentHillLabBackTextString14:
	text_SilentLabP2TextString14
	
SilentHillLabBackFunc4:
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

SilentHillLabBackStarterData:
	db DEX_HONOGUMA
	dw SilentHillLabBackTextString4
	db DEX_KURUSU

	db DEX_KURUSU
	dw SilentHillLabBackTextString5
	db DEX_HAPPA

	db DEX_HAPPA
	dw SilentHillLabBackTextString6
	db DEX_HONOGUMA
	
SilentHillLabBackTextString15:
	text_SilentLabP2TextString15
	
SilentHillLabBackTextPointers2:
	dw Function3899 
	dw Function3899
	dw Function3899
	dw Function3899
	dw MapDefaultText

SilentHillLabBackPadding:
	textpad_SilentLabP2
