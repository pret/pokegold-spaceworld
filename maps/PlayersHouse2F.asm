include "constants.asm"
INCLUDE "hack/text/PlayersHouse2F.inc"

SECTION "Player's House 2F", ROMX[$418B], BANK[$34]

PlayersHouse2FScriptLoader:: ; 418B
	ld hl, PlayersHouse2FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
PlayersHouse2FScriptPointers: ; 4195
	dw PlayersHouse2FScript1 
	dw PlayersHouse2FNPCIDs1 
	dw PlayersHouse2FScript2 
	dw PlayersHouse2FNPCIDs2 
	dw PlayersHouse2FScript3 
	dw PlayersHouse2FDollText 
	
PlayersHouse2FNPCIDs1: ; 41A1
	db 0
	db 1
	db $FF
	
PlayersHouse2FNPCIDs2: ; 41A4
	db 1
	db $FF
	
PlayersHouse2FTextPointers: ; 41A6
	dw Function3899 
	dw PlayersHouse2FRadioText
	dw PlayersHouse2FComputerText 
	dw Function3899 
	dw PlayersHouse2FN64Text 
	
PlayersHouse2FScript1: ; 41B0
	call PlayersHouse2PositionCheck
	ret z
	ld hl, PlayersHouse2FNPCIDs1
	ld de, PlayersHouse2FTextPointers
	call CallMapTextSubroutine
	ret nz
	ret
	
PlayersHouse2PositionCheck: ; 41BF
	ld hl, wd41a
	bit 0, [hl]
	ret nz
	ld a, [wYCoord]
	cp 1
	ret nz
	ld a, [wXCoord]
	cp 9
	ret nz
	ld hl, wJoypadFlags
	set 6, [hl]
	ld a, LEFT
	ld d, 0
	call SetObjectFacing
	ld hl, PlayersHouse2FTextString2
	call OpenTextbox
	call PlayersHouse2FMovePlayer
	call ClearAccumulator
	ret
	
PlayersHouse2FMovePlayer: ; 41EA
	ld a, 0
	ld hl, Movement
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ret
	
Movement: ; 41FD
	db $08
	db $04
	db $32
	
PlayersHouse2FScript2: ; 4200
	ld hl, PlayersHouse2FNPCIDs2
	ld de, PlayersHouse2FTextPointers
	call CallMapTextSubroutine
	ret
	
PlayersHouse2FScript3: ; 420A
	ld hl, wd41a
	bit 3, [hl]
	jr nz, .jump
	ld hl, PlayersHouse2FTextString1
	call OpenTextbox
	ld hl, wd41a
	set 3, [hl]
	ld c, 3
	call DelayFrames
.jump
	ld hl, PlayersHouse2FTextString2
	call OpenTextbox
	ret
	
PlayersHouse2FDollText: ; 4228
	ld hl, PlayersHouse2FTextString3
	call OpenTextbox
	ret
	
PlayersHouse2FRadioText: ; 422F
	ld hl, PlayersHouse2FTextString9
	call OpenTextbox
	ret
	
PlayersHouse2FComputerText: ; 4236
	ld hl, wd41a
	bit 0, [hl]
	jr nz, .jump
	ld hl, PlayersHouse2FTextString5
	call OpenTextbox
	ret

.jump
; 4244
	call RefreshScreen
	callab Function1477D
	call Function1fea
	ret
	
PlayersHouse2FCheckEmail: ; 4253
	call YesNoBox
	jr c, .jump2
	ld hl, wd41a
	set 0, [hl]
	ld hl, PlayersHouse2FTextString6
	call PrintText
	ret
	
.jump2
; 4264
	ld hl, PlayersHouse2FTextString7
	call PrintText
	ret
	
PlayersHouse2FN64Text: ; 426B
	ld hl, PlayersHouse2FTextString4
	call OpenTextbox
	ret
	
PlayersHouse2FTextString1: ; 4272
	text_PlayersHouse2FTextString1
	
PlayersHouse2FTextString2: ; 4332
	text_PlayersHouse2FTextString2
	
PlayersHouse2FTextString3: ; 4365
	text_PlayersHouse2FTextString3
	
PlayersHouse2FTextString4: ; 438D
	text_PlayersHouse2FTextString4
	
PlayersHouse2FTextString5: ; 43BD
	text_PlayersHouse2FTextString5
	
	db $08
	
; 43F3
	call PlayersHouse2FCheckEmail
	call Function3036
	ret
	
PlayersHouse2FTextString6: ; 43FA
	text_PlayersHouse2FTextString6
	
PlayersHouse2FTextString7: ; 4456
	text_PlayersHouse2FTextString7
	
PlayersHouse2FTextString8: ; 4461 (unused?)
	text_PlayersHouse2FTextString8
	
PlayersHouse2FTextString9: ; 44FE
	text_PlayersHouse2FTextString9
	
; 45FF