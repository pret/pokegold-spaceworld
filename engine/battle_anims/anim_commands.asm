INCLUDE "constants.asm"

SECTION "engine/battle_anims/anim_commands.asm", ROMX

Functioncc000:
Functioncc000_2:
	ret

PlayBattleAnim:
	ld c, 8
.wait
	call DelayFrame
	dec c
	jr nz, .wait

	ld hl, hVBlank
	ld a, [hl]
	push af

	ld [hl], 1
	xor a
	ld [wDisableVBlankOAMUpdate], a
	call RunBattleAnimScript_User
	call RunBattleAnimScript_Target
	pop af
	ldh [hVBlank], a
	xor a
	ld [wDisableVBlankOAMUpdate], a
	ret

RunBattleAnimScript_User:
	ld a, [wOptions]
	bit BATTLE_SCENE_F, a
	jr z, .enabled

; If high byte doesn't equal 0, go ahead and skip to the animation-playing part.
	ld a, [wFXAnimID + 1]
	and a
	ret z
.enabled
	xor a
	ldh [hBGMapMode], a
	call BattleAnimAssignPals
	xor a
	ld [wBattleAnimOAMPointerLo + 1], a	; TODO

.playframe
	call RunBattleAnimCommand
	call _ExecuteBGEffects
	call BattleAnim_UpdateOAM_All
	call DelayFrame

	ld a, [wBattleAnimFlags]
	bit BATTLEANIM_STOP_F, a
	jr z, .playframe

	bit BATTLEANIM_KEEPSPRITES_F, a
	call z, BattleAnim_ClearOAM

	ld a, 1
	ldh [hBGMapMode], a
	ret

RunBattleAnimScript_Target:
	ld a, [wNumHits]
	ld l, a
	ld h, 0
	ld de, ANIM_MISS
	add hl, de
	ld a, l
	ld [wFXAnimID], a
	ld a, h
	ld [wFXAnimID + 1], a

	xor a
	ldh [hBGMapMode], a
	call ClearBattleAnims
	xor a
	ld [wBattleAnimOAMPointerLo + 1], a ; todo

.playframe
	call RunBattleAnimCommand
	call _ExecuteBGEffects
	call DelayFrame

	ld a, [wBattleAnimFlags]
	bit BATTLEANIM_STOP_F, a
	jr z, .playframe

	call BattleAnim_SetPals
	ret

BattleAnim_ClearOAM:
	ld hl, wShadowOAM
	ld c, SPRITEOAMSTRUCT_LENGTH * NUM_SPRITE_OAM_STRUCTS
	xor a
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

RunBattleAnimCommand:
	call .CheckTimer
	ret nc
	call .RunScript
	ret

.CheckTimer:
	ld a, [wBattleAnimDuration]
	and a
	jr z, .done
	dec a
	ld [wBattleAnimDuration], a
	and a
	ret

.done
	scf
	ret

.RunScript:
.loop
	call GetBattleAnimByte
	cp $FF ; anim_ret_command
	jr nz, .not_done_with_anim

	ld hl, wBattleAnimFlags
	bit BATTLEANIM_IN_SUBROUTINE_F, [hl]
	jr nz, .do_anim

	set BATTLEANIM_STOP_F, [hl]
	ret

.not_done_with_anim
	cp $D0 ; anim_obj_command
	jr nc, .do_anim
	ld [wBattleAnimDuration], a
	ret

.do_anim
	call .DoCommand
	jr .loop

.DoCommand:
	; Execute battle animation command in [wBattleAnimByte].
	ld a, [wBattleAnimByte]
	sub $D0 ; anim_obj_command

	ld e, a
	ld d, $00
	ld hl, BattleAnimCommands
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

