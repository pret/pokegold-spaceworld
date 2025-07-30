INCLUDE "constants.asm"

SECTION "engine/gfx/load_minor_object_gfx.asm", ROMX


_LoadMinorObjectGFX::
	ld hl, wQueuedMinorObjectGFX
	push hl
	ld a, [hl]
	ld l, a
	ld h, 0
	ld de, .MinorObjectGFX
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	push de
	ret

.MinorObjectGFX:
	dw .LoadNull
	dw .LoadJumpShadow
	dw .LoadUnknownBouncingOrb
	dw .LoadShockEmote
	dw .LoadQuestionEmote
	dw .LoadHappyEmote
	dw .LoadBoulderDust
	dw .LoadGrampsSpriteStandPt0
	dw .LoadGrampsSpriteStandPt1
	dw .LoadGrampsSpriteWalkPt0
	dw .LoadGrampsSpriteWalkPt1
	dw .LoadClefairySpriteStandPt0
	dw .LoadClefairySpriteStandPt1
	dw .LoadClefairySpriteWalkPt0
	dw .LoadClefairySpriteWalkPt1

.FarCopy:
	ld a, c
	ld [wVBCopyFarSrcBank], a
	ld a, l
	ld [wVBCopyFarSrc], a
	ld a, h
	ld [wVBCopyFarSrc+1], a
.ContinueFarCopyNewDst:
	ld a, e
	ld [wVBCopyFarDst], a
	ld a, d
	ld [wVBCopyFarDst+1], a
.ContinueFarCopy:
	ld a, b
	ld [wVBCopyFarSize], a
	ret

.LoadNull:
	ret

.LoadShockEmote:
	ld hl, ShockEmoteGFX
	jr .load_emote
.LoadQuestionEmote:
	ld hl, QuestionEmoteGFX
	jr .load_emote
.LoadHappyEmote:
	ld hl, HappyEmoteGFX
.load_emote:
	ld de, vChars1 tile $78
	ld b, (HappyEmoteGFX.end - HappyEmoteGFX) / LEN_2BPP_TILE
	ld c, BANK(EmoteGFX)
	jp .FarCopy

.LoadJumpShadow:
	ld [hl], $00
	ld hl, JumpShadowGFX
	ld de, vChars1 tile $7c
	ld b, (JumpShadowGFX.end - JumpShadowGFX) / LEN_2BPP_TILE
	ld c, BANK(JumpShadowGFX)
	jp .FarCopy

.LoadUnknownBouncingOrb:
	ld [hl], $00
	ld hl, UnknownBouncingOrbGFX
	ld de, vChars1 tile $7c
	ld b, (UnknownBouncingOrbGFX.end - UnknownBouncingOrbGFX) / LEN_2BPP_TILE
	ld c, BANK(UnknownBouncingOrbGFX)
	jp .FarCopy

.LoadBoulderDust:
	ld [hl], $00
	ld hl, BoulderDustGFX
	ld de, vChars1 tile $7c
	ld b, (BoulderDustGFX.end - BoulderDustGFX) / LEN_2BPP_TILE
	ld c, BANK(BoulderDustGFX)
	jp .FarCopy

.LoadGrampsSpriteStandPt0:
	inc [hl]
	ld hl, GrampsSpriteGFX
	ld de, vChars0
	ld b, (GrampsSpriteGFX.end - GrampsSpriteGFX) / LEN_2BPP_TILE / 4
	ld c, BANK(GrampsSpriteGFX)
	jp .FarCopy

.LoadGrampsSpriteStandPt1:
	inc [hl]
	ld b, (GrampsSpriteGFX.end - GrampsSpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopy

.LoadGrampsSpriteWalkPt0:
	inc [hl]
	ld de, vChars1
	ld b, (GrampsSpriteGFX.end - GrampsSpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopyNewDst

.LoadGrampsSpriteWalkPt1:
	ld [hl], $00
	ld b, (GrampsSpriteGFX.end - GrampsSpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopy

.LoadClefairySpriteStandPt0:
	inc [hl]
	ld hl, ClefairySpriteGFX
	ld de, vChars0
	ld b, (ClefairySpriteGFX.end - ClefairySpriteGFX) / LEN_2BPP_TILE / 4
	ld c, BANK(ClefairySpriteGFX)
	jp .FarCopy

.LoadClefairySpriteStandPt1:
	inc [hl]
	ld b, (ClefairySpriteGFX.end - ClefairySpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopy

.LoadClefairySpriteWalkPt0:
	inc [hl]
	ld de, vChars1
	ld b, (ClefairySpriteGFX.end - ClefairySpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopyNewDst

.LoadClefairySpriteWalkPt1:
	ld [hl], $00
	ld b, (ClefairySpriteGFX.end - ClefairySpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopy
