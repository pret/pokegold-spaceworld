INCLUDE "constants.asm"

SECTION "Title Screen Sprites", ROMX[$5EB8], BANK[$01]
TitleFireGFX::
INCBIN "gfx/title/fire.2bpp"
TitleNotesGFX::
INCBIN "gfx/title/notes.2bpp"

SECTION "Mon Nest Icon", ROMX[$4A0F], BANK[$02]
PokedexNestIconGFX::
INCBIN "gfx/pokegear/dexmap_nest_icon.1bpp"

SECTION "Bank 2 Misc GFX", ROMX[$44bf], BANK[$02]
INCBIN "gfx/overworld/gfx_84bf.2bpp"
JumpShadowGFX::
INCBIN "gfx/overworld/shadow.2bpp"
ShockEmoteGFX::
INCBIN "gfx/overworld/shock.2bpp"
QuestionEmoteGFX::
INCBIN "gfx/overworld/question.2bpp"
HappyEmoteGFX::
INCBIN "gfx/overworld/happy.2bpp"

SECTION "Pokegear GFX", ROMX[$4F32], BANK[$02]
PokegearGFX::
INCBIN "gfx/pokegear/pokegear.2bpp"

SECTION "Super Palettes", ROMX[$5B4C], BANK[$02]
INCLUDE "data/pokemon/palettes.inc"
INCLUDE "data/super_palettes.inc"

SECTION "Unused SGB Border GFX", ROMX[$62CC], BANK[$02]
UnusedSGBBorderGFX::
INCBIN "gfx/sgb/sgb_border_alt.2bpp"

SECTION "SGB Border GFX", ROMX[$6B1C], BANK[$02]
SGBBorderGFX::
INCBIN "gfx/sgb/sgb_border.2bpp"

SECTION "Title Screen GFX", ROMX[$47CF], BANK[$04]
TitleScreenGFX::
INCBIN "gfx/title/title.2bpp"

SECTION "Mail Icon GFX", ROMX[$5BB1], BANK[$04]
MailIconGFX::
INCBIN "gfx/icons/mail.2bpp"

SECTION "Trainer Card GFX", ROMX[$7171], BANK[$04]
TrainerCardGFX::
INCBIN "gfx/trainer_card/trainer_card.2bpp"
TrainerCardLeadersGFX::
INCBIN "gfx/trainer_card/leaders.2bpp"

SECTION "Unused Leader", ROMX[$7BA3], BANK[$04]
UnusedLeaderNameGFX::
INCBIN "gfx/trainer_card/unused_leader_name.2bpp"

SECTION "Bank 6 Tilesets 00", ROMX[$4000], BANK[$06]
Tileset_00_GFX:
INCBIN "gfx/tilesets/tileset_00.2bpp"

SECTION "Bank 6 Tilesets 01", ROMX[$5800], BANK[$06]
Tileset_01_GFX:
INCBIN "gfx/tilesets/tileset_01.2bpp"

SECTION "Bank 6 Tilesets 02", ROMX[$6600], BANK[$06]
Tileset_02_GFX:
INCBIN "gfx/tilesets/tileset_02.2bpp"

SECTION "Bank 6 Tilesets 09", ROMX[$7400], BANK[$06]
Tileset_09_GFX:
INCBIN "gfx/tilesets/tileset_09.2bpp"

SECTION "Bank 7 Tilesets 13", ROMX[$4000], BANK[$07]
Tileset_13_GFX:
INCBIN "gfx/tilesets/tileset_13.2bpp"

SECTION "Bank 7 Tilesets 0e", ROMX[$4B00], BANK[$07]
Tileset_0e_GFX:
INCBIN "gfx/tilesets/tileset_0e.2bpp"

SECTION "Bank 7 Tilesets 06", ROMX[$5600], BANK[$07]
Tileset_06_GFX:
INCBIN "gfx/tilesets/tileset_06.2bpp"

SECTION "Bank 7 Tilesets 05", ROMX[$6400], BANK[$07]
Tileset_05_GFX:
INCBIN "gfx/tilesets/tileset_05.2bpp"

SECTION "Bank 7 Tilesets 03", ROMX[$7200], BANK[$07]
Tileset_03_GFX:
INCBIN "gfx/tilesets/tileset_03.2bpp"

SECTION "Bank 8 Tilesets 04", ROMX[$4000], BANK[$08]
Tileset_04_GFX:
INCBIN "gfx/tilesets/tileset_04.2bpp"

