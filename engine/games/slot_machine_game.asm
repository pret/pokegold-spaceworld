INCLUDE "constants.asm"

SECTION "engine/games/slot_machine_game.asm", ROMX

DEF SLOTS_NO_BIAS        EQU -1
DEF SLOTS_NO_MATCH       EQU -1

DEF SLOTS_STARTING_COINS    EQU 256

DEF SLOTS_GFX_BLANK_TILE          EQU $17
DEF SLOTS_GFX_ILLUMINATED_LIGHT   EQU $14
DEF SLOTS_GFX_DEILLUMINATED_LIGHT EQU $23
DEF SLOTS_GFX_SEVEN_TILE_1        EQU $25
DEF SLOTS_GFX_SEVEN_TILE_2        EQU $41

DEF SLOTS_SEVEN    EQU $00
DEF SLOTS_POKEBALL EQU $04
DEF SLOTS_CHERRY   EQU $08
DEF SLOTS_PIKACHU  EQU $0c
DEF SLOTS_SQUIRTLE EQU $10
DEF SLOTS_STARYU   EQU $14

DEF REEL_SIZE EQU 15

; SlotsJumptable constants
	const_def
	const SLOTS_INIT
	const SLOTS_BET_AND_START
	const SLOTS_WAIT_START
	const SLOTS_WAIT_REEL1
	const SLOTS_WAIT_STOP_REEL1
	const SLOTS_WAIT_REEL2
	const SLOTS_WAIT_STOP_REEL2
	const SLOTS_WAIT_REEL3
	const SLOTS_WAIT_STOP_REEL3
	const SLOTS_NEXT_09
	const SLOTS_NEXT_0A
	const SLOTS_NEXT_0B
	const SLOTS_FLASH_IF_WIN
	const SLOTS_FLASH_SCREEN
	const SLOTS_GIVE_EARNED_COINS
	const SLOTS_PAYOUT_TEXT_AND_ANIM
	const SLOTS_PAYOUT_ANIM
	const SLOTS_RESTART_OR_QUIT
	const SLOTS_QUIT
DEF SLOTS_END_LOOP_F EQU 7

; ReelActionJumptable constants
	const_def
	const REEL_ACTION_DO_NOTHING
	const REEL_ACTION_STOP_REEL_IGNORE_JOYPAD
	const REEL_ACTION_QUADRUPLE_RATE
	const REEL_ACTION_DOUBLE_RATE
	const REEL_ACTION_NORMAL_RATE
	const REEL_ACTION_HALF_RATE
	const REEL_ACTION_QUARTER_RATE
	const REEL_ACTION_STOP_REEL1
	const REEL_ACTION_STOP_REEL2
	const REEL_ACTION_STOP_REEL3
	const REEL_ACTION_SET_UP_REEL2_SKIP_TO_7
	const REEL_ACTION_WAIT_REEL2_SKIP_TO_7
	const REEL_ACTION_FAST_SPIN_REEL2_UNTIL_LINED_UP_7S
	const REEL_ACTION_0D
	const REEL_ACTION_CHECK_DROP_REEL
	const REEL_ACTION_WAIT_DROP_REEL
	const REEL_ACTION_START_SLOW_ADVANCE_REEL3
	const REEL_ACTION_WAIT_SLOW_ADVANCE_REEL3
	const REEL_ACTION_INIT_GOLEM
	const REEL_ACTION_WAIT_GOLEM
	const REEL_ACTION_END_GOLEM
	const REEL_ACTION_INIT_CHANSEY
	const REEL_ACTION_WAIT_CHANSEY
	const REEL_ACTION_WAIT_EGG
	const REEL_ACTION_DROP_REEL

