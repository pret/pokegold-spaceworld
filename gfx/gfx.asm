INCLUDE "constants.asm"

SECTION "gfx.asm@Mon Nest Icon", ROMX
PokedexNestIconGFX::
INCBIN "gfx/trainer_gear/dexmap_nest_icon.1bpp"

SECTION "gfx.asm@Minor Object GFX", ROMX
UnknownBouncingOrbGFX:: INCBIN "gfx/overworld/gfx_84bf.2bpp"
.end:
JumpShadowGFX::         INCBIN "gfx/overworld/shadow.2bpp"
.end:
EmoteGFX::
ShockEmoteGFX::         INCBIN "gfx/overworld/shock.2bpp"
.end:
QuestionEmoteGFX::      INCBIN "gfx/overworld/question.2bpp"
.end:
HappyEmoteGFX::         INCBIN "gfx/overworld/happy.2bpp"
.end:
BoulderDustGFX::        INCBIN "gfx/overworld/boulder_dust.2bpp"
.end:

SECTION "gfx.asm@Trainer Gear GFX", ROMX
TrainerGearGFX::
INCBIN "gfx/trainer_gear/trainer_gear.2bpp"
RadioGFX::
INCBIN "gfx/trainer_gear/radio.2bpp"
VerticalPipeGFX::
INCBIN "gfx/trainer_gear/vertical_pipe.2bpp"

SECTION "gfx.asm@Title Screen BG Decoration Border", ROMX
TitleBGDecorationBorder::
INCBIN "gfx/title/titlebgdecoration.2bpp"

SECTION "gfx.asm@SGB GFX", ROMX

INCLUDE "data/pokemon/palettes.inc"
INCLUDE "data/sgb/super_palettes.inc"

AlternateSGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border_alt.sgb.tilemap"

AlternateSGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border_alt.pal"

AlternateSGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_alt.2bpp"

SGBBorderTilemap::
INCBIN "gfx/sgb/sgb_border.sgb.tilemap"

SGBBorderPalettes:
INCLUDE "gfx/sgb/sgb_border.pal"

SGBBorderGFX::
if DEF(GOLD)
INCBIN "gfx/sgb/sgb_border_gold.2bpp"
else
INCBIN "gfx/sgb/sgb_border_silver.2bpp"
endc

SECTION "gfx.asm@Shrink GFX", ROMX
ShrinkPic1::
INCBIN "gfx/player/shrink1.pic"
ShrinkPic2::
INCBIN "gfx/player/shrink2.pic"

SECTION "gfx.asm@Title Screen GFX", ROMX
if DEF(GOLD)
TitleScreenGFX:: INCBIN "gfx/title/title.2bpp"
TitleScreenVersionGFX:: INCBIN "gfx/title/title_gold_version.2bpp"
TitleScreenHoOhGFX:: INCBIN "gfx/title/title_hooh.2bpp"
TitleScreenLogoGFX:: INCBIN "gfx/title/title_logo.2bpp"
TitleScreenGoldLogoGFX:: INCBIN "gfx/title/title_goldlogo.2bpp"
else
TitleScreenGFX:: INCBIN "gfx/title/title.2bpp"
TitleScreenVersionGFX:: INCBIN "gfx/title/title_silver_version.2bpp"
TitleScreenHoOhGFX:: INCBIN "gfx/title/title_hooh.2bpp"
TitleScreenLogoGFX:: INCBIN "gfx/title/title_logo.2bpp"
TitleScreenGoldLogoGFX:: INCBIN "gfx/title/title_silverlogo.2bpp"
endc

SECTION "gfx.asm@Name Entry Extra Tiles", ROMX
TextScreenGFX_End::
INCBIN "gfx/font/text_entry_end.1bpp"
TextScreenGFX_Hyphen::
INCBIN "gfx/font/text_entry_hyphen.1bpp"
TextScreenGFX_Underscore::
INCBIN "gfx/font/text_entry_underscore.1bpp"

SECTION "gfx.asm@Mail Icon GFX", ROMX
MailIconGFX::
INCBIN "gfx/icons/mail.2bpp"

SECTION "gfx.asm@Trainer Card GFX", ROMX
TrainerCardBorderGFX:: INCBIN "gfx/trainer_card/border.2bpp"
TrainerCardGFX:: INCBIN "gfx/trainer_card/trainer_card.2bpp"
TrainerCardColonGFX:: INCBIN "gfx/trainer_card/colon.2bpp"
TrainerCardIDNoGFX:: INCBIN "gfx/trainer_card/id_no.2bpp"
.End::
TrainerCardLeadersGFX:: INCBIN "gfx/trainer_card/leaders.2bpp"
	db $18, $00 ; leftover of previous graphics
