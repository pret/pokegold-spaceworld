include "constants.asm"

SECTION "Battle Anims BG Effects", ROMX [$4000], BANK [$32]

	const_def
	const BGSQUARE_SIX
	const BGSQUARE_FOUR
	const BGSQUARE_TWO
	const BGSQUARE_SEVEN
	const BGSQUARE_FIVE
	const BGSQUARE_THREE

; BG effects for use in battle animations.

ExecuteBGEffects: ; c8000 (32:4000)
	ld hl, wActiveBGEffects
	ld e, 5
.loop
	ld a, [hl]
	and a
	jr z, .next
	ld c, l
	ld b, h
	push hl
	push de
	call DoBattleBGEffectFunction
	pop de
	pop hl
.next
	ld bc, 4
	add hl, bc
	dec e
	jr nz, .loop
	ret

QueueBGEffect: ; c801a (32:401a)
	ld hl, wActiveBGEffects
	ld e, 5
.loop
	ld a, [hl]
	and a
	jr z, .load
	ld bc, 4
	add hl, bc
	dec e
	jr nz, .loop
	scf
	ret

.load
	ld c, l
	ld b, h
	ld hl, BG_EFFECT_STRUCT_FUNCTION
	add hl, bc
	ld a, [wBattleAnimTemp0]
	ld [hli], a
	ld a, [wBattleAnimTemp1]
	ld [hli], a
	ld a, [wBattleAnimTemp2]
	ld [hli], a
	ld a, [wBattleAnimTemp3]
	ld [hl], a
	ret

EndBattleBGEffect: ; c8043 (32:4043)
	ld hl, BG_EFFECT_STRUCT_FUNCTION
	add hl, bc
	ld [hl], 0
	ret

DoBattleBGEffectFunction: ; c804a (32:404a)
	ld hl, BG_EFFECT_STRUCT_FUNCTION
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, BattleBGEffects
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

BattleBGEffects: ; c805a (32:405a)
; entries correspond to ANIM_BG_* constants
	dw BattleBGEffect_End
	dw BattleBGEffect_FlashInverted
	dw BattleBGEffect_FlashWhite
	dw BattleBGEffect_WhiteHues
	dw BattleBGEffect_BlackHues
	dw BattleBGEffect_AlternateHues
	dw BattleBGEffect_06
	dw BattleBGEffect_07
	dw BattleBGEffect_08
	dw BattleBGEffect_HideMon
	dw BattleBGEffect_ShowMon
	dw BattleBGEffect_EnterMon
	dw BattleBGEffect_ReturnMon
	dw BattleBGEffect_Surf
	;dw BattleBGEffect_Whirlpool
	dw BattleBGEffect_Teleport
	dw BattleBGEffect_NightShade
	dw BattleBGEffect_FeetFollow
	dw BattleBGEffect_HeadFollow
	dw BattleBGEffect_DoubleTeam
	dw BattleBGEffect_AcidArmor
	dw BattleBGEffect_RapidFlash
	dw BattleBGEffect_16
	dw BattleBGEffect_17
	dw BattleBGEffect_18
	dw BattleBGEffect_19
	dw BattleBGEffect_1a
	dw BattleBGEffect_1b
	dw BattleBGEffect_1c
	dw BattleBGEffect_1d
	dw BattleBGEffect_1e
	dw BattleBGEffect_1f
	dw BattleBGEffect_20
	dw BattleBGEffect_Withdraw
	dw BattleBGEffect_BounceDown
	dw BattleBGEffect_Dig
	dw BattleBGEffect_Tackle
	;dw BattleBGEffect_25
	dw BattleBGEffect_26
	dw BattleBGEffect_27
	dw BattleBGEffect_28
	dw BattleBGEffect_Psychic
	dw BattleBGEffect_2a
	dw BattleBGEffect_2b
	dw BattleBGEffect_2c
	dw BattleBGEffect_2d
	dw BattleBGEffect_2e
	dw BattleBGEffect_2f
	;dw BattleBGEffect_30
	;dw BattleBGEffect_31
	;dw BattleBGEffect_32
	;dw BattleBGEffect_VibrateMon
	;dw BattleBGEffect_WobbleMon


BattleBGEffect_End: ; c80b6 (32:40b6)
	call EndBattleBGEffect
	ret

BattleBGEffects_AnonJumptable: ; c80ba (32:40ba)
	ld hl, sp+$0
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
BatttleBGEffects_GetNamedJumptablePointer: ; c80c0 (32:40c0)
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

BattleBGEffects_IncrementJumptable: ; c80cd (32:40cd)
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	inc [hl]
	ret

BattleBGEffect_FlashInverted: ; c80d3 (32:40d3)
	ld de, .inverted
	call BattleBGEffect_FlashContinue
	ret

.inverted
	db %11100100 ; 3210
	db %00011011 ; 0123
; c80f3

BattleBGEffect_FlashWhite: ; c80dc (32:40dc)
	ld de, .white
	call BattleBGEffect_FlashContinue
	ret

.white
	db %11100100 ; 3210
	db %00000000 ; 0000
; c80fb

BattleBGEffect_FlashContinue: ; c80e5 (32:40e5)
; current timer, flash duration, number of flashes
	ld a, $1
	ld [wBattleAnimTemp0], a
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	ld a, [hl]
	and a
	jr z, .init
	dec [hl]
	ret

