INCLUDE "constants.asm"

SECTION "Mon Nest Icon", ROMX[$4A0F], BANK[$02]
PokedexNestIconGFX::
INCBIN "build/gfx/pokegear/dexmap_nest_icon.1bpp"

SECTION "Bank 2 Misc GFX", ROMX[$44bf], BANK[$02]
INCBIN "build/gfx/overworld/gfx_84bf.2bpp"
JumpShadowGFX::
INCBIN "build/gfx/overworld/shadow.2bpp"
ShockEmoteGFX::
INCBIN "build/gfx/overworld/shock.2bpp"
QuestionEmoteGFX::
INCBIN "build/gfx/overworld/question.2bpp"
HappyEmoteGFX::
INCBIN "build/gfx/overworld/happy.2bpp"

SECTION "Pokegear GFX", ROMX[$4F32], BANK[$02]
PokegearGFX::
INCBIN "build/gfx/pokegear/pokegear.2bpp"

SECTION "Title Screen BG Decoration Border", ROMX[$51FB], BANK[$02]
TitleBGDecorationBorder::
INCBIN "build/gfx/title/titlebgdecoration.2bpp"

SECTION "Super Palettes", ROMX[$5B4C], BANK[$02]
INCLUDE "data/pokemon/palettes.inc"
INCLUDE "data/super_palettes.inc"

SECTION "Unused SGB Border GFX", ROMX[$62CC], BANK[$02]
UnusedSGBBorderGFX::
INCBIN "build/gfx/sgb/sgb_border_alt.2bpp"

SECTION "SGB Border GFX", ROMX[$6B1C], BANK[$02]
SGBBorderGFX::
if def(GOLD)
INCBIN "build/gfx/sgb/sgb_border_gold.2bpp"
else
INCBIN "build/gfx/sgb/sgb_border_silver.2bpp"
endc

SECTION "Title Screen GFX", ROMX[$47CF], BANK[$04]
if def(GOLD)
TitleScreenGFX:: INCBIN "build/gfx/title/title.2bpp"
TitleScreenVersionGFX:: INCBIN "build/gfx/title/title_gold_version.2bpp"
TitleScreenHoOhGFX:: INCBIN "build/gfx/title/title_hooh.2bpp"
TitleScreenLogoGFX:: INCBIN "build/gfx/title/title_logo.2bpp"
TitleScreenGoldLogoGFX:: INCBIN "build/gfx/title/title_goldlogo.2bpp"
else
TitleScreenGFX:: INCBIN "build/gfx/title/title.2bpp"
TitleScreenVersionGFX:: INCBIN "build/gfx/title/title_silver_version.2bpp"
TitleScreenHoOhGFX:: INCBIN "build/gfx/title/title_hooh.2bpp"
TitleScreenLogoGFX:: INCBIN "build/gfx/title/title_logo.2bpp"
TitleScreenGoldLogoGFX:: INCBIN "build/gfx/title/title_silverlogo.2bpp"
endc

SECTION "Mail Icon GFX", ROMX[$5BB1], BANK[$04]
MailIconGFX::
INCBIN "build/gfx/icons/mail.2bpp"

SECTION "Trainer Card GFX", ROMX[$7171], BANK[$04]
TrainerCardGFX::                     INCBIN "build/gfx/trainer_card/trainer_card.2bpp" ; 0x013171--0x013381
TrainerCardColonGFX::                INCBIN "build/gfx/trainer_card/colon.2bpp"        ; 0x013381--0x013391
TrainerCardIDNoGFX::                 INCBIN "build/gfx/trainer_card/id_no.2bpp"        ; 0x013391--0x0133B1
TrainerCardIDNoGFXEnd::
TrainerCardLeadersGFX::              INCBIN "build/gfx/trainer_card/leaders.2bpp"      ; 0x0133B1--0x133BA1
if DEBUG || def(GOLD)
	db $18, $00 ; leftover of previous graphics
else
    db $b2, $aa ; leftover of previous graphics?
endc

if DEBUG
; Not sure how to parse this from the non-debug ROM, so I'll leave this be for now
Unreferenced_UnusedLeaderNameGFX:: INCBIN "build/gfx/trainer_card/unused_leader_name.2bpp" ; 0x13ba3
endc

SECTION "Bank 6 Tilesets 00", ROMX[$4000], BANK[$06]
Tileset_00_GFX:
INCBIN "build/gfx/tilesets/tileset_00.2bpp"

