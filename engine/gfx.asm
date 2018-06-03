INCLUDE "constants.asm"

SECTION "Misc GFX Loading Functions", ROMX[$4000], BANK[$3E]

LoadFontGraphics:: ; f8000 (3e:4000)
	ld de, FontGFX
	ld hl, $8800
	lb bc, BANK(FontGFX), ((FontGFXEnd - FontGFX) / LEN_1BPP_TILE)
	jp CopyVideoDataDoubleOptimized
LoadFontExtraGraphicsWithCursor:: ; f800c (3e:400c)
	ld de, FontExtraCDEFGHIVSLM_GFX
	ld hl, $9620
	lb bc, BANK(FontExtraCDEFGHIVSLM_GFX), ((FontSmallKanaPunctuationGFXEnd - FontExtraCDEFGHIVSLM_GFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	ld de, BlackTileAndCursor1bppGFX
	ld hl, $9600
	lb bc, BANK(BlackTileAndCursor1bppGFX), ((BlackTileAndCursor1bppGFXEnd - BlackTileAndCursor1bppGFX) / LEN_1BPP_TILE)
	call CopyVideoDataDoubleOptimized
	jr LoadActiveFrameGraphics
LoadPokemonMenuGraphics:: ; f8026 (3e:4026)
	ld de, BattleHPBarGFX
	ld hl, $9600
	lb bc, BANK(BattleHPBarGFX), ((LevelUpGFXEnd - BattleHPBarGFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	jr LoadActiveFrameGraphics
LoadHexadecimalFontOrHUDGraphics:: ; f8034 (3e:4034)
	call LoadActiveFrameGraphics
	ld hl, $d153
	bit 0, [hl]
	jr z, LoadHudGraphics
	ld hl, $9660
	ld de, FontGFX + (("０" - "ア") * $08)
	lb bc, BANK(FontGFX), ("９" - "０" + 1)
	call CopyVideoDataDoubleOptimized
	ld hl, $9700
	ld de, FontExtraAB_GFX
	lb bc, BANK(FontExtraAB_GFX), ("Ｆ" - "Ａ" + 1)
	call CopyVideoDataOptimized
	ret
LoadHudGraphics:: ; f8057 (3e:4057)
	ld hl, $9660
	ld de, FontGFX + (("０" - "ア") * $08)
	lb bc, BANK(FontGFX), ("９" - "０" + 1)
	call CopyVideoDataDoubleOptimized
	ld hl, $9700
	ld de, $7381
	ld bc, $0401
	call CopyVideoDataOptimized
	ld hl, $9710
	ld de, HUD_GFX
	lb bc, BANK(HUD_GFX), ((HUD_GFXEnd - HUD_GFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	ret
LoadActiveFrameGraphics:: ; f807c (3e:407c)
	ld a, [wActiveFrame]
	ld bc, (FrameGFXFirstFrameEnd - FrameGFXFirstFrame)
	ld hl, FrameGFX
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, $9790
	lb bc, BANK(FrameGFX), ((FrameGFXFirstFrameEnd - FrameGFXFirstFrame) / LEN_1BPP_TILE)
	call CopyVideoDataDoubleOptimized
	ld hl, $97f0
	ld de, EmptyTile1bppGFX
	lb bc, BANK(EmptyTile1bppGFX), ((EmptyTile1bppGFXEnd - EmptyTile1bppGFX) / LEN_1BPP_TILE)
	call CopyVideoDataDoubleOptimized
	ret
LoadPokeDexGraphics:: ; f80a0 (3e:40a0)
	call LoadPokemonMenuGraphics
	ld de, PokedexGFX
	ld hl, $9600
	lb bc, BANK(PokedexGFX), ((PokedexLocationGFXEnd - PokedexGFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	ld de, PokeBallsGFX
	ld hl, $9720
	lb bc, BANK(PokeBallsGFX), 1 ; 1 of 4 tiles
	jp CopyVideoDataOptimized
LoadBattleGraphics:: ; f80bb (3e:40bb)
	ld de, BattleHPBarGFX
	ld hl, $9600
	lb bc, BANK(BattleHPBarGFX), ((BattleHPBarGFXEnd - BattleHPBarGFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	ld hl, $9700
	ld de, BattleMarkersGFX
	lb bc, BANK(BattleMarkersGFX), ((BattleMarkersGFXEnd - BattleMarkersGFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	call LoadActiveFrameGraphics
	ld de, HpExpBarParts0GFX
	ld hl, $96c0
	lb bc, BANK(HpExpBarParts0GFX), ((HpExpBarParts0GFXEnd - HpExpBarParts0GFX) / LEN_1BPP_TILE)
	call CopyVideoDataDoubleOptimized
	ld de, HpExpBarParts1GFX
	ld hl, $9730
	lb bc, BANK(HpExpBarParts1GFX), ((HpExpBarParts3GFXEnd - HpExpBarParts1GFX) / LEN_1BPP_TILE)
	call CopyVideoDataDoubleOptimized
	ld de, ExpBarGFX
	ld hl, $9550
	lb bc, BANK(ExpBarGFX), ((ExpBarGFXEnd - ExpBarGFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	ret
LoadPokemonStatsGraphics:: ; f80fb (3e:40fb)
	call LoadPokemonMenuGraphics
	ld de, HpExpBarParts0GFX
	ld hl, $96c0
	lb bc, BANK(HpExpBarParts0GFX), ((HpExpBarParts0GFXEnd - HpExpBarParts0GFX) / LEN_1BPP_TILE)
	call CopyVideoDataDoubleOptimized
	ld de, HpExpBarParts1GFX
	ld hl, $9780
	lb bc, BANK(HpExpBarParts1GFX), 1 ; 1 of 6 tiles
	call CopyVideoDataDoubleOptimized
	ld de, HpExpBarParts2GFX
	ld hl, $9760
	lb bc, BANK(HpExpBarParts0GFX), ((HpExpBarParts2GFXEnd - HpExpBarParts2GFX) / LEN_1BPP_TILE)
	call CopyVideoDataDoubleOptimized
	ld de, ExpBarGFX
	ld hl, $9550
	lb bc, BANK(ExpBarGFX), ((ExpBarGFXEnd - ExpBarGFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	ld de, StatsGFX
	ld hl, $9310
	lb bc, BANK(StatsGFX), ((StatsGFXEnd - StatsGFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	ret
LoadBackpackGraphics:: ; f813b (3e:413b)
	ld de, BlackTileAndCursor1bppGFX
	ld hl, $9600
	lb bc, BANK(BlackTileAndCursor1bppGFX), ((BlackTileAndCursor1bppGFXEnd - BlackTileAndCursor1bppGFX) / LEN_1BPP_TILE)
	call CopyVideoDataDoubleOptimized
	ld de, PackIconGFX
	ld hl, $9620
	lb bc, BANK(PackIconGFX), 12 ; 12 of 15 tiles
	call CopyVideoDataOptimized
	ld de, FontSmallKanaPunctuationGFX
	ld hl, $96e0
	lb bc, BANK(FontSmallKanaPunctuationGFX), ((FontSmallKanaPunctuationGFXEnd - FontSmallKanaPunctuationGFX) / LEN_2BPP_TILE)
	call CopyVideoDataOptimized
	jp LoadActiveFrameGraphics
; 0xf8162