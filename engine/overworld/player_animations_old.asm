; A bunch of old animation functions from Generation I.
; Basically non-functional because RAM has moved around so much since then.
; Certain lines of code were removed here, presumably so that it would actually compile.

EnterMapAnim_Old::
	call InitFacingDirectionList_Old
	ld a, $ec
	ld [wSpritePlayerStateData1YPixels_Old], a
	call WaitBGMap
	push hl
	call GBFadeInFromWhite
	pop hl
	call PlayerSpinWhileMovingDown_Old
	call FishingAnim_Old ; was IsPlayerStandingOnWarpPadOrHole
	ld a, b
	and a
	jr nz, .done
; This originally jumped if the player was standing on a warp pad or hole,
; but b now has no meaningful value on return from FishingAnim_Old

	ld hl, wPlayerSpinInPlaceAnimFrameDelay_Old
	xor a
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelay_Old
	inc a
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelayDelta_Old
	ld a, $8
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelayEndValue_Old
	ld [hl], $ff ; wPlayerSpinInPlaceAnimSoundID_Old
	ld hl, wFacingDirectionList_Old
	call PlayerSpinInPlace_Old
.done
	jp RestoreFacingDirectionAndYScreenPos_Old

; Unreferenced
.dungeonWarpAnimation
	ld c, 50
	call DelayFrames
	call PlayerSpinWhileMovingDown_Old
	jr .done

; Also unreferenced
.flyAnimation
	pop hl
	ld de, PidgeySpriteGFX
	ld hl, vNPCSprites
	lb bc, BANK(PidgeySpriteGFX), $c
	call Request2bpp
	call LoadBirdSpriteGraphics_Old
	ld hl, wBattleMenuRows ; Originally wFlyAnimUsingCoordList
	xor a ; is using coord list
	ld [hli], a ; wFlyAnimUsingCoordList
	ld a, 12
	ld [hli], a ; wFlyAnimCounter
	ld [hl], $8 ; wFlyAnimBirdSpriteImageIndex (facing right)
	ld de, FlyAnimationEnterScreenCoords_Old
	call DoFlyAnimation_Old
	call RedrawPlayerSprite
	jr .done

FlyAnimationEnterScreenCoords_Old:
; y, x pairs
; This was the sequence of screen coordinates used by the overworld
; Fly animation when the player is entering a map.
	db $05, $98
	db $0F, $90
	db $18, $88
	db $20, $80
	db $27, $78
	db $2D, $70
	db $32, $68
	db $36, $60
	db $39, $58
	db $3B, $50
	db $3C, $48
	db $3C, $40

PlayerSpinWhileMovingDown_Old:
	ld hl, wPlayerSpinWhileMovingUpOrDownAnimDeltaY_Old
	ld a, $10
	ld [hli], a ; wPlayerSpinWhileMovingUpOrDownAnimDeltaY_Old
	ld a, $3c
	ld [hli], a ; wPlayerSpinWhileMovingUpOrDownAnimMaxY_Old
	call GetPlayerTeleportAnimFrameDelay_Old
	ld [hl], a ; wPlayerSpinWhileMovingUpOrDownAnimFrameDelay_Old
	jp PlayerSpinWhileMovingUpOrDown_Old

LeaveMapAnim_Old:
	call InitFacingDirectionList_Old
	call FishingAnim_Old ; originally IsPlayerStandingOnWarpPadOrHole
	ld a, b
	and a
	jr z, .playerNotStandingOnWarpPadOrHole
; This originally jumped if the player was standing on a warp pad or hole,
; but b now has no meaningful value on return from FishingAnim_Old

	dec a
	jp nz, LeaveMapThroughHoleAnim_Old
.spinWhileMovingUp
	ld hl, wPlayerSpinWhileMovingUpOrDownAnimDeltaY_Old
	ld a, -$10
	ld [hli], a ; wPlayerSpinWhileMovingUpOrDownAnimDeltaY_Old
	ld a, $ec
	ld [hli], a ; wPlayerSpinWhileMovingUpOrDownAnimMaxY_Old
	call GetPlayerTeleportAnimFrameDelay_Old
	ld [hl], a ; wPlayerSpinWhileMovingUpOrDownAnimFrameDelay_Old
	call PlayerSpinWhileMovingUpOrDown_Old
	call FishingAnim_Old ; originally IsPlayerStandingOnWarpPadOrHole
	ld a, b
	dec a
	jr z, .playerStandingOnWarpPad
