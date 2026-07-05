LoadFontGraphics::
	ld de, FontGFX
	ld hl, vFont
	lb bc, BANK(FontGFX), (FontGFX.End - FontGFX) / LEN_1BPP_TILE
	jp Get1bpp

LoadFontExtraGraphicsWithCursor::
	ld de, FontExtraCDEFGHIVSLM_GFX
	ld hl, vChars2 tile $62
	lb bc, BANK(FontExtraCDEFGHIVSLM_GFX), (FontSmallKanaPunctuationGFX.End - FontExtraCDEFGHIVSLM_GFX) / LEN_2BPP_TILE
	call Get2bpp
	ld de, BlackTileAndCursor1bppGFX
	ld hl, vChars2 tile '■' ; $60
	lb bc, BANK(BlackTileAndCursor1bppGFX), (BlackTileAndCursor1bppGFX.End - BlackTileAndCursor1bppGFX) / LEN_1BPP_TILE
	call Get1bpp
	jr LoadActiveFrameGraphics

LoadPokemonMenuGraphics::
	ld de, BattleHPBarGFX
	ld hl, vChars2 tile $60
	lb bc, BANK(BattleHPBarGFX), (LevelUpGFX.End - BattleHPBarGFX) / LEN_2BPP_TILE
	call Get2bpp
	jr LoadActiveFrameGraphics

LoadToolgearGraphicsDebug::
	call LoadActiveFrameGraphics
	ld hl, wTimeOfDayDebugFlags
	bit TOOLGEAR_COORDS_F, [hl]
	jr z, .loadToolgearGraphics
	ld hl, vChars2 tile $66
	ld de, FontGFX + ('０' - 'ア') * LEN_1BPP_TILE
	lb bc, BANK(FontGFX), '９' - '０' + 1
	call Get1bpp
	ld hl, vChars2 tile $70
	ld de, FontExtraAB_GFX
	lb bc, BANK(FontExtraAB_GFX), 'Ｆ' - 'Ａ' + 1
	call Get2bpp
	ret

.loadToolgearGraphics::
	ld hl, vChars2 tile $66
	ld de, FontGFX + ('０' - 'ア') * LEN_1BPP_TILE
	lb bc, BANK(FontGFX), '９' - '０' + 1
	call Get1bpp
	ld hl, vChars2 tile $70
	ld de, TrainerCardColonGFX
	lb bc, BANK(TrainerCardColonGFX), 1 ; tile
	call Get2bpp
	ld hl, vChars2 tile $71
	ld de, HUD_GFX
	lb bc, BANK(HUD_GFX), (HUD_GFX.End - HUD_GFX) / LEN_2BPP_TILE
	call Get2bpp
	ret

LoadActiveFrameGraphics::
	ld a, [wActiveFrame]
	ld bc, FrameGFX.FirstEntryEnd - FrameGFX
	ld hl, FrameGFX
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, vChars2 tile '┌' ; $79
	lb bc, BANK(FrameGFX), (FrameGFX.FirstEntryEnd - FrameGFX) / LEN_1BPP_TILE
	call Get1bpp
	ld hl, vChars2 tile '　' ; $7f
	ld de, EmptyTile1bppGFX
	lb bc, BANK(EmptyTile1bppGFX), (EmptyTile1bppGFX.End - EmptyTile1bppGFX) / LEN_1BPP_TILE
	call Get1bpp
	ret

LoadPokeDexGraphics::
	call LoadPokemonMenuGraphics
	ld de, PokedexGFX
	ld hl, vChars2 tile $60
	lb bc, BANK(PokedexGFX), 5 + (PokedexGFX.End - PokedexGFX) / LEN_2BPP_TILE ; copies first 5 tiles of TownMapGFX
	call Get2bpp
	ld de, PokeBallsGFX
	ld hl, vChars2 tile $72
	lb bc, BANK(PokeBallsGFX), 1 ; 1 of 4 tiles
	jp Get2bpp

LoadBattleFontsHPBar::
	ld de, BattleHPBarGFX
	ld hl, vChars2 tile $60
	lb bc, BANK(BattleHPBarGFX), ((BattleHPBarGFX.End - BattleHPBarGFX) / LEN_2BPP_TILE)
	call Get2bpp
	ld hl, vChars2 tile $70
	ld de, BattleMarkersGFX
	lb bc, BANK(BattleMarkersGFX), ((BattleMarkersGFX.End - BattleMarkersGFX) / LEN_2BPP_TILE)
	call Get2bpp
	call LoadActiveFrameGraphics
	; fallthrough

LoadHPBar::
	ld de, HpExpBarParts0GFX
	ld hl, vChars2 tile $6c
	lb bc, BANK(HpExpBarParts0GFX), (HpExpBarParts0GFX.End - HpExpBarParts0GFX) / LEN_1BPP_TILE
	call Get1bpp
	ld de, HpExpBarParts1GFX
	ld hl, vChars2 tile $73
	lb bc, BANK(HpExpBarParts1GFX), (HpExpBarParts3GFX.End - HpExpBarParts1GFX) / LEN_1BPP_TILE
	call Get1bpp
	ld de, ExpBarGFX
	ld hl, vChars2 tile $55
	lb bc, BANK(ExpBarGFX), (ExpBarGFX.End - ExpBarGFX) / LEN_2BPP_TILE
	call Get2bpp
	ret

LoadPokemonStatsGraphics::
	call LoadPokemonMenuGraphics
	ld de, HpExpBarParts0GFX
	ld hl, vChars2 tile $6c
	lb bc, BANK(HpExpBarParts0GFX), (HpExpBarParts0GFX.End - HpExpBarParts0GFX) / LEN_1BPP_TILE
	call Get1bpp
	ld de, HpExpBarParts1GFX
	ld hl, vChars2 tile $78
	lb bc, BANK(HpExpBarParts1GFX), 1 ; 1 of 6 tiles
	call Get1bpp
	ld de, HpExpBarParts2GFX
	ld hl, vChars2 tile $76
	lb bc, BANK(HpExpBarParts0GFX), (HpExpBarParts2GFX.End - HpExpBarParts2GFX) / LEN_1BPP_TILE
	call Get1bpp
	ld de, ExpBarGFX
	ld hl, vChars2 tile $55
	lb bc, BANK(ExpBarGFX), (ExpBarGFX.End - ExpBarGFX) / LEN_2BPP_TILE
	call Get2bpp
	; fallthrough

LoadOnlyPokemonStatsGraphics::
	ld de, StatsGFX
	ld hl, vChars2 tile $31
	lb bc, BANK(StatsGFX), (StatsGFX.End - StatsGFX) / LEN_2BPP_TILE
	call Get2bpp
	ret

LoadBackpackGraphics::
	ld de, BlackTileAndCursor1bppGFX
	ld hl, vChars2 tile '■' ; $60
	lb bc, BANK(BlackTileAndCursor1bppGFX), (BlackTileAndCursor1bppGFX.End - BlackTileAndCursor1bppGFX) / LEN_1BPP_TILE
	call Get1bpp
	ld de, PackIconGFX
	ld hl, vChars2 tile $62
	lb bc, BANK(PackIconGFX), 12 ; 12 of 15 tiles
	call Get2bpp
	ld de, FontSmallKanaPunctuationGFX
	ld hl, vChars2 tile $6e
	lb bc, BANK(FontSmallKanaPunctuationGFX), (FontSmallKanaPunctuationGFX.End - FontSmallKanaPunctuationGFX) / LEN_2BPP_TILE
	call Get2bpp
	jp LoadActiveFrameGraphics

INCLUDE "gfx/font.asm"
