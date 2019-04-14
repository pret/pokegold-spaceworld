INCLUDE "constants.asm"

SECTION "gfx.asm@Mon Nest Icon", ROMX
PokedexNestIconGFX::
INCBIN "gfx/trainer_gear/dexmap_nest_icon.1bpp"

SECTION "gfx.asm@Bank 2 Misc GFX", ROMX
UnknownBouncingOrbGFX::
INCBIN "gfx/overworld/gfx_84bf.2bpp"
JumpShadowGFX::
INCBIN "gfx/overworld/shadow.2bpp"
ShockEmoteGFX::
INCBIN "gfx/overworld/shock.2bpp"
QuestionEmoteGFX::
INCBIN "gfx/overworld/question.2bpp"
HappyEmoteGFX::
INCBIN "gfx/overworld/happy.2bpp"
UnknownBallGFX::
INCBIN "gfx/overworld/gfx_85cf.2bpp"

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
INCLUDE "data/super_palettes.inc"

Corrupted9e1cGFX:
INCBIN "gfx/sgb/corrupted_9e1c.2bpp"

UnusedSGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_alt.2bpp"

Corrupteda66cGFX:
INCBIN "gfx/sgb/corrupted_a66c.2bpp"

SGBBorderGFX::
if def(GOLD)
INCBIN "gfx/sgb/sgb_border_gold.2bpp"
else
INCBIN "gfx/sgb/sgb_border_silver.2bpp"
endc

SECTION "gfx.asm@Corrupted SGB GFX", ROMX

SGBBorderGoldCorruptedGFX:
INCBIN "gfx/sgb/sgb_border_gold_corrupted.2bpp"

Corruptedb1e3GFX:
INCBIN "gfx/sgb/corrupted_b1e3.2bpp"

SGBBorderSilverCorruptedGFX:
INCBIN "gfx/sgb/sgb_border_silver_corrupted.2bpp"

Corruptedba93GFX:
INCBIN "gfx/sgb/corrupted_ba93.2bpp"

SECTION "gfx.asm@Title Screen GFX", ROMX
if def(GOLD)
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
TrainerCardBorderGFX::               INCBIN "gfx/trainer_card/border.2bpp"
TrainerCardGFX::                     INCBIN "gfx/trainer_card/trainer_card.2bpp" ; 0x013171--0x013381
TrainerCardColonGFX::                INCBIN "gfx/trainer_card/colon.2bpp"        ; 0x013381--0x013391
TrainerCardIDNoGFX::                 INCBIN "gfx/trainer_card/id_no.2bpp"        ; 0x013391--0x0133B1
TrainerCardIDNoGFXEnd::
TrainerCardLeadersGFX::              INCBIN "gfx/trainer_card/leaders.2bpp"      ; 0x0133B1--0x133BA1
if DEBUG || def(GOLD)
	db $18, $00 ; leftover of previous graphics
else
    db $b2, $aa ; leftover of previous graphics?
endc

if DEBUG
; Not sure how to parse this from the non-debug ROM, so I'll leave this be for now
Unreferenced_UnusedLeaderNameGFX:: INCBIN "gfx/trainer_card/unused_leader_name.2bpp" ; 0x13ba3
endc

SECTION "gfx.asm@Bank 6 Tilesets 00", ROMX
Tileset_00_GFX:
INCBIN "gfx/tilesets/tileset_00.2bpp"

SECTION "gfx.asm@Bank 6 Tilesets 01", ROMX
Tileset_01_GFX:
INCBIN "gfx/tilesets/tileset_01.2bpp"

SECTION "gfx.asm@Bank 6 Tilesets 02", ROMX
Tileset_02_GFX:
INCBIN "gfx/tilesets/tileset_02.2bpp"

SECTION "gfx.asm@Bank 6 Tilesets 09", ROMX
Tileset_09_GFX:
INCBIN "gfx/tilesets/tileset_09.2bpp"

