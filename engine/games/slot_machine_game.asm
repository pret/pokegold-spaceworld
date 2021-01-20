INCLUDE "constants.asm"

SECTION "engine/games/slot_machine_game.asm", ROMX

; Constants for slot_reel offsets (see macros/wram.asm)
REEL_ACTION        EQUS "(wReel1ReelAction - wReel1)"
REEL_TILEMAP_ADDR  EQUS "(wReel1TilemapAddr - wReel1)"
REEL_POSITION      EQUS "(wReel1Position - wReel1)"
REEL_SPIN_DISTANCE EQUS "(wReel1SpinDistance - wReel1)"
REEL_SPIN_RATE     EQUS "(wReel1SpinRate - wReel1)"
REEL_OAM_ADDR      EQUS "(wReel1OAMAddr - wReel1)"
REEL_X_COORD       EQUS "(wReel1XCoord - wReel1)"
REEL_MANIP_COUNTER EQUS "(wReel1ManipCounter - wReel1)"
REEL_MANIP_DELAY   EQUS "(wReel1ManipDelay - wReel1)"
REEL_FIELD_0B      EQUS "(wReel1Field0b - wReel1)"
REEL_STOP_DELAY    EQUS "(wReel1StopDelay - wReel1)"

SlotMachineGame:
	ld hl, wCoins
	ld [hl], 1
	inc hl
	ld [hl], 0
	ld hl, wce5f
	set 4, [hl]
	call SlotMachineGame_Init
	call DelayFrame

.loop
	call SlotsLoop
	jr nc, .loop
	ld hl, wce5f
	res 4, [hl]
	ld hl, rLCDC
	res rLCDC_SPRITE_SIZE, [hl]
	ret

SlotMachineGame_Init:
	call DisableLCD
	ld b, SGB_SLOT_MACHINE
	call GetSGBLayout
	ld hl, InitEffectObject
	ld a, $23
	call FarCall_hl
	ld hl, wReel1ReelAction
	ld bc, $48
	xor a
	call ByteFill
	ld hl, SlotMachine2GFX
	ld de, $8000
	ld bc, $800
	ld a, $24
	call FarCopyData
	ld hl, SlotMachineGFX
	ld de, $9000
	ld bc, $250
	ld a, $24
	call FarCopyData
	ld hl, SlotMachine2GFX
	ld de, $9250
	ld bc, $1C0
	ld a, $24
	call FarCopyData
	ld hl, SlotMachine3GFX
	ld de, $9410
	ld bc, $1C0
	ld a, $24
	call FarCopyData
	ld hl, SlotsTilemap
	ld de, $C2A0
	ld bc, $F0

.InitTilemap:
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .InitTilemap
	ld hl, rLCDC
	set 2, [hl]
	call EnableLCD
	xor a
	ld hl, wReel1ReelAction
	ld c, 100

.ClrRAM:
	ld [hli], a
	dec c
	jr nz, .ClrRAM
	call Slots_InitReelTiles
	ld a, %11100100
	ld [rBGP], a
	ld [rOBP0], a
	ld a, %11000000
	ld [rOBP1], a
	ld a, $28
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], $20
	xor a
	ld [wJumptableIndex], a
	ld a, $FF
	ld [wSlotBias], a
	ret

SlotsLoop:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call SlotsJumptable
	call Slots_SpinReels
	ld a, $60
	ld [wc4bd], a
	ld hl, DoNextFrameForFirst16Sprites
	ld a, $23
	call FarCall_hl
	call Slots_PrintCoinsAndPayout
	call Slots_FlashPaletteOnMatchingSevens
	call Function90373
	call Function90358
	call DelayFrame
	and a
	ret
.done
	scf
	ret

Slots_FlashPaletteOnMatchingSevens:
	ld a, [wReel1ReelAction]
	and a
	ret nz
	ld a, [wReel2ReelAction]
	and a
	ret nz
	ld a, [wFirstTwoReelsMatchingSevens]
	and a
	jr nz, .matching_sevens
	ld a, %11100100
	ld [rBGP], a
	ret
.matching_sevens
	ld a, [wVBlankJoyFrameCounter]
	and 7
	ret nz
	ld a, [rBGP]
	xor %1100
	ld [rBGP], a
	ret

Slots_PrintCoinsAndPayout:
	ld hl, $C2B9
	ld de, wCoins
	ld bc, $8204
	call PrintNumber
	ld hl, $C2BF
	ld de, wPayout
	ld bc, $8204
	call PrintNumber
	ret

Function90358:
	ld a, [wSlotBias]
	add a, 0
	daa
	ld e, a
	and $F
	add a, $F6
	ld hl, $C2A1
	ld [hl], a
	ld a, e
	swap a
	and $F
	add a, $F6
	ld hl, $C2A0
	ld [hl], a
	ret

Function90373:
	ld hl, wcb61
	ld a, [hl]
	inc [hl]
	and 7
	ret nz
	ld hl, $C2F5
	ld a, [hl]
	cp $17
	call nz, .asm90397
	ld hl, $C2F9
	ld a, [hl]
	cp $17
	call nz, .asm90397
	ld hl, $C2FD
	ld a, [hl]
	cp $17
	call nz, .asm90397
	ret
.asm90397
	cp 65
	jr c, .asm9039f
	ld b, %11100100
	jr .asm903a1
.asm9039f
	ld b, $1C
.asm903a1
	ld de, $14
	ld c, 6
