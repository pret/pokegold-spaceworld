INCLUDE "constants.asm"

SECTION "engine/sprites/sprites.asm@LoadOverworldSprite", ROMX

LoadOverworldSprite:
	push af
	call GetOverworldSpriteData
	push bc
	push hl
	push de
	ld a, [wcdaf]
	bit 7, a
	jr nz, .dont_copy
	call Get2bpp
.dont_copy
	pop de
	ld hl, SPRITE_TILE_SIZE * 3
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld bc, vChars1 - vChars0
	add hl, bc
	pop bc
	pop af
	call IsAnimatedSprite
	ret c
	ld a, [wcdaf]
	bit 6, a
	ret nz
	call Get2bpp
	ret

; get the data for overworld sprite in a
; returns: gfx ptr in hl, length in c, bank in b
GetOverworldSpriteData:
	push hl
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, OverworldSprites
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld c, [hl]
	swap c
	inc hl
	ld b, [hl]
	pop hl
	ret

SECTION "engine/sprites/sprites.asm@OverworldSprites", ROMX

overworld_sprite: MACRO
; pointer, length, bank
	dw \1
	db \2 tiles, BANK(\1)
ENDM

OverworldSprites::
	overworld_sprite GoldSpriteGFX, 12
	overworld_sprite GoldBikeSpriteGFX, 12
	overworld_sprite GoldSkateboardSpriteGFX, 12
	overworld_sprite SilverSpriteGFX, 12
	overworld_sprite OkidoSpriteGFX, 12
	overworld_sprite RedSpriteGFX, 12
	overworld_sprite BlueSpriteGFX, 12
	overworld_sprite MasakiSpriteGFX, 12
	overworld_sprite ElderSpriteGFX, 12
	overworld_sprite SakakiSpriteGFX, 12
	overworld_sprite GantetsuSpriteGFX, 12
	overworld_sprite MomSpriteGFX, 12
	overworld_sprite SilversMomSpriteGFX, 12
	overworld_sprite RedsMomSpriteGFX, 12
	overworld_sprite RedsMomSpriteGFX, 12
	overworld_sprite NanamiSpriteGFX, 12
	overworld_sprite EvilOkidoSpriteGFX, 12
	overworld_sprite KikukoSpriteGFX, 12
	overworld_sprite HayatoSpriteGFX, 12
	overworld_sprite TsukushiSpriteGFX, 12
	overworld_sprite TsukushiSpriteGFX, 12
	overworld_sprite EnokiSpriteGFX, 12
	overworld_sprite MikanSpriteGFX, 12
	overworld_sprite MikanSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerMSpriteGFX, 12
	overworld_sprite CooltrainerFSpriteGFX, 12
	overworld_sprite BugCatcherBoySpriteGFX, 12
	overworld_sprite TwinSpriteGFX, 12
	overworld_sprite YoungsterSpriteGFX, 12
	overworld_sprite LassSpriteGFX, 12
	overworld_sprite TeacherSpriteGFX, 12
	overworld_sprite GirlSpriteGFX, 12
	overworld_sprite SuperNerdSpriteGFX, 12
	overworld_sprite RockerSpriteGFX, 12
	overworld_sprite PokefanMSpriteGFX, 12
	overworld_sprite PokefanFSpriteGFX, 12
	overworld_sprite GrampsSpriteGFX, 12
	overworld_sprite GrannySpriteGFX, 12
	overworld_sprite SwimmerMSpriteGFX, 12
	overworld_sprite SwimmerFSpriteGFX, 12
	overworld_sprite RocketMSpriteGFX, 12
	overworld_sprite RocketMSpriteGFX, 12
	overworld_sprite RocketMSpriteGFX, 12
	overworld_sprite RocketFSpriteGFX, 12
	overworld_sprite NurseSpriteGFX, 12
	overworld_sprite LinkReceptionistSpriteGFX, 12
	overworld_sprite ClerkSpriteGFX, 12
	overworld_sprite FisherSpriteGFX, 12
	overworld_sprite FishingGuruSpriteGFX, 12
	overworld_sprite ScientistSpriteGFX, 12
	overworld_sprite MediumSpriteGFX, 12
	overworld_sprite SageSpriteGFX, 12
	overworld_sprite FrowningManSpriteGFX, 12
	overworld_sprite GentlemanSpriteGFX, 12
	overworld_sprite BlackbeltSpriteGFX, 12
	overworld_sprite ReceptionistSpriteGFX, 12
	overworld_sprite OfficerSpriteGFX, 12
	overworld_sprite CaptainSpriteGFX, 12
	overworld_sprite CaptainSpriteGFX, 12
	overworld_sprite CaptainSpriteGFX, 12
	overworld_sprite MohawkSpriteGFX, 12
	overworld_sprite GymGuySpriteGFX, 12
	overworld_sprite SailorSpriteGFX, 12
	overworld_sprite HelmetSpriteGFX, 12
	overworld_sprite BurglarSpriteGFX, 12
	overworld_sprite RhydonSpriteGFX, 12
	overworld_sprite ClefairySpriteGFX, 12
	overworld_sprite PidgeySpriteGFX, 12
	overworld_sprite CharizardSpriteGFX, 12
	overworld_sprite SnorlaxSpriteGFX, 4
	overworld_sprite SeelSpriteGFX, 12
	overworld_sprite PoliwrathSpriteGFX, 12
	overworld_sprite LaprasSpriteGFX, 12
	overworld_sprite PokeBallSpriteGFX, 4
	overworld_sprite PokedexSpriteGFX, 4
	overworld_sprite PaperSpriteGFX, 4
	overworld_sprite OldLinkReceptionistSpriteGFX, 4
	overworld_sprite OldLinkReceptionistSpriteGFX, 4
	overworld_sprite EggSpriteGFX, 4
	overworld_sprite BoulderSpriteGFX, 4