SECTION "gfx.asm@Bank 7 Tilesets 13", ROMX
Tileset_13_GFX:
INCBIN "gfx/tilesets/tileset_13.2bpp"

SECTION "gfx.asm@Bank 7 Tilesets 0e", ROMX
Tileset_0e_GFX:
INCBIN "gfx/tilesets/tileset_0e.2bpp"

SECTION "gfx.asm@Bank 7 Tilesets 06", ROMX
Tileset_06_GFX:
INCBIN "gfx/tilesets/tileset_06.2bpp"

SECTION "gfx.asm@Bank 7 Tilesets 05", ROMX
Tileset_05_GFX:
INCBIN "gfx/tilesets/tileset_05.2bpp"

SECTION "gfx.asm@Bank 7 Tilesets 03", ROMX
Tileset_03_GFX:
INCBIN "gfx/tilesets/tileset_03.2bpp"

SECTION "gfx.asm@Bank 8 Tilesets 04", ROMX
Tileset_04_GFX:
INCBIN "gfx/tilesets/tileset_04.2bpp"

SECTION "gfx.asm@Bank 8 Tilesets 07", ROMX
Tileset_07_GFX:
INCBIN "gfx/tilesets/tileset_07.2bpp"

SECTION "gfx.asm@Bank 8 Tilesets 08", ROMX
Tileset_08_GFX:
INCBIN "gfx/tilesets/tileset_08.2bpp"

SECTION "gfx.asm@Bank 8 Tilesets 0f", ROMX
Tileset_0f_GFX:
INCBIN "gfx/tilesets/tileset_0f.2bpp"

SECTION "gfx.asm@Bank 8 Tilesets 11", ROMX
Tileset_11_GFX:
INCBIN "gfx/tilesets/tileset_11.2bpp"

SECTION "gfx.asm@Gameboy GFX", ROMX
TradeGameBoyGFX::
INCBIN "gfx/trade/gameboy.2bpp"

SECTION "gfx.asm@Bank C Tilesets 12", ROMX
Tileset_12_GFX:
INCBIN "gfx/tilesets/tileset_12.2bpp"

SECTION "gfx.asm@Bank C Tilesets 0b", ROMX
Tileset_0b_GFX:
INCBIN "gfx/tilesets/tileset_0b.2bpp"

SECTION "gfx.asm@Bank C Tilesets 0d", ROMX
Tileset_0d_GFX:
INCBIN "gfx/tilesets/tileset_0d.2bpp"

SECTION "gfx.asm@Bank C Tilesets 14", ROMX
Tileset_14_GFX:
INCBIN "gfx/tilesets/tileset_14.2bpp"

SECTION "gfx.asm@Bank C Tilesets 0c", ROMX
Tileset_0c_GFX:
INCBIN "gfx/tilesets/tileset_0c.2bpp"

SECTION "gfx.asm@Bank C Tilesets Common", ROMX
CommonExteriorTilesGFX:
INCBIN "gfx/tilesets/tileset_common.2bpp"

SECTION "gfx.asm@PokeBalls GFX", ROMX

PokeBallsGFX::                   INCBIN "gfx/misc/poke_balls.2bpp" ; 0x038494--0x0384d4

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
ProtagonistPic:: INCBIN "/gfx/trainer/protagonist.pic"
KurtPic:: INCBIN "/gfx/trainer/kurt.pic"
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

SECTION "gfx.asm@Bank 13 Tilesets 16", ROMX
Tileset_16_GFX:
INCBIN "gfx/tilesets/tileset_16.2bpp"

SECTION "gfx.asm@Bank 13 Tilesets 19", ROMX
Tileset_19_GFX:
INCBIN "gfx/tilesets/tileset_19.2bpp"

SECTION "gfx.asm@Bank 13 Tilesets 1a", ROMX
Tileset_1a_GFX:
INCBIN "gfx/tilesets/tileset_1a.2bpp"

SECTION "gfx.asm@PKMN Sprite Bank List", ROMX
INCLUDE "gfx/pokemon/pkmn_pic_banks.asm"