.asm903a6
	ld a, [hl]
	add a, b
	ld [hli], a
	ld a, [hl]
	add a, b
	ld [hld], a
	add hl, de
	dec c
	jr nz, .asm903a6
	ret

SlotsJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw SlotsAction_Init
	dw SlotsAction_BetAndStart
	dw SlotsAction_WaitStart
	dw SlotsAction_WaitReel1
	dw SlotsAction_WaitStopReel1
	dw SlotsAction_WaitReel2
	dw SlotsAction_WaitStopReel2
	dw SlotsAction_WaitReel3
	dw SlotsAction_WaitStopReel3
	dw SlotsAction_Next
	dw SlotsAction_Next
	dw SlotsAction_Next
	dw SlotsAction_FlashIfWin
	dw SlotsAction_FlashScreen
	dw SlotsAction_GiveEarnedCoins
	dw SlotsAction_PayoutTextAndAnim
	dw SlotsAction_PayoutAnim
	dw SlotsAction_RestartOrQuit
	dw SlotsAction_Quit

SlotsAction_Next:
	ld hl, wJumptableIndex
	inc [hl]
	ret

SlotsAction_Init:
	call SlotsAction_Next
	xor a
	ld [wFirstTwoReelsMatching], a
	ld [wFirstTwoReelsMatchingSevens], a
	ld a, $FF
	ld [wSlotMatched], a
	ret

SlotsAction_BetAndStart:
	call Slots_AskBet
	jr nc, .proceed
	ld a, $12
	ld [wJumptableIndex], a
	ret
.proceed
	call SlotsAction_Next
	call Slots_IlluminateBetLights
	call Slots_InitBias
	ld a, 32
	ld [wSlotsDelay], a
	ld a, 4
	ld [wReel1ReelAction], a
	ld [wReel2ReelAction], a
	ld [wReel3ReelAction], a
	ld a, 4
	ld [wReel1ManipCounter], a
	ld [wReel2ManipCounter], a
	ld [wReel3ManipCounter], a
	ret

SlotsAction_WaitStart:
	ld hl, wSlotsDelay
	ld a, [hl]
	and a
	jr z, .proceed
	dec [hl]
	ret
.proceed
	call SlotsAction_Next
	xor a
	ldh [hJoypadSum], a
	ret

SlotsAction_WaitReel1:
	ld hl, hJoypadSum
	ld a, [hl]
	and A_BUTTON
	ret z
	call SlotsAction_Next
	call Slots_StopReel1
	ld [wReel1ReelAction], a

SlotsAction_WaitStopReel1:
	ld a, [wReel1ReelAction]
	cp 0
	ret nz
	ld bc, wReel1ReelAction
	ld de, wReel1Stopped
	call Slots_LoadReelState
	call SlotsAction_Next
	xor a
	ldh [hJoypadSum], a

SlotsAction_WaitReel2:
	ld hl, hJoypadSum
	ld a, [hl]
	and A_BUTTON
	ret z
	call SlotsAction_Next
	call Slots_StopReel2
	ld [wReel2ReelAction], a

SlotsAction_WaitStopReel2:
	ld a, [wReel2ReelAction]
	cp 0
	ret nz
	ld bc, wReel2ReelAction
	ld de, wReel2Stopped
	call Slots_LoadReelState
	call SlotsAction_Next
	xor a
	ldh [hJoypadSum], a

SlotsAction_WaitReel3:
	ld hl, hJoypadSum
	ld a, [hl]
	and 1
	ret z
	call SlotsAction_Next
	call Slots_StopReel3
	ld [wReel3ReelAction], a

SlotsAction_WaitStopReel3:
	ld a, [wReel3ReelAction]
	cp 0
	ret nz
	ld bc, wReel3ReelAction
	ld de, wReel3Stopped
	call Slots_LoadReelState
	call SlotsAction_Next
	xor a
	ldh [hJoypadSum], a
	call Function90822
	call Function90805
	ret

SlotsAction_FlashIfWin:
	ld a, [wSlotMatched]
	cp $FF
	jr nz, .matched
	call SlotsAction_Next
	call SlotsAction_Next
	ret
.matched
	call SlotsAction_Next
	ld a, $10
	ld [wSlotsDelay], a

SlotsAction_FlashScreen:
	ld hl, wSlotsDelay
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	srl a
	ret z
	ld a, [rOBP0]
	xor $FF
	ld [rOBP0], a
	ret
.done
	ld a, %11100100
	ld [rOBP0], a
	call SlotsAction_Next
	ret

SlotsAction_GiveEarnedCoins:
	xor a
	ld [wFirstTwoReelsMatching], a
	ld [wFirstTwoReelsMatchingSevens], a
	ld a, %11100100
	ld [rBGP], a
	call Slots_GetPayout
	xor a
	ld [wSlotsDelay], a
	call SlotsAction_Next
	ret

SlotsAction_PayoutTextAndAnim:
	call Slots_PayoutText
	call SlotsAction_Next
	ld bc, wReel1ReelAction
	call Function907c8
	ld bc, wReel2ReelAction
	call Function907c8
	ld bc, wReel3ReelAction
	call Function907c8
	call WaitBGMap
	ld hl, wVirtualOAM
	ld e, $60
	xor a
.loop
	ld [hli], a
	dec e
	jr nz, .loop