; This originally jumped if the player was standing on a warp pad or hole,
; but b now has no meaningful value on return from FishingAnim_Old

	ld c, 10
	call DelayFrames
.playerStandingOnWarpPad
	call GBFadeOutToWhite
	jp RestoreFacingDirectionAndYScreenPos_Old

.playerNotStandingOnWarpPadOrHole
	ld hl, wPlayerSpinInPlaceAnimFrameDelay_Old
	ld a, 16
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelay_Old
	ld a, -1
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelayDelta_Old
	xor a
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelayEndValue_Old
	ld [hl], SFX_TELEPORT_EXIT_2 ; wPlayerSpinInPlaceAnimSoundID_Old
	ld hl, wFacingDirectionList_Old
	call PlayerSpinInPlace_Old
	jr .spinWhileMovingUp

; Also unreferenced
.flyAnimation
	call LoadBirdSpriteGraphics_Old
	ld hl, wFlyAnimUsingCoordList_Old
	ld a, $ff ; is not using coord list (flap in place)
	ld [hli], a ; wFlyAnimUsingCoordList_Old
	ld a, 8
	ld [hli], a ; wFlyAnimCounter_Old
	ld [hl], $c ; wFlyAnimBirdSpriteImageIndex_Old
	call DoFlyAnimation_Old
	ld hl, wFlyAnimUsingCoordList_Old
	xor a ; is using coord list
	ld [hli], a ; wFlyAnimUsingCoordList_Old
	ld a, $c
	ld [hli], a ; wFlyAnimCounter_Old
	ld [hl], $c ; wFlyAnimBirdSpriteImageIndex_Old (facing right)
	ld de, FlyAnimationScreenCoords1_Old
	call DoFlyAnimation_Old
	ld c, 40
	call DelayFrames
	ld hl, wFlyAnimCounter_Old
	ld a, 11
	ld [hli], a ; wFlyAnimCounter_Old
	ld [hl], $8 ; wFlyAnimBirdSpriteImageIndex_Old (facing left)
	ld de, FlyAnimationScreenCoords2_Old
	call DoFlyAnimation_Old
	call GBFadeOutToWhite
	jp RestoreFacingDirectionAndYScreenPos_Old

FlyAnimationScreenCoords1_Old:
; y, x pairs
; This is the sequence of screen coordinates used by the first part
; of the Fly overworld animation.
	db $3C, $48
	db $3C, $50
	db $3B, $58
	db $3A, $60
	db $39, $68
	db $37, $70
	db $37, $78
	db $33, $80
	db $30, $88
	db $2D, $90
	db $2A, $98
	db $27, $A0

FlyAnimationScreenCoords2_Old:
; y, x pairs
; This is the sequence of screen coordinates used by the second part
; of the Fly overworld animation.
	db $1A, $90
	db $19, $80
	db $17, $70
	db $15, $60
	db $12, $50
	db $0F, $40
	db $0C, $30
	db $09, $20
	db $05, $10
	db $00, $00

	db $F0, $00

LeaveMapThroughHoleAnim_Old:
	ld a, [wShadowOAMSprite00TileID]
	ld [wShadowOAMSprite02TileID], a
	ld a, [wShadowOAMSprite01TileID]
	ld [wShadowOAMSprite03TileID], a
	ld a, $a0
	ld [wShadowOAMSprite00YCoord], a
	ld [wShadowOAMSprite01YCoord], a
	ld c, 2
	call DelayFrames
	; hide upper half of player's sprite
	ld a, $a0
	ld [wShadowOAMSprite02YCoord], a
	ld [wShadowOAMSprite03YCoord], a
	call GBFadeOutToWhite
	jp RestoreFacingDirectionAndYScreenPos_Old

DoFlyAnimation_Old:
	ld a, [wFlyAnimBirdSpriteImageIndex_Old]
	xor $1 ; make the bird flap its wings
	ld [wFlyAnimBirdSpriteImageIndex_Old], a
	ld [wSpritePlayerStateData1ImageIndex_Old], a
	ld c, 3
	call DelayFrames
	ld a, [wFlyAnimUsingCoordList_Old]
	cp $ff
	jr z, .skipCopyingCoords ; if the bird is flapping its wings in place
	ld hl, wSpritePlayerStateData1YPixels_Old
	ld a, [de]
	inc de
	ld [hli], a ; y
	inc hl
	ld a, [de]
	inc de
	ld [hl], a ; x
