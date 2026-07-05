SECTION "SGB GFX", ROMX

INCLUDE "data/pokemon/palettes.asm"
INCLUDE "data/sgb/super_palettes.asm"

if DEF(_GOLD)
AlternateSGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_alt_gold.sgb.tilemap"

AlternateSGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_alt_gold.pal"

AlternateSGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_alt.2bpp"

SGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_gold.sgb.tilemap"

SGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_gold.pal"

SGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_gold.2bpp"
endc

if DEF(_SILVER)
AlternateSGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_alt_silver.sgb.tilemap"

AlternateSGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_alt_silver.pal"

AlternateSGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_alt.2bpp"

SGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_silver.sgb.tilemap"

SGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_silver.pal"

SGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_silver.2bpp"
endc


SECTION "Shrink GFX", ROMX

ShrinkPic1::
INCBIN "gfx/player/shrink1.pic"
ShrinkPic2::
INCBIN "gfx/player/shrink2.pic"


SECTION "Title Screen GFX", ROMX

TitleScreenGFX:: INCBIN "gfx/title/title.2bpp"
if DEF(_GOLD)
TitleScreenVersionGFX:: INCBIN "gfx/title/title_gold_version.2bpp"
TitleScreenHoOhGFX:: INCBIN "gfx/title/title_hooh.2bpp"
endc
if DEF(_SILVER)
TitleScreenVersionGFX:: INCBIN "gfx/title/title_silver_version.2bpp"
TitleScreenHoOhGFX:: INCBIN "gfx/title/title_hooh.2bpp"
endc
TitleScreenLogoGFX:: INCBIN "gfx/title/title_logo.2bpp"
if DEF(_GOLD)
TitleScreenGoldLogoGFX:: INCBIN "gfx/title/title_goldlogo.2bpp"
endc
if DEF(_SILVER)
TitleScreenGoldLogoGFX:: INCBIN "gfx/title/title_silverlogo.2bpp"
endc


SECTION "Trainer Card GFX", ROMX

TrainerCardBorderGFX:: INCBIN "gfx/trainer_card/border.2bpp"
TrainerCardGFX:: INCBIN "gfx/trainer_card/trainer_card.2bpp"
TrainerCardColonGFX:: INCBIN "gfx/trainer_card/colon.2bpp"
TrainerCardIDNoGFX:: INCBIN "gfx/trainer_card/id_no.2bpp"
.End::
TrainerCardLeadersGFX:: INCBIN "gfx/trainer_card/leaders.2bpp"


SECTION "Attack Animation GFX", ROMX