; Constants for slot_reel offsets (see macros/wram.asm)
DEF REEL_ACTION        EQUS "(wReel1ReelAction - wReel1)"
DEF REEL_TILEMAP_ADDR  EQUS "(wReel1TilemapAddr - wReel1)"
DEF REEL_POSITION      EQUS "(wReel1Position - wReel1)"
DEF REEL_SPIN_DISTANCE EQUS "(wReel1SpinDistance - wReel1)"
DEF REEL_SPIN_RATE     EQUS "(wReel1SpinRate - wReel1)"
DEF REEL_OAM_ADDR      EQUS "(wReel1OAMAddr - wReel1)"
DEF REEL_X_COORD       EQUS "(wReel1XCoord - wReel1)"
DEF REEL_MANIP_COUNTER EQUS "(wReel1ManipCounter - wReel1)"
DEF REEL_MANIP_DELAY   EQUS "(wReel1ManipDelay - wReel1)"
DEF REEL_FIELD_0B      EQUS "(wReel1Field0b - wReel1)"
DEF REEL_STOP_DELAY    EQUS "(wReel1StopDelay - wReel1)"

SlotMachineGame:
; Always start off with 256 coins
	ld hl, wCoins
	ld [hl], HIGH(SLOTS_STARTING_COINS)
	inc hl
	ld [hl], LOW(SLOTS_STARTING_COINS)

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
	callab InitEffectObject
	ld hl, wSlots
	ld bc, wSlotsDataEnd - wSlots
	xor a
	call ByteFill

	ld hl, SlotMachine2GFX
	ld de, vSprites
	ld bc, $80 tiles
	ld a, BANK(SlotMachine2GFX)
	call FarCopyData

	ld hl, SlotMachineGFX
	ld de, vChars2
	ld bc, $25 tiles
	ld a, BANK(SlotMachineGFX)
	call FarCopyData

	ld hl, SlotMachine2GFX
	ld de, vChars2 tile $25
	ld bc, $1c tiles
	ld a, BANK(SlotMachine2GFX)
	call FarCopyData

	ld hl, SlotMachine3GFX
	ld de, vChars2 tile $41
	ld bc, $1c tiles
	ld a, $24
	call FarCopyData

	ld hl, SlotsTilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * 12
.init_tilemap
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .init_tilemap

	ld hl, rLCDC
	set 2, [hl]
	call EnableLCD

	xor a
	ld hl, wSlots
	ld c, wSlotsEnd - wSlots
.clear_ram
	ld [hli], a
	dec c
	jr nz, .clear_ram

	call Slots_InitReelTiles

	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a

	ld a, %11000000
	ldh [rOBP1], a

	ld a, SPRITE_ANIM_INDEX_28
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], SPRITE_ANIM_INDEX_20

	xor a
	ld [wJumptableIndex], a
	ld a, SLOTS_NO_BIAS
	ld [wSlotBias], a
	ret

SlotsLoop:
	ld a, [wJumptableIndex]
	bit SLOTS_END_LOOP_F, a
	jr nz, .done
	call SlotsJumptable
	call Slots_SpinReels
	ld a, $60
	ld [wc4bd], a
	callab DoNextFrameForFirst16Sprites
	call Slots_PrintCoinsAndPayout
	call Slots_FlashPaletteOnMatchingSevens
	call Slots_AnimateReelSpritesAfterSpin
	call Slots_DisplayBiasValue
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
	ldh [rBGP], a
	ret

.matching_sevens
	ld a, [wVBlankJoyFrameCounter]
	and 7
	ret nz
	ldh a, [rBGP]
	xor %1100
	ldh [rBGP], a
	ret

Slots_PrintCoinsAndPayout:
	hlcoord 5, 1
	ld de, wCoins
	lb bc, PRINTNUM_LEADINGZEROS | 2, 4
	call PrintNumber
	hlcoord 11, 1
	ld de, wPayout
	lb bc, PRINTNUM_LEADINGZEROS | 2, 4
	call PrintNumber
	ret

Slots_DisplayBiasValue:
; debug feature
	ld a, [wSlotBias]
	add 0
	daa
	ld e, a

; print second digit
	and $f
	add "０"
	hlcoord 1, 0
	ld [hl], a

; print first digit
	ld a, e
	swap a
	and $F
	add "０"
	hlcoord 0, 0
	ld [hl], a
	ret