INCLUDE "gfx/pokemon/pkmn_pics.asm"


SECTION "gfx.asm@Annon Pic Ptrs and Pics", ROMX
INCLUDE "gfx/pokemon/annon_pic_ptrs.asm"
INCLUDE "gfx/pokemon/annon_pics.asm"

INCLUDE "gfx/pokemon/egg.asm"

SECTION "gfx.asm@Attack Animation GFX", ROMX

INCBIN "gfx/battle_anims/attack_animations_1.2bpp"
PointerGFX::
INCBIN "gfx/battle_anims/pointer.2bpp"
INCBIN "gfx/battle_anims/attack_animations_2.2bpp"

SECTION "gfx.asm@Pokemon Party Sprites", ROMX
NyoromoIcon:: INCBIN "gfx/icons/nyoromo.2bpp"
PurinIcon:: INCBIN "gfx/icons/purin.2bpp"
DigdaIcon:: INCBIN "gfx/icons/digda.2bpp"
PikachuIcon:: INCBIN "gfx/icons/pikachu.2bpp"
HitodemanIcon:: INCBIN "gfx/icons/hitodeman.2bpp"
KoikingIcon:: INCBIN "gfx/icons/koiking.2bpp"
PoppoIcon:: INCBIN "gfx/icons/poppo.2bpp"
SidonIcon:: INCBIN "gfx/icons/sidon.2bpp"
PippiIcon:: INCBIN "gfx/icons/pippi.2bpp"
NazonokusaIcon:: INCBIN "gfx/icons/nazonokusa.2bpp"
MushiIcon:: INCBIN "gfx/icons/mushi.2bpp"
GangarIcon:: INCBIN "gfx/icons/gangar.2bpp"
LaplaceIcon:: INCBIN "gfx/icons/laplace.2bpp"
BarrierdIcon:: INCBIN "gfx/icons/barrierd.2bpp"
LokonIcon:: INCBIN "gfx/icons/lokon.2bpp"
KentaurosIcon:: INCBIN "gfx/icons/kentauros.2bpp"
ShellderIcon:: INCBIN "gfx/icons/shellder.2bpp"
MetamonIcon:: INCBIN "gfx/icons/metamon.2bpp"
IwarkIcon:: INCBIN "gfx/icons/iwark.2bpp"
BiriridamaIcon:: INCBIN "gfx/icons/biriridama.2bpp"
ZenigameIcon:: INCBIN "gfx/icons/zenigame.2bpp"
FushigidaneIcon:: INCBIN "gfx/icons/fushigidane.2bpp"
HitokageIcon:: INCBIN "gfx/icons/hitokage.2bpp"
BeedleIcon:: INCBIN "gfx/icons/beedle.2bpp"
AnnonIcon:: INCBIN "gfx/icons/annon.2bpp"
IsitsubuteIcon:: INCBIN "gfx/icons/isitsubute.2bpp"
WanrikyIcon:: INCBIN "gfx/icons/wanriky.2bpp"
EggIcon:: INCBIN "gfx/icons/egg.2bpp"
MenokurageIcon:: INCBIN "gfx/icons/menokurage.2bpp"
ButterfreeIcon:: INCBIN "gfx/icons/butterfree.2bpp"
ZubatIcon:: INCBIN "gfx/icons/zubat.2bpp"
KabigonIcon:: INCBIN "gfx/icons/kabigon.2bpp"

SECTION "gfx.asm@Slot Machine GFX", ROMX
SlotMachineGFX::
INCBIN "gfx/minigames/slots.2bpp"
SlotMachine2GFX::
INCBIN "gfx/minigames/slots_2.2bpp"