SECTION "Bank 6 Tilesets 01", ROMX[$5800], BANK[$06]
Tileset_01_GFX:
INCBIN "build/gfx/tilesets/tileset_01.2bpp"

SECTION "Bank 6 Tilesets 02", ROMX[$6600], BANK[$06]
Tileset_02_GFX:
INCBIN "build/gfx/tilesets/tileset_02.2bpp"

SECTION "Bank 6 Tilesets 09", ROMX[$7400], BANK[$06]
Tileset_09_GFX:
INCBIN "build/gfx/tilesets/tileset_09.2bpp"

SECTION "Bank 7 Tilesets 13", ROMX[$4000], BANK[$07]
Tileset_13_GFX:
INCBIN "build/gfx/tilesets/tileset_13.2bpp"

SECTION "Bank 7 Tilesets 0e", ROMX[$4B00], BANK[$07]
Tileset_0e_GFX:
INCBIN "build/gfx/tilesets/tileset_0e.2bpp"

SECTION "Bank 7 Tilesets 06", ROMX[$5600], BANK[$07]
Tileset_06_GFX:
INCBIN "build/gfx/tilesets/tileset_06.2bpp"

SECTION "Bank 7 Tilesets 05", ROMX[$6400], BANK[$07]
Tileset_05_GFX:
INCBIN "build/gfx/tilesets/tileset_05.2bpp"

SECTION "Bank 7 Tilesets 03", ROMX[$7200], BANK[$07]
Tileset_03_GFX:
INCBIN "build/gfx/tilesets/tileset_03.2bpp"

SECTION "Bank 8 Tilesets 04", ROMX[$4000], BANK[$08]
Tileset_04_GFX:
INCBIN "build/gfx/tilesets/tileset_04.2bpp"

SECTION "Bank 8 Tilesets 07", ROMX[$4E00], BANK[$08]
Tileset_07_GFX:
INCBIN "build/gfx/tilesets/tileset_07.2bpp"

SECTION "Bank 8 Tilesets 08", ROMX[$5C00], BANK[$08]
Tileset_08_GFX:
INCBIN "build/gfx/tilesets/tileset_08.2bpp"

SECTION "Bank 8 Tilesets 0f", ROMX[$6A00], BANK[$08]
Tileset_0f_GFX:
INCBIN "build/gfx/tilesets/tileset_0f.2bpp"

SECTION "Bank 8 Tilesets 11", ROMX[$7500], BANK[$08]
Tileset_11_GFX:
INCBIN "build/gfx/tilesets/tileset_11.2bpp"

SECTION "Gameboy GFX", ROMX[$5641], BANK[$0A]
TradeGameBoyGFX::
INCBIN "build/gfx/trade/gameboy.2bpp"

SECTION "Bank C Tilesets 12", ROMX[$4000], BANK[$0C]
Tileset_12_GFX:
INCBIN "build/gfx/tilesets/tileset_12.2bpp"

SECTION "Bank C Tilesets 0b", ROMX[$4B00], BANK[$0C]
Tileset_0b_GFX:
INCBIN "build/gfx/tilesets/tileset_0b.2bpp"

SECTION "Bank C Tilesets 0d", ROMX[$5600], BANK[$0C]
Tileset_0d_GFX:
INCBIN "build/gfx/tilesets/tileset_0d.2bpp"

SECTION "Bank C Tilesets 14", ROMX[$6100], BANK[$0C]
Tileset_14_GFX:
INCBIN "build/gfx/tilesets/tileset_14.2bpp"

SECTION "Bank C Tilesets 0c", ROMX[$7100], BANK[$0C]
Tileset_0c_GFX:
INCBIN "build/gfx/tilesets/tileset_0c.2bpp"

SECTION "PokeBalls GFX", ROMX[$4494], BANK[$0E]

PokeBallsGFX::                   INCBIN "build/gfx/misc/poke_balls.2bpp" ; 0x038494--0x0384d4

SECTION "Pokedex GFX", ROMX[$40D5], BANK[$11]
PokedexButtonsGFX::
INCBIN "build/gfx/pokedex/buttons.2bpp"
PokedexPokeBallGFX::
INCBIN "build/gfx/pokedex/poke_ball.2bpp"
PokedexCursorsGFX::
INCBIN "build/gfx/pokedex/cursors.2bpp"
PokedexSearchGFX::
INCBIN "build/gfx/pokedex/search.2bpp"

