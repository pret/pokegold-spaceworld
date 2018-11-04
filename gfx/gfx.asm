INCLUDE "constants.asm"

SECTION "gfx.asm@Mon Nest Icon", ROMX
PokedexNestIconGFX::
INCBIN "gfx/trainer_gear/dexmap_nest_icon.1bpp"

SECTION "gfx.asm@Bank 2 Misc GFX", ROMX
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

SECTION "gfx.asm@Bank 6 Tilesets 00", ROMX
Tileset_00_GFX:
Tileset_1b_GFX:
INCBIN "gfx/tilesets/tileset_00.common.2bpp"
Tileset_00_Meta:
INCBIN "data/tilesets/tileset_00_metatiles.bin"
Tileset_00_Coll:
INCBIN "data/tilesets/tileset_00_collision.bin"

SECTION "gfx.asm@Bank 6 Tilesets 1b", ROMX
Tileset_1b_Meta:
INCBIN "data/tilesets/tileset_1b_metatiles.bin"
Tileset_1b_Coll:
INCBIN "data/tilesets/tileset_1b_collision.bin"

SECTION "gfx.asm@Bank 6 Tilesets 01", ROMX
Tileset_01_GFX:
INCBIN "gfx/tilesets/tileset_01.common.2bpp"
Tileset_01_Meta:
INCBIN "data/tilesets/tileset_01_metatiles.bin"
Tileset_01_Coll:
INCBIN "data/tilesets/tileset_01_collision.bin"

SECTION "gfx.asm@Bank 6 Tilesets 02", ROMX
Tileset_02_GFX:
INCBIN "gfx/tilesets/tileset_02.common.2bpp"
Tileset_02_Meta:
INCBIN "data/tilesets/tileset_02_metatiles.bin"
Tileset_02_Coll:
INCBIN "data/tilesets/tileset_02_collision.bin"

SECTION "gfx.asm@Bank 6 Tilesets 09", ROMX
Tileset_09_GFX:
INCBIN "gfx/tilesets/tileset_09.2bpp"
Tileset_09_Meta:
INCBIN "data/tilesets/tileset_09_metatiles.bin"
Tileset_09_Coll:
INCBIN "data/tilesets/tileset_09_collision.bin"

SECTION "gfx.asm@Bank 7 Tilesets 13", ROMX
Tileset_13_GFX:
INCBIN "gfx/tilesets/tileset_13.2bpp"
Tileset_13_Meta:
INCBIN "data/tilesets/tileset_13_metatiles.bin"
Tileset_13_Coll:
INCBIN "data/tilesets/tileset_13_collision.bin"

SECTION "gfx.asm@Bank 7 Tilesets 0e", ROMX
Tileset_0e_GFX:
INCBIN "gfx/tilesets/tileset_0e.2bpp"
Tileset_0e_Meta:
INCBIN "data/tilesets/tileset_0e_metatiles.bin"
Tileset_0e_Coll:
INCBIN "data/tilesets/tileset_0e_collision.bin"

SECTION "gfx.asm@Bank 7 Tilesets 06", ROMX
Tileset_06_GFX:
INCBIN "gfx/tilesets/tileset_06.common.2bpp"
Tileset_06_Meta:
INCBIN "data/tilesets/tileset_06_metatiles.bin"
Tileset_06_Coll:
INCBIN "data/tilesets/tileset_06_collision.bin"

SECTION "gfx.asm@Bank 7 Tilesets 05", ROMX
Tileset_05_GFX:
INCBIN "gfx/tilesets/tileset_05.common.2bpp"
Tileset_05_Meta:
INCBIN "data/tilesets/tileset_05_metatiles.bin"
Tileset_05_Coll:
INCBIN "data/tilesets/tileset_05_collision.bin"

SECTION "gfx.asm@Bank 7 Tilesets 03", ROMX
Tileset_03_GFX:
INCBIN "gfx/tilesets/tileset_03.common.2bpp"
Tileset_03_Meta:
INCBIN "data/tilesets/tileset_03_metatiles.bin"
Tileset_03_Coll:
INCBIN "data/tilesets/tileset_03_collision.bin"