SlotsAction_PayoutAnim:
	ld hl, wSlotsDelay
	ld a, [hl]
	inc [hl]
	and 1
	ret z
	ld hl, wPayout
	ld a, [hli]
	ld d, a
	or [hl]
	jr z, .done
	ld e, [hl]
	dec de
	ld [hl], e
	dec hl
	ld [hl], d
	ld hl, wCoins
	ld d, [hl]
	inc hl
	ld e, [hl]
	call Slots_CheckCoinCaseFull
	jr c, .okay
	inc de
.okay
	ld [hl], e
	dec hl
	ld [hl], d
	ld a, [wSlotsDelay]
	and 7
	ret z
	ld de, $2F
	call PlaySFX
	ret
.done
	call SlotsAction_Next
	call Function90822
	call Function90805
	ret

SlotsAction_RestartOrQuit:
	call Slots_DeilluminateBetLights
	call TextboxWaitPressAorB_BlinkCursor
	call Slots_AskPlayAgain
	jr c, .exit_slots
	ld a, 0
	ld [wJumptableIndex], a
	ret

.exit_slots
	ld a, $12
	ld [wJumptableIndex], a
	ret

SlotsAction_Quit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Slots_LoadReelState:
	push de
	call Slots_GetCurrentReelState
	pop de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ret

Slots_CheckCoinCaseFull:
	ld a, d
	cp $27
	jr c, .not_full
	ld a, e
	cp $F
	jr c, .not_full
	scf
	ret
.not_full
	and a
	ret

Slots_GetCurrentReelState:
	ld hl, REEL_POSITION
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .okay
	ld a, $F
.okay
	dec a
	and $F
	ld e, a
	ld d, 0
	ld hl, REEL_TILEMAP_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ret

Slots_StopReel1:
	ld a, 7
	ret

Slots_StopReel2:
	ld a, [wSlotBias]
	and a
	jr z, .skip
	cp $FF
	jr nz, .dont_jump
.skip
	call .CheckReel1ForASeven
	jr nz, .dont_jump
	call Random
	cp 80
	jr nc, .dont_jump
	ld a, $A
	ret

.dont_jump
	ld a, 8
	ret

.CheckReel1ForASeven:
	ld a, [wReel1Stopped]
	and a
	ret z
	ld a, [wReel1Stopped+1]
	and a
	ret z
	ld a, [wReel1Stopped+2]
	and a
	ret

Slots_StopReel3:
	ld a, [wFirstTwoReelsMatching]
	and a
	jr z, .stop
	ld a, [wFirstTwoReelsMatchingSevens]
	and a
	jr z, .stop
	ld a, [wSlotBias]
	and a
	jr nz, .biased
	call Random
	cp 180
	jr nc, .stop
	cp 120
	jr nc, .slow_advance
	cp 60
	jr nc, .golem
	ld a, $15
	ret
.biased
	call Random
	cp 160
	jr nc, .stop
	cp 80
	jr nc, .slow_advance
.golem
	ld a, $12
	ret
.slow_advance
	ld a, $10
	ret
.stop
	ld a, 9
	ret

Slots_InitReelTiles:
	ld bc, wReel1ReelAction
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld de, wVirtualOAM
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, REEL_TILEMAP_ADDR
	add hl, bc
	ld de, Slots_Reel1Tilemap
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, REEL_X_COORD
	add hl, bc
	ld [hl], 48
	call .OAM
	ld bc, wReel2ReelAction
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld de, $C220
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, REEL_TILEMAP_ADDR
	add hl, bc
	ld de, Slots_Reel2Tilemap
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, REEL_X_COORD
	add hl, bc
	ld [hl], 80
	call .OAM
	ld bc, wReel3ReelAction
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld de, $C240
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, REEL_TILEMAP_ADDR
	add hl, bc
	ld de, Slots_Reel3Tilemap
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, REEL_X_COORD
	add hl, bc
	ld [hl], 112
	call .OAM
	ret

.OAM:
	ld hl, REEL_ACTION
	add hl, bc
	ld [hl], 0
	ld hl, REEL_POSITION
	add hl, bc
	ld [hl], $E
	ld hl, REEL_SPIN_DISTANCE
	add hl, bc
	ld [hl], 0
	call Slots_UpdateReelPositionAndOAM
	ret

Slots_SpinReels:
	ld bc, wReel1ReelAction
	call .SpinReel
	ld bc, wReel2ReelAction
	call .SpinReel
	ld bc, wReel3ReelAction
	call .SpinReel
	ret

.SpinReel:
	ld hl, REEL_SPIN_DISTANCE
	add hl, bc
	ld a, [hl]
	and $F
	jr nz, .skip
	call ReelActionJumptable

.skip
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld a, [hl]
	and a
	ret z
	ld d, a
	ld hl, REEL_SPIN_DISTANCE
	add hl, bc
	add a, [hl]
	ld [hl], a
	and $F
	jr z, Slots_UpdateReelPositionAndOAM
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld e, 8
.loop
	ld a, [hl]
	add a, d
	ld [hli], a
	inc hl
	inc hl
	inc hl
	dec e
	jr nz, .loop
	ret

Slots_UpdateReelPositionAndOAM:
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wCurReelXCoord], a
	ld a, 80
	ld [wCurReelYCoord], a
	ld hl, REEL_POSITION
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, REEL_TILEMAP_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	call Slots_LoadOAM
	ld hl, REEL_POSITION
	add hl, bc
	ld a, [hl]
	inc a
	and $F
	cp $F
	jr nz, .load
	xor a