BattleAnimCommands:
	dw BattleAnimCmd_Obj
	dw BattleAnimCmd_1GFX
	dw BattleAnimCmd_2GFX
	dw BattleAnimCmd_3GFX
	dw BattleAnimCmd_4GFX
	dw BattleAnimCmd_5GFX
	dw BattleAnimCmd_IncObj
	dw BattleAnimCmd_SetObj
	dw BattleAnimCmd_IncBGEffect
	dw BattleAnimCmd_BattlerGFX_1Row
	dw BattleAnimCmd_BattlerGFX_2Row
	dw BattleAnimCmd_CheckPokeball
	dw BattleAnimCmd_Transform
	dw BattleAnimCmd_RaiseSub
	dw BattleAnimCmd_DropSub
	dw BattleAnimCmd_ResetObp0
	dw BattleAnimCmd_Sound
	dw BattleAnimCmd_Cry
	dw BattleAnimCmd_MinimizeOpp
	dw BattleAnimCmd_OAMOn
	dw BattleAnimCmd_OAMOff
	dw BattleAnimCmd_E5
	dw BattleAnimCmd_E6
	dw BattleAnimCmd_E7
	dw BattleAnimCmd_E8
	dw BattleAnimCmd_E9
	dw BattleAnimCmd_EA
	dw BattleAnimCmd_EB
	dw BattleAnimCmd_EC
	dw BattleAnimCmd_ED
	dw BattleAnimCmd_IfParamAnd
	dw BattleAnimCmd_JumpUntil
	dw BattleAnimCmd_BGEffect
	dw BattleAnimCmd_BGP
	dw BattleAnimCmd_OBP0
	dw BattleAnimCmd_OBP1
	dw BattleAnimCmd_KeepSprites
	dw BattleAnimCmd_F5
	dw BattleAnimCmd_F6
	dw BattleAnimCmd_F7
	dw BattleAnimCmd_IfParamEqual
	dw BattleAnimCmd_SetVar
	dw BattleAnimCmd_IncVar
	dw BattleAnimCmd_IfVarEqual
	dw BattleAnimCmd_Jump
	dw BattleAnimCmd_Loop
	dw BattleAnimCmd_Call
	dw BattleAnimCmd_Ret

BattleAnimCmd_E5:
BattleAnimCmd_E6:
BattleAnimCmd_E7:
BattleAnimCmd_E8:
BattleAnimCmd_E9:
BattleAnimCmd_EA:
BattleAnimCmd_EB:
BattleAnimCmd_EC:
BattleAnimCmd_ED:
	ret

BattleAnimCmd_Ret:
	ld hl, wBattleAnimFlags
	res BATTLEANIM_IN_SUBROUTINE_F, [hl]
	ld hl, wBattleAnimParent
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_Call:
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	push de
	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wBattleAnimParent
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wBattleAnimFlags
	set BATTLEANIM_IN_SUBROUTINE_F, [hl]
	ret

BattleAnimCmd_Jump:
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_Loop:
	call GetBattleAnimByte
	ld hl, wBattleAnimFlags
	bit BATTLEANIM_IN_LOOP_F, [hl]
	jr nz, .continue_loop
	and a
	jr z, .perpetual
	dec a
	set BATTLEANIM_IN_LOOP_F, [hl]
	ld [wBattleAnimLoops], a
.continue_loop
	ld hl, wBattleAnimLoops
	ld a, [hl]
	and a
	jr z, .return_from_loop
	dec [hl]
.perpetual
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.return_from_loop
	ld hl, wBattleAnimFlags
	res BATTLEANIM_IN_LOOP_F, [hl]
	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

BattleAnimCmd_JumpUntil:
	ld hl, wBattleAnimParam
	ld a, [hl]
	and a
	jr z, .dont_jump

	dec [hl]
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.dont_jump
	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

BattleAnimCmd_SetVar:
	call GetBattleAnimByte
	ld [wBattleAnimVar], a
	ret

BattleAnimCmd_IncVar:
	ld hl, wBattleAnimVar
	inc [hl]
	ret