SECTION "gfx.asm@Bank 8 Tilesets 04", ROMX
Tileset_04_GFX:
INCBIN "gfx/tilesets/tileset_04.common.2bpp"
Tileset_04_Meta:
INCBIN "data/tilesets/tileset_04_metatiles.bin"
Tileset_04_Coll:
INCBIN "data/tilesets/tileset_04_collision.bin"

SECTION "gfx.asm@Bank 8 Tilesets 07", ROMX
Tileset_07_GFX:
INCBIN "gfx/tilesets/tileset_07.common.2bpp"
Tileset_07_Meta:
INCBIN "data/tilesets/tileset_07_metatiles.bin"
Tileset_07_Coll:
INCBIN "data/tilesets/tileset_07_collision.bin"

SECTION "gfx.asm@Bank 8 Tilesets 08", ROMX
Tileset_08_GFX:
INCBIN "gfx/tilesets/tileset_08.common.2bpp"
Tileset_08_Meta:
INCBIN "data/tilesets/tileset_08_metatiles.bin"
Tileset_08_Coll:
INCBIN "data/tilesets/tileset_08_collision.bin"

SECTION "gfx.asm@Bank 8 Tilesets 0f", ROMX
Tileset_0f_GFX:
INCBIN "gfx/tilesets/tileset_0f.2bpp"
Tileset_0f_Meta:
INCBIN "data/tilesets/tileset_0f_metatiles.bin"
Tileset_0f_Coll:
INCBIN "data/tilesets/tileset_0f_collision.bin"

SECTION "gfx.asm@Bank 8 Tilesets 11", ROMX
Tileset_11_GFX:
INCBIN "gfx/tilesets/tileset_11.2bpp"
Tileset_11_Meta:
INCBIN "data/tilesets/tileset_11_metatiles.bin"
Tileset_11_Coll:
INCBIN "data/tilesets/tileset_11_collision.bin"

SECTION "gfx.asm@Gameboy GFX", ROMX
TradeGameBoyGFX::
INCBIN "gfx/trade/gameboy.2bpp"

SECTION "gfx.asm@Bank C Tilesets 12", ROMX
Tileset_12_GFX:
INCBIN "gfx/tilesets/tileset_12.2bpp"
Tileset_12_Meta:
INCBIN "data/tilesets/tileset_12_metatiles.bin"
Tileset_12_Coll:
INCBIN "data/tilesets/tileset_12_collision.bin"

SECTION "gfx.asm@Bank C Tilesets 0b", ROMX
Tileset_0b_GFX:
INCBIN "gfx/tilesets/tileset_0b.2bpp"
Tileset_0b_Meta:
INCBIN "data/tilesets/tileset_0b_metatiles.bin"
Tileset_0b_Coll:
INCBIN "data/tilesets/tileset_0b_collision.bin"

SECTION "gfx.asm@Bank C Tilesets 0d", ROMX
Tileset_0d_GFX:
INCBIN "gfx/tilesets/tileset_0d.2bpp"
Tileset_0d_Meta:
INCBIN "data/tilesets/tileset_0d_metatiles.bin"
Tileset_0d_Coll:
INCBIN "data/tilesets/tileset_0d_collision.bin"

SECTION "gfx.asm@Bank C Tilesets 14", ROMX
Tileset_14_GFX:
INCBIN "gfx/tilesets/tileset_14.2bpp"
Tileset_14_Meta:
INCBIN "data/tilesets/tileset_14_metatiles.bin"
Tileset_14_Coll:
INCBIN "data/tilesets/tileset_14_collision.bin"

SECTION "gfx.asm@Bank C Tilesets 0c", ROMX
Tileset_0c_GFX:
INCBIN "gfx/tilesets/tileset_0c.2bpp"
Tileset_0c_Meta:
INCBIN "data/tilesets/tileset_0c_metatiles.bin"
Tileset_0c_Coll:
INCBIN "data/tilesets/tileset_0c_collision.bin"

SECTION "gfx.asm@Bank C Tilesets Common", ROMX
CommonExteriorTilesGFX:
INCBIN "gfx/tilesets/common.2bpp"