.load
	ld [hl], a
	ret

Slots_LoadOAM:
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
.load_oam_loop
	ld a, [wCurReelYCoord]
	ld [hli], a
	ld a, [wCurReelXCoord]
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ld a, 128
	ld [hli], a
	ld a, [wCurReelYCoord]
	ld [hli], a
	ld a, [wCurReelXCoord]
	add a, 8
	ld [hli], a
	ld a, [de]
	inc a
	inc a
	ld [hli], a
	ld a, 128
	ld [hli], a
	inc de
	ld a, [wCurReelYCoord]
	sub 16
	ld [wCurReelYCoord], a
	cp 16
	jr nz, .load_oam_loop
	ret

ReelActionJumptable:
	ld hl, REEL_ACTION
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw ReelAction_DoNothing
	dw ReelAction_StopReelIgnoreJoypad
	dw ReelAction_QuadrupleRate
	dw ReelAction_DoubleRate
	dw ReelAction_NormalRate
	dw ReelAction_HalfRate
	dw ReelAction_QuarterRate
	dw ReelAction_StopReel1
	dw ReelAction_StopReel2
	dw ReelAction_StopReel3
	dw ReelAction_SetUpReel2SkipTo7
	dw ReelAction_WaitReel2SkipTo7
	dw ReelAction_FastSpinReel2UntilLinedUp7s
	dw ReelAction_Action0D
	dw ReelAction_CheckDropReel
	dw ReelAction_WaitDropReel
	dw ReelAction_StartSlowAdvanceReel3
	dw ReelAction_WaitSlowAdvanceReel3
	dw ReelAction_InitGolem
	dw ReelAction_WaitGolem
	dw ReelAction_EndGolem
	dw ReelAction_InitChansey
	dw ReelAction_WaitChansey
	dw ReelAction_WaitEgg
	dw ReelAction_DropReel

ReelAction_DoNothing:
	ret

ReelAction_QuadrupleRate:
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 16
	ret

ReelAction_DoubleRate:
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 8
	ret

ReelAction_NormalRate:
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 4
	ret

ReelAction_HalfRate:
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 2
	ret

ReelAction_QuarterRate:
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 1
	ret

Slots_StopReel:
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 0
	ld hl, REEL_ACTION
	add hl, bc
	ld [hl], 1
	ld hl, REEL_STOP_DELAY
	add hl, bc
	ld [hl], 3
	call Function907c8

ReelAction_StopReelIgnoreJoypad:
	ld hl, REEL_STOP_DELAY
	add hl, bc
	ld a, [hl]
	and a
	jr z, .EndReel
	dec [hl]
	ret

.EndReel:
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld e, 32
	xor a
.clr_reel
	ld [hli], a
	dec e
	jr nz, .clr_reel
	ld hl, REEL_ACTION
	add hl, bc
	ld a, 0
	ld [hl], a
	ret

Function907c8:
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	sub 48
	srl a
	srl a
	srl a
	ld e, a
	ld d, 0
	push bc
	ld hl, $C2F5
	add hl, de
	push hl
	call Slots_GetCurrentReelState
	ld e, l
	ld d, h
	inc de
	inc de
	pop hl
	ld bc, $14
	call .asm907f6
	dec de
	call .asm907f6
	dec de
	call .asm907f6
	pop bc
	ret

.asm907f6
	ld a, [de]
	add a, $25
	ld [hli], a
	inc a
	inc a
	ld [hld], a
	add hl, bc
	dec a
	ld [hli], a
	inc a
	inc a
	ld [hld], a
	add hl, bc
	ret

Function90805:
	ld hl, $C2F5
	call .asm90814
	ld hl, $C2F9
	call .asm90814
	ld hl, $C2FD

.asm90814
	ld a, $17
	ld de, $14
	ld c, 6
.loop
	ld [hli], a
	ld [hld], a
	add hl, de
	dec c
	jr nz, .loop
	ret

Function90822:
	ld bc, wReel1ReelAction
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wCurReelXCoord], a
	ld a, $50
	ld [wCurReelYCoord], a
	call Slots_GetCurrentReelState
	ld e, l
	ld d, h
	call Slots_LoadOAM
	ld bc, wReel2ReelAction
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wCurReelXCoord], a
	ld a, $50
	ld [wCurReelYCoord], a
	call Slots_GetCurrentReelState
	ld e, l
	ld d, h
	call Slots_LoadOAM
	ld bc, wReel3ReelAction
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wCurReelXCoord], a
	ld a, $50
	ld [wCurReelYCoord], a
	call Slots_GetCurrentReelState
	ld e, l
	ld d, h
	call Slots_LoadOAM
	ret

ReelAction_StopReel1:
	ld a, [wSlotBias]
	cp $FF
	jr z, .NoBias
	ld hl, REEL_MANIP_COUNTER
	add hl, bc
	ld a, [hl]
	and a
	jr z, .NoBias
	dec [hl]
	call .CheckForBias
	ret nz

.NoBias:
	call Slots_StopReel
	ret

.CheckForBias:
	call Slots_GetCurrentReelState
	ld a, [wSlotBias]
	ld e, a
	ld a, [hli]
	cp e
	ret z
	ld a, [hli]
	cp e
	ret z
	ld a, [hl]
	cp e
	ret