Slots_AnimateReelSpritesAfterSpin:
	ld hl, wcb61
	ld a, [hl]
	inc [hl]
	and 7
	ret nz
	hlcoord 5, 4
	ld a, [hl]
	cp SLOTS_GFX_BLANK_TILE
	call nz, .AnimateReelSprite
	hlcoord 9, 4
	ld a, [hl]
	cp SLOTS_GFX_BLANK_TILE
	call nz, .AnimateReelSprite
	hlcoord 13, 4
	ld a, [hl]
	cp SLOTS_GFX_BLANK_TILE
	call nz, .AnimateReelSprite
	ret

.AnimateReelSprite:
	cp SLOTS_GFX_SEVEN_TILE_2
	jr c, .seven_tile
	ld b, %11100100
	jr .continue
.seven_tile
	ld b, $1C
.continue
	ld de, $14
	ld c, 6
.loop
	ld a, [hl]
	add b
	ld [hli], a
	ld a, [hl]
	add b
	ld [hld], a
	add hl, de
	dec c
	jr nz, .loop
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
	ld a, SLOTS_NO_MATCH
	ld [wSlotMatched], a
	ret

SlotsAction_BetAndStart:
	call Slots_AskBet
	jr nc, .proceed
	ld a, SLOTS_QUIT
	ld [wJumptableIndex], a
	ret

.proceed
	call SlotsAction_Next
	call Slots_IlluminateBetLights
	call Slots_InitBias
	ld a, 32
	ld [wSlotsDelay], a
	ld a, REEL_ACTION_NORMAL_RATE
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
	cp REEL_ACTION_DO_NOTHING
	ret nz
	ld bc, wReel1
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
	cp REEL_ACTION_DO_NOTHING
	ret nz
	ld bc, wReel2
	ld de, wReel2Stopped
	call Slots_LoadReelState
	call SlotsAction_Next
	xor a
	ldh [hJoypadSum], a

SlotsAction_WaitReel3:
	ld hl, hJoypadSum
	ld a, [hl]
	and A_BUTTON
	ret z
	call SlotsAction_Next
	call Slots_StopReel3
	ld [wReel3ReelAction], a

SlotsAction_WaitStopReel3:
	ld a, [wReel3ReelAction]
	cp REEL_ACTION_DO_NOTHING
	ret nz
	ld bc, wReel3
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
	cp SLOTS_NO_MATCH
	jr nz, .matched
	call SlotsAction_Next
	call SlotsAction_Next
	ret

.matched
	call SlotsAction_Next
	ld a, 16
	ld [wSlotsDelay], a

SlotsAction_FlashScreen:
	ld hl, wSlotsDelay
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	srl a
	ret z

	ldh a, [rOBP0]
	xor $ff
	ldh [rOBP0], a
	ret

.done
	ld a, %11100100
	ldh [rOBP0], a
	call SlotsAction_Next
	ret

SlotsAction_GiveEarnedCoins:
	xor a
	ld [wFirstTwoReelsMatching], a
	ld [wFirstTwoReelsMatchingSevens], a
	ld a, %11100100
	ldh [rBGP], a
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
	and $1
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
	ld a, SLOTS_INIT
	ld [wJumptableIndex], a
	ret

.exit_slots
	ld a, SLOTS_QUIT
	ld [wJumptableIndex], a
	ret

SlotsAction_Quit:
	ld hl, wJumptableIndex
	set SLOTS_END_LOOP_F, [hl]
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
	cp HIGH(MAX_COINS)
	jr c, .not_full
	ld a, e
	cp LOW(MAX_COINS)
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
	ld a, $f

.okay
	dec a
	and $f
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
	ld a, REEL_ACTION_STOP_REEL1
	ret

Slots_StopReel2:
	ld a, [wSlotBias]
	and a
	jr z, .skip
	cp SLOTS_NO_BIAS
	jr nz, .dont_jump
.skip
	call .CheckReel1ForASeven
	jr nz, .dont_jump
	call Random
	cp 31 percent + 1
	jr nc, .dont_jump
	ld a, REEL_ACTION_SET_UP_REEL2_SKIP_TO_7
	ret

.dont_jump
	ld a, REEL_ACTION_STOP_REEL2
	ret