SECTION "gfx.asm@PokeBalls GFX", ROMX

PokeBallsGFX:: INCBIN "gfx/misc/poke_balls.2bpp"

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


SECTION "gfx.asm@Bank 13 Tilesets 0a", ROMX
Tileset_0a_GFX:
INCBIN "gfx/tilesets/tileset_0a.2bpp"
Tileset_0a_Meta:
INCBIN "data/tilesets/tileset_0a_metatiles.bin"
Tileset_0a_Coll:
INCBIN "data/tilesets/tileset_0a_collision.bin"

SECTION "gfx.asm@Bank 13 Tilesets 16", ROMX
Tileset_16_GFX:
INCBIN "gfx/tilesets/tileset_16.2bpp"
Tileset_16_Meta:
INCBIN "data/tilesets/tileset_16_metatiles.bin"
Tileset_16_Coll:
INCBIN "data/tilesets/tileset_16_collision.bin"

SECTION "gfx.asm@Bank 13 Tilesets 19", ROMX
Tileset_19_GFX:
INCBIN "gfx/tilesets/tileset_19.2bpp"
Tileset_19_Meta:
INCBIN "data/tilesets/tileset_19_metatiles.bin"
Tileset_19_Coll:
INCBIN "data/tilesets/tileset_19_collision.bin"

SECTION "gfx.asm@Bank 13 Tilesets 1a", ROMX
Tileset_1a_GFX:
INCBIN "gfx/tilesets/tileset_1a.2bpp"
Tileset_1a_Meta:
INCBIN "data/tilesets/tileset_1a_metatiles.bin"
Tileset_1a_Coll:
INCBIN "data/tilesets/tileset_1a_collision.bin"

SECTION "gfx.asm@PKMN Sprite Bank List", ROMX
INCLUDE "gfx/pokemon/pkmn_pic_banks.inc"

INCLUDE "gfx/pokemon/pkmn_pics.inc"


SECTION "gfx.asm@Annon Pic Ptrs and Pics", ROMX
INCLUDE "gfx/pokemon/annon_pic_ptrs.inc"
INCLUDE "gfx/pokemon/annon_pics.inc"

INCLUDE "gfx/pokemon/egg.inc"

SECTION "gfx.asm@Attack Animation GFX", ROMX

INCBIN "gfx/battle_anims/attack_animations_1.2bpp"
PointerGFX::
INCBIN "gfx/battle_anims/pointer.2bpp"
INCBIN "gfx/battle_anims/attack_animations_2.2bpp"

SECTION "gfx.asm@Pokemon Party Sprites", ROMX
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

SECTION "gfx.asm@Bank 37 Tilesets 10", ROMX
Tileset_10_GFX:
INCBIN "gfx/tilesets/tileset_10.2bpp"
Tileset_10_Meta:
INCBIN "data/tilesets/tileset_10_metatiles.bin"
Tileset_10_Coll:
INCBIN "data/tilesets/tileset_10_collision.bin"

SECTION "gfx.asm@Bank 37 Tilesets 15", ROMX
Tileset_15_GFX:
INCBIN "gfx/tilesets/tileset_15.2bpp"
Tileset_15_Meta:
INCBIN "data/tilesets/tileset_15_metatiles.bin"
Tileset_15_Coll:
INCBIN "data/tilesets/tileset_15_collision.bin"

SECTION "gfx.asm@Bank 37 Tilesets 17", ROMX
Tileset_17_GFX:
INCBIN "gfx/tilesets/tileset_17.2bpp"
Tileset_17_Meta:
INCBIN "data/tilesets/tileset_17_metatiles.bin"
Tileset_17_Coll:
INCBIN "data/tilesets/tileset_17_collision.bin"

SECTION "gfx.asm@Bank 37 Tilesets 18", ROMX
Tileset_18_GFX:
INCBIN "gfx/tilesets/tileset_18.2bpp"
Tileset_18_Meta:
INCBIN "data/tilesets/tileset_18_metatiles.bin"
Tileset_18_Coll:
INCBIN "data/tilesets/tileset_18_collision.bin"

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
