include "constants.asm"
INCLUDE "hack/text/PlayersHouse2F.inc"

SECTION "maps/PlayerHouse2F.asm", ROMX

PlayerHouse2FScriptLoader:: ; 418B
	ld hl, PlayerHouse2FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
PlayerHouse2FScriptPointers: ; 4195
	dw PlayerHouse2FScript1
	dw PlayerHouse2FNPCIDs1
	dw PlayerHouse2FScript2 
	dw PlayerHouse2FNPCIDs2

PlayerHouse2FTextPointers::
	dw PlayerHouse2FText1
	dw PlayerHouse2FDollText
	
PlayerHouse2FNPCIDs1: ; 41A1
	db 0
	db 1
	db $FF
	
PlayerHouse2FNPCIDs2: ; 41A4
	db 1
	db $FF
	
PlayerHouse2FSignPointers: ; 41A6
	dw Function3899 
	dw PlayerHouse2FRadioText
	dw PlayerHouse2FComputerText
	dw Function3899 
	dw PlayerHouse2FN64Text 
	
PlayerHouse2FScript1: ; 41B0
	call PlayerHouse2PositionCheck
	ret z
	ld hl, PlayerHouse2FNPCIDs1
	ld de, PlayerHouse2FSignPointers
	call CallMapTextSubroutine
	ret nz
	ret
	
PlayerHouse2PositionCheck: ; 41BF
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
	ld hl, PlayerHouse2FTextString2
	call OpenTextbox
	call PlayerHouse2FMovePlayer
	call ClearAccumulator
	ret
	
PlayerHouse2FMovePlayer: ; 41EA
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
	
PlayerHouse2FScript2: ; 4200
	ld hl, PlayerHouse2FNPCIDs2
	ld de, PlayerHouse2FSignPointers
	call CallMapTextSubroutine
	ret
	
PlayerHouse2FText1: ; 420A
	ld hl, wd41a
	bit 3, [hl]
	jr nz, .jump
	ld hl, PlayerHouse2FTextString1
	call OpenTextbox
	ld hl, wd41a
	set 3, [hl]
	ld c, 3
	call DelayFrames
.jump
	ld hl, PlayerHouse2FTextString2
	call OpenTextbox
	ret
	
PlayerHouse2FDollText: ; 4228
	ld hl, PlayerHouse2FTextString3
	call OpenTextbox
	ret
	
PlayerHouse2FRadioText: ; 422F
	ld hl, PlayerHouse2FTextString9
	call OpenTextbox
	ret
	
PlayerHouse2FComputerText: ; 4236
	ld hl, wd41a
	bit 0, [hl]
	jr nz, .jump
	ld hl, PlayerHouse2FTextString5
	call OpenTextbox
	ret

.jump
; 4244
	call RefreshScreen
	callab Function1477D
	call Function1fea
	ret
	
PlayerHouse2FCheckEmail: ; 4253
	call YesNoBox
	jr c, .jump2
	ld hl, wd41a
	set 0, [hl]
	ld hl, PlayerHouse2FTextString6
	call PrintText
	ret
	
.jump2
; 4264
	ld hl, PlayerHouse2FTextString7
	call PrintText
	ret
	
PlayerHouse2FN64Text: ; 426B
	ld hl, PlayerHouse2FTextString4
	call OpenTextbox
	ret
	
PlayerHouse2FTextString1: ; 4272
	text_PlayersHouse2FTextString1
	
PlayerHouse2FTextString2: ; 4332
	text_PlayersHouse2FTextString2
	
PlayerHouse2FTextString3: ; 4365
	text_PlayersHouse2FTextString3
	
PlayerHouse2FTextString4: ; 438D
	text_PlayersHouse2FTextString4
	
PlayerHouse2FTextString5: ; 43BD
	text_PlayersHouse2FTextString5
	
	db $08
	
; 43F3
	call PlayerHouse2FCheckEmail
	call Function3036
	ret
	
PlayerHouse2FTextString6: ; 43FA
	text_PlayersHouse2FTextString6
	
PlayerHouse2FTextString7: ; 4456
	text_PlayersHouse2FTextString7
	
PlayerHouse2FTextString8: ; 4461 (unused?)
	text_PlayersHouse2FTextString8
	
PlayerHouse2FTextString9: ; 44FE
	text_PlayersHouse2FTextString9

PlayerHouse2FPadding:
	textpad_PlayersHouse2F
	
; 45FF