SECTION "gfx.asm@Bank 30 Sprites 1", ROMX
GoldSpriteGFX:: INCBIN "gfx/sprites/gold.2bpp" ; 30:4000
GoldBikeSpriteGFX:: INCBIN "gfx/sprites/gold_bike.2bpp" ; 30:4180
GoldSkateboardSpriteGFX:: INCBIN "gfx/sprites/gold_skateboard.2bpp" ; 30:4300
SilverSpriteGFX:: INCBIN "gfx/sprites/silver.2bpp" ; 30:4480
OkidoSpriteGFX:: INCBIN "gfx/sprites/okido.2bpp" ; 30:4600
RedSpriteGFX:: INCBIN "gfx/sprites/red.2bpp" ; 30:4780
BlueSpriteGFX:: INCBIN "gfx/sprites/blue.2bpp" ; 30:4900
MasakiSpriteGFX:: INCBIN "gfx/sprites/masaki.2bpp" ; 30:4a80
ElderSpriteGFX:: INCBIN "gfx/sprites/elder.2bpp" ; 30:4c00
SakakiSpriteGFX:: INCBIN "gfx/sprites/sakaki.2bpp" ; 30:4d80
GantetsuSpriteGFX:: INCBIN "gfx/sprites/gantetsu.2bpp" ; 30:4f00
MomSpriteGFX:: INCBIN "gfx/sprites/mom.2bpp" ; 30:5080
SilversMomSpriteGFX:: INCBIN "gfx/sprites/silvers_mom.2bpp" ; 30:5200
RedsMomSpriteGFX:: INCBIN "gfx/sprites/reds_mom.2bpp" ; 30:5380
NanamiSpriteGFX:: INCBIN "gfx/sprites/nanami.2bpp" ; 30:5500
EvilOkidoSpriteGFX:: INCBIN "gfx/sprites/evil_okido.2bpp" ; 30:5680
KikukoSpriteGFX:: INCBIN "gfx/sprites/kikuko.2bpp" ; 30:5800
HayatoSpriteGFX:: INCBIN "gfx/sprites/hayato.2bpp" ; 30:5980
TsukushiSpriteGFX:: INCBIN "gfx/sprites/tsukushi.2bpp" ; 30:5a40
EnokiSpriteGFX:: INCBIN "gfx/sprites/enoki.2bpp" ; 30:5b00
MikanSpriteGFX:: INCBIN "gfx/sprites/mikan.2bpp" ; 30:5bc0
CooltrainerMSpriteGFX:: INCBIN "gfx/sprites/cooltrainer_m.2bpp" ; 30:5d40
CooltrainerFSpriteGFX:: INCBIN "gfx/sprites/cooltrainer_f.2bpp" ; 30:5ec0
BugCatcherBoySpriteGFX:: INCBIN "gfx/sprites/bug_catcher_boy.2bpp" ; 30:6040
TwinSpriteGFX:: INCBIN "gfx/sprites/twin.2bpp" ; 30:61c0
YoungsterSpriteGFX:: INCBIN "gfx/sprites/youngster.2bpp" ; 30:6340
LassSpriteGFX:: INCBIN "gfx/sprites/lass.2bpp" ; 30:64c0
TeacherSpriteGFX:: INCBIN "gfx/sprites/teacher.2bpp" ; 30:6640
GirlSpriteGFX:: INCBIN "gfx/sprites/girl.2bpp" ; 30:67c0
SuperNerdSpriteGFX:: INCBIN "gfx/sprites/super_nerd.2bpp" ; 30:6940
RockerSpriteGFX:: INCBIN "gfx/sprites/rocker.2bpp" ; 30:6ac0
PokefanMSpriteGFX:: INCBIN "gfx/sprites/pokefan_m.2bpp" ; 30:6c40
PokefanFSpriteGFX:: INCBIN "gfx/sprites/pokefan_f.2bpp" ; 30:6dc0
GrampsSpriteGFX:: INCBIN "gfx/sprites/gramps.2bpp" ; 30:6f40
GrannySpriteGFX:: INCBIN "gfx/sprites/granny.2bpp" ; 30:70c0
SwimmerMSpriteGFX:: INCBIN "gfx/sprites/swimmer_m.2bpp" ; 30:7240
SwimmerFSpriteGFX:: INCBIN "gfx/sprites/swimmer_f.2bpp" ; 30:73c0
RocketMSpriteGFX:: INCBIN "gfx/sprites/rocket_m.2bpp" ; 30:7540
RocketFSpriteGFX:: INCBIN "gfx/sprites/rocket_f.2bpp" ; 30:76c0
NurseSpriteGFX:: INCBIN "gfx/sprites/nurse.2bpp" ; 30:7840
LinkReceptionistSpriteGFX:: INCBIN "gfx/sprites/link_receptionist.2bpp" ; 30:7900
ClerkSpriteGFX:: INCBIN "gfx/sprites/clerk.2bpp" ; 30:79c0
FisherSpriteGFX:: INCBIN "gfx/sprites/fisher.2bpp" ; 30:7b40
FishingGuruSpriteGFX:: INCBIN "gfx/sprites/fishing_guru.2bpp" ; 30:7cc0