.init
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	ld [hl], a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .apply_pal
	call EndBattleBGEffect
	ret

.apply_pal
	dec a
	ld [hl], a
	and 1
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	ld [wBGP], a
	ret

BattleBGEffect_WhiteHues: ; c8117 (32:4117)
	ld de, .Pals
	call BattleBGEffect_GetNthDMGPal
	jr c, .quit
	ld [wBGP], a
	ret

.quit
	call EndBattleBGEffect
	ret

.Pals:
	db %11100100
	db %11100000
	db %11010000
	db -1
; c8141

BattleBGEffect_BlackHues: ; c812b (32:412b)
	ld de, .Pals
	call BattleBGEffect_GetNthDMGPal
	jr c, .quit
	ld [wBGP], a
	ret

.quit
	call EndBattleBGEffect
	ret

.Pals:
	db %11100100
	db %11110100
	db %11111000
	db -1
; c8155

BattleBGEffect_AlternateHues: ; c813f (32:413f)
	ld de, .Pals
	call BattleBGEffect_GetNthDMGPal
	jr c, .quit
	ld [wBGP], a
	ld [wOBP1], a
	ret

.quit
	call EndBattleBGEffect
	ret

.Pals:
	db %11100100
	db %11111000
	db %11111100
	db %11111000
	db %11100100
	db %10010000
	db %01000000
	db %10010000
	db -2
; c8171

BattleBGEffect_06: ; c815b (32:415b)
	call BattleBGEffects_CheckSGB
	jr nz, .sgb
	ld de, .PalsCGB
	jr .okay

.sgb
	ld de, .PalsSGB
.okay
	call BattleBGEffect_GetNthDMGPal
	ld [wOBP0], a
	ret

.PalsCGB:
	db %11100100
	db %10010000
	db -2

.PalsSGB:
	db %11110000
	db %11000000
	db -2
; c818b

BattleBGEffect_07: ; c8175 (32:4175)
	call BattleBGEffects_CheckSGB
	jr nz, .sgb
	ld de, .PalsCGB
	jr .okay

.sgb
	ld de, .PalsSGB
.okay
	call BattleBGEffect_GetNthDMGPal
	ld [wOBP0], a
	ret

.PalsCGB:
	db %11100100
	db %11011000
	db -2

.PalsSGB:
	db %11110000
	db %11001100
	db -2
; c81a5

BattleBGEffect_08: ; c818f (32:418f)
	ld de, .Pals
	call BattleBGEffect_GetNthDMGPal
	ld [wBGP], a
	ret

.Pals:
	db %00011011
	db %01100011
	db %10000111
	db -2
; c81b3

BattleBGEffect_HideMon: ; c819d (32:419d)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw .four


.zero
	call BattleBGEffects_IncrementJumptable
	push bc
	call BGEffect_CheckBattleTurn
	jr nz, .player_side
	hlcoord 12, 0
	lb bc, 7, 7
	jr .got_pointer

.player_side
	hlcoord 2, 6
	lb bc, 6, 6
.got_pointer
	call ClearBox
	pop bc
	ld a, $1
	ldh [hBGMapMode], a
	ret

.four
	xor a
	ldh [hBGMapMode], a
	call EndBattleBGEffect
	ret

BattleBGEffect_ShowMon: ; c81d2 (32:41d2)
	call BGEffect_CheckFlyDigStatus
	jr z, .not_flying
	call EndBattleBGEffect
	ret

.not_flying
	call BGEffect_CheckBattleTurn
	jr nz, .player_side
	ld de, .EnemyData
	jr .got_pointer

.player_side
	ld de, .PlayerData
.got_pointer
	ld a, e
	ld [wBattleAnimTemp1], a
	ld a, d
	ld [wBattleAnimTemp2], a
	call BattleBGEffect_RunPicResizeScript
	ret

.PlayerData:
	db  0, $31, 0
	db -1
.EnemyData:
	db  3, $00, 3
	db -1
; c8214

BattleBGEffect_FeetFollow: ; c81fc (32:41fc)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw .five


.zero
	call BGEffect_CheckFlyDigStatus
	jr z, .not_flying_digging
	call EndBattleBGEffect
	ret

.not_flying_digging
	call BattleBGEffects_IncrementJumptable
	push bc
	call BGEffect_CheckBattleTurn
	jr nz, .player_turn
	ld a, ANIM_OBJ_PLAYERFEETFOLLOW
	ld [wBattleAnimTemp0], a
	ld a, 16 * 8 + 4
	jr .okay

.player_turn
	ld a, ANIM_OBJ_ENEMYFEETFOLLOW
	ld [wBattleAnimTemp0], a
	ld a, 6 * 8
.okay
	ld [wBattleAnimTemp1], a
	ld a, 8 * 8
	ld [wBattleAnimTemp2], a
	xor a
	ld [wBattleAnimTemp3], a
	call _QueueBattleAnimation
	pop bc
	ret

.one
	call BattleBGEffects_IncrementJumptable
	push bc
	call BGEffect_CheckBattleTurn
	jr nz, .player_turn_2
	hlcoord 12, 6
	lb bc, 1, 7
	jr .okay2

.player_turn_2
	hlcoord 2, 6
	lb bc, 1, 6
.okay2
	call ClearBox
	ld a, $1
	ldh [hBGMapMode], a
	pop bc
	ret