BattleAnimCmd_IfVarEqual:
	call GetBattleAnimByte
	ld hl, wBattleAnimVar
	cp [hl]
	jr z, .jump

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_IfParamEqual:
	call GetBattleAnimByte
	ld hl, wBattleAnimParam
	cp [hl]
	jr z, .jump

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_IfParamAnd:
	call GetBattleAnimByte
	ld e, a
	ld a, [wBattleAnimParam]
	and e
	jr nz, .jump

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_Obj:
; index, x, y, param
	call GetBattleAnimByte
	ld [wBattleObjectTempID], a
	call GetBattleAnimByte
	ld [wBattleObjectTempXCoord], a
	call GetBattleAnimByte
	ld [wBattleObjectTempYCoord], a
	call GetBattleAnimByte
	ld [wBattleObjectTempParam], a
	call QueueBattleAnimation
	ret

BattleAnimCmd_BGEffect:
	call GetBattleAnimByte
	ld [wBattleBGEffectTempID], a
	call GetBattleAnimByte
	ld [wBattleBGEffectTempJumptableIndex], a
	call GetBattleAnimByte
	ld [wBattleBGEffectTempTurn], a
	call GetBattleAnimByte
	ld [wBattleBGEffectTempParam], a
	call _QueueBGEffect
	ret

BattleAnimCmd_BGP:
	call GetBattleAnimByte
	ld [wBGP], a
	ret

BattleAnimCmd_OBP0:
	call GetBattleAnimByte
	ld [wOBP0], a
	ret

BattleAnimCmd_OBP1:
	call GetBattleAnimByte
	ld [wOBP1], a
	ret

BattleAnimCmd_ResetObp0:
	ld a, [wSGB]
	and a
	ld a, $e0
	jr z, .not_sgb
	ld a, $f0
.not_sgb
	ld [wOBP0], a
	ret

BattleAnimCmd_1GFX:
BattleAnimCmd_2GFX:
BattleAnimCmd_3GFX:
BattleAnimCmd_4GFX:
BattleAnimCmd_5GFX:
	ld a, [wBattleAnimByte]
	and $f
	ld c, a
	ld hl, wBattleAnimTileDict
	xor a
	ld [wBattleAnimGFXTempTileID], a
.loop
	ld a, [wBattleAnimGFXTempTileID]
	cp (vChars1 - vChars0) / LEN_2BPP_TILE - BATTLEANIM_BASE_TILE
	ret nc
	call GetBattleAnimByte
	ld [hli], a
	ld a, [wBattleAnimGFXTempTileID]
	ld [hli], a
	push bc
	push hl
	ld l, a
	ld h, 0
rept 4
	add hl, hl
endr
	ld de, vChars0 tile BATTLEANIM_BASE_TILE
	add hl, de
	ld a, [wBattleAnimByte]
	call LoadBattleAnimGFX
	ld a, [wBattleAnimGFXTempTileID]
	add c
	ld [wBattleAnimGFXTempTileID], a
	pop hl
	pop bc
	dec c
	jr nz, .loop
	ret

BattleAnimCmd_IncObj:
	call GetBattleAnimByte
	ld e, NUM_BATTLE_ANIM_STRUCTS
	ld bc, wActiveAnimObjects
.loop
	ld hl, BATTLEANIMSTRUCT_INDEX
	add hl, bc
	ld d, [hl]
	ld a, [wBattleAnimByte]
	cp d
	jr z, .found
	ld hl, BATTLEANIMSTRUCT_LENGTH
	add hl, bc
	ld c, l
	ld b, h
	dec e
	jr nz, .loop
	ret

.found
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret

BattleAnimCmd_IncBGEffect:
	call GetBattleAnimByte
	ld e, NUM_BG_EFFECTS
	ld bc, wBGEffect1Function
.loop
	ld hl, $0
	add hl, bc
	ld d, [hl]
	ld a, [wBattleAnimByte]
	cp d
	jr z, .found
	ld hl, BG_EFFECT_STRUCT_LENGTH
	add hl, bc
	ld c, l
	ld b, h
	dec e
	jr nz, .loop
	ret

.found
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	inc [hl]
	ret