Unreferenced_UnusedLeaderNameGFX:: INCBIN "gfx/trainer_card/unused_leader_name.2bpp"

SECTION "gfx.asm@Bank 6 Tilesets Silent Hill", ROMX
SilentHill_GFX:
Forest_GFX:
INCBIN "gfx/tilesets/silent_hill.common.2bpp"
SilentHill_Meta:
INCBIN "data/tilesets/silent_hill_metatiles.bin"
SilentHill_Coll:
INCLUDE "data/tilesets/silent_hill_collision.inc"

SECTION "gfx.asm@Bank 6 Tilesets Forest", ROMX
Forest_Meta:
INCBIN "data/tilesets/forest_metatiles.bin"
Forest_Coll:
INCLUDE "data/tilesets/forest_collision.inc"

SECTION "gfx.asm@Bank 6 Tilesets Old City", ROMX
OldCity_GFX:
INCBIN "gfx/tilesets/old_city.common.2bpp"
OldCity_Meta:
INCBIN "data/tilesets/old_city_metatiles.bin"
OldCity_Coll:
INCLUDE "data/tilesets/old_city_collision.inc"

SECTION "gfx.asm@Bank 6 Tilesets West", ROMX
West_GFX:
INCBIN "gfx/tilesets/west.common.2bpp"
West_Meta:
INCBIN "data/tilesets/west_metatiles.bin"
West_Coll:
INCLUDE "data/tilesets/west_collision.inc"

SECTION "gfx.asm@Bank 6 Tilesets House", ROMX
House_GFX:
INCBIN "gfx/tilesets/house.2bpp"
House_Meta:
INCBIN "data/tilesets/house_metatiles.bin"
House_Coll:
INCLUDE "data/tilesets/house_collision.inc"

SECTION "gfx.asm@Bank 7 Tilesets Rocket House", ROMX
RocketHouse_GFX:
INCBIN "gfx/tilesets/rocket_house.2bpp"
RocketHouse_Meta:
INCBIN "data/tilesets/rocket_house_metatiles.bin"
RocketHouse_Coll:
INCLUDE "data/tilesets/rocket_house_collision.inc"

SECTION "gfx.asm@Bank 7 Tilesets Aquarium", ROMX
Aquarium_GFX:
INCBIN "gfx/tilesets/aquarium.2bpp"
Aquarium_Meta:
INCBIN "data/tilesets/aquarium_metatiles.bin"
Aquarium_Coll:
INCLUDE "data/tilesets/aquarium_collision.inc"

SECTION "gfx.asm@Bank 7 Tilesets North", ROMX
North_GFX:
INCBIN "gfx/tilesets/north.common.2bpp"
North_Meta:
INCBIN "data/tilesets/north_metatiles.bin"
North_Coll:
INCLUDE "data/tilesets/north_collision.inc"

SECTION "gfx.asm@Bank 7 Tilesets Font", ROMX
Font_GFX:
INCBIN "gfx/tilesets/font.common.2bpp"
Font_Meta:
INCBIN "data/tilesets/font_metatiles.bin"
Font_Coll:
INCLUDE "data/tilesets/font_collision.inc"

SECTION "gfx.asm@Bank 7 Tilesets HighTech", ROMX
HighTech_GFX:
INCBIN "gfx/tilesets/hightech.common.2bpp"
HighTech_Meta:
INCBIN "data/tilesets/hightech_metatiles.bin"
HighTech_Coll:
INCLUDE "data/tilesets/hightech_collision.inc"

SECTION "gfx.asm@Bank 8 Tilesets Birdon", ROMX
Birdon_GFX:
INCBIN "gfx/tilesets/birdon.common.2bpp"
Birdon_Meta:
INCBIN "data/tilesets/birdon_metatiles.bin"
Birdon_Coll:
INCLUDE "data/tilesets/birdon_collision.inc"

SECTION "gfx.asm@Bank 8 Tilesets Kanto", ROMX
Kanto_GFX:
INCBIN "gfx/tilesets/kanto.common.2bpp"
Kanto_Meta:
INCBIN "data/tilesets/kanto_metatiles.bin"
Kanto_Coll:
INCLUDE "data/tilesets/kanto_collision.inc"

SECTION "gfx.asm@Bank 8 Tilesets South", ROMX
South_GFX:
INCBIN "gfx/tilesets/south.common.2bpp"
South_Meta:
INCBIN "data/tilesets/south_metatiles.bin"
South_Coll:
INCLUDE "data/tilesets/south_collision.inc"