.CheckReel1ForASeven:
	ld a, [wReel1Stopped]
	and a
	ret z
	ld a, [wReel1Stopped + 1]
	and a
	ret z
	ld a, [wReel1Stopped + 2]
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
	cp 71 percent - 1
	jr nc, .stop
	cp 47 percent + 1
	jr nc, .slow_advance
	cp 24 percent - 1
	jr nc, .golem
	ld a, REEL_ACTION_INIT_CHANSEY
	ret
.biased
	call Random
	cp 63 percent
	jr nc, .stop
	cp 31 percent + 1
	jr nc, .slow_advance
.golem
	ld a, REEL_ACTION_INIT_GOLEM
	ret
.slow_advance
	ld a, REEL_ACTION_START_SLOW_ADVANCE_REEL3
	ret
.stop
	ld a, REEL_ACTION_STOP_REEL3
	ret

Slots_InitReelTiles:
	ld bc, wReel1
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
	ld [hl], 6 * TILE_WIDTH
	call .OAM

	ld bc, wReel2
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld de, wVirtualOAMSprite08
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
	ld [hl], 10 * TILE_WIDTH
	call .OAM

	ld bc, wReel3
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld de, wVirtualOAMSprite16
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
	ld [hl], 14 * TILE_WIDTH
	call .OAM
	ret

.OAM:
	ld hl, REEL_ACTION
	add hl, bc
	ld [hl], REEL_ACTION_DO_NOTHING
	ld hl, REEL_POSITION
	add hl, bc
	ld [hl], REEL_SIZE - 1
	ld hl, REEL_SPIN_DISTANCE
	add hl, bc
	ld [hl], REEL_ACTION_DO_NOTHING
	call Slots_UpdateReelPositionAndOAM
	ret

Slots_SpinReels:
	ld bc, wReel1
	call .SpinReel
	ld bc, wReel2
	call .SpinReel
	ld bc, wReel3
	call .SpinReel
	ret

.SpinReel:
	ld hl, REEL_SPIN_DISTANCE
	add hl, bc
	ld a, [hl]
	and $f
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
	add [hl]
	ld [hl], a
	and $f
	jr z, Slots_UpdateReelPositionAndOAM
	ld hl, REEL_OAM_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld e, 8
.loop
	ld a, [hl]
	add d
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
	ld a, 10 * TILE_WIDTH
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
	and $f
	cp REEL_SIZE
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
.loop
; set y and x coordinates
	ld a, [wCurReelYCoord]
	ld [hli], a
	ld a, [wCurReelXCoord]
	ld [hli], a
; set tile ID
	ld a, [de]
	ld [hli], a
; set priority behind BG, no attributes beyond it
	ld a, (1 << OAM_PRIORITY)
	ld [hli], a
; next OAM
	ld a, [wCurReelYCoord]
	ld [hli], a
	ld a, [wCurReelXCoord]
	add 8
	ld [hli], a
	ld a, [de]
	inc a
	inc a
	ld [hli], a
	ld a, (1 << OAM_PRIORITY)
	ld [hli], a
	inc de
	ld a, [wCurReelYCoord]
	sub 2 * TILE_WIDTH
	ld [wCurReelYCoord], a
	cp 2 * TILE_WIDTH
	jr nz, .loop
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
	dw ReelAction_0D
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
	ld [hl], REEL_ACTION_STOP_REEL_IGNORE_JOYPAD
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
.clear_reel_oam
	ld [hli], a
	dec e
	jr nz, .clear_reel_oam

	ld hl, REEL_ACTION
	add hl, bc
	ld a, REEL_ACTION_DO_NOTHING
	ld [hl], a
	ret

Function907c8:
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	sub 6 * TILE_WIDTH
	srl a
	srl a
	srl a
	ld e, a
	ld d, 0
	push bc
	hlcoord 5, 4
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
	add SLOTS_GFX_SEVEN_TILE_1
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
	hlcoord 5, 4
	call .asm90814
	hlcoord 9, 4
	call .asm90814
	hlcoord 13, 4