SECTION "Trainer Battle Sprites", ROMX[$4000], BANK[$12]
HayatoPic:: INCBIN "build/gfx/trainer/hayato.pic"
AkanePic:: INCBIN "build/gfx/trainer/akane.pic" ; Gen 1 Bug Catcher
TsukushiPic:: INCBIN "build/gfx/trainer/tsukushi.pic"
EnokiPic:: INCBIN "build/gfx/trainer/enoki.pic"
OkeraPic:: INCBIN "build/gfx/trainer/okera.pic" ; Gen 1 Police Female
MikanPic:: INCBIN "build/gfx/trainer/mikan.pic"
BluePic:: INCBIN "build/gfx/trainer/blue.pic"	; Gen 1 Pokemaniac
GamaPic:: INCBIN "build/gfx/trainer/gama.pic" ; Gen 1 Super Nerd
RivalPic:: INCBIN "build/gfx/trainer/rival.pic"
OakPic:: INCBIN "build/gfx/trainer/oak.pic"
ProtagonistPic:: INCBIN "build/gfx/trainer/protagonist.pic"
KurtPic:: INCBIN "build/gfx/trainer/kurt.pic"
YoungsterPic:: INCBIN "build/gfx/trainer/youngster.pic"
SchoolboyPic:: INCBIN "build/gfx/trainer/schoolboy.pic"
FledglingPic:: INCBIN "build/gfx/trainer/fledgling.pic"
LassPic:: INCBIN "build/gfx/trainer/lass.pic"
ProfessionalMPic:: INCBIN "build/gfx/trainer/professional_m.pic"
ProfessionalFPic:: INCBIN "build/gfx/trainer/professional_f.pic"
BeautyPic:: INCBIN "build/gfx/trainer/beauty.pic"
PokemaniacPic:: INCBIN "build/gfx/trainer/pokemaniac.pic"
RocketMPic:: INCBIN "build/gfx/trainer/rocket_m.pic"
TeacherMPic:: INCBIN "build/gfx/trainer/teacher_m.pic"
TeacherFPic:: INCBIN "build/gfx/trainer/teacher_f.pic"
BugCatcherBoyPic:: INCBIN "build/gfx/trainer/bug_catcher_boy.pic"
FisherPic:: INCBIN "build/gfx/trainer/fisher.pic"
SwimmerMPic:: INCBIN "build/gfx/trainer/swimmer_m.pic"
SwimmerFPic:: INCBIN "build/gfx/trainer/swimmer_f.pic"
SuperNerdPic:: INCBIN "build/gfx/trainer/supernerd.pic"
EngineerPic:: INCBIN "build/gfx/trainer/engineer.pic"
GreenPic:: INCBIN "build/gfx/trainer/green.pic" ; Gen 1 Green
BikerPic:: INCBIN "build/gfx/trainer/biker.pic"
BurglarPic:: INCBIN "build/gfx/trainer/burglar.pic"
FirebreatherPic:: INCBIN "build/gfx/trainer/firebreather.pic"
JugglerPic:: INCBIN "build/gfx/trainer/juggler.pic"
BlackbeltPic:: INCBIN "build/gfx/trainer/blackbelt.pic"
SportsmanPic:: INCBIN "build/gfx/trainer/sportsman.pic"
MediumPic:: INCBIN "build/gfx/trainer/medium.pic"
SoldierPic:: INCBIN "build/gfx/trainer/soldier.pic"
KimonoGirlPic:: INCBIN "build/gfx/trainer/kimonogirl.pic"
TwinsPic:: INCBIN "build/gfx/trainer/twins.pic"


SECTION "Bank 13 Tilesets 0a", ROMX[$4000], BANK[$13]
Tileset_0a_GFX:
INCBIN "build/gfx/tilesets/tileset_0a.2bpp"

SECTION "Bank 13 Tilesets 16", ROMX[$4B00], BANK[$13]
Tileset_16_GFX:
INCBIN "build/gfx/tilesets/tileset_16.2bpp"

SECTION "Bank 13 Tilesets 19", ROMX[$5B00], BANK[$13]
Tileset_19_GFX:
INCBIN "build/gfx/tilesets/tileset_19.2bpp"

SECTION "Bank 13 Tilesets 1a", ROMX[$6900], BANK[$13]
Tileset_1a_GFX:
INCBIN "build/gfx/tilesets/tileset_1a.2bpp"