ReelAction_StopReel2:
	call Slots_CheckMatchedFirstTwoReels
	jr nc, .nope
	ld a, [wSlotBuildingMatch]
	ld hl, wSlotBias
	cp [hl]
	jr z, .NoBias

.nope
	ld a, [wSlotBias]
	cp $FF
	jr z, .NoBias
	ld hl, REEL_MANIP_COUNTER
	add hl, bc
	ld a, [hl]
	and a
	jr z, .NoBias
	dec [hl]
	ret

.NoBias:
	call Slots_StopReel
	ret

ReelAction_StopReel3:
	call Slots_CheckMatchedAllThreeReels
	jr nc, .NoMatch
	ld hl, wSlotBias
	cp [hl]
	jr z, .NoBias
	ld hl, REEL_MANIP_COUNTER
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.NoMatch:
	ld a, [wSlotBias]
	cp $FF
	jr z, .NoBias
	ld hl, REEL_MANIP_COUNTER
	add hl, bc
	ld a, [hl]
	and a
	jr z, .NoBias
	dec [hl]
	ret

.NoBias:
	call Slots_StopReel
	ret

ReelAction_SetUpReel2SkipTo7:
	call Slots_CheckMatchedFirstTwoReels
	jr nc, .no_match
	ld a, [wFirstTwoReelsMatchingSevens]
	and a
	jr z, .no_match
	call Slots_StopReel
	ret

.no_match
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld [hl], 32
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 0
	ret

ReelAction_WaitReel2SkipTo7:
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld a, [hl]
	and a
	jr z, .no_delay
	dec [hl]
	ret

.no_delay
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 8
	ret

ReelAction_FastSpinReel2UntilLinedUp7s:
	call Slots_CheckMatchedFirstTwoReels
	ret nc
	ld a, [wFirstTwoReelsMatchingSevens]
	and a
	ret z
	call Slots_StopReel
	ret

ReelAction_InitGolem:
	call Slots_CheckMatchedAllThreeReels
	ret c
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 0
	call Slots_GetNumberOfGolems
	push bc
	push af
	ld de, $6068
	ld a, $3D
	call InitSpriteAnimStruct
	ld hl, $E
	add hl, bc
	pop af
	ld [hl], a
	pop bc
	xor a
	ld [wSlotsDelay], a

ReelAction_WaitGolem:
	ld a, [wSlotsDelay]
	cp 2
	jr z, .two
	cp 1
	jr z, .one
	ret

.two
	call Slots_CheckMatchedAllThreeReels
	call Slots_StopReel
	ret

.one
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 8
	ret

ReelAction_EndGolem:
	xor a
	ld [wSlotsDelay], a
	ld hl, REEL_ACTION
	add hl, bc
	dec [hl]
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 0
	ret

ReelAction_InitChansey:
	call Slots_CheckMatchedAllThreeReels
	ret c
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 0
	push bc
	ld de, $6000
	ld a, $3E
	call InitSpriteAnimStruct
	pop bc
	xor a
	ld [wSlotsDelay], a
	ret

ReelAction_WaitChansey:
	ld a, [wSlotsDelay]
	and a
	ret z
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld a, 2
	ld [wSlotsDelay], a

ReelAction_WaitEgg:
	ld a, [wSlotsDelay]
	cp 4
	ret c
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], $10
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld [hl], $11

ReelAction_DropReel:
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld a, [hl]
	and a
	jr z, .check_match
	dec [hl]
	ret

.check_match
	call Slots_CheckMatchedAllThreeReels
	jr nc, .EggAgain
	and a
	jr nz, .EggAgain
	ld a, 5
	ld [wSlotsDelay], a
	call Slots_StopReel
	ret

.EggAgain:
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 0
	ld hl, REEL_ACTION
	add hl, bc
	dec [hl]
	dec [hl]
	ld a, 1
	ld [wSlotsDelay], a
	ret

ReelAction_Action0D:
	call Slots_CheckMatchedAllThreeReels
	ret c
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	call Slots_GetNumberOfGolems
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld [hl], a

ReelAction_CheckDropReel:
	ld hl, $A
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .spin
	call Slots_CheckMatchedAllThreeReels
	call Slots_StopReel
	ret

.spin
	dec [hl]
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld hl, REEL_FIELD_0B
	add hl, bc
	ld [hl], 32
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 0

ReelAction_WaitDropReel:
	ld hl, REEL_FIELD_0B
	add hl, bc
	ld a, [hl]
	and a
	jr z, .DropReel
	dec [hl]
	ret

.DropReel:
	ld hl, REEL_ACTION
	add hl, bc
	dec [hl]
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 8
	ret

ReelAction_StartSlowAdvanceReel3:
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 1
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl]
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld [hl], $10

ReelAction_WaitSlowAdvanceReel3:
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld a, [hl]
	and a
	jr z, .check1
	dec [hl]
	ret

.check1
	ld a, [wSlotBias]
	and a
	jr nz, .check2
	call Slots_CheckMatchedAllThreeReels
	ret nc
	and a
	ret nz
	call Slots_StopReel
	ret

.check2
	call Slots_CheckMatchedAllThreeReels
	ret c
	call Slots_StopReel
	ret



Slots_CheckMatchedFirstTwoReels:
	xor a
	ld [wFirstTwoReelsMatching], a
	ld [wFirstTwoReelsMatchingSevens], a
	call Slots_GetCurrentReelState
	call Slots_CopyReelState
	ld a, [wSlotBet]
	and 3
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .return
	push de
	jp hl