SECTION "gfx.asm@Bank 8 Tilesets Tower", ROMX
Tower_GFX:
INCBIN "gfx/tilesets/tower.2bpp"
Tower_Meta:
INCBIN "data/tilesets/tower_metatiles.bin"
Tower_Coll:
INCLUDE "data/tilesets/tower_collision.inc"

SECTION "gfx.asm@Bank 8 Tilesets Gate", ROMX
Gate_GFX:
INCBIN "gfx/tilesets/gate.2bpp"
Gate_Meta:
INCBIN "data/tilesets/gate_metatiles.bin"
Gate_Coll:
INCLUDE "data/tilesets/gate_collision.inc"

SECTION "gfx.asm@Gameboy GFX", ROMX
TradeGameBoyGFX::
INCBIN "gfx/trade/gameboy.2bpp"

SECTION "gfx.asm@Bank C Tilesets Radio Tower", ROMX
RadioTower_GFX:
INCBIN "gfx/tilesets/radio_tower.2bpp"
RadioTower_Meta:
INCBIN "data/tilesets/radio_tower_metatiles.bin"
RadioTower_Coll:
INCLUDE "data/tilesets/radio_tower_collision.inc"

SECTION "gfx.asm@Bank C Tilesets Traditional House", ROMX
TraditionalHouse_GFX:
INCBIN "gfx/tilesets/traditional_house.2bpp"
TraditionalHouse_Meta:
INCBIN "data/tilesets/traditional_house_metatiles.bin"
TraditionalHouse_Coll:
INCLUDE "data/tilesets/traditional_house_collision.inc"

SECTION "gfx.asm@Bank C Tilesets Mart", ROMX
Mart_GFX:
INCBIN "gfx/tilesets/mart.2bpp"
Mart_Meta:
INCBIN "data/tilesets/mart_metatiles.bin"
Mart_Coll:
INCLUDE "data/tilesets/mart_collision.inc"

SECTION "gfx.asm@Bank C Tilesets Gym", ROMX
Gym_GFX:
INCBIN "gfx/tilesets/gym.2bpp"
Gym_Meta:
INCBIN "data/tilesets/gym_metatiles.bin"
Gym_Coll:
INCLUDE "data/tilesets/gym_collision.inc"

SECTION "gfx.asm@Bank C Tilesets Pokecenter", ROMX
Pokecenter_GFX:
INCBIN "gfx/tilesets/pokecenter.2bpp"
Pokecenter_Meta:
INCBIN "data/tilesets/pokecenter_metatiles.bin"
Pokecenter_Coll:
INCLUDE "data/tilesets/pokecenter_collision.inc"

SECTION "gfx.asm@Bank C Tilesets Common", ROMX
CommonExteriorTilesGFX:
INCBIN "gfx/tilesets/common.2bpp"

SECTION "gfx.asm@Pokedex GFX", ROMX
PokedexButtonsGFX::
INCBIN "gfx/pokedex/buttons.2bpp"
PokedexPokeBallGFX::
INCBIN "gfx/pokedex/poke_ball.2bpp"
PokedexCursorGFX::
INCBIN "gfx/pokedex/cursor.2bpp"
PokedexBorderGFX::
INCBIN "gfx/pokedex/border.2bpp"
PokedexSearchGFX::
INCBIN "gfx/pokedex/search.2bpp"