SECTION "PKMN Sprite Bank List", ROMX[$725C], BANK[$14]
INCLUDE "gfx/pokemon/pkmn_pic_banks.asm"

INCLUDE "gfx/pokemon/pkmn_pics.asm"


SECTION "Annon Pic Ptrs and Pics", ROMX[$4d6a], BANK[$1f]
INCLUDE "gfx/pokemon/annon_pic_ptrs.asm"
INCLUDE "gfx/pokemon/annon_pics.asm"

INCLUDE "gfx/pokemon/egg.asm"

SECTION "Attack Animation GFX", ROMX[$4000], BANK[$21]
INCBIN "build/gfx/battle_anims/attack_animations.2bpp"

SECTION "Pokemon Party Sprites", ROMX[$60CC], BANK[$23]
NyoromoIcon:: INCBIN "build/gfx/icons/nyoromo.2bpp"
PurinIcon:: INCBIN "build/gfx/icons/purin.2bpp"
DigdaIcon:: INCBIN "build/gfx/icons/digda.2bpp"
PikachuIcon:: INCBIN "build/gfx/icons/pikachu.2bpp"
HitodemanIcon:: INCBIN "build/gfx/icons/hitodeman.2bpp"
KoikingIcon:: INCBIN "build/gfx/icons/koiking.2bpp"
PoppoIcon:: INCBIN "build/gfx/icons/poppo.2bpp"
SidonIcon:: INCBIN "build/gfx/icons/sidon.2bpp"
PippiIcon:: INCBIN "build/gfx/icons/pippi.2bpp"
NazonokusaIcon:: INCBIN "build/gfx/icons/nazonokusa.2bpp"
MushiIcon:: INCBIN "build/gfx/icons/mushi.2bpp"
GangarIcon:: INCBIN "build/gfx/icons/gangar.2bpp"
LaplaceIcon:: INCBIN "build/gfx/icons/laplace.2bpp"
BarrierdIcon:: INCBIN "build/gfx/icons/barrierd.2bpp"
LokonIcon:: INCBIN "build/gfx/icons/lokon.2bpp"
KentaurosIcon:: INCBIN "build/gfx/icons/kentauros.2bpp"
ShellderIcon:: INCBIN "build/gfx/icons/shellder.2bpp"
MetamonIcon:: INCBIN "build/gfx/icons/metamon.2bpp"
IwarkIcon:: INCBIN "build/gfx/icons/iwark.2bpp"
BiriridamaIcon:: INCBIN "build/gfx/icons/biriridama.2bpp"
ZenigameIcon:: INCBIN "build/gfx/icons/zenigame.2bpp"
FushigidaneIcon:: INCBIN "build/gfx/icons/fushigidane.2bpp"
HitokageIcon:: INCBIN "build/gfx/icons/hitokage.2bpp"
BeedleIcon:: INCBIN "build/gfx/icons/beedle.2bpp"
AnnonIcon:: INCBIN "build/gfx/icons/annon.2bpp"
IsitsubuteIcon:: INCBIN "build/gfx/icons/isitsubute.2bpp"
WanrikyIcon:: INCBIN "build/gfx/icons/wanriky.2bpp"
EggIcon:: INCBIN "build/gfx/icons/egg.2bpp"
MenokurageIcon:: INCBIN "build/gfx/icons/menokurage.2bpp"
ButterfreeIcon:: INCBIN "build/gfx/icons/butterfree.2bpp"
ZubatIcon:: INCBIN "build/gfx/icons/zubat.2bpp"
KabigonIcon:: INCBIN "build/gfx/icons/kabigon.2bpp"

SECTION "Slot Machine GFX", ROMX[$4FDB], BANK[$24]
SlotMachineGFX::
INCBIN "build/gfx/minigames/slots.2bpp"
SlotMachine2GFX::
INCBIN "build/gfx/minigames/slots_2.2bpp"