.return
	ld a, [wFirstTwoReelsMatching]
	and a
	ret z
	scf
	ret
.Jumptable:dw .zero
	dw .one
	dw .two
	dw .three

.three
	call .CheckUpwardsDiag
	call .CheckDownwardsDiag

.two
	call .CheckBottomRow
	call .CheckTopRow

.one
	call .CheckMiddleRow

.zero
	ret



.CheckBottomRow:
	ld hl, wCurReelStopped
	ld a, [wReel1Stopped]
	cp [hl]
	call z, .StoreResult
	ret




.CheckUpwardsDiag:
	ld hl,	wCurReelStopped+1
	ld a, [wReel1Stopped]
	cp [hl]
	call z, .StoreResult
	ret




.CheckMiddleRow:
	ld hl,	wCurReelStopped+1
	ld a, [wReel1Stopped+1]
	cp [hl]
	call z, .StoreResult
	ret




.CheckDownwardsDiag:
	ld hl,	wCurReelStopped+1
	ld a, [wReel1Stopped+2]
	cp [hl]
	call z, .StoreResult
	ret




.CheckTopRow:
	ld hl,	wCurReelStopped+2
	ld a, [wReel1Stopped+2]
	cp [hl]
	call z, .StoreResult
	ret




.StoreResult:
	ld [wSlotBuildingMatch], a
	and a
	jr nz, .matching_sevens
	ld a, 1
	ld [wFirstTwoReelsMatchingSevens], a

.matching_sevens
	ld a, 1
	ld [$C50B], a
	ret




Slots_CheckMatchedAllThreeReels:
	ld a, $FF
	ld [wSlotMatched], a
	call Slots_GetCurrentReelState
	call Slots_CopyReelState
	ld a, [wSlotBet]
	and 3
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .return
	push de
	jp hl

.return
	ld a, [wSlotMatched]
	cp $FF
	jr nz, .matched_nontrivial
	and a
	ret

.matched_nontrivial
	scf
	ret
.Jumptable:dw .zero
	dw .one
	dw .two
	dw .three

.three
	call .CheckUpwardsDiag
	call .CheckDownwardsDiag

.two
	call .CheckBottomRow
	call .CheckTopRow

.one
	call .CheckMiddleRow

.zero
	ret



.CheckBottomRow:
	ld hl, wCurReelStopped
	ld a, [wReel1Stopped]
	cp [hl]
	ret nz
	ld hl, wReel2Stopped
	cp [hl]
	call z, .StoreResult
	ret




.CheckUpwardsDiag:
	ld hl,	wCurReelStopped+2
	ld a, [wReel1Stopped]
	cp [hl]
	ret nz
	ld hl,	wReel2Stopped+1
	cp [hl]
	call z, .StoreResult
	ret




.CheckMiddleRow:
	ld hl,	wCurReelStopped+1
	ld a, [wReel1Stopped+1]
	cp [hl]
	ret nz
	ld hl,	wReel2Stopped+1
	cp [hl]
	call z, .StoreResult
	ret




.CheckDownwardsDiag:
	ld hl, wCurReelStopped
	ld a, [wReel1Stopped+2]
	cp [hl]
	ret nz
	ld hl,	wReel2Stopped+1
	cp [hl]
	call z, .StoreResult
	ret




.CheckTopRow:
	ld hl,	wCurReelStopped+2
	ld a, [wReel1Stopped+2]
	cp [hl]
	ret nz
	ld hl,	wReel2Stopped+2
	cp [hl]
	call z, .StoreResult
	ret




.StoreResult:
	ld [wSlotMatched], a
	ret




Slots_CopyReelState:
	ld de, wCurReelStopped
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret




Slots_GetNumberOfGolems:
	ld hl, REEL_POSITION
	add hl, bc
	ld a, [hl]
	push af
	push hl
	call .Check7Bias
	pop hl
	pop af
	ld [hl], a
	ld a, e
	ret




.Check7Bias:
	ld a, [wSlotBias]
	and a
	jr nz, .not_biased_to_seven
	ld e, 0

.loop1
	ld hl, REEL_POSITION
	add hl, bc
	inc [hl]
	inc e
	push de
	call Slots_CheckMatchedAllThreeReels
	pop de
	jr nc, .loop1
	and a
	jr nz, .loop1
	ret

.not_biased_to_seven
	call Random
	and 7
	cp 4
	jr c, .not_biased_to_seven
	ld e, a

.loop2
	ld a, e
	inc e
	ld hl, REEL_POSITION
	add hl, bc
	add a, [hl]
	ld [hl], a
	push de
	call Slots_CheckMatchedAllThreeReels
	pop de
	jr c, .loop2
	ret




Slots_InitBias:
	ld a, [wSlotBias]
	and a
	ret z
	call Random
	ld c, a
	ld hl, .Biases

.loop
	ld a, [hli]
	cp c
	jr nc, .done
	inc hl
	jr .loop

.done
	ld a, [hl]
	ld [$C509], a
	ret

.Biases:db	 1
	db	 0
	db	 3
	db	 4
	db	$A
	db $14
	db $14
	db $10
	db $28
	db	$C
	db $50
	db	 8
	db $FF
	db $FF