SECTION "Bank 8 Tilesets 07", ROMX[$4E00], BANK[$08]
Tileset_07_GFX:
INCBIN "gfx/tilesets/tileset_07.2bpp"

SECTION "Bank 8 Tilesets 08", ROMX[$5C00], BANK[$08]
Tileset_08_GFX:
INCBIN "gfx/tilesets/tileset_08.2bpp"

SECTION "Bank 8 Tilesets 0f", ROMX[$6A00], BANK[$08]
Tileset_0f_GFX:
INCBIN "gfx/tilesets/tileset_0f.2bpp"

SECTION "Bank 8 Tilesets 11", ROMX[$7500], BANK[$08]
Tileset_11_GFX:
INCBIN "gfx/tilesets/tileset_11.2bpp"

SECTION "Gameboy GFX", ROMX[$5641], BANK[$0A]
TradeGameBoyGFX::
INCBIN "gfx/trade/gameboy.2bpp"

SECTION "Bank C Tilesets 12", ROMX[$4000], BANK[$0C]
Tileset_12_GFX:
INCBIN "gfx/tilesets/tileset_12.2bpp"

SECTION "Bank C Tilesets 0b", ROMX[$4B00], BANK[$0C]
Tileset_0b_GFX:
INCBIN "gfx/tilesets/tileset_0b.2bpp"

SECTION "Bank C Tilesets 0d", ROMX[$5600], BANK[$0C]
Tileset_0d_GFX:
INCBIN "gfx/tilesets/tileset_0d.2bpp"

SECTION "Bank C Tilesets 14", ROMX[$6100], BANK[$0C]
Tileset_14_GFX:
INCBIN "gfx/tilesets/tileset_14.2bpp"

SECTION "Bank C Tilesets 0c", ROMX[$7100], BANK[$0C]
Tileset_0c_GFX:
INCBIN "gfx/tilesets/tileset_0c.2bpp"

SECTION "Pokedex GFX", ROMX[$40D5], BANK[$11]
PokedexButtonsGFX::
INCBIN "gfx/pokedex/buttons.2bpp"
PokedexPokeBallGFX::
INCBIN "gfx/pokedex/poke_ball.2bpp"
PokedexCursorsGFX::
INCBIN "gfx/pokedex/cursors.2bpp"
PokedexSearchGFX::
INCBIN "gfx/pokedex/search.2bpp"

SECTION "Trainer Battle Sprites", ROMX[$4000], BANK[$12]
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
KimonoGirlPic:: INCBIN "gfx/trainer/kimonogirl.pic"
TwinsPic:: INCBIN "gfx/trainer/twins.pic"


SECTION "Bank 13 Tilesets 0a", ROMX[$4000], BANK[$13]
Tileset_0a_GFX:
INCBIN "gfx/tilesets/tileset_0a.2bpp"

SECTION "Bank 13 Tilesets 16", ROMX[$4B00], BANK[$13]
Tileset_16_GFX:
INCBIN "gfx/tilesets/tileset_16.2bpp"

SECTION "Bank 13 Tilesets 19", ROMX[$5B00], BANK[$13]
Tileset_19_GFX:
INCBIN "gfx/tilesets/tileset_19.2bpp"

SECTION "Bank 13 Tilesets 1a", ROMX[$6900], BANK[$13]
Tileset_1a_GFX:
INCBIN "gfx/tilesets/tileset_1a.2bpp"

SECTION "PKMN Sprite Bank List", ROMX[$725C], BANK[$14]
INCLUDE "gfx/pokemon/pkmn_pic_banks.asm"

INCLUDE "gfx/pokemon/pkmn_pics.asm"


SECTION "Annon Pic Ptrs and Pics", ROMX[$4d6a], BANK[$1f]
INCLUDE "gfx/pokemon/annon_pic_ptrs.asm"
INCLUDE "gfx/pokemon/annon_pics.asm"

INCLUDE "gfx/pokemon/egg.asm"

SECTION "Attack Animation GFX", ROMX[$4000], BANK[$21]
INCBIN "gfx/battle_anims/attack_animations.2bpp"

SECTION "Pokemon Party Sprites", ROMX[$60CC], BANK[$23]
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

SECTION "Slot Machine GFX", ROMX[$4FDB], BANK[$24]
SlotMachineGFX::
INCBIN "gfx/minigames/slots.2bpp"
SlotMachine2GFX::
INCBIN "gfx/minigames/slots_2.2bpp"

SECTION "Bank 30 Sprites 1", ROMX[$4000], BANK[$30]
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