SECTION "Bank 30 Sprites 1", ROMX[$4000], BANK[$30]
GoldSpriteGFX:: INCBIN "build/gfx/sprites/gold.2bpp" ; 30:4000
GoldBikeSpriteGFX:: INCBIN "build/gfx/sprites/gold_bike.2bpp" ; 30:4180
GoldSkateboardSpriteGFX:: INCBIN "build/gfx/sprites/gold_skateboard.2bpp" ; 30:4300
SilverSpriteGFX:: INCBIN "build/gfx/sprites/silver.2bpp" ; 30:4480
OkidoSpriteGFX:: INCBIN "build/gfx/sprites/okido.2bpp" ; 30:4600
RedSpriteGFX:: INCBIN "build/gfx/sprites/red.2bpp" ; 30:4780
BlueSpriteGFX:: INCBIN "build/gfx/sprites/blue.2bpp" ; 30:4900
MasakiSpriteGFX:: INCBIN "build/gfx/sprites/masaki.2bpp" ; 30:4a80
ElderSpriteGFX:: INCBIN "build/gfx/sprites/elder.2bpp" ; 30:4c00
SakakiSpriteGFX:: INCBIN "build/gfx/sprites/sakaki.2bpp" ; 30:4d80
GantetsuSpriteGFX:: INCBIN "build/gfx/sprites/gantetsu.2bpp" ; 30:4f00
MomSpriteGFX:: INCBIN "build/gfx/sprites/mom.2bpp" ; 30:5080
SilversMomSpriteGFX:: INCBIN "build/gfx/sprites/silvers_mom.2bpp" ; 30:5200
RedsMomSpriteGFX:: INCBIN "build/gfx/sprites/reds_mom.2bpp" ; 30:5380
NanamiSpriteGFX:: INCBIN "build/gfx/sprites/nanami.2bpp" ; 30:5500
EvilOkidoSpriteGFX:: INCBIN "build/gfx/sprites/evil_okido.2bpp" ; 30:5680
KikukoSpriteGFX:: INCBIN "build/gfx/sprites/kikuko.2bpp" ; 30:5800
HayatoSpriteGFX:: INCBIN "build/gfx/sprites/hayato.2bpp" ; 30:5980
TsukushiSpriteGFX:: INCBIN "build/gfx/sprites/tsukushi.2bpp" ; 30:5a40
EnokiSpriteGFX:: INCBIN "build/gfx/sprites/enoki.2bpp" ; 30:5b00
MikanSpriteGFX:: INCBIN "build/gfx/sprites/mikan.2bpp" ; 30:5bc0
CooltrainerMSpriteGFX:: INCBIN "build/gfx/sprites/cooltrainer_m.2bpp" ; 30:5d40
CooltrainerFSpriteGFX:: INCBIN "build/gfx/sprites/cooltrainer_f.2bpp" ; 30:5ec0
BugCatcherBoySpriteGFX:: INCBIN "build/gfx/sprites/bug_catcher_boy.2bpp" ; 30:6040
TwinSpriteGFX:: INCBIN "build/gfx/sprites/twin.2bpp" ; 30:61c0
YoungsterSpriteGFX:: INCBIN "build/gfx/sprites/youngster.2bpp" ; 30:6340
LassSpriteGFX:: INCBIN "build/gfx/sprites/lass.2bpp" ; 30:64c0
TeacherSpriteGFX:: INCBIN "build/gfx/sprites/teacher.2bpp" ; 30:6640
GirlSpriteGFX:: INCBIN "build/gfx/sprites/girl.2bpp" ; 30:67c0
SuperNerdSpriteGFX:: INCBIN "build/gfx/sprites/super_nerd.2bpp" ; 30:6940
RockerSpriteGFX:: INCBIN "build/gfx/sprites/rocker.2bpp" ; 30:6ac0
PokefanMSpriteGFX:: INCBIN "build/gfx/sprites/pokefan_m.2bpp" ; 30:6c40
PokefanFSpriteGFX:: INCBIN "build/gfx/sprites/pokefan_f.2bpp" ; 30:6dc0
GrampsSpriteGFX:: INCBIN "build/gfx/sprites/gramps.2bpp" ; 30:6f40
GrannySpriteGFX:: INCBIN "build/gfx/sprites/granny.2bpp" ; 30:70c0
SwimmerMSpriteGFX:: INCBIN "build/gfx/sprites/swimmer_m.2bpp" ; 30:7240
SwimmerFSpriteGFX:: INCBIN "build/gfx/sprites/swimmer_f.2bpp" ; 30:73c0
RocketMSpriteGFX:: INCBIN "build/gfx/sprites/rocket_m.2bpp" ; 30:7540
RocketFSpriteGFX:: INCBIN "build/gfx/sprites/rocket_f.2bpp" ; 30:76c0
NurseSpriteGFX:: INCBIN "build/gfx/sprites/nurse.2bpp" ; 30:7840
LinkReceptionistSpriteGFX:: INCBIN "build/gfx/sprites/link_receptionist.2bpp" ; 30:7900
ClerkSpriteGFX:: INCBIN "build/gfx/sprites/clerk.2bpp" ; 30:79c0
FisherSpriteGFX:: INCBIN "build/gfx/sprites/fisher.2bpp" ; 30:7b40
FishingGuruSpriteGFX:: INCBIN "build/gfx/sprites/fishing_guru.2bpp" ; 30:7cc0