SECTION "gfx.asm@Trainer Battle Sprites", ROMX
HayatoPic:: INCBIN "gfx/trainer/hayato.pic"
AkanePic:: INCBIN "gfx/trainer/akane.pic" ; Gen 1 Bug Catcher
TsukushiPic:: INCBIN "gfx/trainer/tsukushi.pic"
EnokiPic:: INCBIN "gfx/trainer/enoki.pic"
OkeraPic:: INCBIN "gfx/trainer/okera.pic" ; Gen 1 Police Female
MikanPic:: INCBIN "gfx/trainer/mikan.pic"
BluePic:: INCBIN "gfx/trainer/blue.pic"	; Gen 1 Pokemaniac
GamaPic:: INCBIN "gfx/trainer/gama.pic" ; Gen 1 Super Nerd
RivalPic:: INCBIN "gfx/trainer/rival.pic"
OakPic:: INCBIN "gfx/trainer/oak.pic"
ProtagonistPic:: INCBIN "gfx/trainer/protagonist.pic"
KurtPic:: INCBIN "gfx/trainer/kurt.pic"
YoungsterPic:: INCBIN "gfx/trainer/youngster.pic"
SchoolboyPic:: INCBIN "gfx/trainer/schoolboy.pic"
FledglingPic:: INCBIN "gfx/trainer/fledgling.pic"
LassPic:: INCBIN "gfx/trainer/lass.pic"
ProfessionalMPic:: INCBIN "gfx/trainer/professional_m.pic"
ProfessionalFPic:: INCBIN "gfx/trainer/professional_f.pic"
BeautyPic:: INCBIN "gfx/trainer/beauty.pic"
PokemaniacPic:: INCBIN "gfx/trainer/pokemaniac.pic"
RocketMPic:: INCBIN "gfx/trainer/rocket_m.pic"
TeacherMPic:: INCBIN "gfx/trainer/teacher_m.pic"
TeacherFPic:: INCBIN "gfx/trainer/teacher_f.pic"
BugCatcherBoyPic:: INCBIN "gfx/trainer/bug_catcher_boy.pic"
FisherPic:: INCBIN "gfx/trainer/fisher.pic"
SwimmerMPic:: INCBIN "gfx/trainer/swimmer_m.pic"
SwimmerFPic:: INCBIN "gfx/trainer/swimmer_f.pic"
SuperNerdPic:: INCBIN "gfx/trainer/supernerd.pic"
EngineerPic:: INCBIN "gfx/trainer/engineer.pic"
GreenPic:: INCBIN "gfx/trainer/green.pic" ; Gen 1 Green
BikerPic:: INCBIN "gfx/trainer/biker.pic"
BurglarPic:: INCBIN "gfx/trainer/burglar.pic"
FirebreatherPic:: INCBIN "gfx/trainer/firebreather.pic"
JugglerPic:: INCBIN "gfx/trainer/juggler.pic"
BlackbeltPic:: INCBIN "gfx/trainer/blackbelt.pic"
SportsmanPic:: INCBIN "gfx/trainer/sportsman.pic"
MediumPic:: INCBIN "gfx/trainer/medium.pic"
SoldierPic:: INCBIN "gfx/trainer/soldier.pic"
KimonoGirlPic:: INCBIN "gfx/trainer/kimonogirl.pic"
TwinsPic:: INCBIN "gfx/trainer/twins.pic"


SECTION "gfx.asm@Bank 13 Tilesets Lab", ROMX
Lab_GFX:
INCBIN "gfx/tilesets/lab.2bpp"
Lab_Meta:
INCBIN "data/tilesets/lab_metatiles.bin"
Lab_Coll:
INCLUDE "data/tilesets/lab_collision.inc"

SECTION "gfx.asm@Bank 13 Tilesets Ruins Of Alph", ROMX
RuinsOfAlph_GFX:
INCBIN "gfx/tilesets/ruins_of_alph.2bpp"
RuinsOfAlph_Meta:
INCBIN "data/tilesets/ruins_of_alph_metatiles.bin"
RuinsOfAlph_Coll:
INCLUDE "data/tilesets/ruins_of_alph_collision.inc"

SECTION "gfx.asm@Bank 13 Tilesets Ship", ROMX
Ship_GFX:
INCBIN "gfx/tilesets/ship.common.2bpp"
Ship_Meta:
INCBIN "data/tilesets/ship_metatiles.bin"
Ship_Coll:
INCLUDE "data/tilesets/ship_collision.inc"

SECTION "gfx.asm@Bank 13 Tilesets Ship Port", ROMX
ShipPort_GFX:
INCBIN "gfx/tilesets/ship_port.common.2bpp"
ShipPort_Meta:
INCBIN "data/tilesets/ship_port_metatiles.bin"
ShipPort_Coll:
INCLUDE "data/tilesets/ship_port_collision.inc"

SECTION "gfx.asm@PKMN Sprite Bank List", ROMX
INCLUDE "gfx/pokemon/pkmn_pic_banks.inc"

INCLUDE "gfx/pokemon/pkmn_pics.inc"


SECTION "gfx.asm@Annon Pic Ptrs and Pics", ROMX
INCLUDE "gfx/pokemon/annon_pic_ptrs.inc"
INCLUDE "gfx/pokemon/annon_pics.inc"

INCLUDE "gfx/pokemon/egg.inc"

SECTION "gfx.asm@Attack Animation GFX", ROMX

