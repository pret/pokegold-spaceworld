INCLUDE "constants.asm"

SECTION "engine/dumps/bank23.asm@AnimateTilesetImpl", ROMX

AnimateTilesetImpl:
	ldh a, [hMapAnims]
	and a
	ret z

	ld a, [wTilesetAnim]
	ld e, a
	ld a, [wTilesetAnim+1]
	ld d, a
	ldh a, [hTileAnimFrame]
	ld l, a
	inc a
	ldh [hTileAnimFrame], a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

SECTION "engine/dumps/bank23.asm@RestoreOverworldMapTiles", ROMX

RestoreOverworldMapTiles::
	xor a
	call OpenSRAM
	ld hl, wTileMap
	ld de, sScratch
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	call CloseSRAM
	farcall ReanchorBGMap_NoOAMUpdate

	xor a
	call OpenSRAM
	ld hl, sScratch
	ld de, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.loop
	ld a, [hl]
	cp $61
	jr c, .next
	ld [de], a
.next
	inc hl
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	
	call CloseSRAM
	call UpdateSprites
	call WaitBGMap
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call DelayFrame

	xor a
	ldh [hBGMapMode], a
	call InitToolgearBuffer
	ld b, SGB_MAP_PALS
	call GetSGBLayout
	ret

SECTION "engine/dumps/bank23.asm@EnterMapAnim_Old", ROMX

; A bunch of old animation functions from Generation I.
; Basically non-functional because RAM has moved around so much since then.
; Certain lines of code were removed here, presumably so that it would actually compile.

; TODO: Make this less messy by including old variables in wram.asm.
; Shouldn't be too much of a priority since it's... you know, not used. Or functional.

EnterMapAnim_Old::
	call InitFacingDirectionList_Old
	ld a, $ec
	ld [wReservedObjectFlags], a ; wSpritePlayerStateData1YPixels in pokered
	call WaitBGMap
	push hl
	call GBFadeInFromWhite
	pop hl
	call PlayerSpinWhileMovingDown_Old
	call FishingAnim_Old ; was IsPlayerStandingOnWarpPadOrHole
	ld a, b
	and a
	jr nz, .done
; if the player is not standing on a warp pad or hole
	ld hl, wBattleMenuRows ; originally wPlayerSpinInPlaceAnimFrameDelay
	xor a
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelay
	inc a
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelayDelta
	ld a, $8
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelayEndValue
	ld [hl], $ff ; wPlayerSpinInPlaceAnimSoundID
	ld hl, $cc45 ; originally wFacingDirectionList
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
	ld hl, wBattleMenuRows ; originally wPlayerSpinWhileMovingUpOrDownAnimDeltaY
	ld a, $10
	ld [hli], a ; wPlayerSpinWhileMovingUpOrDownAnimDeltaY
	ld a, $3c
	ld [hli], a ; wPlayerSpinWhileMovingUpOrDownAnimMaxY
	call GetPlayerTeleportAnimFrameDelay_Old
	ld [hl], a ; wPlayerSpinWhileMovingUpOrDownAnimFrameDelay
	jp PlayerSpinWhileMovingUpOrDown_Old

LeaveMapAnim_Old:
	call InitFacingDirectionList_Old
	call FishingAnim_Old ; originally IsPlayerStandingOnWarpPadOrHole
	ld a, b
	and a
	jr z, .playerNotStandingOnWarpPadOrHole
	dec a
	jp nz, LeaveMapThroughHoleAnim_Old
.spinWhileMovingUp
	ld hl, wBattleMenuRows ; originally wPlayerSpinWhileMovingUpOrDownAnimDeltaY
	ld a, -$10
	ld [hli], a ; wPlayerSpinWhileMovingUpOrDownAnimDeltaY
	ld a, $ec
	ld [hli], a ; wPlayerSpinWhileMovingUpOrDownAnimMaxY
	call GetPlayerTeleportAnimFrameDelay_Old
	ld [hl], a ; wPlayerSpinWhileMovingUpOrDownAnimFrameDelay
	call PlayerSpinWhileMovingUpOrDown_Old
	call FishingAnim_Old ; originally IsPlayerStandingOnWarpPadOrHole
	ld a, b
	dec a
	jr z, .playerStandingOnWarpPad
; if not standing on a warp pad, there is an extra delay
	ld c, 10
	call DelayFrames
.playerStandingOnWarpPad
	call GBFadeOutToWhite
	jp RestoreFacingDirectionAndYScreenPos_Old

.playerNotStandingOnWarpPadOrHole
	ld hl, wBattleMenuRows ; originally wPlayerSpinInPlaceAnimFrameDelay
	ld a, 16
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelay
	ld a, -1
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelayDelta
	xor a
	ld [hli], a ; wPlayerSpinInPlaceAnimFrameDelayEndValue
	ld [hl], SFX_TELEPORT_EXIT_2 ; wPlayerSpinInPlaceAnimSoundID
	ld hl, $cc45 ; originally wFacingDirectionList
	call PlayerSpinInPlace_Old
	jr .spinWhileMovingUp