SECTION "Bank 31 Sprites 2", ROMX[$4000], BANK[$31]
ScientistSpriteGFX:: INCBIN "build/gfx/sprites/scientist.2bpp" ; 31:4000
MediumSpriteGFX:: INCBIN "build/gfx/sprites/medium.2bpp" ; 31:4180
SageSpriteGFX:: INCBIN "build/gfx/sprites/sage.2bpp" ; 31:4300
FrowningManSpriteGFX:: INCBIN "build/gfx/sprites/frowning_man.2bpp" ; 31:4480
GentlemanSpriteGFX:: INCBIN "build/gfx/sprites/gentleman.2bpp" ; 31:4600
BlackbeltSpriteGFX:: INCBIN "build/gfx/sprites/blackbelt.2bpp" ; 31:4780
ReceptionistSpriteGFX:: INCBIN "build/gfx/sprites/receptionist.2bpp" ; 31:4900
OfficerSpriteGFX:: INCBIN "build/gfx/sprites/officer.2bpp" ; 31:4a80
CaptainSpriteGFX:: INCBIN "build/gfx/sprites/captain.2bpp" ; 31:4c00
MohawkSpriteGFX:: INCBIN "build/gfx/sprites/mohawk.2bpp" ; 31:4d80
GymGuySpriteGFX:: INCBIN "build/gfx/sprites/gym_guy.2bpp" ; 31:4f00
SailorSpriteGFX:: INCBIN "build/gfx/sprites/sailor.2bpp" ; 31:5080
HelmetSpriteGFX:: INCBIN "build/gfx/sprites/helmet.2bpp" ; 31:5200
BurglarSpriteGFX:: INCBIN "build/gfx/sprites/burglar.2bpp" ; 31:5380
SidonSpriteGFX:: INCBIN "build/gfx/sprites/sidon.2bpp" ; 31:5500
PippiSpriteGFX:: INCBIN "build/gfx/sprites/pippi.2bpp" ; 31:5680
PoppoSpriteGFX:: INCBIN "build/gfx/sprites/poppo.2bpp" ; 31:5800
LizardonSpriteGFX:: INCBIN "build/gfx/sprites/lizardon.2bpp" ; 31:5980
KabigonSpriteGFX:: INCBIN "build/gfx/sprites/kabigon.2bpp" ; 31:5b00
PawouSpriteGFX:: INCBIN "build/gfx/sprites/pawou.2bpp" ; 31:5c80
NyorobonSpriteGFX:: INCBIN "build/gfx/sprites/nyorobon.2bpp" ; 31:5e00
LaplaceSpriteGFX:: INCBIN "build/gfx/sprites/laplace.2bpp" ; 31:5f80
PokeBallSpriteGFX:: INCBIN "build/gfx/sprites/poke_ball.2bpp" ; 31:6100
PokedexSpriteGFX:: INCBIN "build/gfx/sprites/pokedex.2bpp" ; 31:6280
PaperSpriteGFX:: INCBIN "build/gfx/sprites/paper.2bpp" ; 31:6400
OldLinkReceptionistSpriteGFX:: INCBIN "build/gfx/sprites/old_link_receptionist.2bpp" ; 31:6580
EggSpriteGFX:: INCBIN "build/gfx/sprites/egg.2bpp" ; 31:65c0
BoulderSpriteGFX:: INCBIN "build/gfx/sprites/boulder.2bpp" ; 31:6600

SECTION "Bank 37 Tilesets 10", ROMX[$4000], BANK[$37]
Tileset_10_GFX:
INCBIN "build/gfx/tilesets/tileset_10.2bpp"

SECTION "Bank 37 Tilesets 15", ROMX[$4B00], BANK[$37]
Tileset_15_GFX:
INCBIN "build/gfx/tilesets/tileset_15.2bpp"