.five
	xor a
	ldh [hBGMapMode], a
	call EndBattleBGEffect
	ret

BattleBGEffect_HeadFollow: ; c8266 (32:4266)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw .five


.zero
	call BGEffect_CheckFlyDigStatus
	jr z, .not_flying_digging
	call EndBattleBGEffect
	ret

.not_flying_digging
	call BattleBGEffects_IncrementJumptable
	push bc
	call BGEffect_CheckBattleTurn
	jr nz, .player_turn
	ld a, ANIM_OBJ_PLAYERHEADFOLLOW
	ld [wBattleAnimTemp0], a
	ld a, 16 * 8 + 4
	jr .okay

.player_turn
	ld a, ANIM_OBJ_ENEMYHEADFOLLOW
	ld [wBattleAnimTemp0], a
	ld a, 6 * 8
.okay
	ld [wBattleAnimTemp1], a
	ld a, 8 * 8
	ld [wBattleAnimTemp2], a
	xor a
	ld [wBattleAnimTemp3], a
	call _QueueBattleAnimation
	pop bc
	ret

.one
	call BattleBGEffects_IncrementJumptable
	push bc
	call BGEffect_CheckBattleTurn
	jr nz, .player_turn_2
	hlcoord 12, 5
	lb bc, 2, 7
	jr .okay2

.player_turn_2
	hlcoord 2, 6
	lb bc, 2, 6
.okay2
	call ClearBox
	ld a, $1
	ldh [hBGMapMode], a
	pop bc
	ret

.five
	xor a
	ldh [hBGMapMode], a
	call EndBattleBGEffect
	ret

_QueueBattleAnimation: ; c82ee (32:42ee)
	callab QueueBattleAnimation
	ret

BattleBGEffect_27: ; c82d9 (32:42d9)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw .four


.zero
	call BattleBGEffects_IncrementJumptable
	call BGEffect_CheckBattleTurn
	ld [hl], a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $8
	ret

.one
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	and a
	jr z, .user_2
	hlcoord 0, 6
	lb de, 8, 6
.row1
	push de
	push hl
.col1
	inc hl
	ld a, [hld]
	ld [hli], a
	dec d
	jr nz, .col1
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop de
	dec e
	jr nz, .row1
	jr .okay2

.user_2
	hlcoord 19, 0
	lb de, 8, 7
.row2
	push de
	push hl
.col2
	dec hl
	ld a, [hli]
	ld [hld], a
	dec d
	jr nz, .col2
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop de
	dec e
	jr nz, .row2
.okay2
	ld a, $1
	ldh [hBGMapMode], a
	call BattleBGEffects_IncrementJumptable
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	dec [hl]
	ret

.four
	xor a
	ldh [hBGMapMode], a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	ld [hl], $1
	ret

.done
	call EndBattleBGEffect
	ret

BattleBGEffect_EnterMon: ; c8350 (32:4350)
	call BGEffect_CheckBattleTurn
	jr nz, .player_turn
	ld de, .EnemyData
	jr .okay

.player_turn
	ld de, .PlayerData
.okay
	ld a, e
	ld [wBattleAnimTemp1], a
	ld a, d
	ld [wBattleAnimTemp2], a
	call BattleBGEffect_RunPicResizeScript
	ret

.PlayerData:
	db  2, $31, 2
	db  1, $31, 1
	db  0, $31, 0
	db -1
.EnemyData:
	db  5, $00, 5
	db  4, $00, 4
	db  3, $00, 3
	db -1
; c83a8

BattleBGEffect_ReturnMon: ; c837d (32:437d)
	call BGEffect_CheckBattleTurn
	jr nz, .player_turn
	ld de, .EnemyData
	jr .okay

.player_turn
	ld de, .PlayerData
.okay
	ld a, e
	ld [wBattleAnimTemp1], a
	ld a, d
	ld [wBattleAnimTemp2], a
	call BattleBGEffect_RunPicResizeScript
	ret

.PlayerData:
	db  0, $31, 0
	db -2, $66, 0
	db  1, $31, 1
	db -2, $44, 1
	db  2, $31, 2
	db -2, $22, 2
	db -3, $00, 0
	db -1
.EnemyData:
	db  3, $00, 3
	db -2, $77, 3
	db  4, $00, 4
	db -2, $55, 4
	db  5, $00, 5
	db -2, $33, 5
	db -3, $00, 0
	db -1
; c83ed

BattleBGEffect_RunPicResizeScript: ; c83c2 (32:43c2)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw BattleBGEffects_IncrementJumptable
	dw .restart
	dw .end


.zero
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld e, [hl]
	ld d, $0
	inc [hl]
	ld a, [wBattleAnimTemp1]
	ld l, a
	ld a, [wBattleAnimTemp2]
	ld h, a
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .end
	cp -2
	jr z, .clear
	cp -3
	jr z, .skip
	call .PlaceGraphic
.skip
	call BattleBGEffects_IncrementJumptable
	ld a, $1
	ldh [hBGMapMode], a
	ret

.clear
	call .ClearBox
	jr .zero

.restart
	xor a
	ldh [hBGMapMode], a
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	ld [hl], $0
	ret

.end
	xor a
	ldh [hBGMapMode], a
	call EndBattleBGEffect
	ret