AnimObj00GFX:
AnimObjHitGFX:       INCBIN "gfx/battle_anims/hit.2bpp"
AnimObjCutGFX:       INCBIN "gfx/battle_anims/cut.2bpp"
AnimObjFireGFX:      INCBIN "gfx/battle_anims/fire.2bpp"
AnimObjWaterGFX:     INCBIN "gfx/battle_anims/water.2bpp"
AnimObjLightningGFX: INCBIN "gfx/battle_anims/lightning.2bpp"
AnimObjSmokeGFX:     INCBIN "gfx/battle_anims/smoke.2bpp"
AnimObjExplosionGFX: INCBIN "gfx/battle_anims/explosion.2bpp"
AnimObjIceGFX:       INCBIN "gfx/battle_anims/ice.2bpp"
AnimObjRocksGFX:     INCBIN "gfx/battle_anims/rocks.2bpp"
AnimObjPoisonGFX:    INCBIN "gfx/battle_anims/poison.2bpp"
AnimObjPlantGFX:     INCBIN "gfx/battle_anims/plant.2bpp"
AnimObjPokeBallGFX:  INCBIN "gfx/battle_anims/pokeball.2bpp"
AnimObjBubbleGFX:    INCBIN "gfx/battle_anims/bubble.2bpp"
AnimObjNoiseGFX:     INCBIN "gfx/battle_anims/noise.2bpp"
AnimObjReflectGFX:   INCBIN "gfx/battle_anims/reflect.2bpp"
AnimObjPowderGFX:    INCBIN "gfx/battle_anims/powder.2bpp"
AnimObjBeamGFX:      INCBIN "gfx/battle_anims/beam.2bpp"
AnimObjSpeedGFX:     INCBIN "gfx/battle_anims/speed.2bpp"
AnimObjChargeGFX:    INCBIN "gfx/battle_anims/charge.2bpp"
AnimObjWindGFX:      INCBIN "gfx/battle_anims/wind.2bpp"
AnimObjWhipGFX:      INCBIN "gfx/battle_anims/whip.2bpp"
AnimObjRopeGFX:      INCBIN "gfx/battle_anims/rope.2bpp"
AnimObjEggGFX:       INCBIN "gfx/battle_anims/egg.2bpp"
AnimObjPsychicGFX:   INCBIN "gfx/battle_anims/psychic.2bpp"
AnimObjSandGFX:      INCBIN "gfx/battle_anims/sand.2bpp"
AnimObjWebGFX:       INCBIN "gfx/battle_anims/web.2bpp"
AnimObjHazeGFX:      INCBIN "gfx/battle_anims/haze.2bpp"
AnimObjHornGFX:      INCBIN "gfx/battle_anims/horn.2bpp"
AnimObjFlowerGFX:    INCBIN "gfx/battle_anims/flower.2bpp"
AnimObjMiscGFX:      
PointerGFX:          INCBIN "gfx/battle_anims/pointer.2bpp"
					 INCBIN "gfx/battle_anims/misc.2bpp"
AnimObjSkyAttackGFX: INCBIN "gfx/battle_anims/skyattack.2bpp"
AnimObjGlobeGFX:     INCBIN "gfx/battle_anims/globe.2bpp"
AnimObjShapesGFX:    INCBIN "gfx/battle_anims/shapes.2bpp"
AnimObjStatusGFX:    INCBIN "gfx/battle_anims/status.2bpp"
AnimObjObjectsGFX:   INCBIN "gfx/battle_anims/objects.2bpp"
AnimObjShineGFX:     INCBIN "gfx/battle_anims/shine.2bpp"
AnimObjAngelsGFX:    INCBIN "gfx/battle_anims/angels.2bpp"
	                 ;INCBIN "gfx/battle_anims/destinybond.2bpp"