SECTION "Bank 37 Tilesets 17", ROMX[$5B00], BANK[$37]
Tileset_17_GFX:
INCBIN "build/gfx/tilesets/tileset_17.2bpp"

SECTION "Bank 37 Tilesets 18", ROMX[$6B00], BANK[$37]
Tileset_18_GFX:
INCBIN "build/gfx/tilesets/tileset_18.2bpp"

SECTION "Poker GFX", ROMX[$5403], BANK[$38]
PokerGFX::
INCBIN "build/gfx/minigames/poker.2bpp"

SECTION "15 Puzzle GFX", ROMX[$5F93], BANK[$38]
FifteenPuzzleGFX::
INCBIN "build/gfx/minigames/15_puzzle.2bpp"

SECTION "Matches GFX", ROMX[$6606], BANK[$38]
MemoryGameGFX::
INCBIN "build/gfx/minigames/matches.2bpp"

SECTION "Picross GFX", ROMX[$75B7], BANK[$38]
PicrossGFX::
INCBIN "build/gfx/minigames/picross.2bpp"
PicrossCursorGFX::
INCBIN "build/gfx/minigames/picross_cursor.2bpp"

SECTION "Gamefreak Logo GFX", ROMX[$41FF], BANK[$39]
GameFreakLogoGFX::
INCBIN "build/gfx/splash/game_freak_logo.1bpp"
GameFreakLogoSparkleGFX::
INCBIN "build/gfx/splash/game_freak_logo_oam.2bpp"

SECTION "Intro Underwater GFX", ROMX[$4ADF], BANK[$39]
IntroUnderwaterGFX::
INCBIN "build/gfx/intro/underwater.2bpp"

SECTION "Intro Water Mon and Forest GFX", ROMX[$55EF], BANK[$39]
IntroWaterPokemonGFX::
INCBIN "build/gfx/intro/water_pokemon.2bpp"
IntroForestGFX::
INCBIN "build/gfx/intro/forest.2bpp"

SECTION "Intro Mon", ROMX[$626F], BANK[$39]
IntroPurinPikachuGFX::
INCBIN "build/gfx/intro/purin_pikachu.2bpp"
IntroLizardon1GFX::
INCBIN "build/gfx/intro/lizardon_1.2bpp"
IntroLizardon2GFX::
INCBIN "build/gfx/intro/lizardon_2.2bpp"
IntroLizardon3GFX::
INCBIN "build/gfx/intro/lizardon_3.2bpp"
IntroLizardonFlamesGFX::
INCBIN "build/gfx/intro/lizardon_flames.2bpp"
IntroKamexGFX::
INCBIN "build/gfx/intro/kamex.2bpp"
IntroFushigibanaGFX::
INCBIN "build/gfx/intro/fushigibana.2bpp"

SECTION "Misc GFX", ROMX[$4162], BANK[$3E]
FontExtraGFX::
FontExtraAB_GFX::                 INCBIN "build/gfx/font/font_extra.ab.2bpp"          ; 0x0f8162--0x0f8182
FontExtraCDEFGHIVSLM_GFX::        INCBIN "build/gfx/font/font_extra.cdefghivslm.2bpp" ; 0x0f8182--0x0f8242
FontSmallKanaPunctuationGFX::     INCBIN "build/gfx/font/small_kana_punctuation.2bpp" ; 0x0f8242--0x0f82f2
FontSmallKanaPunctuationGFXEnd::
Unreferenced_DefaultFrame0GFX::   INCBIN "build/gfx/frames/1.2bpp"                    ; 0x0f82f2--0x0f8362
FontGFX::                         INCBIN "build/gfx/font/font.1bpp"                   ; 0x0f8362--0x0f8712 kana
FontGFXEnd::                                                                    ; 0x0f8712--0x0f8762 numbers
FontBattleExtraGFX::
BattleHPBarGFX::                  INCBIN "build/gfx/battle/hp_bar.2bpp"               ; 0x0f8762--0x0f8822
BattleHPBarGFXEnd::
HpExpBarParts0_2bppGFX::          INCBIN "build/gfx/battle/hp_exp_bar_parts0.2bpp"    ; 0x0f8822--0x0f8862
BattleMarkersGFX::                INCBIN "build/gfx/battle/markers.2bpp"              ; 0x0f8862--0x0f8892
BattleMarkersGFXEnd::
LevelUpGFX::                      INCBIN "build/gfx/battle/levelup.2bpp"              ; 0x0f8892--0x0f88f2
LevelUpGFXEnd::
Unreferenced_DefaultFrame1::      INCBIN "build/gfx/frames/1.2bpp"                    ; 0x0f88f2--0x0f8962
FrameGFX::
FrameGFXFirstFrame::              INCBIN "build/gfx/frames/1.1bpp"                    ; 0x0f8962--0x0f8992
FrameGFXFirstFrameEnd::
                                  INCBIN "build/gfx/frames/2.1bpp"                    ; 0x0f8992--0x0f89c2
                                  INCBIN "build/gfx/frames/3.1bpp"                    ; 0x0f89c2--0x0f89f2
                                  INCBIN "build/gfx/frames/4.1bpp"                    ; 0x0f89f2--0x0f8a22
                                  INCBIN "build/gfx/frames/5.1bpp"                    ; 0x0f8a22--0x0f8a52
                                  INCBIN "build/gfx/frames/6.1bpp"                    ; 0x0f8a52--0x0f8a82
                                  INCBIN "build/gfx/frames/7.1bpp"                    ; 0x0f8a82--0x0f8ab2
                                  INCBIN "build/gfx/frames/8.1bpp"                    ; 0x0f8ab2--0x0f8ae2
                                  INCBIN "build/gfx/frames/9.1bpp"                    ; 0x0f8ae2--0x0f8b12