.asm90814
	ld a, SLOTS_GFX_BLANK_TILE
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
	ld bc, wReel1
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wCurReelXCoord], a
	ld a, 10 * TILE_WIDTH
	ld [wCurReelYCoord], a
	call Slots_GetCurrentReelState
	ld e, l
	ld d, h
	call Slots_LoadOAM

	ld bc, wReel2
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wCurReelXCoord], a
	ld a, 10 * TILE_WIDTH
	ld [wCurReelYCoord], a
	call Slots_GetCurrentReelState
	ld e, l
	ld d, h
	call Slots_LoadOAM

	ld bc, wReel3
	ld hl, REEL_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wCurReelXCoord], a
	ld a, 10 * TILE_WIDTH
	ld [wCurReelYCoord], a
	call Slots_GetCurrentReelState
	ld e, l
	ld d, h
	call Slots_LoadOAM
	ret

ReelAction_StopReel1:
	ld a, [wSlotBias]
	cp SLOTS_NO_BIAS
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
	cp SLOTS_NO_BIAS
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
	cp SLOTS_NO_BIAS
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
	inc [hl] ; REEL_ACTION_FAST_SPIN_REEL2_UNTIL_LINED_UP_7S
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
	inc [hl] ; REEL_ACTION_WAIT_GOLEM
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 0
	call Slots_GetNumberOfGolems
	push bc
	push af
	depixel 12, 13
	ld a, SPRITE_ANIM_INDEX_SLOTS_GOLEM
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_0E
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
	depixel 12, 0
	ld a, SPRITE_ANIM_INDEX_SLOTS_CHANSEY
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
	inc [hl] ; REEL_ACTION_WAIT_EGG
	ld a, 2
	ld [wSlotsDelay], a

ReelAction_WaitEgg:
	ld a, [wSlotsDelay]
	cp 4
	ret c
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl] ; REEL_ACTION_DROP_REEL
	ld hl, REEL_SPIN_RATE
	add hl, bc
	ld [hl], 16
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld [hl], 17

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
	dec [hl] ; REEL_ACTION_WAIT_CHANSEY
	ld a, 1
	ld [wSlotsDelay], a
	ret

ReelAction_0D:
	call Slots_CheckMatchedAllThreeReels
	ret c
	ld hl, REEL_ACTION
	add hl, bc
	inc [hl] ; REEL_ACTION_CHECK_DROP_REEL
	call Slots_GetNumberOfGolems
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld [hl], a

ReelAction_CheckDropReel:
	ld hl, REEL_MANIP_DELAY
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
	inc [hl] ; REEL_ACTION_WAIT_DROP_REEL
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
	inc [hl] ; REEL_ACTION_WAIT_SLOW_ADVANCE_REEL3
	ld hl, REEL_MANIP_DELAY
	add hl, bc
	ld [hl], 16

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

.Jumptable:
	dw .zero
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
	ld hl,	wCurReelStopped + 1
	ld a, [wReel1Stopped]
	cp [hl]
	call z, .StoreResult
	ret

.CheckMiddleRow:
	ld hl,	wCurReelStopped + 1
	ld a, [wReel1Stopped + 1]
	cp [hl]
	call z, .StoreResult
	ret

.CheckDownwardsDiag:
	ld hl,	wCurReelStopped + 1
	ld a, [wReel1Stopped + 2]
	cp [hl]
	call z, .StoreResult
	ret

.CheckTopRow:
	ld hl,	wCurReelStopped + 2
	ld a, [wReel1Stopped + 2]
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
	ld [wFirstTwoReelsMatching], a
	ret

Slots_CheckMatchedAllThreeReels:
	ld a, SLOTS_NO_MATCH
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
	cp SLOTS_NO_MATCH
	jr nz, .matched_nontrivial
	and a
	ret

.matched_nontrivial
	scf
	ret

.Jumptable:
	dw .zero
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
	ld hl,	wCurReelStopped + 2
	ld a, [wReel1Stopped]
	cp [hl]
	ret nz
	ld hl,	wReel2Stopped + 1
	cp [hl]
	call z, .StoreResult
	ret