SECTION "Bank 31 Sprites 2", ROMX[$4000], BANK[$31]
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

SECTION "Bank 37 Tilesets 10", ROMX[$4000], BANK[$37]
Tileset_10_GFX:
INCBIN "gfx/tilesets/tileset_10.2bpp"

SECTION "Bank 37 Tilesets 15", ROMX[$4B00], BANK[$37]
Tileset_15_GFX:
INCBIN "gfx/tilesets/tileset_15.2bpp"

SECTION "Bank 37 Tilesets 17", ROMX[$5B00], BANK[$37]
Tileset_17_GFX:
INCBIN "gfx/tilesets/tileset_17.2bpp"

SECTION "Bank 37 Tilesets 18", ROMX[$6B00], BANK[$37]
Tileset_18_GFX:
INCBIN "gfx/tilesets/tileset_18.2bpp"

SECTION "Poker GFX", ROMX[$5403], BANK[$38]
PokerGFX::
INCBIN "gfx/minigames/poker.2bpp"

SECTION "15 Puzzle GFX", ROMX[$5F93], BANK[$38]
FifteenPuzzleGFX::
INCBIN "gfx/minigames/15_puzzle.2bpp"

SECTION "Matches GFX", ROMX[$6606], BANK[$38]
MemoryGameGFX::
INCBIN "gfx/minigames/matches.2bpp"

SECTION "Picross GFX", ROMX[$75B7], BANK[$38]
PicrossGFX::
INCBIN "gfx/minigames/picross.2bpp"
PicrossCursorGFX::
INCBIN "gfx/minigames/picross_cursor.2bpp"

SECTION "Gamefreak Logo GFX", ROMX[$41FF], BANK[$39]
GameFreakLogoGFX::
INCBIN "gfx/splash/game_freak_logo.1bpp"
GameFreakLogoSparkleGFX::
INCBIN "gfx/splash/game_freak_logo_oam.2bpp"

SECTION "Intro Underwater GFX", ROMX[$4ADF], BANK[$39]
IntroUnderwaterGFX::
INCBIN "gfx/intro/underwater.2bpp"

SECTION "Intro Water Mon and Forest GFX", ROMX[$55EF], BANK[$39]
IntroWaterPokemonGFX::
INCBIN "gfx/intro/water_pokemon.2bpp"
IntroForestGFX::
INCBIN "gfx/intro/forest.2bpp"

SECTION "Intro Mon", ROMX[$626F], BANK[$39]
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

SECTION "Misc GFX", ROMX[$4162], BANK[$3E]
FontExtraGFX::
INCBIN "gfx/font/font_extra.2bpp"
FontGFX::
INCBIN "gfx/font/font.1bpp"
FontBattleExtraGFX::
INCBIN "gfx/font/font_battle_extra.2bpp"
FrameGFX::
INCBIN "gfx/frames/1.1bpp"
INCBIN "gfx/frames/2.1bpp"
INCBIN "gfx/frames/3.1bpp"
INCBIN "gfx/frames/4.1bpp"
INCBIN "gfx/frames/5.1bpp"
INCBIN "gfx/frames/6.1bpp"
INCBIN "gfx/frames/7.1bpp"
INCBIN "gfx/frames/8.1bpp"
INCBIN "gfx/frames/9.1bpp"
StatsSeparatorGFX::
INCBIN "gfx/stats/separator.2bpp"
StatsGFX::
INCBIN "gfx/stats/stats.2bpp"
HPExpBarBorderGFX::
INCBIN "gfx/battle/hp_exp_bar_border.1bpp"
ExpBarGFX::
INCBIN "gfx/battle/exp_bar.2bpp"
PokedexUnitsGFX::
INCBIN "gfx/pokedex/m_kg.2bpp"
PokedexGFX::
INCBIN "gfx/pokedex/pokedex.2bpp"
TownMapGFX::
INCBIN "gfx/pokegear/town_map.2bpp"
HUD_GFX::
INCBIN "gfx/hud/hud.2bpp"
BoldAlphabetGFX::
INCBIN "gfx/font/alphabet.1bpp"
AnnonAlphabetGFX::
INCBIN "gfx/font/annon_alphabet.1bpp"
INCBIN "gfx/font/gfx_f9322.1bpp"
PackIconGFX::
INCBIN "gfx/pack/pack_icons.2bpp"

SECTION "Town Map Cursor", ROMX[$506F], BANK[$3F]
TownMapCursorGFX::
INCBIN "gfx/pokegear/town_map_cursor.2bpp"