; Also unreferenced
.flyAnimation
	call LoadBirdSpriteGraphics_Old
	ld hl, wBattleMenuRows ; originally wFlyAnimUsingCoordList
	ld a, $ff ; is not using coord list (flap in place)
	ld [hli], a ; wFlyAnimUsingCoordList
	ld a, 8
	ld [hli], a ; wFlyAnimCounter
	ld [hl], $c ; wFlyAnimBirdSpriteImageIndex
	call DoFlyAnimation_Old
	ld hl, wBattleMenuRows ; wFlyAnimUsingCoordList
	xor a ; is using coord list
	ld [hli], a ; wFlyAnimUsingCoordList
	ld a, $c
	ld [hli], a ; wFlyAnimCounter
	ld [hl], $c ; wFlyAnimBirdSpriteImageIndex (facing right)
	ld de, FlyAnimationScreenCoords1_Old
	call DoFlyAnimation_Old
	ld c, 40
	call DelayFrames
	ld hl, wBattleMenuColumns ; originally wFlyAnimCounter
	ld a, 11
	ld [hli], a ; wFlyAnimCounter
	ld [hl], $8 ; wFlyAnimBirdSpriteImageIndex (facing left)
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
	ld a, [wTrainerHUDTiles] ; originally wFlyAnimBirdSpriteImageIndex
	xor $1 ; make the bird flap its wings
	ld [wTrainerHUDTiles], a
	ld [wReservedObjectSpriteTile], a ; originally wSpritePlayerStateData1ImageIndex
	ld c, 3
	call DelayFrames
	ld a, [wBattleMenuRows] ; wFlyAnimUsingCoordList
	cp $ff
	jr z, .skipCopyingCoords ; if the bird is flapping its wings in place
	ld hl, wReservedObjectFlags ; originally wSpritePlayerStateData1YPixels
	ld a, [de]
	inc de
	ld [hli], a ; y
	inc hl
	ld a, [de]
	inc de
	ld [hl], a ; x
.skipCopyingCoords
	ld a, [wBattleMenuColumns] ; wFlyAnimCounter
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
	ld a, [wReservedObjectSpriteTile] ; originally wSpritePlayerStateData1ImageIndex
	ld [$cc4d], a ; originally wSavedPlayerFacingDirection
	ld a, [wReservedObjectFlags] ; originally wSpritePlayerStateData1YPixels
	ld [$cc4c], a ; originally wSavedPlayerScreenY
	ld hl, .PlayerSpinningFacingOrder
	ld de, $cc45 ; originally wFacingDirectionList
	ld bc, 4
	call CopyBytes
	ld a, [wReservedObjectSpriteTile]
	ld hl, $cc45
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
	ld [wReservedObjectSpriteTile], a ; originally wSpritePlayerStateData1ImageIndex
	push hl
	ld hl, $cc45 ; wFacingDirectionList
	ld de, $cc44 ; wFacingDirectionList - 1
	ld bc, 4
	call CopyBytes
	ld a, [$cc44]
	ld [$cc48], a ; wFacingDirectionList + 3
	pop hl
	ret

PlayerSpinInPlace_Old:
	call SpinPlayerSprite_Old
	ld a, [wBattleMenuRows] ; originally wPlayerSpinInPlaceAnimFrameDelay
	ld c, a
	and $3
	jr nz, .skipPlayingSound
.skipPlayingSound
	ld a, [wBattleMenuColumns] ; wPlayerSpinInPlaceAnimFrameDelayDelta
	add c
	ld [wBattleMenuRows], a ; wPlayerSpinInPlaceAnimFrameDelay
	ld c, a
	ld a, [wTrainerHUDTiles] ; wPlayerSpinInPlaceAnimFrameDelayEndValue
	cp c
	ret z
	call DelayFrames
	jr PlayerSpinInPlace_Old

PlayerSpinWhileMovingUpOrDown_Old:
	call SpinPlayerSprite_Old
	ld a, [wBattleMenuRows] ; wPlayerSpinWhileMovingUpOrDownAnimDeltaY
	ld c, a
	ld a, [wReservedObjectFlags] ; wSpritePlayerStateData1YPixels
	add c
	ld [wReservedObjectFlags], a ; wSpritePlayerStateData1YPixels
	ld c, a
	ld a, [wBattleMenuColumns] ; wPlayerSpinWhileMovingUpOrDownAnimMaxY
	cp c
	ret z
	ld a, [wTrainerHUDTiles] ; wPlayerSpinWhileMovingUpOrDownAnimFrameDelay
	ld c, a
	call DelayFrames
	jr PlayerSpinWhileMovingUpOrDown_Old

RestoreFacingDirectionAndYScreenPos_Old:
	ld a, [$cc4c] ; wSavedPlayerScreenY
	ld [wReservedObjectFlags], a ; wSpritePlayerStateData1YPixels
	ld a, [$cc4d] ; wSavedPlayerFacingDirection
	ld [wReservedObjectSpriteTile], a ; wSpritePlayerStateData1ImageIndex
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
	call $4c4d ; LoadAnimSpriteGfx_Old
	ld a, [wReservedObjectSpriteTile] ; originally wSpritePlayerStateData1ImageIndex
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
	ld hl, wReservedObjectFlags ; wSpritePlayerStateData1YPixels
	call .ShakePlayerSprite
	ld hl, wShadowOAMSprite39
	call .ShakePlayerSprite
	ld c, 3
	call DelayFrames
	dec b
	jr nz, .loop

; If the player is facing up, hide the fishing rod so it doesn't overlap with
; the exclamation bubble that will be shown next.
	ld a, [wReservedObjectSpriteTile] ; wSpritePlayerStateData1ImageIndex
	cp OW_UP
	jr nz, .skipHidingFishingRod
	ld a, $a0
	ld [wShadowOAMSprite39YCoord], a

.skipHidingFishingRod
	ld hl, $cc4c ; wEmotionBubbleSpriteIndex
	xor a
	ld [hli], a ; player's sprite
	ld [hl], a ; EXCLAMATION_BUBBLE
; There's no predef for displaying emotion bubbles in this build, so this amounts to nothing

; If the player is facing up, unhide the fishing rod.
	ld a, [wReservedObjectSpriteTile] ; wSpritePlayerStateData1ImageIndex
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