.CheckMiddleRow:
	ld hl,	wCurReelStopped + 1
	ld a, [wReel1Stopped + 1]
	cp [hl]
	ret nz
	ld hl,	wReel2Stopped + 1
	cp [hl]
	call z, .StoreResult
	ret

.CheckDownwardsDiag:
	ld hl, wCurReelStopped
	ld a, [wReel1Stopped + 2]
	cp [hl]
	ret nz
	ld hl,	wReel2Stopped + 1
	cp [hl]
	call z, .StoreResult
	ret

.CheckTopRow:
	ld hl,	wCurReelStopped + 2
	ld a, [wReel1Stopped + 2]
	cp [hl]
	ret nz
	ld hl,	wReel2Stopped + 2
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
	cp 8 / 2 ; 50%
	jr c, .not_biased_to_seven
	ld e, a

.loop2
	ld a, e
	inc e
	ld hl, REEL_POSITION
	add hl, bc
	add [hl]
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

.Biases:
	db   1 percent - 1, SLOTS_SEVEN
	db   1 percent + 1, SLOTS_POKEBALL
	db   4 percent,     SLOTS_STARYU
	db   8 percent,     SLOTS_SQUIRTLE
	db  16 percent,     SLOTS_PIKACHU
	db  31 percent + 1, SLOTS_CHERRY
	db 100 percent,     SLOTS_NO_BIAS

Slots_IlluminateBetLights:
	ld b, SLOTS_GFX_ILLUMINATED_LIGHT
	ld a, [wSlotBet]
	dec a
	jr z, Slot_Lights1OnOff
	dec a
	jr z, Slots_Lights2OnOff
	jr Slots_Lights3OnOff

Slots_DeilluminateBetLights:
	ld b, SLOTS_GFX_DEILLUMINATED_LIGHT

Slots_Lights3OnOff:
	hlcoord 3, 2
	call Slots_TurnLightsOnOrOff
	hlcoord 3, 10
	call Slots_TurnLightsOnOrOff

Slots_Lights2OnOff:
	hlcoord 3, 4
	call Slots_TurnLightsOnOrOff
	hlcoord 3, 8
	call Slots_TurnLightsOnOrOff

Slot_Lights1OnOff:
	hlcoord 3, 6

Slots_TurnLightsOnOrOff:
	ld a, b
	ld [hl], a
	ld de, SCREEN_WIDTH / 2 + 3
	add hl, de
	ld [hl], a
	ld de, SCREEN_WIDTH / 2 - 3
	add hl, de
	inc a
	ld [hl], a
	ld de, SCREEN_WIDTH / 2 + 3
	add hl, de
	ld [hl], a
	ret

Slots_AskBet:
.loop
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
	jr .loop

.Start:
	ld hl,	wCoins+1
	ld a, [hl]
	sub c
	ld [hld], a
	jr nc, .ok
	dec [hl]

.ok
	ld de, SFX_PAY_DAY
	call PlaySFX
	ld hl, .SlotsStartText
	call PrintText
	and a
	ret

.BetHowManyCoinsText:
	text "コインを"
	line "なんまい　かけますか？"
	done

.SlotsStartText:
	text "スタート！"
	done

.NotEnoughCoinsText:
	text "コインが　たりません！"
	prompt

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 14, 10, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "３まい@"
	db "２まい@"
	db "１まい@"

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

.RanOutOfCoinsText:
	text "コインが"
	line "なくなっちゃった<⋯⋯>"
	done

.PlayAgainText:
	text "もう　１かい"
	line "あそびますか？"
	done

Slots_GetPayout:
	ld a, [wSlotMatched]
	cp SLOTS_NO_MATCH
	jr z, .no_win
	srl a
	ld e, a
	ld d, 0
	ld hl, .PayoutTable
	add hl, de
	ld a, [hli]
	ld [wPayout + 1], a
	ld a, [hl]
	ld [wPayout], a
	ret

.PayoutTable:
	dw 300
	dw  50
	dw   6
	dw   8
	dw  10
	dw  15