AnimObj00GFX::
AnimObjHitGFX::       INCBIN "gfx/battle_anims/hit.2bpp"
AnimObjCutGFX::       INCBIN "gfx/battle_anims/cut.2bpp"
AnimObjFireGFX::      INCBIN "gfx/battle_anims/fire.2bpp"
AnimObjWaterGFX::     INCBIN "gfx/battle_anims/water.2bpp"
AnimObjLightningGFX:: INCBIN "gfx/battle_anims/lightning.2bpp"
AnimObjSmokeGFX::     INCBIN "gfx/battle_anims/smoke.2bpp"
AnimObjExplosionGFX:: INCBIN "gfx/battle_anims/explosion.2bpp"
AnimObjIceGFX::       INCBIN "gfx/battle_anims/ice.2bpp"
AnimObjRocksGFX::     INCBIN "gfx/battle_anims/rocks.2bpp"
AnimObjPoisonGFX::    INCBIN "gfx/battle_anims/poison.2bpp"
AnimObjPlantGFX::     INCBIN "gfx/battle_anims/plant.2bpp"
AnimObjPokeBallGFX::  INCBIN "gfx/battle_anims/pokeball.2bpp"
AnimObjBubbleGFX::    INCBIN "gfx/battle_anims/bubble.2bpp"
AnimObjNoiseGFX::     INCBIN "gfx/battle_anims/noise.2bpp"
AnimObjReflectGFX::   INCBIN "gfx/battle_anims/reflect.2bpp"
AnimObjPowderGFX::    INCBIN "gfx/battle_anims/powder.2bpp"
AnimObjBeamGFX::      INCBIN "gfx/battle_anims/beam.2bpp"
AnimObjSpeedGFX::     INCBIN "gfx/battle_anims/speed.2bpp"
AnimObjChargeGFX::    INCBIN "gfx/battle_anims/charge.2bpp"
AnimObjWindGFX::      INCBIN "gfx/battle_anims/wind.2bpp"
AnimObjWhipGFX::      INCBIN "gfx/battle_anims/whip.2bpp"
AnimObjRopeGFX::      INCBIN "gfx/battle_anims/rope.2bpp"
AnimObjEggGFX::       INCBIN "gfx/battle_anims/egg.2bpp"
AnimObjPsychicGFX::   INCBIN "gfx/battle_anims/psychic.2bpp"
AnimObjSandGFX::      INCBIN "gfx/battle_anims/sand.2bpp"
AnimObjWebGFX::       INCBIN "gfx/battle_anims/web.2bpp"
AnimObjHazeGFX::      INCBIN "gfx/battle_anims/haze.2bpp"
AnimObjHornGFX::      INCBIN "gfx/battle_anims/horn.2bpp"
AnimObjFlowerGFX::    INCBIN "gfx/battle_anims/flower.2bpp"
AnimObjMiscGFX::
PointerGFX::          INCBIN "gfx/battle_anims/pointer.2bpp"
                      INCBIN "gfx/battle_anims/misc.2bpp"
AnimObjSkyAttackGFX:: INCBIN "gfx/battle_anims/skyattack.2bpp"
AnimObjGlobeGFX::     INCBIN "gfx/battle_anims/globe.2bpp"
AnimObjShapesGFX::    INCBIN "gfx/battle_anims/shapes.2bpp"
AnimObjStatusGFX::    INCBIN "gfx/battle_anims/status.2bpp"
AnimObjObjectsGFX::   INCBIN "gfx/battle_anims/objects.2bpp"
AnimObjShineGFX::     INCBIN "gfx/battle_anims/shine.2bpp"
AnimObjAngelsGFX::    INCBIN "gfx/battle_anims/angels.2bpp"
                     ;INCBIN "gfx/battle_anims/destinybond.2bpp"


SECTION "Slot Machine GFX", ROMX

SlotMachineGFX::
INCBIN "gfx/minigames/slots_1.2bpp"
SlotMachine2GFX::
INCBIN "gfx/minigames/slots_2.2bpp"
INCBIN "gfx/minigames/slots_3.2bpp"
SlotMachine3GFX::
INCBIN "gfx/minigames/slots_4.2bpp"


SECTION "Picross GFX", ROMX

PicrossNumbersGFX::
INCBIN "gfx/minigames/picross_numbers.2bpp"
PicrossBackgroundGFX::
INCBIN "gfx/minigames/picross_background.2bpp"
PicrossGridHighlightsGFX::
INCBIN "gfx/minigames/picross_highlights.2bpp"
PicrossGridGFX::
INCBIN "gfx/minigames/picross_grid.2bpp"
PicrossCursorGFX::
INCBIN "gfx/minigames/picross_cursor.2bpp"


SECTION "Intro Underwater GFX", ROMX

IntroUnderwaterGFX::
INCBIN "gfx/intro/underwater.2bpp"
Intro_WaterTilemap::
INCBIN "gfx/intro/water_tilemap.bin"
Intro_WaterMeta::
INCBIN "gfx/intro/water.bin"
IntroWaterPokemonGFX::
INCBIN "gfx/intro/water_pokemon.2bpp"


SECTION "Intro Forest GFX", ROMX

IntroForestGFX::
INCBIN "gfx/intro/forest.2bpp"
IntroForestLogGFX::
INCBIN "gfx/intro/forest_log.2bpp"
Intro_GrassTilemap::
INCBIN "gfx/intro/forest_tilemap.bin"
Intro_GrassMeta::
INCBIN "gfx/intro/forest.bin"