Slots_IlluminateBetLights:
	ld b, $14
	ld a, [wSlotBet]
	dec a
	jr z, Slot_Lights1OnOff
	dec a
	jr z, Slots_Lights2OnOff
	jr Slots_Lights3OnOff

Slots_DeilluminateBetLights:
	ld b, $23

Slots_Lights3OnOff:
	ld hl, $C2CB
	call Slots_TurnLightsOnOrOff
	ld hl, $C36B
	call Slots_TurnLightsOnOrOff

Slots_Lights2OnOff:
	ld hl, $C2F3
	call Slots_TurnLightsOnOrOff
	ld hl, $C343
	call Slots_TurnLightsOnOrOff

Slot_Lights1OnOff:
	ld hl, $C31B




Slots_TurnLightsOnOrOff:
	ld a, b
	ld [hl], a
	ld de, $D
	add hl, de
	ld [hl], a
	ld de, 7
	add hl, de
	inc a
	ld [hl], a
	ld de, $D
	add hl, de
	ld [hl], a
	ret




Slots_AskBet:
	ld hl, .BetHowManyCoinsText
	call PrintText
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c
	ld a, [wMenuCursorY]
	ld b, a
	ld a, 4
	sub b
	ld [wSlotBet], a
	ld hl, wCoins
	ld c, a
	ld a, [hli]
	and a
	jr nz, .Start
	ld a, [hl]
	cp c
	jr nc, .Start
	ld hl, .NotEnoughCoinsText
	call PrintText
	jr Slots_AskBet

.Start:
	ld hl,	wCoins+1
	ld a, [hl]
	sub c
	ld [hld], a
	jr nc, .ok
	dec [hl]

.ok
	ld de, $30
	call PlaySFX
	ld hl, .SlotsStartText
	call PrintText
	and a
	ret

.BetHowManyCoinsText:db	 0
	db $89
	db $81
	db $AB
	db $DD
	db $4F
	db $C5
	db $DE
	db $CF
	db $B2
	db $7F
	db $B6
	db $B9
	db $CF
	db $BD
	db $B6
	db $E6
	db $57
.SlotsStartText:db	0
	db $8C
	db $8F
	db $E3
	db $93
	db $E7
	db $57
.NotEnoughCoinsText:db	 0
	db $89
	db $81
	db $AB
	db $26
	db $7F
	db $C0
	db $D8
	db $CF
	db $BE
	db $DE
	db $E7
	db $58
.MenuHeader:db $40
	db	$A
	db	$E
	db $11
	db $13
	db $AC
	db $4C
	db	 1
	db $80
	db	 3
	db $F9
	db $CF
	db $B2
	db $50
	db $F8
	db $CF
	db $B2
	db $50
	db $F7
	db $CF
	db $B2
	db $50



Slots_AskPlayAgain:
	ld hl, wCoins
	ld a, [hli]
	or [hl]
	jr nz, .have_coins
	ld hl, .RanOutOfCoinsText
	call PrintText
	ld c, 60
	call DelayFrames
	jr .exit_slots

.have_coins
	ld hl, .PlayAgainText
	call PrintText
	call YesNoBox
	jr c, .exit_slots
	and a
	ret

.exit_slots
	scf
	ret

.RanOutOfCoinsText:db	 0
	db $89
	db $81
	db $AB
	db $26
	db $4F
	db $C5
	db $B8
	db $C5
	db $DF
	db $C1
	db $E0
	db $DF
	db $C0
	db $56
	db $57
.PlayAgainText:db	 0
	db $D3
	db $B3
	db $7F
	db $F7
	db $B6
	db $B2
	db $4F
	db $B1
	db $BF
	db $3B
	db $CF
	db $BD
	db $B6
	db $E6
	db $57



Slots_GetPayout:
	ld a, [wSlotMatched]
	cp $FF
	jr z, Slots_GetPayout_no_win
	srl a
	ld e, a
	ld d, 0
	ld hl, Slots_GetPayout_PayoutTable
	add hl, de
	ld a, [hli]
	ld [wPayout+1], a
	ld a, [hl]
	ld [wPayout], a
	ret
Slots_GetPayout_PayoutTable:
	dw 300
	dw 50
	dw 6
	dw 8
	dw 10
	dw 15

Slots_GetPayout_no_win:
	ld hl, wPayout
	xor a
	ld [hli], a
	ld [hl], a
	ret




Slots_PayoutText:
	ld a, [wSlotMatched]
	cp $FF
	jr nz, .matched
	ld hl, .DarnText
	call PrintText
	ret

.matched
	srl a
	ld e, a
	ld d, 0
	ld hl, .PayoutStrings
	add hl, de
	add hl, de
	add hl, de
	ld de, wStringBuffer2
	ld c, 4

.copy_string
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy_string
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .return
	push de
	jp hl


.return
	ld hl, $4D80
	call $E70
	ret
.PayoutStrings:db $F9
	db $F6
	db $F6
	db $50
	dw .ClearBias
	db $FB
	db $F6
	db $50
	db $50
	dw .Blank
	db $FC
	db $50
	db $50
	db $50
	dw .Blank
	db $FE
	db $50
	db $50
	db $50
	dw .Blank
	db $F7
	db $F6
	db $50
	db $50
	dw .Blank
	db $F7
	db $FB
	db $50
	db $50
	dw .Blank