.no_win
	ld hl, wPayout
	xor a
	ld [hli], a
	ld [hl], a
	ret

Slots_PayoutText:
	ld a, [wSlotMatched]
	cp SLOTS_NO_MATCH
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
	ld hl, .Text_PrintPayout
	call PrintText
	ret

.PayoutStrings:
	dbw "３００@", .ClearBias
	dbw "５０@@", .Blank
	dbw "６@@@", .Blank
	dbw "８@@@", .Blank
	dbw "１０@@", .Blank
	dbw "１５@@", .Blank

.Text_PrintPayout:
	start_asm
	ld a, [wSlotMatched]
	add $25
	ldcoord_a 2, 13
	inc a
	ldcoord_a 2, 14
	inc a
	ldcoord_a 3, 13
	inc a
	ldcoord_a 3, 14
	hlcoord 18, 16
	ld [hl], "▼"
	ld hl, .LinedUpText
rept 4
	inc bc
endr
	ret

.LinedUpText:
	text "が　そろった！"
	line "コイン　@"
	text_from_ram wStringBuffer2
	text "まい　いただき！"
	done

.DarnText:
	text "はずれー"
	done

.ClearBias:
	ld a, SLOTS_NO_BIAS
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

.Jumptable:
	dw .init
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
	ld d, 14 * 8
	callba BattleAnim_Sine_e
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
	cp 9 * 8
	jr nc, .restart
	and 3
	ret nz
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	xor $ff
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

.Jumptable:
	dw .walk
	dw .one
	dw .two

.walk
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	inc [hl]
	cp 13 * 8
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
	depixel 12, 13, 0, 4
	ld a, SPRITE_ANIM_INDEX_SLOTS_EGG
	call InitSpriteAnimStruct
	pop bc
	ret

; The first three positions are repeated to
; avoid needing to check indices when copying.
Slots_Reel1Tilemap:
	db SLOTS_SEVEN
	db SLOTS_CHERRY
	db SLOTS_STARYU
	db SLOTS_PIKACHU
	db SLOTS_SQUIRTLE
	db SLOTS_SEVEN
	db SLOTS_CHERRY
	db SLOTS_STARYU
	db SLOTS_PIKACHU
	db SLOTS_SQUIRTLE
	db SLOTS_POKEBALL
	db SLOTS_CHERRY
	db SLOTS_STARYU
	db SLOTS_PIKACHU
	db SLOTS_SQUIRTLE
; repeated
	db SLOTS_SEVEN
	db SLOTS_CHERRY
	db SLOTS_STARYU

Slots_Reel2Tilemap:
	db SLOTS_SEVEN
	db SLOTS_PIKACHU
	db SLOTS_CHERRY
	db SLOTS_SQUIRTLE
	db SLOTS_STARYU
	db SLOTS_POKEBALL
	db SLOTS_PIKACHU
	db SLOTS_CHERRY
	db SLOTS_SQUIRTLE
	db SLOTS_STARYU
	db SLOTS_POKEBALL
	db SLOTS_PIKACHU
	db SLOTS_CHERRY
	db SLOTS_SQUIRTLE
	db SLOTS_STARYU
; repeated
	db SLOTS_SEVEN
	db SLOTS_PIKACHU
	db SLOTS_CHERRY

Slots_Reel3Tilemap:
	db SLOTS_SEVEN
	db SLOTS_PIKACHU
	db SLOTS_CHERRY
	db SLOTS_SQUIRTLE
	db SLOTS_STARYU
	db SLOTS_PIKACHU
	db SLOTS_CHERRY
	db SLOTS_SQUIRTLE
	db SLOTS_STARYU
	db SLOTS_PIKACHU
	db SLOTS_POKEBALL
	db SLOTS_CHERRY
	db SLOTS_SQUIRTLE
	db SLOTS_STARYU
	db SLOTS_PIKACHU
; repeated
	db SLOTS_SEVEN
	db SLOTS_PIKACHU
	db SLOTS_CHERRY

SlotsTilemap:
INCBIN "gfx/minigames/slots_tilemap.bin"