.ClearBox:
; get dims
	push bc
	inc hl
	ld a, [hli]
	ld b, a
	and $f
	ld c, a
	ld a, b
	swap a
	and $f
	ld b, a
; get coords
	ld e, [hl]
	ld d, 0
	ld hl, .Coords
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ClearBox
	pop bc
	ret

.PlaceGraphic:
; get dims
	push bc
	push hl
	ld e, [hl]
	ld d, 0
	ld hl, .BGSquares
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld b, a
	and $f
	ld c, a
	ld a, b
	swap a
	and $f
	ld b, a
; store pointer
	ld e, [hl]
	inc hl
	ld d, [hl]
; get byte
	pop hl
	inc hl
	ld a, [hli]
	ld [wBattleAnimTemp0], a
; get coord
	push de
	ld e, [hl]
	ld d, 0
	ld hl, .Coords
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de
; fill box
.row
	push bc
	push hl
	ld a, [wBattleAnimTemp0]
	ld b, a
.col
	ld a, [de]
	add b
	ld [hli], a
	inc de
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	pop bc
	ret

.Coords:
	dwcoord  2,  6
	dwcoord  3,  8
	dwcoord  4, 10
	dwcoord 12,  0
	dwcoord 13,  2
	dwcoord 14,  4

.BGSquares:
bgsquare: MACRO
	dn \1, \2
	dw \3
ENDM

	bgsquare 6, 6, .SixBySix
	bgsquare 4, 4, .FourByFour
	bgsquare 2, 2, .TwoByTwo
	bgsquare 7, 7, .SevenBySeven
	bgsquare 5, 5, .FiveByFive
	bgsquare 3, 3, .ThreeByThree

.SixBySix:
	db $00, $06, $0c, $12, $18, $1e
	db $01, $07, $0d, $13, $19, $1f
	db $02, $08, $0e, $14, $1a, $20
	db $03, $09, $0f, $15, $1b, $21
	db $04, $0a, $10, $16, $1c, $22
	db $05, $0b, $11, $17, $1d, $23

.FourByFour:
	db $00, $0c, $12, $1e
	db $02, $0e, $14, $20
	db $03, $0f, $15, $21
	db $05, $11, $17, $23

.TwoByTwo:
	db $00, $1e
	db $05, $23

.SevenBySeven:
	db $00, $07, $0e, $15, $1c, $23, $2a
	db $01, $08, $0f, $16, $1d, $24, $2b
	db $02, $09, $10, $17, $1e, $25, $2c
	db $03, $0a, $11, $18, $1f, $26, $2d
	db $04, $0b, $12, $19, $20, $27, $2e
	db $05, $0c, $13, $1a, $21, $28, $2f
	db $06, $0d, $14, $1b, $22, $29, $30

.FiveByFive:
	db $00, $07, $15, $23, $2a
	db $01, $08, $16, $24, $2b
	db $03, $0a, $18, $26, $2d
	db $05, $0c, $1a, $28, $2f
	db $06, $0d, $1b, $29, $30

.ThreeByThree:
	db $00, $15, $2a
	db $03, $18, $2d
	db $06, $1b, $30
; c8545

BattleBGEffect_Surf: ; c851d (32:451d)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one


.zero
	call BattleBGEffects_IncrementJumptable
	lb de, 4, 1
	call InitSurfWaves

.one
	ldh a, [hLCDCPointer]
	and a
	ret z
	push bc
	call .RotatewSurfWaveBGEffect
	pop bc
	ret

.RotatewSurfWaveBGEffect:
	ld hl, wLYOverrides
	ld de, wLYOverrides2 + 1
.asm_c853e:
	ld bc, wLYOverrides2
	ld a, [bc]
	push af
	ld a, $7f
.asm_c8545:
	push af
	ld a, [de]
.asm_c8547:
	ld [bc], a
	ldh a, [hLYOverrideStart]
	cp l
	jr nc, .asm_c8555
	ldh a, [hLYOverrideEnd]
	cp l
	jr c, .asm_c8555
	ld a, [de]
	jr .asm_c8556

.asm_c8555:
	xor a
.asm_c8556:
	ld [hli], a
	inc de
	inc bc
	pop af
	dec a
	jr nz, .asm_c8545
	pop af
	ld [bc], a
	ret

BattleBGEffect_Psychic: ; c8560 (32:4560)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, $5f
	ldh [hLYOverrideEnd], a
	lb de, 6, 5
	call Functionc8f2e
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $0
	ret

.one
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	inc [hl]
	and $3
	ret nz
	call BattleBGEffect_WavyScreenFX
	ret

.two
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_Teleport: ; c8599 (32:4599)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	call BattleBGEffect_SetLCDStatCustoms
	lb de, 6, 5
	call Functionc8f2e
	ret

.one
	call BattleBGEffect_WavyScreenFX
	ret

.two
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_NightShade: ; c85bd (32:45bd)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCY)
	call BattleBGEffect_SetLCDStatCustoms
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld e, [hl]
	ld d, 3
	call Functionc8f2e
	ret

.one
	call BattleBGEffect_WavyScreenFX
	ret

.two
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_DoubleTeam: ; c85e5 (32:45e5)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	call BattleBGEffect_SetLCDStatCustoms
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld [hl], $0
	ret

.one
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	cp $10
	jr nc, .next
	inc [hl]
	call .UpdateLYOverrides
	ret