SECTION "gfx.asm@Bank 31 Sprites 2", ROMX
ScientistSpriteGFX:: INCBIN "gfx/sprites/scientist.2bpp" ; 31:4000
MediumSpriteGFX:: INCBIN "gfx/sprites/medium.2bpp" ; 31:4180
SageSpriteGFX:: INCBIN "gfx/sprites/sage.2bpp" ; 31:4300
FrowningManSpriteGFX:: INCBIN "gfx/sprites/frowning_man.2bpp" ; 31:4480
GentlemanSpriteGFX:: INCBIN "gfx/sprites/gentleman.2bpp" ; 31:4600
BlackbeltSpriteGFX:: INCBIN "gfx/sprites/blackbelt.2bpp" ; 31:4780
ReceptionistSpriteGFX:: INCBIN "gfx/sprites/receptionist.2bpp" ; 31:4900
OfficerSpriteGFX:: INCBIN "gfx/sprites/officer.2bpp" ; 31:4a80
CaptainSpriteGFX:: INCBIN "gfx/sprites/captain.2bpp" ; 31:4c00
MohawkSpriteGFX:: INCBIN "gfx/sprites/mohawk.2bpp" ; 31:4d80
GymGuySpriteGFX:: INCBIN "gfx/sprites/gym_guy.2bpp" ; 31:4f00
SailorSpriteGFX:: INCBIN "gfx/sprites/sailor.2bpp" ; 31:5080
HelmetSpriteGFX:: INCBIN "gfx/sprites/helmet.2bpp" ; 31:5200
BurglarSpriteGFX:: INCBIN "gfx/sprites/burglar.2bpp" ; 31:5380
SidonSpriteGFX:: INCBIN "gfx/sprites/sidon.2bpp" ; 31:5500
PippiSpriteGFX:: INCBIN "gfx/sprites/pippi.2bpp" ; 31:5680
PoppoSpriteGFX:: INCBIN "gfx/sprites/poppo.2bpp" ; 31:5800
LizardonSpriteGFX:: INCBIN "gfx/sprites/lizardon.2bpp" ; 31:5980
KabigonSpriteGFX:: INCBIN "gfx/sprites/kabigon.2bpp" ; 31:5b00
PawouSpriteGFX:: INCBIN "gfx/sprites/pawou.2bpp" ; 31:5c80
NyorobonSpriteGFX:: INCBIN "gfx/sprites/nyorobon.2bpp" ; 31:5e00
LaplaceSpriteGFX:: INCBIN "gfx/sprites/laplace.2bpp" ; 31:5f80
PokeBallSpriteGFX:: INCBIN "gfx/sprites/poke_ball.2bpp" ; 31:6100
PokedexSpriteGFX:: INCBIN "gfx/sprites/pokedex.2bpp" ; 31:6280
PaperSpriteGFX:: INCBIN "gfx/sprites/paper.2bpp" ; 31:6400
OldLinkReceptionistSpriteGFX:: INCBIN "gfx/sprites/old_link_receptionist.2bpp" ; 31:6580
EggSpriteGFX:: INCBIN "gfx/sprites/egg.2bpp" ; 31:65c0
BoulderSpriteGFX:: INCBIN "gfx/sprites/boulder.2bpp" ; 31:6600

