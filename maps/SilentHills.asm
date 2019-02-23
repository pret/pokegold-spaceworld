include "constants.asm"
INCLUDE "hack/text/SilentHills.inc"

SECTION "Silent Hills Script", ROMX[$7669], BANK[$36]

SilentHillsScriptLoader:: ; 7669
	ld hl, SilentHillsScriptPointers1
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentHillsNPCIDs1: ; 7673
	db 0
	db 2
	db 3
	db $FF
	
SilentHillsNPCIDs2: ; 7677
	db 2
	db 3
	db $FF
	
SilentHillsNPCIDs3: ; 767A
	db 1
	db 2
	db 3
	db $FF
	
SilentHillsScriptPointers1: ; 767E
	dw SilentHillsScript1
	dw SilentHillsNPCIDs1 
	
SilentHillsScriptPointers2: ; 7682
	dw SilentHillsScript2 
	dw SilentHillsNPCIDs1 
	
SilentHillsScriptPointers3: ; 7686
	dw SilentHillsScript3 
	dw SilentHillsNPCIDs1 
	
SilentHillsScriptPointers4: ; 768A
	dw SilentHillsScript4 
	dw SilentHillsNPCIDs2 
	
SilentHillsScriptPointers5: ; 768E
	dw SilentHillsScript5 
	dw SilentHillsNPCIDs3 
	
SilentHillsScriptPointers6: ; 7692
	dw SilentHillsScript6 
	dw SilentHillsNPCIDs2 
	
SilentHillsScriptPointers7: ; 7696
	dw SilentHillsScript7 
	dw SilentHillsNPCIDs2 
	
SilentHillsScript1: ; 769A
	ld a, [wYCoord]
	cp 5
	ret nz
	ld a, [wXCoord]
	cp 5
	ret nz
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 02
	call Function17f9
	ld a, 02
	ld hl, SilentHillsMovement1
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentHillsMovement1: ; 76C8
	db $0D 
	db $0D 
	db $0D 
	db $09 
	db $05 
	db $02 
	db $32
	
SilentHillsScript2: ; 76CF
	ld a, 0
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillsTextRival1
	call OpenTextbox
	ld hl, SilentHillsTextRival2
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 2
	ld hl, SilentHillsMovement2
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ld a, 2
	ld [wMapScriptNumber], a
	ret
	
SilentHillsMovement2: ; 76FF
	db $00, $04, $08, $0C, $0C, $0C, $33
	
SilentHillsScript3: ;7706
	call Function1848
	ld a, 3
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret
	
SilentHillsScript4: ; 7712
	ld a, [wXCoord]
	cp 0
	jr nz, .bigjump
	ld a, [wYCoord]
	cp 8
	jr z, .jump
	cp 09
	jr nz, .bigjump
.jump
	call Function776a
	ld hl, SilentHillsTextNorthExit
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 3
	call Function15ed
	ld a, 3
	call Function17f9
	ld a, [wYCoord]
	cp 9
	jr z, .jump2
	ld hl, SilentHillsMovement3
	jr .skip
.jump2
	ld hl, SilentHillsMovement4
.skip
	ld a, 03
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ld a, 4
	ld [wMapScriptNumber], a
	ret

.bigjump	
	ld hl, SilentHillsNPCIDs2
	ld de, SilentHillsTextPointers
	call CallMapTextSubroutine
	ret
	
Function776a: ; 776A
	ld hl, wd41a
	set 7, [hl]
	ld a, 1
	ld hl, wd29d
	ld [hl], a
	ret
	
SilentHillsMovement3: ; 7776
	db $0A, $0A, $0A, $09, $0A, $06, $02, $32
	
SilentHillsMovement4: ; 777E
	db $0A, $0A, $0A, $0A, $06, $02, $32
	
SilentHillsScript5: ; 7785
	ld a, 0
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillsTextPokemonInGrassString
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 3
	call Function17f9
	ld a, 0
	call Function186a
	ld b, 3
	ld c, 0
	call StartFollow
	ld a, [wYCoord]
	cp 9
	jr z, .jump
	ld hl, SilentHillsMovement5
	jr .skip
.jump	
	ld hl, SilentHillsMovement6
.skip
	ld a, 3
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ld a, 5
	ld [wMapScriptNumber], a
	ret
	
SilentHillsMovement5: ; 77CC
	db $0B, $0B, $0B, $0B, $0B, $0B, $08, $08, $08, $08, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $05, $33
	