.three
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	cp $ff
	jr z, .next
	dec [hl]
	call .UpdateLYOverrides
	ret

.next
	call BattleBGEffects_IncrementJumptable
	ret

.two
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	ld d, $2
	call BattleBGEffects_Sine
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	add [hl]
	call .UpdateLYOverrides
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	add $4
	ld [hl], a

.four
	ret

.UpdateLYOverrides:
	ld e, a
	xor $ff
	inc a
	ld d, a
	ld h, HIGH(wLYOverrides)
	ldh a, [hLYOverrideStart]
	ld l, a
	ldh a, [hLYOverrideEnd]
	sub l
	srl a
.loop
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	dec a
	jr nz, .loop
	ld [hl], e
	ret

.five
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_AcidArmor: ; c865e (32:465e)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCY)
	call BattleBGEffect_SetLCDStatCustoms
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld e, [hl]
	ld d, 3
	call Functionc8f2e
	ret

.one
	ldh a, [hLYOverrideEnd]
	ld l, a
	ld h, HIGH(wLYOverrides)
	ld e, l
	ld d, h
	dec de
.loop
	ld a, [de]
	dec de
	ld [hld], a
	ldh a, [hLYOverrideStart]
	cp l
	jr nz, .loop
	ld [hl], $90
	ret

.two
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_Withdraw: ; c8695 (32:4695)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCY)
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld [hl], $1
	ret

.one
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	and $3f
	ld d, a
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	cp d
	ret nc
	call BGEffect_DisplaceLYOverridesBackup
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	rlca
	rlca
	and $3
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	add [hl]
	ld [hl], a
	ret

.two
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_Dig: ; c86dc (32:46dc)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCY)
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld [hl], $2
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $0
	ret

.one
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	ret

.next
	ld [hl], $10
	call BattleBGEffects_IncrementJumptable
.two
	ldh a, [hLYOverrideStart]
	ld l, a
	ldh a, [hLYOverrideEnd]
	sub l
	dec a
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	cp [hl]
	ret c
	ld a, [hl]
	push af
	and $7
	jr nz, .skip
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	dec [hl]
.skip
	pop af
	call BGEffect_DisplaceLYOverridesBackup
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	inc [hl]
	inc [hl]
	ret

.three
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_Tackle: ; c873b (32:473b)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw Tackle_BGEffect25_2d_one
	dw Tackle_BGEffect25_2d_two
	dw .three


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $0
	call BGEffect_CheckBattleTurn
	jr nz, .player_side
	ld a, 2
	jr .okay

.player_side
	ld a, -2
.okay
	ld [hl], a
	ret

.three
	call BattleAnim_ResetLCDStatCustom
	ret

Tackle_BGEffect25_2d_one:
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	cp -8
	jr z, .reached_limit
	cp  8
	jr nz, .finish
.reached_limit
	call BattleBGEffects_IncrementJumptable
.finish
	call Functionc88a5
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	add [hl]
	ld [hl], a
	ret

Tackle_BGEffect25_2d_two:
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .asm_c8893
	call BattleBGEffects_IncrementJumptable
.asm_c8893
	call Functionc88a5
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	xor $ff
	inc a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	add [hl]
	ld [hl], a
	ret

Functionc88a5: ; c87aa (32:47aa)
	push af
.asm_c87ab:
	ld a, [rLY]
	cp $60
	jr c, .asm_c87ab
	pop af
	call BGEffect_FillLYOverridesBackup
	ret

BattleBGEffect_2d: ; c87b6 (32:47b6)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw BGEffect2d_2f_zero
	dw Tackle_BGEffect25_2d_one
	dw Tackle_BGEffect25_2d_two
	dw .three


.three
	call BattleAnim_ResetLCDStatCustom
	ret

BGEffect2d_2f_zero:
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $0
	call BGEffect_CheckBattleTurn
	jr nz, .player_turn
	ld a, -2
	jr .okay

.player_turn
	ld a, 2
.okay
	ld [hl], a
	ret

BattleBGEffect_2f: ; c87e9 (32:47e9)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw BGEffect2d_2f_zero
	dw Tackle_BGEffect25_2d_one
	dw .two
	dw Tackle_BGEffect25_2d_two
	dw .four

.four
	call BattleAnim_ResetLCDStatCustom
.two
	ret

BattleBGEffect_26: ; c87fb (32:47fb)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $0
	ret

.one
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	ld d, $8
	call BattleBGEffects_Sine
	call .Functionc8836
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	add $4
	ld [hl], a
	ret

.two
	call BattleAnim_ResetLCDStatCustom
	ret

.Functionc8836:
	push af
.loop
	ld a, [rLY]
	cp $60
	jr c, .loop
	pop af
	call BGEffect_FillLYOverridesBackup
	ret

BattleBGEffect_2c: ; c8842 (32:4842)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	xor a
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld [hli], a
	ld [hl], a
	ret

.one
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	ld d, $6
	call BattleBGEffects_Sine
	push af
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	ld d, $2
	call BattleBGEffects_Sine
	ld e, a
	pop af
	add e
	call .Functionc8894
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	add $8
	ld [hl], a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	add $2
	ld [hl], a
	ret

.two
	call BattleAnim_ResetLCDStatCustom
	ret

.Functionc8894:
	push af
.asm_c8895:
	ld a, [rLY]
	cp $60
	jr c, .asm_c8895
	pop af
	call BGEffect_FillLYOverridesBackup
	ret

