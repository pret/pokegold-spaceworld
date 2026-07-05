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