SECTION "Intro Mon", ROMX

IntroJigglypuffPikachuGFX::
INCBIN "gfx/intro/jigglypuff_pikachu.2bpp"
IntroCharizard1GFX::
INCBIN "gfx/intro/charizard_1.2bpp"
IntroCharizard2GFX::
INCBIN "gfx/intro/charizard_2.2bpp"
IntroCharizard3GFX::
INCBIN "gfx/intro/charizard_3.2bpp"
IntroCharizardFlamesGFX::
INCBIN "gfx/intro/charizard_flames.2bpp"
IntroBlastoiseGFX::
INCBIN "gfx/intro/blastoise.2bpp"
IntroVenusaurGFX::
INCBIN "gfx/intro/venusaur.2bpp"


SECTION "Misc GFX", ROMX

FontExtraGFX::
FontExtraAB_GFX:: INCBIN "gfx/font/font_extra.ab.2bpp"
FontExtraCDEFGHIVSLM_GFX:: INCBIN "gfx/font/font_extra.cdefghivslm.2bpp"
FontSmallKanaPunctuationGFX:: INCBIN "gfx/font/small_kana_punctuation.2bpp"
.End::
Unreferenced_DefaultFrame0GFX:: INCBIN "gfx/frames/1_alt.2bpp"
FontGFX:: INCBIN "gfx/font/font.1bpp"
.End::
FontBattleExtraGFX::
BattleHPBarGFX:: INCBIN "gfx/battle/hp_bar.2bpp"
.End::
HpExpBarParts0_2bppGFX:: INCBIN "gfx/battle/hp_exp_bar_parts0_alt.2bpp"
BattleMarkersGFX:: INCBIN "gfx/battle/markers.2bpp"
.End::
LevelUpGFX:: INCBIN "gfx/battle/levelup.2bpp"
.End::

Unreferenced_DefaultFrame1:: INCBIN "gfx/frames/1_alt.2bpp"

FrameGFX::
INCBIN "gfx/frames/1.1bpp"
.FirstEntryEnd::
INCBIN "gfx/frames/2.1bpp"
INCBIN "gfx/frames/3.1bpp"
INCBIN "gfx/frames/4.1bpp"
INCBIN "gfx/frames/5.1bpp"
INCBIN "gfx/frames/6.1bpp"
INCBIN "gfx/frames/7.1bpp"
INCBIN "gfx/frames/8.1bpp"
INCBIN "gfx/frames/9.1bpp"

StatsGFX::
INCBIN "gfx/stats/separator.2bpp"
INCBIN "gfx/stats/stats.2bpp"
.End::

HpExpBarParts0GFX:: INCBIN "gfx/battle/hp_exp_bar_parts0.1bpp"
.End::
HpExpBarParts1GFX:: INCBIN "gfx/battle/hp_exp_bar_parts1.1bpp"
.End::
HpExpBarParts2GFX:: INCBIN "gfx/battle/hp_exp_bar_parts2.1bpp"
.End::
HpExpBarParts3GFX:: INCBIN "gfx/battle/hp_exp_bar_parts3.1bpp"
.End::
ExpBarGFX:: INCBIN "gfx/battle/exp_bar.2bpp"
.End::
PokedexGFX:: INCBIN "gfx/pokedex/pokedex.2bpp"
.End::
TownMapGFX:: INCBIN "gfx/trainer_gear/town_map.2bpp"
.End::
HUD_GFX:: INCBIN "gfx/hud/hud.2bpp"
.End::
BoldAlphabetGFX:: INCBIN "gfx/font/alphabet.1bpp"
AnnonAlphabetGFX:: INCBIN "gfx/font/annon_alphabet.1bpp"
EmptyTile1bppGFX:: INCBIN "gfx/misc/empty_tile.1bpp"
.End::
BlackTileAndCursor1bppGFX:: INCBIN "gfx/misc/black_tile_cursor.1bpp"
.End::
PackIconGFX:: INCBIN "gfx/pack/pack_icons.2bpp"
.End::