BattleBGEffect_28: ; c88a0 (32:48a0)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	call BattleBGEffect_SetLCDStatCustoms
	ret

.one
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	cp $20
	ret nc
	inc [hl]
	ld d, a
	ld e, 4
	call Functionc8f2e
	ret

.two
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	and a
	jr z, .reset
	dec [hl]
	ld d, a
	ld e, 4
	call Functionc8f2e
	ret

.reset
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_BounceDown: ; c88da (32:48da)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCY)
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld [hl], $1
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $20
	ret

.one
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	cp $38
	ret nc
	push af
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	ld d, $10
	call BattleBGEffects_Cosine
	add $10
	ld d, a
	pop af
	add d
	call BGEffect_DisplaceLYOverridesBackup
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	inc [hl]
	inc [hl]
	ret

.two
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_2a: ; c8927 (32:4927)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five

.zero
	call BattleBGEffects_IncrementJumptable
	ld a, $e4
	call BattleBGEffects_SetLYOverrides
	ld a, $47
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	ldh a, [hLYOverrideStart]
	ld l, a
	ld h, HIGH(wLYOverrides)
.loop
	ldh a, [hLYOverrideEnd]
	cp l
	jr z, .done
	xor a
	ld [hli], a
	jr .loop

.done
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $0
.one
.four
	ret

.two
	call .GetLYOverride
	jr nc, .next
	call .SetLYOverridesBackup
	ret

.next
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $0
	ldh a, [hLYOverrideStart]
	inc a
	ldh [hLYOverrideStart], a
	call BattleBGEffects_IncrementJumptable
	ret

.three
	call .GetLYOverride
	jr nc, .finish
	call .SetLYOverridesBackup
	ldh a, [hLYOverrideEnd]
	dec a
	ld l, a
	ld [hl], e
	ret

.finish
	call BattleBGEffects_IncrementJumptable
	ret

.SetLYOverridesBackup:
	ld e, a
	ldh a, [hLYOverrideStart]
	ld l, a
	ldh a, [hLYOverrideEnd]
	sub l
	srl a
	ld h, HIGH(wLYOverrides)
.loop2
	ld [hl], e
	inc hl
	inc hl
	dec a
	jr nz, .loop2
	ret

.five
	call BattleBGEffects_ResetVideoHRAM
	ret

.GetLYOverride:
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	inc [hl]
	srl a
	srl a
	srl a
	ld e, a
	ld d, 0
	ld hl, .data
	add hl, de
	ld a, [hl]
	cp $ff
	ret

.data
	db $00, $40, $90, $e4
	db -1
; c8acc

BattleBGEffect_2b: ; c89ba (32:49ba)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one


.zero
	call BattleBGEffects_IncrementJumptable
	call BattleBGEffects_ClearLYOverrides
	ld a, LOW(rSCX)
	call BattleBGEffect_SetLCDStatCustoms
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld [hl], $40
	ret

.one
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	srl a
	srl a
	srl a
	and $f
	ld d, a
	ld e, a
	call Functionc8f2e
	ret

.done
	call BattleAnim_ResetLCDStatCustom
	ret

BattleBGEffect_1c: ; c89ef (32:49ef)
	call BattleBGEffects_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two


.zero
	call BattleBGEffects_IncrementJumptable
	ld a, $e4
	call BattleBGEffects_SetLYOverrides
	ld a, LOW(rBGP)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, $60
	ldh [hLYOverrideEnd], a
	ret

.one
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	inc [hl]
	and $18
	srl a
	srl a
	ld e, a
	ld d, $0
	push bc
	call BGEffect_CheckBattleTurn
	jr nz, .player
	ld hl, .CGB_DMGEnemyData
	add hl, de
	ld a, [hli]
	ld [wOBP1], a
	ld d, a
	ld e, [hl]
	lb bc, $2f, $30
	jr .okay

.player
	ld hl, .DMG_PlayerData
	add hl, de
	ld d, [hl]
	inc hl
	ld a, [hl]
	ld [wOBP1], a
	ld e, a
	lb bc, $37, $28
.okay
	call .DMG_LYOverrideLoads
	pop bc
	ret

.two
	call BattleBGEffects_ResetVideoHRAM
	ld a, $e4
	ld [wBGP], a
	ld [wOBP1], a
	ret

.DMG_LYOverrideLoads:
	ld hl, wLYOverrides
.loop1
	ld [hl], d
	inc hl
	dec b
	jr nz, .loop1
.loop2
	ld [hl], e
	inc hl
	dec c
	jr nz, .loop2
	ret

.CGB_DMGEnemyData:
	db $e4, $e4
	db $f8, $90
	db $fc, $40
	db $f8, $90
.DMG_PlayerData:
	db $e4, $e4
	db $90, $f8
	db $40, $fc
	db $90, $f8
; c8be8

BattleBGEffect_RapidFlash: ; c8a6e (32:4a6e)
	ld de, .FlashPals
	call BGEffect_RapidCyclePals
	ret

.FlashPals:
	db $e4, $6c, $fe
; c8bf2

BattleBGEffect_16: ; c8a78 (32:4a78)
	ld de, .Pals
	call BGEffect_RapidCyclePals
	ret

.Pals:
	db $e4, $90, $40, $ff
; c8bfd