BattleAnimCmd_SetObj:
	call GetBattleAnimByte
	ld e, NUM_BATTLE_ANIM_STRUCTS
	ld bc, wActiveAnimObjects
.loop
	ld hl, BATTLEANIMSTRUCT_INDEX
	add hl, bc
	ld d, [hl]
	ld a, [wBattleAnimByte]
	cp d
	jr z, .found
	ld hl, BATTLEANIMSTRUCT_LENGTH
	add hl, bc
	ld c, l
	ld b, h
	dec e
	jr nz, .loop
	ret

.found
	call GetBattleAnimByte
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

BattleAnimCmd_BattlerGFX_1Row:
	ld hl, wBattleAnimTileDict
.loop
	ld a, [hl]
	and a
	jr z, .okay
	inc hl
	inc hl
	jr .loop

.okay
	ld a, BATTLE_ANIM_GFX_PLAYERHEAD
	ld [hli], a
	ld a, ($80 - 6 - 7) - BATTLEANIM_BASE_TILE
	ld [hli], a
	ld a, BATTLE_ANIM_GFX_ENEMYFEET
	ld [hli], a
	ld a, ($80 - 6) - BATTLEANIM_BASE_TILE
	ld [hl], a

	ld hl, vChars0 tile ($80 - 6 - 7)
	ld de, vChars2 tile $06 ; Enemy feet start tile
	ld a, 7 tiles ; Enemy pic height
	ld [wBattleAnimGFXTempPicHeight], a
	ld a, 7 ; Copy 7x1 tiles
	call .LoadFeet
	ld de, vChars2 tile $31 ; Player head start tile
	ld a, 6 tiles ; Player pic height
	ld [wBattleAnimGFXTempPicHeight], a
	ld a, 6 ; Copy 6x1 tiles
	call .LoadFeet
	ret

.LoadFeet:
	push af
	push hl
	push de
	lb bc, BANK(@), 1
	call Request2bpp
	pop de
	ld a, [wBattleAnimGFXTempPicHeight]
	ld l, a
	ld h, 0
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld bc, 1 tiles
	add hl, bc
	pop af
	dec a
	jr nz, .LoadFeet
	ret

BattleAnimCmd_BattlerGFX_2Row:
	ld hl, wBattleAnimTileDict
.loop
	ld a, [hl]
	and a
	jr z, .okay
	inc hl
	inc hl
	jr .loop

.okay
	ld a, BATTLE_ANIM_GFX_PLAYERHEAD
	ld [hli], a
	ld a, ($80 - 6 * 2 - 7 * 2) - BATTLEANIM_BASE_TILE
	ld [hli], a
	ld a, BATTLE_ANIM_GFX_ENEMYFEET
	ld [hli], a
	ld a, ($80 - 6 * 2) - BATTLEANIM_BASE_TILE
	ld [hl], a

	ld hl, vChars0 tile ($80 - 6 * 2 - 7 * 2)
	ld de, vChars2 tile $05 ; Enemy feet start tile
	ld a, 7 tiles ; Enemy pic height
	ld [wBattleAnimGFXTempPicHeight], a
	ld a, 7 ; Copy 7x2 tiles
	call .LoadHead
	ld de, vChars2 tile $31 ; Player head start tile
	ld a, 6 tiles ; Player pic height
	ld [wBattleAnimGFXTempPicHeight], a
	ld a, 6 ; Copy 6x2 tiles
	call .LoadHead
	ret

.LoadHead:
	push af
	push hl
	push de
	lb bc, BANK(@), 2
	call Request2bpp
	pop de
	ld a, [wBattleAnimGFXTempPicHeight]
	ld l, a
	ld h, 0
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld bc, 2 tiles
	add hl, bc
	pop af
	dec a
	jr nz, .LoadHead
	ret

BattleAnimCmd_CheckPokeball:
	callfar GetPokeBallWobble
	ld a, c
	ld [wBattleAnimVar], a
	ret