SECTION "gfx.asm@Bank 37 Tilesets 10", ROMX
Tileset_10_GFX:
INCBIN "gfx/tilesets/tileset_10.2bpp"

SECTION "gfx.asm@Bank 37 Tilesets 15", ROMX
Tileset_15_GFX:
INCBIN "gfx/tilesets/tileset_15.2bpp"

SECTION "gfx.asm@Bank 37 Tilesets 17", ROMX
Tileset_17_GFX:
INCBIN "gfx/tilesets/tileset_17.2bpp"

SECTION "gfx.asm@Bank 37 Tilesets 18", ROMX
Tileset_18_GFX:
INCBIN "gfx/tilesets/tileset_18.2bpp"

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
PicrossGFX::
INCBIN "gfx/minigames/picross.2bpp"
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

SECTION "gfx.asm@Intro Water Mon and Forest GFX", ROMX
IntroWaterPokemonGFX::
INCBIN "gfx/intro/water_pokemon.2bpp"
IntroForestGFX::
INCBIN "gfx/intro/forest.2bpp"

SECTION "gfx.asm@Intro Mon", ROMX
IntroPurinPikachuGFX::
INCBIN "gfx/intro/purin_pikachu.2bpp"
IntroLizardon1GFX::
INCBIN "gfx/intro/lizardon_1.2bpp"
IntroLizardon2GFX::
INCBIN "gfx/intro/lizardon_2.2bpp"
IntroLizardon3GFX::
INCBIN "gfx/intro/lizardon_3.2bpp"
IntroLizardonFlamesGFX::
INCBIN "gfx/intro/lizardon_flames.2bpp"
IntroKamexGFX::
INCBIN "gfx/intro/kamex.2bpp"
IntroFushigibanaGFX::
INCBIN "gfx/intro/fushigibana.2bpp"

SECTION "gfx.asm@Misc GFX", ROMX
FontExtraGFX::
FontExtraAB_GFX::                 INCBIN "gfx/font/font_extra.ab.2bpp"          ; 0x0f8162--0x0f8182
FontExtraCDEFGHIVSLM_GFX::        INCBIN "gfx/font/font_extra.cdefghivslm.2bpp" ; 0x0f8182--0x0f8242
FontSmallKanaPunctuationGFX::     INCBIN "gfx/font/small_kana_punctuation.2bpp" ; 0x0f8242--0x0f82f2
FontSmallKanaPunctuationGFXEnd::
Unreferenced_DefaultFrame0GFX::   INCBIN "gfx/frames/1.2bpp"                    ; 0x0f82f2--0x0f8362
FontGFX::                         INCBIN "gfx/font/font.1bpp"                   ; 0x0f8362--0x0f8712 kana
FontGFXEnd::                                                                    ; 0x0f8712--0x0f8762 numbers
FontBattleExtraGFX::
BattleHPBarGFX::                  INCBIN "gfx/battle/hp_bar.2bpp"               ; 0x0f8762--0x0f8822
BattleHPBarGFXEnd::
HpExpBarParts0_2bppGFX::          INCBIN "gfx/battle/hp_exp_bar_parts0.2bpp"    ; 0x0f8822--0x0f8862
BattleMarkersGFX::                INCBIN "gfx/battle/markers.2bpp"              ; 0x0f8862--0x0f8892
BattleMarkersGFXEnd::
LevelUpGFX::                      INCBIN "gfx/battle/levelup.2bpp"              ; 0x0f8892--0x0f88f2
LevelUpGFXEnd::
Unreferenced_DefaultFrame1::      INCBIN "gfx/frames/1.2bpp"                    ; 0x0f88f2--0x0f8962
FrameGFX::
FrameGFXFirstFrame::              INCBIN "gfx/frames/1.1bpp"                    ; 0x0f8962--0x0f8992
FrameGFXFirstFrameEnd::
                                  INCBIN "gfx/frames/2.1bpp"                    ; 0x0f8992--0x0f89c2
                                  INCBIN "gfx/frames/3.1bpp"                    ; 0x0f89c2--0x0f89f2
                                  INCBIN "gfx/frames/4.1bpp"                    ; 0x0f89f2--0x0f8a22
                                  INCBIN "gfx/frames/5.1bpp"                    ; 0x0f8a22--0x0f8a52
                                  INCBIN "gfx/frames/6.1bpp"                    ; 0x0f8a52--0x0f8a82
                                  INCBIN "gfx/frames/7.1bpp"                    ; 0x0f8a82--0x0f8ab2
                                  INCBIN "gfx/frames/8.1bpp"                    ; 0x0f8ab2--0x0f8ae2
                                  INCBIN "gfx/frames/9.1bpp"                    ; 0x0f8ae2--0x0f8b12