BattleBGEffect_17: ; c8a83 (32:4a83)
	ld de, .Pals
	call BGEffect_RapidCyclePals
	ret

.Pals:
	db $e4, $f8, $fc, $ff
; c8c08

BattleBGEffect_18: ; c8a8e (32:4a8e)
	ld de, .Pals
	call BGEffect_RapidCyclePals
	ret

.Pals:
	db $e4, $90, $40, $90, $fe
; c8c14

BattleBGEffect_19: ; c8a9a (32:4a9a)
	ld de, .Pals
	call BGEffect_RapidCyclePals
	ret

.Pals:
	db $e4, $f8, $fc, $f8, $fe
; c8c20

BattleBGEffect_1a: ; c8aa6 (32:4aa6)
	ld de, .Pals
	call BGEffect_RapidCyclePals
	ret

.Pals:
	db $e4, $f8, $fc, $f8, $e4, $90, $40, $90, $fe
; c8c30

BattleBGEffect_1b: ; c8ab6 (32:4ab6)
	ld de, .Pals
	call BGEffect_RapidCyclePals
	ret

.Pals:
	db $e4, $fc, $e4, $00, $fe
; c8c3c

BattleBGEffect_1d: ; c8ac2 (32:4ac2)
	ld de, .Pals
	call BGEffect_RapidCyclePals
	ret

.Pals:
	db $e4, $90, $40, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $40, $90, $e4, $ff
; c8c55

BattleBGEffect_1e: ; c8adb (32:4adb)
	ld de, .Pals
	call BGEffect_RapidCyclePals
	ret

.Pals:
	db $00, $40, $90, $e4, $ff
; c8c61

BattleBGEffect_2e: ; c8ae7 (32:4ae7)
	call Functionc8d0b
	jr c, .xor_a
	bit 7, a
	jr z, .okay
.xor_a
	xor a
.okay
	ldh [hSCY], a
	xor $ff
	inc a
	ld [$c753], a ; wAnimObject01YOffset
	ret

BattleBGEffect_1f: ; c8afa (32:4afa)
	call Functionc8d0b
	jr nc, .skip
	xor a
.skip
	ldh [hSCX], a
	ret

BattleBGEffect_20: ; c8b03 (32:4b03)
	call Functionc8d0b
	jr nc, .skip
	xor a
.skip
	ldh [hSCY], a
	ret

Functionc8d0b: ; c8b0c (32:4b0c)
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .okay
	call EndBattleBGEffect
	scf
	ret

.okay
	dec [hl]
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	and $f
	jr z, .every_16_frames
	dec [hl]
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	and a
	ret

.every_16_frames
	ld a, [hl]
	swap a
	or [hl]
	ld [hl], a
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	xor $ff
	inc a
	ld [hl], a
	and a
	ret

BattleBGEffect_GetNthDMGPal: ; c8b3b (32:4b3b)
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	ld a, [hl]
	and a
	jr z, .zero
	dec [hl]
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	call BattleBGEffect_GetNextDMGPal
	ret

.zero
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	ld [hl], a
	call BattleBGEffect_GetFirstDMGPal
	ret

BGEffect_RapidCyclePals: ; c8b5b (32:4b5b)
	push de
	ld de, .Jumptable_DMG
	call BatttleBGEffects_GetNamedJumptablePointer
	pop de
	jp hl

.Jumptable_DMG:
	dw .zero_dmg
	dw .one_dmg
	dw .two_dmg


.zero_dmg ; c8d8b (32:4d8b)
	call BattleBGEffects_IncrementJumptable
	ld a, $e4
	call BattleBGEffects_SetLYOverrides
	ld a, $47
	call BattleBGEffect_SetLCDStatCustoms
	ldh a, [hLYOverrideEnd]
	inc a
	ldh [hLYOverrideEnd], a
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	ld [hl], $0
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld [hl], a
	ret

.one_dmg ; c8daa (32:4daa)
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ld a, [hl]
	and $f
	jr z, .okay_1_dmg
	dec [hl]
	ret

.okay_1_dmg
	ld a, [hl]
	swap a
	or [hl]
	ld [hl], a
	call BattleBGEffect_GetFirstDMGPal
	jr c, .okay_2_dmg
	call BGEffect_FillLYOverridesBackup
	ret

.okay_2_dmg
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	dec [hl]
	ret

.two_dmg ; c8dc9 (32:4dc9)
	call BattleBGEffects_ResetVideoHRAM
	ld a, %11100100
	ld [rBGP], a
	call EndBattleBGEffect
	ret

BattleBGEffect_GetFirstDMGPal: ; c8bb3 (32:4bb3)
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld a, [hl]
	inc [hl]
BattleBGEffect_GetNextDMGPal: ; c8bb9 (32:4bb9)
	ld l, a
	ld h, $0
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .quit
	cp -2
	jr nz, .repeat
	ld a, [de]
	ld hl, BG_EFFECT_STRUCT_03
	add hl, bc
	ld [hl], $0
.repeat
	and a
	ret

.quit
	scf
	ret

BattleBGEffects_ClearLYOverrides: ; c8bd1 (32:4bd1)
	xor a
BattleBGEffects_SetLYOverrides: ; c8bd2 (32:4bd2)
	ld hl, wLYOverrides
	ld e, $91
.loop
	ld [hli], a
	dec e
	jr nz, .loop
	ret