.Text_PrintPayout:db 8
	ld a, [wSlotMatched]
	add a, $25
	ld [$C3A6], a
	inc a
	ld [$C3BA], a
	inc a
	ld [$C3A7], a
	inc a
	ld [$C3BB], a
	ld hl, $C3F2
	ld [hl], $EE
	ld hl, .LinedUpText
	inc bc
	inc bc
	inc bc
	inc bc
	ret
.LinedUpText:db	 0
	db $26
	db $7F
	db $BF
	db $DB
	db $DF
	db $C0
	db $E7
	db $4F
	db $89
	db $81
	db $AB
	db $7F
	db $50
	db	 1
	dw $CD31
	db	 0
	db $CF
	db $B2
	db $7F
	db $B2
	db $C0
	db $30
	db $B7
	db $E7
	db $57
.DarnText:db 0
	db $CA
	db $2D
	db $DA
	db $E3
	db $57

.ClearBias:
	ld a, $FF
	ld [wSlotBias], a
	ret

.Blank:
	ret

Slots_AnimateGolem:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
.Jumptable:dw .init
	dw .fall
	dw .roll

.init
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .retain
	ld a, 2
	ld [wSlotsDelay], a
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], 0
	ret

.retain
	dec [hl]
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $30
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], 0

.fall
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	cp $20
	jr c, .landed
	dec [hl]
	ld e, a
	ld d, 112
	ld a, $33
	ld hl, BattleAnim_Sine_e
	call FarCall_hl
	ld a, e
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.landed
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld [hl], 2
	ld a, 1
	ld [wSlotsDelay], a
	ret

.roll
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	cp 72
	jr nc, .restart
	and 3
	ret nz
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	xor $FF
	inc a
	ld [hl], a
	ldh [hSCY], a
	ret

.restart
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	xor a
	ld [hl], a
	ldh [hSCY], a
	ret

Slots_AnimateChansey:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
.Jumptable:dw .walk
	dw .one
	dw .two

.walk
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	inc [hl]
	cp 104
	ret nz
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld a, 1
	ld [wSlotsDelay], a

.one
	ld a, [wSlotsDelay]
	cp 2
	jr z, .retain
	cp 5
	ret nz
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], 0
	ret

.retain
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], 8

.two
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	and a
	jr z, .spawn_egg
	dec [hl]
	ret

.spawn_egg
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	dec [hl]
	push bc
	ld de, $606C
	ld a, $3F
	call InitSpriteAnimStruct
	pop bc
	ret
Slots_Reel1Tilemap:db 0
	db	 8
	db $14
	db	$C
	db $10
	db	 0
	db	 8
	db $14
	db	$C
	db $10
	db	 4
	db	 8
	db $14
	db	$C
	db $10
	db	 0
	db	 8
	db $14
Slots_Reel2Tilemap:db 0
	db	$C
	db	 8
	db $10
	db $14
	db	 4
	db	$C
	db	 8
	db $10
	db $14
	db	 4
	db	$C
	db	 8
	db $10
	db $14
	db	 0
	db	$C
	db	 8
Slots_Reel3Tilemap:db 0
	db	$C
	db	 8
	db $10
	db $14
	db	$C
	db	 8
	db $10
	db $14
	db	$C
	db	 4
	db	 8
	db $10
	db $14
	db	$C
	db	 0
	db	$C
	db	 8
SlotsTilemap: db	 0
	db	 0
	db	 0
	db	 0
	db	 0
	db	 2
	db	 3
	db	 4
	db	 5
	db	 0
	db	 0
	db	 6
	db	 7
	db	 8
	db	 9
	db	 0
	db	 0
	db	 0
	db	 0
	db	 0
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	 1
	db	$A
	db	$E
	db	$B
	db $23
	db $1C
	db $1E
	db $1F
	db $1C
	db $1C
	db $1E
	db $1F
	db $1C
	db $1C
	db $1E
	db $1F
	db $1C
	db $23
	db	$A
	db	$E
	db	$B
	db	$C
	db	$F
	db	$D
	db $24
	db $1D
	db $20
	db $21
	db $1D
	db $1D
	db $20
	db $21
	db $1D
	db $1D
	db $20
	db $21
	db $1D
	db $24
	db	$C
	db	$F
	db	$D
	db	$A
	db $10
	db	$B
	db $23
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $23
	db	$A
	db $10
	db	$B
	db	$C
	db $11
	db	$D
	db $24
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $24
	db	$C
	db $11
	db	$D
	db	$A
	db $12
	db	$B
	db $23
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $23
	db	$A
	db $12
	db	$B
	db	$C
	db $13
	db	$D
	db $24
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $24
	db	$C
	db $13
	db	$D
	db	$A
	db $10
	db	$B
	db $23
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $23
	db	$A
	db $10
	db	$B
	db	$C
	db $11
	db	$D
	db $24
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $16
	db $17
	db $17
	db $16
	db $24
	db	$C
	db $11
	db	$D
	db	$A
	db	$E
	db	$B
	db $23
	db	 0
	db $18
	db $19
	db	 0
	db	 0
	db $18
	db $19
	db	 0
	db	 0
	db $18
	db $19
	db	 0
	db $23
	db	$A
	db	$E
	db	$B
	db	$C
	db	$F
	db	$D
	db $24
	db	 1
	db $1A
	db $1B
	db	 1
	db	 1
	db $1A
	db $1B
	db	 1
	db	 1
	db $1A
	db $1B
	db	 1
	db $24
	db	$C
	db	$F
	db	$D