StatsGFX::                        INCBIN "gfx/stats/separator.2bpp"             ; 0x0f8b12--0x0f8b22
                                  INCBIN "gfx/stats/stats.2bpp"                 ; 0x0f8b22--0x0f8c22
StatsGFXEnd::

HpExpBarParts0GFX::               INCBIN "gfx/battle/hp_exp_bar_parts0.1bpp"    ; 0x0f8c42--0x0f8c5a
HpExpBarParts0GFXEnd::
HpExpBarParts1GFX::               INCBIN "gfx/battle/hp_exp_bar_parts1.1bpp"    ; 0x0f8c42--0x0f8c5a
HpExpBarParts1GFXEnd::
HpExpBarParts2GFX::               INCBIN "gfx/battle/hp_exp_bar_parts2.1bpp"    ; 0x0f8c5a--0x0f8c6a
HpExpBarParts2GFXEnd::
HpExpBarParts3GFX::               INCBIN "gfx/battle/hp_exp_bar_parts3.1bpp"    ; 0x0f8c6a--0x0f8c72
HpExpBarParts3GFXEnd::
ExpBarGFX::                       INCBIN "gfx/battle/exp_bar.2bpp"              ; 0x0f8c72--0x0f8cf2
ExpBarGFXEnd::
PokedexGFX::                      INCBIN "gfx/pokedex/pokedex.2bpp"             ; 0x0f8cf2--0x0f8dc2
PokedexGFXEnd::
PokedexLocationGFX::              INCBIN "gfx/pokedex/locations.2bpp"           ; 0x0f8dc2--0x0f8e12
PokedexLocationGFXEnd::
TownMapGFX::                      INCBIN "gfx/trainer_gear/town_map.2bpp"           ; 0x0f8e12--0x0f8fc2
TownMapGFXEnd::
HUD_GFX::                         INCBIN "gfx/hud/hud.2bpp"                     ; 0x0f8fc2--0x0f9052
HUD_GFXEnd::
BoldAlphabetGFX::                 INCBIN "gfx/font/alphabet.1bpp"
AnnonAlphabetGFX::                INCBIN "gfx/font/annon_alphabet.1bpp"
EmptyTile1bppGFX::                INCBIN "gfx/misc/empty_tile.1bpp"             ; 0x0f9322--0x0f932a
EmptyTile1bppGFXEnd::
BlackTileAndCursor1bppGFX::       INCBIN "gfx/misc/black_tile_cursor.1bpp"      ; 0x0f932a--0x0f933a
BlackTileAndCursor1bppGFXEnd::
PackIconGFX::                     INCBIN "gfx/pack/pack_icons.2bpp"             ; 0x0f933a--0x0f941a
PackIconGFXEnd::

SECTION "gfx.asm@Town Map Cursor", ROMX
TownMapCursorGFX::
INCBIN "gfx/trainer_gear/town_map_cursor.2bpp"