SECTION "gfx.asm@Pokemon Party Sprites", ROMX
MenuMonIconGFX::
PoliwagIcon:: INCBIN "gfx/icons/poliwag.2bpp"
JigglypuffIcon:: INCBIN "gfx/icons/jigglypuff.2bpp"
DiglettIcon:: INCBIN "gfx/icons/diglett.2bpp"
PikachuIcon:: INCBIN "gfx/icons/pikachu.2bpp"
StaryuIcon:: INCBIN "gfx/icons/staryu.2bpp"
MagikarpIcon:: INCBIN "gfx/icons/magikarp.2bpp"
PidgeyIcon:: INCBIN "gfx/icons/pidgey.2bpp"
RhydonIcon:: INCBIN "gfx/icons/rhydon.2bpp"
ClefairyIcon:: INCBIN "gfx/icons/clefairy.2bpp"
OddishIcon:: INCBIN "gfx/icons/oddish.2bpp"
MushiIcon:: INCBIN "gfx/icons/mushi.2bpp"
GengarIcon:: INCBIN "gfx/icons/gengar.2bpp"
LaprasIcon:: INCBIN "gfx/icons/lapras.2bpp"
MrMimeIcon:: INCBIN "gfx/icons/mrmime.2bpp"
LokonIcon:: INCBIN "gfx/icons/lokon.2bpp"
TaurosIcon:: INCBIN "gfx/icons/tauros.2bpp"
ShellderIcon:: INCBIN "gfx/icons/shellder.2bpp"
DittoIcon:: INCBIN "gfx/icons/ditto.2bpp"
OnixIcon:: INCBIN "gfx/icons/onix.2bpp"
VoltorbIcon:: INCBIN "gfx/icons/voltorb.2bpp"
SquirtleIcon:: INCBIN "gfx/icons/squirtle.2bpp"
BulbasaurIcon:: INCBIN "gfx/icons/bulbasaur.2bpp"
CharmanderIcon:: INCBIN "gfx/icons/charmander.2bpp"
WeedleIcon:: INCBIN "gfx/icons/weedle.2bpp"
AnnonIcon:: INCBIN "gfx/icons/annon.2bpp"
GeodudeIcon:: INCBIN "gfx/icons/geodude.2bpp"
MachopIcon:: INCBIN "gfx/icons/machop.2bpp"
EggIcon:: INCBIN "gfx/icons/egg.2bpp"
TentacoolIcon:: INCBIN "gfx/icons/tentacool.2bpp"
ButterfreeIcon:: INCBIN "gfx/icons/butterfree.2bpp"
ZubatIcon:: INCBIN "gfx/icons/zubat.2bpp"
SnorlaxIcon:: INCBIN "gfx/icons/snorlax.2bpp"

SECTION "gfx.asm@Slot Machine GFX", ROMX
SlotMachineGFX::
INCBIN "gfx/minigames/slots_1.2bpp"
SlotMachine2GFX::
INCBIN "gfx/minigames/slots_2.2bpp"
INCBIN "gfx/minigames/slots_3.2bpp"
SlotMachine3GFX::
INCBIN "gfx/minigames/slots_4.2bpp"

SECTION "gfx.asm@Bank 30 Sprites 1", ROMX
GoldSpriteGFX:: INCBIN "gfx/sprites/gold.2bpp"
GoldBikeSpriteGFX:: INCBIN "gfx/sprites/gold_bike.2bpp"
GoldSkateboardSpriteGFX:: INCBIN "gfx/sprites/gold_skateboard.2bpp"
SilverSpriteGFX:: INCBIN "gfx/sprites/silver.2bpp"
OkidoSpriteGFX:: INCBIN "gfx/sprites/okido.2bpp"
RedSpriteGFX:: INCBIN "gfx/sprites/red.2bpp"
BlueSpriteGFX:: INCBIN "gfx/sprites/blue.2bpp"
MasakiSpriteGFX:: INCBIN "gfx/sprites/masaki.2bpp"
ElderSpriteGFX:: INCBIN "gfx/sprites/elder.2bpp"
SakakiSpriteGFX:: INCBIN "gfx/sprites/sakaki.2bpp"
GantetsuSpriteGFX:: INCBIN "gfx/sprites/gantetsu.2bpp"
MomSpriteGFX:: INCBIN "gfx/sprites/mom.2bpp"
SilversMomSpriteGFX:: INCBIN "gfx/sprites/silvers_mom.2bpp"
RedsMomSpriteGFX:: INCBIN "gfx/sprites/reds_mom.2bpp"
NanamiSpriteGFX:: INCBIN "gfx/sprites/nanami.2bpp"
EvilOkidoSpriteGFX:: INCBIN "gfx/sprites/evil_okido.2bpp"
KikukoSpriteGFX:: INCBIN "gfx/sprites/kikuko.2bpp"
HayatoSpriteGFX:: INCBIN "gfx/sprites/hayato.2bpp"
TsukushiSpriteGFX:: INCBIN "gfx/sprites/tsukushi.2bpp"
EnokiSpriteGFX:: INCBIN "gfx/sprites/enoki.2bpp"
MikanSpriteGFX:: INCBIN "gfx/sprites/mikan.2bpp"
CooltrainerMSpriteGFX:: INCBIN "gfx/sprites/cooltrainer_m.2bpp"
CooltrainerFSpriteGFX:: INCBIN "gfx/sprites/cooltrainer_f.2bpp"
BugCatcherBoySpriteGFX:: INCBIN "gfx/sprites/bug_catcher_boy.2bpp"
TwinSpriteGFX:: INCBIN "gfx/sprites/twin.2bpp"
YoungsterSpriteGFX:: INCBIN "gfx/sprites/youngster.2bpp"
LassSpriteGFX:: INCBIN "gfx/sprites/lass.2bpp"
TeacherSpriteGFX:: INCBIN "gfx/sprites/teacher.2bpp"
GirlSpriteGFX:: INCBIN "gfx/sprites/girl.2bpp"
SuperNerdSpriteGFX:: INCBIN "gfx/sprites/super_nerd.2bpp"
RockerSpriteGFX:: INCBIN "gfx/sprites/rocker.2bpp"
PokefanMSpriteGFX:: INCBIN "gfx/sprites/pokefan_m.2bpp"
PokefanFSpriteGFX:: INCBIN "gfx/sprites/pokefan_f.2bpp"
GrampsSpriteGFX:: INCBIN "gfx/sprites/gramps.2bpp"
.end:
GrannySpriteGFX:: INCBIN "gfx/sprites/granny.2bpp"
SwimmerMSpriteGFX:: INCBIN "gfx/sprites/swimmer_m.2bpp"
SwimmerFSpriteGFX:: INCBIN "gfx/sprites/swimmer_f.2bpp"
RocketMSpriteGFX:: INCBIN "gfx/sprites/rocket_m.2bpp"
RocketFSpriteGFX:: INCBIN "gfx/sprites/rocket_f.2bpp"
NurseSpriteGFX:: INCBIN "gfx/sprites/nurse.2bpp"
LinkReceptionistSpriteGFX:: INCBIN "gfx/sprites/link_receptionist.2bpp"
ClerkSpriteGFX:: INCBIN "gfx/sprites/clerk.2bpp"
FisherSpriteGFX:: INCBIN "gfx/sprites/fisher.2bpp"
FishingGuruSpriteGFX:: INCBIN "gfx/sprites/fishing_guru.2bpp"

