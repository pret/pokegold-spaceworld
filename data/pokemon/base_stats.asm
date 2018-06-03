INCLUDE "constants.asm"

SECTION "Base Data", ROMX[$4F10], BANK[$14]

tmhm: MACRO
; used in data/pokemon/base_stats/*.asm
tms1 = 0 ; TM01-TM24 (24)
tms2 = 0 ; TM25-TM48 (24)
tms3 = 0 ; TM49-TM50 + HM01-HM07 (9)
rept _NARG
	if 0 < \1 && \1 <= (NUM_TMS_HMS + 7) / 8 * 8
	if \1 < 24 + 1
tms1 = tms1 | (1 << ((\1) - 1))
	elif \1 < 48 + 1
tms2 = tms2 | (1 << ((\1) - 1 - 24))
	else
tms3 = tms3 | (1 << ((\1) - 1 - 48))
	endc
	else
		fail "\1 is not a TM/HM number"
	endc
	shift
endr
rept 3 ; TM01-TM24 (24/24)
	db tms1 & $ff
tms1 = tms1 >> 8
endr
rept 3 ; TM25-TM48 (24/24)
	db tms2 & $ff
tms2 = tms2 >> 8
endr
rept 2 ; TM49-TM50 + HM01-HM07 (9/16)
	db tms3 & $ff
tms3 = tms3 >> 8
endr
ENDM

BaseData::
MonBaseStats::
BaseStats_Fushigidane:: INCLUDE "data/pokemon/base_stats/fushigidane.inc"
MonBaseStatsEnd::
BaseStats_Fushigisou:: INCLUDE "data/pokemon/base_stats/fushigisou.inc"
BaseStats_Fushigibana:: INCLUDE "data/pokemon/base_stats/fushigibana.inc"
BaseStats_Hitokage:: INCLUDE "data/pokemon/base_stats/hitokage.inc"
BaseStats_Lizardo:: INCLUDE "data/pokemon/base_stats/lizardo.inc"
BaseStats_Lizardon:: INCLUDE "data/pokemon/base_stats/lizardon.inc"
BaseStats_Zenigame:: INCLUDE "data/pokemon/base_stats/zenigame.inc"
BaseStats_Kameil:: INCLUDE "data/pokemon/base_stats/kameil.inc"
BaseStats_Kamex:: INCLUDE "data/pokemon/base_stats/kamex.inc"
BaseStats_Caterpie:: INCLUDE "data/pokemon/base_stats/caterpie.inc"
BaseStats_Transel:: INCLUDE "data/pokemon/base_stats/transel.inc"
BaseStats_Butterfree:: INCLUDE "data/pokemon/base_stats/butterfree.inc"
BaseStats_Beedle:: INCLUDE "data/pokemon/base_stats/beedle.inc"
BaseStats_Cocoon:: INCLUDE "data/pokemon/base_stats/cocoon.inc"
BaseStats_Spear:: INCLUDE "data/pokemon/base_stats/spear.inc"
BaseStats_Poppo:: INCLUDE "data/pokemon/base_stats/poppo.inc"
BaseStats_Pigeon:: INCLUDE "data/pokemon/base_stats/pigeon.inc"
BaseStats_Pigeot:: INCLUDE "data/pokemon/base_stats/pigeot.inc"
BaseStats_Koratta:: INCLUDE "data/pokemon/base_stats/koratta.inc"
BaseStats_Ratta:: INCLUDE "data/pokemon/base_stats/ratta.inc"
BaseStats_Onisuzume:: INCLUDE "data/pokemon/base_stats/onisuzume.inc"
BaseStats_Onidrill:: INCLUDE "data/pokemon/base_stats/onidrill.inc"
BaseStats_Arbo:: INCLUDE "data/pokemon/base_stats/arbo.inc"
BaseStats_Arbok:: INCLUDE "data/pokemon/base_stats/arbok.inc"
BaseStats_Pikachu:: INCLUDE "data/pokemon/base_stats/pikachu.inc"
BaseStats_Raichu:: INCLUDE "data/pokemon/base_stats/raichu.inc"
BaseStats_Sand:: INCLUDE "data/pokemon/base_stats/sand.inc"
BaseStats_Sandpan:: INCLUDE "data/pokemon/base_stats/sandpan.inc"
BaseStats_Nidoran_f:: INCLUDE "data/pokemon/base_stats/nidoran_f.inc"
BaseStats_Nidorina:: INCLUDE "data/pokemon/base_stats/nidorina.inc"
BaseStats_Nidoqueen:: INCLUDE "data/pokemon/base_stats/nidoqueen.inc"
BaseStats_Nidoran_m:: INCLUDE "data/pokemon/base_stats/nidoran_m.inc"
BaseStats_Nidorino:: INCLUDE "data/pokemon/base_stats/nidorino.inc"
BaseStats_Nidoking:: INCLUDE "data/pokemon/base_stats/nidoking.inc"
BaseStats_Pippi:: INCLUDE "data/pokemon/base_stats/pippi.inc"
BaseStats_Pixy:: INCLUDE "data/pokemon/base_stats/pixy.inc"
BaseStats_Rokon:: INCLUDE "data/pokemon/base_stats/rokon.inc"
BaseStats_Kyukon:: INCLUDE "data/pokemon/base_stats/kyukon.inc"
BaseStats_Purin:: INCLUDE "data/pokemon/base_stats/purin.inc"
BaseStats_Pukurin:: INCLUDE "data/pokemon/base_stats/pukurin.inc"
BaseStats_Zubat:: INCLUDE "data/pokemon/base_stats/zubat.inc"
BaseStats_Golbat:: INCLUDE "data/pokemon/base_stats/golbat.inc"
BaseStats_Nazonokusa:: INCLUDE "data/pokemon/base_stats/nazonokusa.inc"
BaseStats_Kusaihana:: INCLUDE "data/pokemon/base_stats/kusaihana.inc"
BaseStats_Ruffresia:: INCLUDE "data/pokemon/base_stats/ruffresia.inc"
BaseStats_Paras:: INCLUDE "data/pokemon/base_stats/paras.inc"
BaseStats_Parasect:: INCLUDE "data/pokemon/base_stats/parasect.inc"
BaseStats_Kongpang:: INCLUDE "data/pokemon/base_stats/kongpang.inc"
BaseStats_Morphon:: INCLUDE "data/pokemon/base_stats/morphon.inc"
BaseStats_Digda:: INCLUDE "data/pokemon/base_stats/digda.inc"
BaseStats_Dugtrio:: INCLUDE "data/pokemon/base_stats/dugtrio.inc"
BaseStats_Nyarth:: INCLUDE "data/pokemon/base_stats/nyarth.inc"
BaseStats_Persian:: INCLUDE "data/pokemon/base_stats/persian.inc"
BaseStats_Koduck:: INCLUDE "data/pokemon/base_stats/koduck.inc"
BaseStats_Golduck:: INCLUDE "data/pokemon/base_stats/golduck.inc"
BaseStats_Mankey:: INCLUDE "data/pokemon/base_stats/mankey.inc"
BaseStats_Okorizaru:: INCLUDE "data/pokemon/base_stats/okorizaru.inc"
BaseStats_Gardie:: INCLUDE "data/pokemon/base_stats/gardie.inc"
BaseStats_Windie:: INCLUDE "data/pokemon/base_stats/windie.inc"
BaseStats_Nyoromo:: INCLUDE "data/pokemon/base_stats/nyoromo.inc"
BaseStats_Nyorozo:: INCLUDE "data/pokemon/base_stats/nyorozo.inc"
BaseStats_Nyorobon:: INCLUDE "data/pokemon/base_stats/nyorobon.inc"
BaseStats_Casey:: INCLUDE "data/pokemon/base_stats/casey.inc"
BaseStats_Yungerer:: INCLUDE "data/pokemon/base_stats/yungerer.inc"
BaseStats_Foodin:: INCLUDE "data/pokemon/base_stats/foodin.inc"
BaseStats_Wanriky:: INCLUDE "data/pokemon/base_stats/wanriky.inc"
BaseStats_Goriky:: INCLUDE "data/pokemon/base_stats/goriky.inc"
BaseStats_Kairiky:: INCLUDE "data/pokemon/base_stats/kairiky.inc"
BaseStats_Madatsubomi:: INCLUDE "data/pokemon/base_stats/madatsubomi.inc"
BaseStats_Utsudon:: INCLUDE "data/pokemon/base_stats/utsudon.inc"
BaseStats_Utsubot:: INCLUDE "data/pokemon/base_stats/utsubot.inc"
BaseStats_Menokurage:: INCLUDE "data/pokemon/base_stats/menokurage.inc"
BaseStats_Dokukurage:: INCLUDE "data/pokemon/base_stats/dokukurage.inc"
BaseStats_Isitsubute:: INCLUDE "data/pokemon/base_stats/isitsubute.inc"
BaseStats_Golone:: INCLUDE "data/pokemon/base_stats/golone.inc"
BaseStats_Golonya:: INCLUDE "data/pokemon/base_stats/golonya.inc"
BaseStats_Ponyta:: INCLUDE "data/pokemon/base_stats/ponyta.inc"
BaseStats_Gallop:: INCLUDE "data/pokemon/base_stats/gallop.inc"
BaseStats_Yadon:: INCLUDE "data/pokemon/base_stats/yadon.inc"
BaseStats_Yadoran:: INCLUDE "data/pokemon/base_stats/yadoran.inc"
BaseStats_Coil:: INCLUDE "data/pokemon/base_stats/coil.inc"
BaseStats_Rarecoil:: INCLUDE "data/pokemon/base_stats/rarecoil.inc"
BaseStats_Kamonegi:: INCLUDE "data/pokemon/base_stats/kamonegi.inc"
BaseStats_Dodo:: INCLUDE "data/pokemon/base_stats/dodo.inc"
BaseStats_Dodorio:: INCLUDE "data/pokemon/base_stats/dodorio.inc"
BaseStats_Pawou:: INCLUDE "data/pokemon/base_stats/pawou.inc"
BaseStats_Jugon:: INCLUDE "data/pokemon/base_stats/jugon.inc"
BaseStats_Betbeter:: INCLUDE "data/pokemon/base_stats/betbeter.inc"
BaseStats_Betbeton:: INCLUDE "data/pokemon/base_stats/betbeton.inc"
BaseStats_Shellder:: INCLUDE "data/pokemon/base_stats/shellder.inc"
BaseStats_Parshen:: INCLUDE "data/pokemon/base_stats/parshen.inc"
BaseStats_Ghos:: INCLUDE "data/pokemon/base_stats/ghos.inc"
BaseStats_Ghost:: INCLUDE "data/pokemon/base_stats/ghost.inc"
BaseStats_Gangar:: INCLUDE "data/pokemon/base_stats/gangar.inc"
BaseStats_Iwark:: INCLUDE "data/pokemon/base_stats/iwark.inc"
BaseStats_Sleepe:: INCLUDE "data/pokemon/base_stats/sleepe.inc"
BaseStats_Sleeper:: INCLUDE "data/pokemon/base_stats/sleeper.inc"
BaseStats_Crab:: INCLUDE "data/pokemon/base_stats/crab.inc"
BaseStats_Kingler:: INCLUDE "data/pokemon/base_stats/kingler.inc"
BaseStats_Biriridama:: INCLUDE "data/pokemon/base_stats/biriridama.inc"
BaseStats_Marumine:: INCLUDE "data/pokemon/base_stats/marumine.inc"
BaseStats_Tamatama:: INCLUDE "data/pokemon/base_stats/tamatama.inc"
BaseStats_Nassy:: INCLUDE "data/pokemon/base_stats/nassy.inc"
BaseStats_Karakara:: INCLUDE "data/pokemon/base_stats/karakara.inc"
BaseStats_Garagara:: INCLUDE "data/pokemon/base_stats/garagara.inc"
BaseStats_Sawamular:: INCLUDE "data/pokemon/base_stats/sawamular.inc"
BaseStats_Ebiwalar:: INCLUDE "data/pokemon/base_stats/ebiwalar.inc"
BaseStats_Beroringa:: INCLUDE "data/pokemon/base_stats/beroringa.inc"
BaseStats_Dogars:: INCLUDE "data/pokemon/base_stats/dogars.inc"
BaseStats_Matadogas:: INCLUDE "data/pokemon/base_stats/matadogas.inc"
BaseStats_Sihorn:: INCLUDE "data/pokemon/base_stats/sihorn.inc"
BaseStats_Sidon:: INCLUDE "data/pokemon/base_stats/sidon.inc"
BaseStats_Lucky:: INCLUDE "data/pokemon/base_stats/lucky.inc"
BaseStats_Monjara:: INCLUDE "data/pokemon/base_stats/monjara.inc"
BaseStats_Garura:: INCLUDE "data/pokemon/base_stats/garura.inc"
BaseStats_Tattu:: INCLUDE "data/pokemon/base_stats/tattu.inc"
BaseStats_Seadra:: INCLUDE "data/pokemon/base_stats/seadra.inc"
BaseStats_Tosakinto:: INCLUDE "data/pokemon/base_stats/tosakinto.inc"
BaseStats_Azumao:: INCLUDE "data/pokemon/base_stats/azumao.inc"
BaseStats_Hitodeman:: INCLUDE "data/pokemon/base_stats/hitodeman.inc"
BaseStats_Starmie:: INCLUDE "data/pokemon/base_stats/starmie.inc"
BaseStats_Barrierd:: INCLUDE "data/pokemon/base_stats/barrierd.inc"
BaseStats_Strike:: INCLUDE "data/pokemon/base_stats/strike.inc"
BaseStats_Rougela:: INCLUDE "data/pokemon/base_stats/rougela.inc"
BaseStats_Eleboo:: INCLUDE "data/pokemon/base_stats/eleboo.inc"
BaseStats_Boober:: INCLUDE "data/pokemon/base_stats/boober.inc"
BaseStats_Kailios:: INCLUDE "data/pokemon/base_stats/kailios.inc"
BaseStats_Kentauros:: INCLUDE "data/pokemon/base_stats/kentauros.inc"
BaseStats_Koiking:: INCLUDE "data/pokemon/base_stats/koiking.inc"
BaseStats_Gyarados:: INCLUDE "data/pokemon/base_stats/gyarados.inc"
BaseStats_Laplace:: INCLUDE "data/pokemon/base_stats/laplace.inc"
BaseStats_Metamon:: INCLUDE "data/pokemon/base_stats/metamon.inc"
BaseStats_Eievui:: INCLUDE "data/pokemon/base_stats/eievui.inc"
BaseStats_Showers:: INCLUDE "data/pokemon/base_stats/showers.inc"
BaseStats_Thunders:: INCLUDE "data/pokemon/base_stats/thunders.inc"
BaseStats_Booster:: INCLUDE "data/pokemon/base_stats/booster.inc"
BaseStats_Porygon:: INCLUDE "data/pokemon/base_stats/porygon.inc"
BaseStats_Omnite:: INCLUDE "data/pokemon/base_stats/omnite.inc"
BaseStats_Omstar:: INCLUDE "data/pokemon/base_stats/omstar.inc"
BaseStats_Kabuto:: INCLUDE "data/pokemon/base_stats/kabuto.inc"
BaseStats_Kabutops:: INCLUDE "data/pokemon/base_stats/kabutops.inc"
BaseStats_Ptera:: INCLUDE "data/pokemon/base_stats/ptera.inc"
BaseStats_Kabigon:: INCLUDE "data/pokemon/base_stats/kabigon.inc"
BaseStats_Freezer:: INCLUDE "data/pokemon/base_stats/freezer.inc"
BaseStats_Thunder:: INCLUDE "data/pokemon/base_stats/thunder.inc"
BaseStats_Fire:: INCLUDE "data/pokemon/base_stats/fire.inc"
BaseStats_Miniryu:: INCLUDE "data/pokemon/base_stats/miniryu.inc"
BaseStats_Hakuryu:: INCLUDE "data/pokemon/base_stats/hakuryu.inc"
BaseStats_Kairyu:: INCLUDE "data/pokemon/base_stats/kairyu.inc"
BaseStats_Mewtwo:: INCLUDE "data/pokemon/base_stats/mewtwo.inc"
BaseStats_Mew:: INCLUDE "data/pokemon/base_stats/mew.inc"
BaseStats_Happa:: INCLUDE "data/pokemon/base_stats/happa.inc"
BaseStats_Hanamogura:: INCLUDE "data/pokemon/base_stats/hanamogura.inc"
BaseStats_Hanaryu:: INCLUDE "data/pokemon/base_stats/hanaryu.inc"
BaseStats_Honoguma:: INCLUDE "data/pokemon/base_stats/honoguma.inc"
BaseStats_Volbear:: INCLUDE "data/pokemon/base_stats/volbear.inc"
BaseStats_Dynabear:: INCLUDE "data/pokemon/base_stats/dynabear.inc"
BaseStats_Kurusu:: INCLUDE "data/pokemon/base_stats/kurusu.inc"
BaseStats_Aqua:: INCLUDE "data/pokemon/base_stats/aqua.inc"
BaseStats_Aquaria:: INCLUDE "data/pokemon/base_stats/aquaria.inc"
BaseStats_Hoho:: INCLUDE "data/pokemon/base_stats/hoho.inc"
BaseStats_Bobo:: INCLUDE "data/pokemon/base_stats/bobo.inc"
BaseStats_Pachimee:: INCLUDE "data/pokemon/base_stats/pachimee.inc"
BaseStats_Mokoko:: INCLUDE "data/pokemon/base_stats/mokoko.inc"
BaseStats_Denryu:: INCLUDE "data/pokemon/base_stats/denryu.inc"
BaseStats_Mikon:: INCLUDE "data/pokemon/base_stats/mikon.inc"
BaseStats_Monja:: INCLUDE "data/pokemon/base_stats/monja.inc"
BaseStats_Jaranra:: INCLUDE "data/pokemon/base_stats/jaranra.inc"
BaseStats_Haneei:: INCLUDE "data/pokemon/base_stats/haneei.inc"
BaseStats_Puku:: INCLUDE "data/pokemon/base_stats/puku.inc"
BaseStats_Shibirefugu:: INCLUDE "data/pokemon/base_stats/shibirefugu.inc"
BaseStats_Pichu:: INCLUDE "data/pokemon/base_stats/pichu.inc"
BaseStats_Py:: INCLUDE "data/pokemon/base_stats/py.inc"
BaseStats_Pupurin:: INCLUDE "data/pokemon/base_stats/pupurin.inc"
BaseStats_Mizuuo:: INCLUDE "data/pokemon/base_stats/mizuuo.inc"
BaseStats_Naty:: INCLUDE "data/pokemon/base_stats/naty.inc"
BaseStats_Natio:: INCLUDE "data/pokemon/base_stats/natio.inc"
BaseStats_Gyopin:: INCLUDE "data/pokemon/base_stats/gyopin.inc"
BaseStats_Maril:: INCLUDE "data/pokemon/base_stats/maril.inc"
BaseStats_Manbo1:: INCLUDE "data/pokemon/base_stats/manbo1.inc"
BaseStats_Ikari:: INCLUDE "data/pokemon/base_stats/ikari.inc"
BaseStats_Grotess:: INCLUDE "data/pokemon/base_stats/grotess.inc"
BaseStats_Eksing:: INCLUDE "data/pokemon/base_stats/eksing.inc"
BaseStats_Para:: INCLUDE "data/pokemon/base_stats/para.inc"
BaseStats_Kokumo:: INCLUDE "data/pokemon/base_stats/kokumo.inc"
BaseStats_Twohead:: INCLUDE "data/pokemon/base_stats/twohead.inc"
BaseStats_Yoroidori:: INCLUDE "data/pokemon/base_stats/yoroidori.inc"
BaseStats_Animon:: INCLUDE "data/pokemon/base_stats/animon.inc"
BaseStats_Hinazu:: INCLUDE "data/pokemon/base_stats/hinazu.inc"
BaseStats_Sunny:: INCLUDE "data/pokemon/base_stats/sunny.inc"
BaseStats_Paon:: INCLUDE "data/pokemon/base_stats/paon.inc"
BaseStats_Donphan:: INCLUDE "data/pokemon/base_stats/donphan.inc"
BaseStats_Twinz:: INCLUDE "data/pokemon/base_stats/twinz.inc"
BaseStats_Kirinriki:: INCLUDE "data/pokemon/base_stats/kirinriki.inc"
BaseStats_Painter:: INCLUDE "data/pokemon/base_stats/painter.inc"
BaseStats_Kounya:: INCLUDE "data/pokemon/base_stats/kounya.inc"
BaseStats_Rinrin:: INCLUDE "data/pokemon/base_stats/rinrin.inc"
BaseStats_Berurun:: INCLUDE "data/pokemon/base_stats/berurun.inc"
BaseStats_Nyorotono:: INCLUDE "data/pokemon/base_stats/nyorotono.inc"
BaseStats_Yadoking:: INCLUDE "data/pokemon/base_stats/yadoking.inc"
BaseStats_Annon:: INCLUDE "data/pokemon/base_stats/annon.inc"
BaseStats_Rediba:: INCLUDE "data/pokemon/base_stats/rediba.inc"
BaseStats_Mitsuboshi:: INCLUDE "data/pokemon/base_stats/mitsuboshi.inc"
BaseStats_Puchicorn:: INCLUDE "data/pokemon/base_stats/puchicorn.inc"
BaseStats_Eifie:: INCLUDE "data/pokemon/base_stats/eifie.inc"
BaseStats_Blacky:: INCLUDE "data/pokemon/base_stats/blacky.inc"
BaseStats_Turban:: INCLUDE "data/pokemon/base_stats/turban.inc"
BaseStats_Betbaby:: INCLUDE "data/pokemon/base_stats/betbaby.inc"
BaseStats_Teppouo:: INCLUDE "data/pokemon/base_stats/teppouo.inc"
BaseStats_Okutank:: INCLUDE "data/pokemon/base_stats/okutank.inc"
BaseStats_Gongu:: INCLUDE "data/pokemon/base_stats/gongu.inc"
BaseStats_Kapoerer:: INCLUDE "data/pokemon/base_stats/kapoerer.inc"
BaseStats_Pudie:: INCLUDE "data/pokemon/base_stats/pudie.inc"
BaseStats_Haneko:: INCLUDE "data/pokemon/base_stats/haneko.inc"
BaseStats_Poponeko:: INCLUDE "data/pokemon/base_stats/poponeko.inc"
BaseStats_Wataneko:: INCLUDE "data/pokemon/base_stats/wataneko.inc"
BaseStats_Baririna:: INCLUDE "data/pokemon/base_stats/baririna.inc"
BaseStats_Lip:: INCLUDE "data/pokemon/base_stats/lip.inc"
BaseStats_Elebaby:: INCLUDE "data/pokemon/base_stats/elebaby.inc"
BaseStats_Booby:: INCLUDE "data/pokemon/base_stats/booby.inc"
BaseStats_Kireihana:: INCLUDE "data/pokemon/base_stats/kireihana.inc"
BaseStats_Tsubomitto:: INCLUDE "data/pokemon/base_stats/tsubomitto.inc"
BaseStats_Miltank:: INCLUDE "data/pokemon/base_stats/miltank.inc"
BaseStats_Bombseeker:: INCLUDE "data/pokemon/base_stats/bombseeker.inc"
BaseStats_Gift:: INCLUDE "data/pokemon/base_stats/gift.inc"
BaseStats_Kotora:: INCLUDE "data/pokemon/base_stats/kotora.inc"
BaseStats_Raitora:: INCLUDE "data/pokemon/base_stats/raitora.inc"
BaseStats_Madame:: INCLUDE "data/pokemon/base_stats/madame.inc"
BaseStats_Norowara:: INCLUDE "data/pokemon/base_stats/norowara.inc"
BaseStats_Kyonpan:: INCLUDE "data/pokemon/base_stats/kyonpan.inc"
BaseStats_Yamikarasu:: INCLUDE "data/pokemon/base_stats/yamikarasu.inc"
BaseStats_Happi:: INCLUDE "data/pokemon/base_stats/happi.inc"
BaseStats_Scissors:: INCLUDE "data/pokemon/base_stats/scissors.inc"
BaseStats_Purakkusu:: INCLUDE "data/pokemon/base_stats/purakkusu.inc"
BaseStats_Devil:: INCLUDE "data/pokemon/base_stats/devil.inc"
BaseStats_Helgaa:: INCLUDE "data/pokemon/base_stats/helgaa.inc"
BaseStats_Wolfman:: INCLUDE "data/pokemon/base_stats/wolfman.inc"
BaseStats_Warwolf:: INCLUDE "data/pokemon/base_stats/warwolf.inc"
BaseStats_Porygon2:: INCLUDE "data/pokemon/base_stats/porygon2.inc"
BaseStats_Nameil:: INCLUDE "data/pokemon/base_stats/nameil.inc"
BaseStats_Haganeil:: INCLUDE "data/pokemon/base_stats/haganeil.inc"
BaseStats_Kingdra:: INCLUDE "data/pokemon/base_stats/kingdra.inc"
BaseStats_Rai:: INCLUDE "data/pokemon/base_stats/rai.inc"
BaseStats_En:: INCLUDE "data/pokemon/base_stats/en.inc"
BaseStats_Sui:: INCLUDE "data/pokemon/base_stats/sui.inc"
BaseStats_Nyula:: INCLUDE "data/pokemon/base_stats/nyula.inc"
BaseStats_Houou:: INCLUDE "data/pokemon/base_stats/houou.inc"
BaseStats_Togepy:: INCLUDE "data/pokemon/base_stats/togepy.inc"
BaseStats_Bulu:: INCLUDE "data/pokemon/base_stats/bulu.inc"
BaseStats_Tail:: INCLUDE "data/pokemon/base_stats/tail.inc"
BaseStats_Leafy:: INCLUDE "data/pokemon/base_stats/leafy.inc"