SilentHillsMovement6: ; 77E0
	db $0B, $0B, $0B, $0B, $0B, $0B, $08, $08, $08, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $05, $33
	
SilentHillsScript6: ; 77F3
	ld hl, SilentHillsNPCIDs2
	ld de, SilentHillsTextPointers
	call CallMapTextSubroutine
	ld hl, wd41b
	bit 2, [hl]
	ret z
	ld a, $12
	ld [wd29d], a
	ld a, 6
	ld [wMapScriptNumber], a
	ret
	
SilentHillsScript7: ; 780D
	call CheckLabDoor 
	ret z
	ld hl, SilentHillsNPCIDs2
	ld de, SilentHillsTextPointers
	call CallMapTextSubroutine
	ret
	
CheckLabDoor: ; 781B
	ld a, [wYCoord]
	cp $C
	ret nz
	ld a, [wXCoord]
	cp $E
	jr z, .jump
	ld a, [wXCoord]
	cp $F
	ret nz
.jump
	ldh a, [hJoyState]
	bit 6, a
	ret z
	ld a, 0
	ld d, UP
	call SetObjectFacing
	ld hl, wJoypadFlags
	set 6, [hl]
	ld hl, SilentHillsTextString1
	call OpenTextbox
	call LabClosed
	call ClearAccumulator
	ret
	
LabClosed: ; 784C
	ld a, 0
	ld hl, SilentHillsMovement7
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ret
	
SilentHillsTextString1: ; 785F
	text_SilentHillsTextString1
	
SilentHillsMovement7: ; 786F
	db $04, $32

SilentHillsTextPointers: ; 7871
	dw SilentHillsPlayerHouseText 
	dw Function38c6 
	dw SilentHillsSignText1 
	dw SilentHillsLabText 
	dw SilentHillsRivalHouseText
	
SilentHillsLabText: ; 787B
	ld hl, SilentHillsTextString2 
	call OpenTextbox
	ret
	
SilentHillsTextString2: ; 7882
	text_SilentHillsTextString2
	
SilentHillsSignText1: ; 7894
	ld hl, SilentHillsTextString3
	call OpenTextbox
	ret
	
SilentHillsTextString3: ; 789B
	text_SilentHillsTextString3
	
SilentHillsPlayerHouseText: ; 78B1
	ld hl, SilentHillsTextString4
	call OpenTextbox
	ret
	
SilentHillsTextString4: ; 78B8
	text_SilentHillsTextString4
	
SilentHillsRivalHouseText: ; 78C3
	ld hl, SilentHillsTextString5
	call OpenTextbox
	ret
	
SilentHillsTextString5: ; 78CA
	text_SilentHillsTextString5
	
; 78D5
	dw SilentHillsTextRival1 ; west
	dw SilentHillsTextNorthExit ; north
	dw SilentHillsTextBackpack ; npc1
	dw SilentHillsTextPokemonHate ; npc2

SilentHillsTextRival1: ; 78DD
	text_SilentHillsTextRival1
	
	db $08
	
LoadMomNamePromptUnused: ; 796F
	call LoadStandardMenuHeader 
	callab MomNamePrompt
	call CloseWindow
	call GetMemSGBLayout
	call UpdateSprites
	call UpdateTimePals
	jp Function3036
	
MomNameMenuHeaderUnused: ; 7989
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, 10, 11
	dw .MomNameMenuDataUnused
	db 01 ; initial selection
	
.MomNameMenuDataUnused: ; 7991
	db STATICMENU_CURSOR
	db 04 ; items
	text_MomNameMenuHeaderUnused
	
SilentHillsTextRival2: ; 79AC - BYTE OFF
	text_SilentHillsTextRival2
	
SilentHillsTextNorthExit: ; 7A14
	text_SilentHillsTextNorthExit
	
SilentHillsTextPokemonInGrassString: ; 7A2A
	text_SilentHillsTextPokemonInGrassString
	
SilentHillsTextBackpack: ; 7A99
	ld hl, SilentHillsTextBackpackString
	call OpenTextbox 
	ret
	
SilentHillsTextBackpackString: ; 7AA0
	text_SilentHillsTextBackpackString
	
SilentHillsTextPokemonHate: ; 7AC0
	ld hl, SilentHillsTextPokemonHateString
	call OpenTextbox
	ret
	
SilentHillsTextPokemonHateString: ; 7AC7
	text_SilentHillsTextPokemonHateString
	
; 7AE4