StatsGFX::                        INCBIN "build/gfx/stats/separator.2bpp"             ; 0x0f8b12--0x0f8b22
                                  INCBIN "build/gfx/stats/stats.2bpp"                 ; 0x0f8b22--0x0f8c22
StatsGFXEnd::

HpExpBarParts0GFX::               INCBIN "build/gfx/battle/hp_exp_bar_parts0.1bpp"    ; 0x0f8c42--0x0f8c5a
HpExpBarParts0GFXEnd::
HpExpBarParts1GFX::               INCBIN "build/gfx/battle/hp_exp_bar_parts1.1bpp"    ; 0x0f8c42--0x0f8c5a
HpExpBarParts1GFXEnd::
HpExpBarParts2GFX::               INCBIN "build/gfx/battle/hp_exp_bar_parts2.1bpp"    ; 0x0f8c5a--0x0f8c6a
HpExpBarParts2GFXEnd::
HpExpBarParts3GFX::               INCBIN "build/gfx/battle/hp_exp_bar_parts3.1bpp"    ; 0x0f8c6a--0x0f8c72
HpExpBarParts3GFXEnd::
ExpBarGFX::                       INCBIN "build/gfx/battle/exp_bar.2bpp"              ; 0x0f8c72--0x0f8cf2
ExpBarGFXEnd::
PokedexGFX::                      INCBIN "build/gfx/pokedex/pokedex.2bpp"             ; 0x0f8cf2--0x0f8dc2
PokedexGFXEnd::
PokedexLocationGFX::              INCBIN "build/gfx/pokedex/locations.2bpp"           ; 0x0f8dc2--0x0f8e12
PokedexLocationGFXEnd::
TownMapGFX::                      INCBIN "build/gfx/pokegear/town_map.2bpp"           ; 0x0f8e12--0x0f8fc2
TownMapGFXEnd::
HUD_GFX::                         INCBIN "build/gfx/hud/hud.2bpp"                     ; 0x0f8fc2--0x0f9052
HUD_GFXEnd::
BoldAlphabetGFX::                 INCBIN "build/gfx/font/alphabet.1bpp"
AnnonAlphabetGFX::                INCBIN "build/gfx/font/annon_alphabet.1bpp"
EmptyTile1bppGFX::                INCBIN "build/gfx/misc/empty_tile.1bpp"             ; 0x0f9322--0x0f932a
EmptyTile1bppGFXEnd::
BlackTileAndCursor1bppGFX::       INCBIN "build/gfx/misc/black_tile_cursor.1bpp"      ; 0x0f932a--0x0f933a
BlackTileAndCursor1bppGFXEnd::
PackIconGFX::                     INCBIN "build/gfx/pack/pack_icons.2bpp"             ; 0x0f933a--0x0f941a
PackIconGFXEnd::

SECTION "Town Map Cursor", ROMX[$506F], BANK[$3F]
TownMapCursorGFX::
INCBIN "build/gfx/pokegear/town_map_cursor.2bpp"