SECTION "gfx.asm@Bank 31 Sprites 2", ROMX
ScientistSpriteGFX:: INCBIN "gfx/sprites/scientist.2bpp"
MediumSpriteGFX:: INCBIN "gfx/sprites/medium.2bpp"
SageSpriteGFX:: INCBIN "gfx/sprites/sage.2bpp"
FrowningManSpriteGFX:: INCBIN "gfx/sprites/frowning_man.2bpp"
GentlemanSpriteGFX:: INCBIN "gfx/sprites/gentleman.2bpp"
BlackbeltSpriteGFX:: INCBIN "gfx/sprites/blackbelt.2bpp"
ReceptionistSpriteGFX:: INCBIN "gfx/sprites/receptionist.2bpp"
OfficerSpriteGFX:: INCBIN "gfx/sprites/officer.2bpp"
CaptainSpriteGFX:: INCBIN "gfx/sprites/captain.2bpp"
MohawkSpriteGFX:: INCBIN "gfx/sprites/mohawk.2bpp"
GymGuySpriteGFX:: INCBIN "gfx/sprites/gym_guy.2bpp"
SailorSpriteGFX:: INCBIN "gfx/sprites/sailor.2bpp"
HelmetSpriteGFX:: INCBIN "gfx/sprites/helmet.2bpp"
BurglarSpriteGFX:: INCBIN "gfx/sprites/burglar.2bpp"
RhydonSpriteGFX:: INCBIN "gfx/sprites/rhydon.2bpp"
ClefairySpriteGFX:: INCBIN "gfx/sprites/clefairy.2bpp"
.end:
PidgeySpriteGFX:: INCBIN "gfx/sprites/pidgey.2bpp"
CharizardSpriteGFX:: INCBIN "gfx/sprites/charizard.2bpp"
SnorlaxSpriteGFX:: INCBIN "gfx/sprites/snorlax.2bpp"
SeelSpriteGFX:: INCBIN "gfx/sprites/seel.2bpp"
PoliwrathSpriteGFX:: INCBIN "gfx/sprites/poliwrath.2bpp"
LaprasSpriteGFX:: INCBIN "gfx/sprites/lapras.2bpp"
PokeBallSpriteGFX:: INCBIN "gfx/sprites/poke_ball.2bpp"
PokedexSpriteGFX:: INCBIN "gfx/sprites/pokedex.2bpp"
PaperSpriteGFX:: INCBIN "gfx/sprites/paper.2bpp"
OldLinkReceptionistSpriteGFX:: INCBIN "gfx/sprites/old_link_receptionist.2bpp"
EggSpriteGFX:: INCBIN "gfx/sprites/egg.2bpp"
BoulderSpriteGFX:: INCBIN "gfx/sprites/boulder.2bpp"