BattleAnimCmd_Transform:
	ld a, [wCurPartySpecies]
	push af

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld a, [wTempBattleMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData
	ld hl, wBattleMonDVs
	predef GetUnownLetter
	ld de, vChars2 tile $00
	call LoadMonFrontSprite
	jr .done

.player
	ld a, [wTempEnemyMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData
	ld hl, wEnemyMonDVs
	predef GetUnownLetter
	ld hl, wMonHBackSprite - wMonHeader
	call UncompressMonSprite
	ld hl, vChars2 tile $31
	predef GetMonBackpic
.done
	pop af
	ld [wCurPartySpecies], a
	ret

BattleAnimCmd_RaiseSub:
	xor a ; BANK(sScratch)
	call OpenSRAM

GetSubstitutePic: ; used only for BANK(GetSubstitutePic)
	ld hl, sScratch
	ld bc, (7 * 7) tiles
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld hl, RhydonSpriteGFX + 0 tiles
	ld de, sScratch + (2 * 7 + 5) tiles
	call .CopyTile
	ld hl, RhydonSpriteGFX + 1 tiles
	ld de, sScratch + (3 * 7 + 5) tiles
	call .CopyTile
	ld hl, RhydonSpriteGFX + 2 tiles
	ld de, sScratch + (2 * 7 + 6) tiles
	call .CopyTile
	ld hl, RhydonSpriteGFX + 3 tiles
	ld de, sScratch + (3 * 7 + 6) tiles
	call .CopyTile

	ld hl, vChars2 tile $00
	ld de, sScratch
	lb bc, BANK(GetSubstitutePic), 7 * 7
	call Request2bpp
	jr .done

.player
	ld hl, RhydonSpriteGFX + 4 tiles
	ld de, sScratch + (2 * 6 + 4) tiles
	call .CopyTile
	ld hl, RhydonSpriteGFX + 5 tiles
	ld de, sScratch + (3 * 6 + 4) tiles
	call .CopyTile
	ld hl, RhydonSpriteGFX + 6 tiles
	ld de, sScratch + (2 * 6 + 5) tiles
	call .CopyTile
	ld hl, RhydonSpriteGFX + 7 tiles
	ld de, sScratch + (3 * 6 + 5) tiles
	call .CopyTile

	ld hl, vChars2 tile $31
	ld de, sScratch
	lb bc, BANK(GetSubstitutePic), 6 * 6
	call Request2bpp

.done
	call CloseSRAM
	ret

.CopyTile:
	ld bc, 1 tiles
	ld a, BANK(RhydonSpriteGFX)
	call FarCopyData
	ret

BattleAnimCmd_MinimizeOpp:
	xor a
	call OpenSRAM

GetMinimizePic:
	ld hl, sScratch
	ld bc, (7 * 7) tiles
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld de, sScratch + (3 * 7 + 5) tiles
	call CopyMinimizePic
	ld hl, vChars2 tile $00
	ld de, sScratch
	lb bc, BANK(GetMinimizePic), 7 * 7
	call Request2bpp
	jr .done

.player
	ld de, sScratch + (3 * 6 + 4) tiles
	call CopyMinimizePic
	ld hl, vChars2 tile $31
	ld de, sScratch
	lb bc, BANK(GetMinimizePic), 6 * 6
	call Request2bpp

.done
	call CloseSRAM
	ret

CopyMinimizePic:
	ld hl, MinimizePic
	ld bc, $10
	ld a, BANK(MinimizePic)
	call FarCopyData
	ret

MinimizePic:
INCBIN "gfx/battle/minimize.2bpp"

BattleAnimCmd_DropSub:
	ld a, [wCurPartySpecies]
	push af
	ldh a, [hBattleTurn]
	and a
	jr z, .player

	callfar DropEnemySub
	jr .done

.player
	callfar DropPlayerSub

.done
	pop af
	ld [wCurPartySpecies], a
	ret

BattleAnimCmd_OAMOn:
	ret

BattleAnimCmd_OAMOff:
	ret

BattleAnimCmd_KeepSprites:
	ld hl, wBattleAnimFlags
	set BATTLEANIM_KEEPSPRITES_F, [hl]
	ret

BattleAnimCmd_F5:
	ret

BattleAnimCmd_F6:
	ret

BattleAnimCmd_F7:
	ret

BattleAnimCmd_Sound:
	call GetBattleAnimByte
	ld e, a
	srl a
	srl a
	ld [wSFXDuration], a
	call .GetCryTrack
	maskbits NUM_NOISE_CHANS
	ld [wCryTracks], a

	ld e, a
	ld d, 0
	ld hl, .GetPanning
	add hl, de
	ld a, [hl]
	ld [wStereoPanningMask], a

	call GetBattleAnimByte
	ld e, a
	ld d, 0
	callfar PlayStereoSFX

	ret

.GetPanning:
	db $f0, $0f, $f0, $0f

.GetCryTrack:
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

	ld a, e
	ret

.enemy
	ld a, e
	xor 1
	ret

BattleAnimCmd_Cry:
	call GetBattleAnimByte
	maskbits NUM_NOISE_CHANS
	ld e, a
	ld d, 0
	ld hl, .CryData
rept 2
	add hl, de
endr

	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

	ld a, $f0
	ld [wCryTracks], a
	ld a, [wTempBattleMonSpecies]
	jr .done_cry_tracks

.enemy
	ld a, $0f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
.done_cry_tracks
	push hl
	call LoadCryHeader
	pop hl

	ld b, $00
	push hl
	ld c, [hl]
	ld hl, wCryPitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc
	ld a, l
	ld [wCryPitch], a
	ld a, h
	ld [wCryPitch + 1], a
	pop hl

	inc hl
	ld c, [hl]
	ld hl, wCryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de

	ld a, l
	ld [wCryLength], a
	ld a, h
	ld [wCryLength + 1], a
	ld a, 1
	ld [wStereoPanningMask], a

	callfar _PlayCryHeader
	ret

.CryData:
; +pitch, +length
	db $00, $c0
	db $00, $40
	db $00, $c0
	db $00, $c0

BattleAnimAssignPals:
	ld a, [wSGB]
	and a
	ld a, %11100000
	jr z, .sgb
	ld a, %11110000
.sgb
	ld [wOBP0], a
	ld a, %11100100
	ld [wBGP], a
	ld [wOBP1], a
	; Fallthrough

; Clear animation block
ClearBattleAnims:
	ld hl, wLYOverrides
	ld bc, wBattleAnimTempPalette - wLYOverrides ; should be wBattleAnimEnd - wLYOverrides?
.loop
	ld [hl], 0
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop

	ld hl, wFXAnimID
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, BattleAnimations
	add hl, de
	add hl, de
	call GetBattleAnimPointer
	ret

BattleAnim_SetPals:
	ld a, 1
	ldh [hBGMapMode], a
	ld a, %11100100
	ld [wBGP], a
	ld [wOBP0], a
	ld [wOBP1], a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ret

BattleAnim_UpdateOAM_All:
	ld a, $00
	ld [wBattleAnimOAMPointerLo], a
	ld hl, wActiveAnimObjects
	ld e, NUM_BATTLE_ANIM_STRUCTS

.loop
	ld a, [hl]
	and a
	jr z, .next
	ld c, l
	ld b, h
	push hl
	push de
	call DoBattleAnimFrame
	call BattleAnimOAMUpdate
	pop de
	pop hl
	jr c, .done

.next
	ld bc, BATTLEANIMSTRUCT_LENGTH
	add hl, bc
	dec e
	jr nz, .loop
	ld a, [wBattleAnimOAMPointerLo]
	ld l, a
	ld h, HIGH(wShadowOAM)

.loop2
	ld a, l
	cp LOW(wShadowOAMEnd)
	jr nc, .done
	xor a
	ld [hli], a
	jr .loop2

.done
	ret
