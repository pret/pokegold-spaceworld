INCLUDE "constants.asm"

SECTION "engine/gfx/load_gfx.asm", ROMX

LoadFontGraphics::
	ld de, FontGFX
	ld hl, $8800
	lb bc, BANK(FontGFX), ((FontGFX.End - FontGFX) / LEN_1BPP_TILE)
	jp Get1bpp
LoadFontExtraGraphicsWithCursor::
	ld de, FontExtraCDEFGHIVSLM_GFX
	ld hl, $9620
	lb bc, BANK(FontExtraCDEFGHIVSLM_GFX), ((FontSmallKanaPunctuationGFX.End - FontExtraCDEFGHIVSLM_GFX) / LEN_2BPP_TILE)
	call Get2bpp
	ld de, BlackTileAndCursor1bppGFX
	ld hl, $9600
	lb bc, BANK(BlackTileAndCursor1bppGFX), ((BlackTileAndCursor1bppGFX.End - BlackTileAndCursor1bppGFX) / LEN_1BPP_TILE)
	call Get1bpp
	jr LoadActiveFrameGraphics
LoadPokemonMenuGraphics::
	ld de, BattleHPBarGFX
	ld hl, $9600
	lb bc, BANK(BattleHPBarGFX), ((LevelUpGFX.End - BattleHPBarGFX) / LEN_2BPP_TILE)
	call Get2bpp
	jr LoadActiveFrameGraphics
LoadToolgearGraphicsDebug::
	call LoadActiveFrameGraphics
	ld hl, $d153
	bit 0, [hl]
	jr z, .loadToolgearGraphics
	ld hl, $9660
	ld de, FontGFX + (("０" - "ア") * $08)
	lb bc, BANK(FontGFX), ("９" - "０" + 1)
	call Get1bpp
	ld hl, $9700
	ld de, FontExtraAB_GFX
	lb bc, BANK(FontExtraAB_GFX), ("Ｆ" - "Ａ" + 1)
	call Get2bpp
	ret
.loadToolgearGraphics::
	ld hl, $9660
	ld de, FontGFX + (("０" - "ア") * $08)
	lb bc, BANK(FontGFX), ("９" - "０" + 1)
	call Get1bpp
	ld hl, $9700
	ld de, TrainerCardColonGFX
	lb bc, BANK(TrainerCardColonGFX), 1 ; tile
	call Get2bpp
	ld hl, $9710
	ld de, HUD_GFX
	lb bc, BANK(HUD_GFX), ((HUD_GFX.End - HUD_GFX) / LEN_2BPP_TILE)
	call Get2bpp
	ret
LoadActiveFrameGraphics::
	ld a, [wActiveFrame]
	ld bc, (FrameGFX.FirstEntryEnd - FrameGFX)
	ld hl, FrameGFX
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, $9790
	lb bc, BANK(FrameGFX), ((FrameGFX.FirstEntryEnd - FrameGFX) / LEN_1BPP_TILE)
	call Get1bpp
	ld hl, $97f0
	ld de, EmptyTile1bppGFX
	lb bc, BANK(EmptyTile1bppGFX), ((EmptyTile1bppGFX.End - EmptyTile1bppGFX) / LEN_1BPP_TILE)
	call Get1bpp
	ret
LoadPokeDexGraphics::
	call LoadPokemonMenuGraphics
	ld de, PokedexGFX
	ld hl, $9600
	lb bc, BANK(PokedexGFX), ((PokedexGFX.End - PokedexGFX) / LEN_2BPP_TILE + 5) ; copies first 5 tiles of TownMapGFX
	call Get2bpp
	ld de, PokeBallsGFX
	ld hl, $9720
	lb bc, BANK(PokeBallsGFX), 1 ; 1 of 4 tiles
	jp Get2bpp
LoadBattleGraphics::
	ld de, BattleHPBarGFX
	ld hl, $9600
	lb bc, BANK(BattleHPBarGFX), ((BattleHPBarGFX.End - BattleHPBarGFX) / LEN_2BPP_TILE)
	call Get2bpp
	ld hl, $9700
	ld de, BattleMarkersGFX
	lb bc, BANK(BattleMarkersGFX), ((BattleMarkersGFX.End - BattleMarkersGFX) / LEN_2BPP_TILE)
	call Get2bpp
	call LoadActiveFrameGraphics
	ld de, HpExpBarParts0GFX
	ld hl, $96c0
	lb bc, BANK(HpExpBarParts0GFX), ((HpExpBarParts0GFX.End - HpExpBarParts0GFX) / LEN_1BPP_TILE)
	call Get1bpp
	ld de, HpExpBarParts1GFX
	ld hl, $9730
	lb bc, BANK(HpExpBarParts1GFX), ((HpExpBarParts3GFX.End - HpExpBarParts1GFX) / LEN_1BPP_TILE)
	call Get1bpp
	ld de, ExpBarGFX
	ld hl, $9550
	lb bc, BANK(ExpBarGFX), ((ExpBarGFX.End - ExpBarGFX) / LEN_2BPP_TILE)
	call Get2bpp
	ret
LoadPokemonStatsGraphics::
	call LoadPokemonMenuGraphics
	ld de, HpExpBarParts0GFX
	ld hl, $96c0
	lb bc, BANK(HpExpBarParts0GFX), ((HpExpBarParts0GFX.End - HpExpBarParts0GFX) / LEN_1BPP_TILE)
	call Get1bpp
	ld de, HpExpBarParts1GFX
	ld hl, $9780
	lb bc, BANK(HpExpBarParts1GFX), 1 ; 1 of 6 tiles
	call Get1bpp
	ld de, HpExpBarParts2GFX
	ld hl, $9760
	lb bc, BANK(HpExpBarParts0GFX), ((HpExpBarParts2GFX.End - HpExpBarParts2GFX) / LEN_1BPP_TILE)
	call Get1bpp
	ld de, ExpBarGFX
	ld hl, $9550
	lb bc, BANK(ExpBarGFX), ((ExpBarGFX.End - ExpBarGFX) / LEN_2BPP_TILE)
	call Get2bpp
LoadOnlyPokemonStatsGraphics::
	ld de, StatsGFX
	ld hl, $9310
	lb bc, BANK(StatsGFX), ((StatsGFX.End - StatsGFX) / LEN_2BPP_TILE)
	call Get2bpp
	ret
LoadBackpackGraphics::
	ld de, BlackTileAndCursor1bppGFX
	ld hl, $9600
	lb bc, BANK(BlackTileAndCursor1bppGFX), ((BlackTileAndCursor1bppGFX.End - BlackTileAndCursor1bppGFX) / LEN_1BPP_TILE)
	call Get1bpp
	ld de, PackIconGFX
	ld hl, $9620
	lb bc, BANK(PackIconGFX), 12 ; 12 of 15 tiles
	call Get2bpp
	ld de, FontSmallKanaPunctuationGFX
	ld hl, $96e0
	lb bc, BANK(FontSmallKanaPunctuationGFX), ((FontSmallKanaPunctuationGFX.End - FontSmallKanaPunctuationGFX) / LEN_2BPP_TILE)
	call Get2bpp
	jp LoadActiveFrameGraphics