BattleBGEffect_SetLCDStatCustoms: ; c8bdc (32:4bdc)
	ldh [hLCDCPointer], a
	call BGEffect_CheckBattleTurn
	jr nz, .player_turn
	lb de, $00, $36
	jr .okay

.player_turn
	lb de, $2f, $5e
.okay
	ld a, d
	ldh [hLYOverrideStart], a
	ld a, e
	ldh [hLYOverrideEnd], a
	ret

BattleAnim_ResetLCDStatCustom: ; c8bf2 (32:4bf2)
	xor a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	call BattleBGEffects_ClearLYOverrides
	xor a
	ldh [hLCDCPointer], a
	call EndBattleBGEffect
	ret

BattleBGEffects_ResetVideoHRAM: ; c8c01 (32:4c01)
	xor a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	call BattleBGEffects_ClearLYOverrides
	ret

Functionc8f2e: ; c8c0c (32:4c0c)
	push bc
	xor a
	ld [wBattleAnimTemp0], a
	ld a, e
	ld [wBattleAnimTemp1], a
	ld a, d
	ld [wBattleAnimTemp2], a
	ld a, $80
	ld [wBattleAnimTemp3], a
	ld bc, wLYOverrides
.loop
	ldh a, [hLYOverrideStart]
	cp c
	jr nc, .next
	ldh a, [hLYOverrideEnd]
	cp c
	jr c, .next
	ld a, [wBattleAnimTemp2]
	ld d, a
	ld a, [wBattleAnimTemp0]
	call BattleBGEffects_Sine
	ld [bc], a
.next
	inc bc
	ld a, [wBattleAnimTemp1]
	ld hl, wBattleAnimTemp0
	add [hl]
	ld [hl], a
	ld hl, wBattleAnimTemp3
	dec [hl]
	jr nz, .loop
	pop bc
	ret

InitSurfWaves: ; c8c47 (32:4c47)
	push bc
	xor a
	ld [wBattleAnimTemp0], a
	ld a, e
	ld [wBattleAnimTemp1], a
	ld a, d
	ld [wBattleAnimTemp2], a
	ld a, $80
	ld [wBattleAnimTemp3], a
	ld bc, wLYOverrides2
.loop
	ld a, [wBattleAnimTemp2]
	ld d, a
	ld a, [wBattleAnimTemp0]
	call BattleBGEffects_Sine
	ld [bc], a
	inc bc
	ld a, [wBattleAnimTemp1]
	ld hl, wBattleAnimTemp0
	add [hl]
	ld [hl], a
	ld hl, wBattleAnimTemp3
	dec [hl]
	jr nz, .loop
	pop bc
	ret

BattleBGEffect_WavyScreenFX: ; c8c78 (32:4c78)
	push bc
	ldh a, [hLYOverrideStart]
	ld l, a
	inc a
	ld e, a
	ld h, HIGH(wLYOverrides)
	ld d, h
	ldh a, [hLYOverrideEnd]
	sub l
	and a
	jr z, .done
	ld c, a
	ld a, [hl]
	push af
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop
	pop af
	ld [hl], a
.done
	pop bc
	ret

BGEffect_FillLYOverridesBackup: ; c8c94 (32:4c94)
	push af
	ld h, HIGH(wLYOverrides)
	ldh a, [hLYOverrideStart]
	ld l, a
	ldh a, [hLYOverrideEnd]
	sub l
	ld d, a
	pop af
.loop
	ld [hli], a
	dec d
	jr nz, .loop
	ret

BGEffect_DisplaceLYOverridesBackup: ; c8ca4 (32:4ca4)
	; e = a; d = [hLYOverrideEnd] - [hLYOverrideStart] - a
	push af
	ld e, a
	ldh a, [hLYOverrideStart]
	ld l, a
	ldh a, [hLYOverrideEnd]
	sub l
	sub e
	ld d, a
	ld h, HIGH(wLYOverrides)
	ldh a, [hLYOverrideStart]
	ld l, a
	ld a, $90
.loop
	ld [hli], a
	dec e
	jr nz, .loop
	pop af
	xor $ff
	inc a
.loop2
	ld [hli], a
	dec d
	jr nz, .loop2
	ret

BGEffect_CheckBattleTurn: ; c8cc2 (32:4cc2)
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ldh a, [hBattleTurn]
	and $1
	xor [hl]
	ret

BGEffect_CheckFlyDigStatus: ; c8ccc (32:4ccc)
	ld hl, BG_EFFECT_STRUCT_BATTLE_TURN
	add hl, bc
	ldh a, [hBattleTurn]
	and $1
	xor [hl]
	jr nz, .player
	ld a, [wEnemySubStatus3] ; EnemySubStatus3
	bit 6, a
	ret

.player
	ld a, [wPlayerSubStatus3] ; PlayerSubStatus3
	bit 6, a
	ret

BattleBGEffects_CheckSGB: ; c8ce3 (32:4ce3)
	ld a, [wcccf]
	and a
	ret

BattleBGEffects_Sine: ; c8ce8 (32:4ce8)
	ld e, a
	callab BattleAnim_Sine_e
	ld a, e
	ret

BattleBGEffects_Cosine: ; c8cf3 (32:4cf3)
	ld e, a
	callab BattleAnim_Cosine_e
	ld a, e
	ret

; c906f (32:506f)