.skipCopyingCoords
	ld a, [wFlyAnimCounter_Old]
	dec a
	ld [wBattleMenuColumns], a
	jr nz, DoFlyAnimation_Old
	ret

LoadBirdSpriteGraphics_Old:
	ld de, PidgeySpriteGFX
	ld hl, vNPCSprites
	lb bc, BANK(PidgeySpriteGFX), 12
	call Request2bpp
	ld de, PidgeySpriteGFX tile 12
	ld hl, vNPCSprites2
	lb bc, BANK(PidgeySpriteGFX), 12
	jp Request2bpp

InitFacingDirectionList_Old:
	ld a, [wSpritePlayerStateData1ImageIndex_Old]
	ld [wSavedPlayerFacingDirection_Old], a
	ld a, [wSpritePlayerStateData1YPixels_Old]
	ld [wSavedPlayerScreenY_Old], a
	ld hl, .PlayerSpinningFacingOrder
	ld de, wFacingDirectionList_Old
	ld bc, 4
	call CopyBytes
	ld a, [wReservedObjectSpriteTile]
	ld hl, wFacingDirectionList_Old
; find the place in the list that matches the current facing direction
.loop
	cp [hl]
	inc hl
	jr nz, .loop
	dec hl
	ret

.PlayerSpinningFacingOrder:
; The order of the direction the player's sprite is facing when teleporting
; away. Creates a spinning effect.
	db OW_DOWN, OW_LEFT, OW_UP, OW_RIGHT

SpinPlayerSprite_Old:
; copy the current value from the list into the sprite data and rotate the list
	ld a, [hl]
	ld [wSpritePlayerStateData1ImageIndex_Old], a
	push hl
	ld hl, wFacingDirectionList_Old
	ld de, wFacingDirectionList_Old - 1
	ld bc, 4
	call CopyBytes
	ld a, [wFacingDirectionList_Old - 1]
	ld [wFacingDirectionList_Old + 3], a
	pop hl
	ret

PlayerSpinInPlace_Old:
	call SpinPlayerSprite_Old
	ld a, [wPlayerSpinInPlaceAnimFrameDelay_Old]
	ld c, a
	and $3
	jr nz, .skipPlayingSound
.skipPlayingSound
	ld a, [wPlayerSpinInPlaceAnimFrameDelayDelta_Old]
	add c
	ld [wPlayerSpinInPlaceAnimFrameDelay_Old], a
	ld c, a
	ld a, [wPlayerSpinInPlaceAnimFrameDelayEndValue_Old]
	cp c
	ret z
	call DelayFrames
	jr PlayerSpinInPlace_Old

PlayerSpinWhileMovingUpOrDown_Old:
	call SpinPlayerSprite_Old
	ld a, [wPlayerSpinWhileMovingUpOrDownAnimDeltaY_Old]
	ld c, a
	ld a, [wSpritePlayerStateData1YPixels_Old]
	add c
	ld [wSpritePlayerStateData1YPixels_Old], a
	ld c, a
	ld a, [wPlayerSpinWhileMovingUpOrDownAnimMaxY_Old]
	cp c
	ret z
	ld a, [wPlayerSpinWhileMovingUpOrDownAnimFrameDelay_Old]
	ld c, a
	call DelayFrames
	jr PlayerSpinWhileMovingUpOrDown_Old

RestoreFacingDirectionAndYScreenPos_Old:
	ld a, [wSavedPlayerScreenY_Old]
	ld [wSpritePlayerStateData1YPixels_Old], a
	ld a, [wSavedPlayerFacingDirection_Old]
	ld [wSpritePlayerStateData1ImageIndex_Old], a
	ret

; if SGB, 2 frames, else 3 frames
GetPlayerTeleportAnimFrameDelay_Old:
	ld a, [wSGB]
	xor $1
	inc a
	inc a
	ret