SECTION "gfx.asm@Bank 37 Tilesets Dept Store", ROMX
DeptStore_GFX:
INCBIN "gfx/tilesets/dept_store.2bpp"
DeptStore_Meta:
INCBIN "data/tilesets/dept_store_metatiles.bin"
DeptStore_Coll:
INCLUDE "data/tilesets/dept_store_collision.inc"

SECTION "gfx.asm@Bank 37 Tilesets Office", ROMX
Office_GFX:
INCBIN "gfx/tilesets/office.2bpp"
Office_Meta:
INCBIN "data/tilesets/office_metatiles.bin"
Office_Coll:
INCLUDE "data/tilesets/office_collision.inc"

SECTION "gfx.asm@Bank 37 Tilesets Cave", ROMX
Cave_GFX:
INCBIN "gfx/tilesets/cave.2bpp"
Cave_Meta:
INCBIN "data/tilesets/cave_metatiles.bin"
Cave_Coll:
INCLUDE "data/tilesets/cave_collision.inc"

SECTION "gfx.asm@Bank 37 Tilesets Power Plant", ROMX
PowerPlant_GFX:
INCBIN "gfx/tilesets/power_plant.2bpp"
PowerPlant_Meta:
INCBIN "data/tilesets/power_plant_metatiles.bin"
PowerPlant_Coll:
INCLUDE "data/tilesets/power_plant_collision.inc"

SECTION "gfx.asm@Poker GFX", ROMX
PokerGFX::
INCBIN "gfx/minigames/poker.2bpp"

SECTION "gfx.asm@15 Puzzle GFX", ROMX
FifteenPuzzleGFX::
INCBIN "gfx/minigames/15_puzzle.2bpp"

SECTION "gfx.asm@Matches GFX", ROMX
MemoryGameGFX::
INCBIN "gfx/minigames/matches.2bpp"

SECTION "gfx.asm@Picross GFX", ROMX
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

SECTION "gfx.asm@Gamefreak Logo GFX", ROMX
GameFreakLogoGFX::
INCBIN "gfx/splash/game_freak_logo.1bpp"
GameFreakLogoSparkleGFX::
INCBIN "gfx/splash/game_freak_logo_oam.2bpp"

SECTION "gfx.asm@Intro Underwater GFX", ROMX
IntroUnderwaterGFX::
INCBIN "gfx/intro/underwater.2bpp"
Intro_WaterTilemap::
INCBIN "gfx/intro/water_tilemap.bin"
Intro_WaterMeta::
INCBIN "gfx/intro/water.bin"
IntroWaterPokemonGFX::
INCBIN "gfx/intro/water_pokemon.2bpp"

SECTION "gfx.asm@Intro Forest GFX", ROMX
IntroForestGFX::
INCBIN "gfx/intro/forest.2bpp"
IntroForestLogGFX::
INCBIN "gfx/intro/forest_log.2bpp"
Intro_GrassTilemap::
INCBIN "gfx/intro/forest_tilemap.bin"
Intro_GrassMeta::
INCBIN "gfx/intro/forest.bin"

SECTION "gfx.asm@Intro Mon", ROMX
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

SECTION "gfx.asm@Misc GFX", ROMX
FontExtraGFX::
FontExtraAB_GFX:: INCBIN "gfx/font/font_extra.ab.2bpp"
FontExtraCDEFGHIVSLM_GFX:: INCBIN "gfx/font/font_extra.cdefghivslm.2bpp"
FontSmallKanaPunctuationGFX:: INCBIN "gfx/font/small_kana_punctuation.2bpp"
.End::
Unreferenced_DefaultFrame0GFX:: INCBIN "gfx/frames/1.2bpp"
FontGFX:: INCBIN "gfx/font/font.1bpp"
.End::
FontBattleExtraGFX::
BattleHPBarGFX:: INCBIN "gfx/battle/hp_bar.2bpp"
.End::
HpExpBarParts0_2bppGFX:: INCBIN "gfx/battle/hp_exp_bar_parts0.2bpp"
BattleMarkersGFX:: INCBIN "gfx/battle/markers.2bpp"
.End::
LevelUpGFX:: INCBIN "gfx/battle/levelup.2bpp"
.End::

Unreferenced_DefaultFrame1:: INCBIN "gfx/frames/1.2bpp"

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

SECTION "gfx.asm@Town Map Cursor", ROMX
TownMapCursorGFX::
INCBIN "gfx/trainer_gear/town_map_cursor.2bpp"
