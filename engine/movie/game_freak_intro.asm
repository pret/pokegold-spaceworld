INCLUDE "constants.asm"

SECTION "engine/movie/game_freak_intro.asm", ROMX

GameFreakIntro::
; Copyright screen and Game Freak logo

	call DisableLCD
	call ClearVRAM

	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	xor a
	ldh [hBGMapAddress], a
	ldh [hJoyState], a
	ldh [hSCX], a
	ldh [hSCY], a

	ld a, $90
	ldh [hWY], a

	call EnableLCD

	ld c, 10
	call DelayFrames
	ld b, SGB_GF_INTRO
	call GetSGBLayout

	callfar IntroCopyRightInfo

	ld a, 1
	ldh [hBGMapMode], a
	call WaitBGMap
	call SetPalettes

	ld c, 3 * 60	; 3 seconds
	call DelayFrames

	xor a
	ldh [hWY], a
	call ClearTileMap

	call .Init
.loop
	call .Frame
	jr nc, .loop

; this was set if user skipped the GF logo by pressing A
	ld a, [wJumptableIndex]
	bit 6, a
	jr nz, .cancelled

; clear carry flag from .PlayFrame
	and a
	ret

.cancelled
	scf
	ret

.Init:
	call DisableLCD

	ld hl, vBGMap0
	ld bc, BG_MAP_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill

	ld de, GameFreakLogoGFX
	ld hl, vChars1
	lb bc, BANK(GameFreakLogoGFX), 28
	call Get1bpp

	ld hl, GameFreakLogoSparkleGFX
	ld de, vChars1 tile $1C
	ld bc, 5 tiles
	ld a, BANK(GameFreakLogoSparkleGFX)
	call FarCopyData

	farcall ClearSpriteAnims

	ld hl, wSpriteAnimDict
	ld a, SPRITE_ANIM_DICT_GS_SPLASH
	ld [hli], a
	ld a, $8d
	ld [hl], a

	xor a
	ld [wJumptableIndex], a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	ldh [hSCX], a
	ldh [hSCY], a

	ld a, 1
	ldh [hBGMapMode], a

	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call EnableLCD

	ld a, %11100100
	ld a, %11100100	; redundant
	ldh [rOBP0], a
	ld a, %00100100
	ldh [rOBP1], a
	ret


.Frame:
; Play one frame of GameFreakPresents sequence.
; Return carry when the sequence completes or is canceled.
	ld hl, hJoypadDown
	ld a, [hl]
	and %00001111
	jr nz, .pressed

	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .Finished

	farcall PlaySpriteAnimations

	call GameFreakPresentsScene
	call DelayFrame
	and a
	ret

.pressed
	ld hl, wJumptableIndex
	set 6, [hl]

.Finished:
	callfar ClearSpriteAnims
	call ClearTileMap
	call ClearSprites

	ld c, 16
	call DelayFrames

	scf
	ret


GameFreakPresentsScene:
	jumptable .scenes, wJumptableIndex

.scenes
	dw GameFreakPresents_Wait64Frames
	dw GameFreakPresents_Star
	dw GameFreakPresents_PlaceLogo
	dw GameFreakPresents_LogoSparkles
	dw GameFreakPresents_PlacePresents
	dw GameFreakPresents_WaitForTimer
	dw GameFreakPresents_SetDoneFlag

GameFreakPresents_NextScene:
	ld hl, wJumptableIndex
	inc [hl]
	ret

GameFreakPresents_Wait64Frames:
	ld c, $40
	call DelayFrames
	call GameFreakPresents_NextScene
	ret

GameFreakPresents_Star:
	xor a
	ld [wIntroSceneFrameCounter], a
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_STAR
	call InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $a0	; star path radius

	ld de, SFX_GAME_FREAK_LOGO_RG
	call PlaySFX
	call GameFreakPresents_NextScene
	ret

GameFreakPresents_PlaceLogo:
	ld a, [wIntroSceneFrameCounter]
	and a
	ret z

	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_OBJ_GAMEFREAK_LOGO
	call InitSpriteAnimStruct
	call GameFreakPresents_NextScene

; set timer for the next scene
	ld a, 128
	ld [wIntroSceneTimer], a
	ret

GameFreakPresents_LogoSparkles:
	ld hl, wIntroSceneTimer
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]

; add first text when timer passes half
	cp 63
	call z, GameFreakPresents_PlaceGameFreak

; add sparkles continuously
	call GameFreakPresents_Sparkle
	ret

.done
; set timer for the next scene and go there
	ld [hl], 128
	call GameFreakPresents_NextScene
	ret


GameFreakPresents_PlaceGameFreak:
	hlcoord 5, 12
	ld de, .game_freak
	call PlaceString
	ret

.game_freak
;	   G    A    M    E         F    R    E    A    K
	db $80, $81, $82, $83, $8d, $84, $85, $83, $81, $86
	db "@"

GameFreakPresents_PlacePresents:
	hlcoord 7, 13
	ld de, .presents
	call PlaceString
	call GameFreakPresents_NextScene
	ld a, $80
	ld [wIntroSceneTimer], a
	ret

.presents
;          P R E S E N T S
	db $87, $88, $89, $8a, $8b, $8c
	db "@"

GameFreakPresents_SetDoneFlag:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

GameFreakPresents_WaitForTimer:
	ld hl, wIntroSceneTimer
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ret
.done
	call GameFreakPresents_NextScene
	ret

GameFreakPresents_UpdateLogoPal:
; called from sprite animation routine

; once we reached the final state, leave it alone
	ldh a, [rOBP1]
	cp %10010000
	ret z

; wait 16 frames before next change
	ld a, [wIntroSceneTimer]
	and $0f
	ret nz

; rotate OBP1 by one color slot (2 bits)
	ld hl, rOBP1
	rrc [hl]
	rrc [hl]
	ret


GameFreakPresents_Sparkle:
; Initialize and configure a sparkle sprite.

; run only every second frame
	ld d, a
	and 1
	ret nz

; shift over so our index is still changing by 1 each time
	ld a, d
	srl a
; set up a new sparkle sprite
	push af
	depixel 11, 11
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_SPARKLE
	call InitSpriteAnimStruct
	pop af

; take the bottom 4 bits of a as an index into
; sparkle_vectors (16 entries)
	and %00001111
	ld e, a
	ld d, 0
	ld hl, .vectors
	add hl, de
	add hl, de

; set the angle and distance for this sprite
	ld e, l
	ld d, h
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [de]
	ld [hl], a ; angle
	inc de
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], 0
	inc hl ; SPRITEANIMSTRUCT_VAR2
	ld a, [de]
	ld [hl], a ; distance
	ret

.vectors
	db $00, $03
	db $08, $04
	db $04, $03
	db $0c, $02
	db $10, $02
	db $18, $03
	db $14, $04
	db $1c, $03
	db $20, $02
	db $28, $02
	db $24, $03
	db $2c, $04
	db $30, $04
	db $38, $03
	db $34, $02
	db $3c, $04