FishingAnim_Old:
	ld c, 10
	call DelayFrames
	ld hl, wMovementFlags_Old
	set 6, [hl] ; BIT_LEDGE_OR_FISHING
	ld de, GoldSpriteGFX
	ld hl, vNPCSprites tile $00
	lb bc, BANK(GoldSpriteGFX), 12
	call Request2bpp
	ld a, 4
	ld hl, RedFishingTiles
	call LoadAnimSpriteGfx_Old
	ld a, [wSpritePlayerStateData1ImageIndex_Old]
	ld c, a
	ld b, $0
	ld hl, FishingRodOAM
	add hl, bc
	ld de, wShadowOAMSprite39
	ld bc, $4
	call CopyBytes
	ld c, 100
	call DelayFrames
	ld a, [wRodResponse_Old]
	and a
	ld hl, NoNibbleText
	jr z, .done
	cp 2
	ld hl, NothingHereText
	jr z, .done

; there was a bite

; shake the player's sprite vertically
	ld b, 10
.loop
	ld hl, wSpritePlayerStateData1YPixels_Old
	call .ShakePlayerSprite
	ld hl, wShadowOAMSprite39
	call .ShakePlayerSprite
	ld c, 3
	call DelayFrames
	dec b
	jr nz, .loop

; If the player is facing up, hide the fishing rod so it doesn't overlap with
; the exclamation bubble that will be shown next.
	ld a, [wSpritePlayerStateData1ImageIndex_Old]
	cp OW_UP
	jr nz, .skipHidingFishingRod
	ld a, $a0
	ld [wShadowOAMSprite39YCoord], a

.skipHidingFishingRod
	ld hl, wEmotionBubbleSpriteIndex_Old
	xor a
	ld [hli], a ; player's sprite
	ld [hl], a ; EXCLAMATION_BUBBLE
; There's no predef for displaying emotion bubbles in this build, so this amounts to nothing

; If the player is facing up, unhide the fishing rod.
	ld a, [wSpritePlayerStateData1ImageIndex_Old]
	cp OW_UP
	jr nz, .skipUnhidingFishingRod
	ld a, $44
	ld [wShadowOAMSprite39YCoord], a

.skipUnhidingFishingRod
	ld hl, ItsABiteText

.done
	call PrintText
	ld hl, wMovementFlags_Old
	res 6, [hl] ; BIT_LEDGE_OR_FISHING
	call RedrawPlayerSprite
	call LoadFont
	ret

.ShakePlayerSprite
	ld a, [hl]
	xor $1
	ld [hl], a
	ret

NoNibbleText:
	text "つれないなー<⋯⋯>"
	prompt

NothingHereText:
	text "なにも　いない　みたい<⋯⋯>"
	prompt

ItsABiteText:
	text "おっ！"
	line "ひいてる　ひいてる！"
	prompt

FishingRodOAM:
; specifies how the fishing rod should be drawn on the screen
	dbsprite  9, 11,  4,  3, $fd, 0      ; down
	dbsprite  9,  8,  4,  4, $fd, 0      ; up
	dbsprite  8, 10,  0,  0, $fe, 0      ; left
	dbsprite 11, 10,  0,  0, $fe, X_FLIP ; right

MACRO fishing_gfx
	dw \1
	db \2
	db $32 ; should've been BANK(\1)
	dw vNPCSprites tile \3
ENDM

RedFishingTiles:
	fishing_gfx RedFishingTilesFront, 2, $02
	fishing_gfx RedFishingTilesBack,  2, $06
	fishing_gfx RedFishingTilesSide,  2, $0a
	fishing_gfx RedFishingRodTiles,   3, $fd

LoadAnimSpriteGfx_Old:
; Load animated sprite tile patterns into VRAM during V-blank. hl is the address
; of an array of structures that contain arguments for CopyVideoData and a is
; the number of structures in the array.
	ld bc, $0
.loop
	push af
	push bc
	push hl
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Request2bpp
	pop hl
	pop bc
	ld a, $6
	add c
	ld c, a
	pop af
	dec a
	jr nz, .loop
	ret

RedFishingTilesFront: INCBIN "gfx/overworld/red_fish_front.2bpp"
RedFishingTilesBack:  INCBIN "gfx/overworld/red_fish_back.2bpp"
RedFishingTilesSide:  INCBIN "gfx/overworld/red_fish_side.2bpp"
RedFishingRodTiles:   INCBIN "gfx/overworld/fishing_rod.2bpp"
