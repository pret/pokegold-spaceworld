INCLUDE "constants.asm"

; entry format:
;	db category
;	db height (meters * 10)
;	dw weight (kilograms * 10)
;	db entry text

SECTION "data/pokemon/dex_entries.asm", ROMX

PokedexEntryPointers1::
	dw BulbasaurDexEntry
	dw IvysaurDexEntry
	dw VenusaurDexEntry
	dw CharmanderDexEntry
	dw CharmeleonDexEntry
	dw CharizardDexEntry
	dw SquirtleDexEntry
	dw WartortleDexEntry
	dw BlastoiseDexEntry
	dw CaterpieDexEntry
	dw MetapodDexEntry
	dw ButterfreeDexEntry
	dw WeedleDexEntry
	dw KakunaDexEntry
	dw BeedrillDexEntry
	dw PidgeyDexEntry
	dw PidgeottoDexEntry
	dw PidgeotDexEntry
	dw RattataDexEntry
	dw RaticateDexEntry
	dw SpearowDexEntry
	dw FearowDexEntry
	dw EkansDexEntry
	dw ArbokDexEntry
	dw PikachuDexEntry
	dw RaichuDexEntry
	dw SandshrewDexEntry
	dw SandslashDexEntry
	dw NidoranFDexEntry
	dw NidorinaDexEntry
	dw NidoqueenDexEntry
	dw NidoranMDexEntry
	dw NidorinoDexEntry
	dw NidokingDexEntry
	dw ClefairyDexEntry
	dw ClefableDexEntry
	dw VulpixDexEntry
	dw NinetalesDexEntry
	dw JigglypuffDexEntry
	dw WigglytuffDexEntry
	dw ZubatDexEntry
	dw GolbatDexEntry
	dw OddishDexEntry
	dw GloomDexEntry
	dw VileplumeDexEntry
	dw ParasDexEntry
	dw ParasectDexEntry
	dw VenonatDexEntry
	dw VenomothDexEntry
	dw DiglettDexEntry
	dw DugtrioDexEntry
	dw MeowthDexEntry
	dw PersianDexEntry
	dw PsyduckDexEntry
	dw GolduckDexEntry
	dw MankeyDexEntry
	dw PrimeapeDexEntry
	dw GrowlitheDexEntry
	dw ArcanineDexEntry
	dw PoliwagDexEntry
	dw PoliwhirlDexEntry
	dw PoliwrathDexEntry
	dw AbraDexEntry
	dw KadabraDexEntry
	dw AlakazamDexEntry
	dw MachopDexEntry
	dw MachokeDexEntry
	dw MachampDexEntry
	dw BellsproutDexEntry
	dw WeepinbellDexEntry
	dw VictreebelDexEntry
	dw TentacoolDexEntry
	dw TentacruelDexEntry
	dw GeodudeDexEntry
	dw GravelerDexEntry
	dw GolemDexEntry
	dw PonytaDexEntry
	dw RapidashDexEntry
	dw SlowpokeDexEntry
	dw SlowbroDexEntry
	dw MagnemiteDexEntry
	dw MagnetonDexEntry
	dw FarfetchdDexEntry
	dw DoduoDexEntry
	dw DodrioDexEntry
	dw SeelDexEntry
	dw DewgongDexEntry
	dw GrimerDexEntry
	dw MukDexEntry
	dw ShellderDexEntry
	dw CloysterDexEntry
	dw GastlyDexEntry
	dw HaunterDexEntry
	dw GengarDexEntry
	dw OnixDexEntry
	dw DrowzeeDexEntry
	dw HypnoDexEntry
	dw KrabbyDexEntry
	dw KinglerDexEntry

BulbasaurDexEntry:
	db "たね@"
	db 7
	dw 69
	db   "うまれたときから　せなかに"
	next "なにかの　タネが　うえてあり"
	next "からだと　いっしょに　そだつ。@"

IvysaurDexEntry:
	db "たね@"
	db 10
	dw 130
	db   "せなかに　ハナのつぼみが　あり"
	next "ようぶんを　きゅうしゅう　すると"
	next "だんだん　そだってくる。@"

VenusaurDexEntry:
	db "たね@"
	db 20
	dw 1000
	db   "おおきな　はなを　いじするため"
	next "ひなたをみつけると　まるで"
	next "ひきよせられるように　いどうする。@"

CharmanderDexEntry:
	db "とかげ@"
	db 6
	dw 85
	db   "あついものを　このむ　せいかく。"
	next "しっぽの　ほのおは　こうふんすると"
	next "おんどが　あがっていく。@"

CharmeleonDexEntry:
	db "かえん@"
	db 11
	dw 190
	db   "もえる　シッポを　ふりまわすと"
	next "まわりの　おんどが　どんどん"
	next "あがって　あいてを　くるしめる。@"

CharizardDexEntry:
	db "かえん@"
	db 17
	dw 905
	db   "がんせきも　もえあがるような　"
	next "こうねつの　ほのおを　はいて"
	next "やまかじを　おこすことも　ある。@"

SquirtleDexEntry:
	db "かめのこ@"
	db 5
	dw 90
	db   "うまれたあと　せなかが　ふくらんで"
	next "かたい　こうらが　できる。くちから"
	next "きょうりょくな　あわを　だす。@"

WartortleDexEntry:
	db "かめ@"
	db 10
	dw 225
	db   "しばしば　すいちゅうに　かくれ"
	next "えものを　ねらう。はやく　およぐとき"
	next "みみを　うごかして　バランスをとる。@"

BlastoiseDexEntry:
	db "こうら@"
	db 16
	dw 855
	db   "おもたくて　カラが　かたいため"
	next "のしかかられると　たいていの"
	next "ポケモンは　きを　うしなってしまう。@"

CaterpieDexEntry:
	db "いもむし@"
	db 3
	dw 29
	db   "みどりの　ひふに　おおわれている。"
	next "だっぴして　せいちょうすると"
	next "いとを　かけて　サナギに　かわる。@"

MetapodDexEntry:
	db "さなぎ@"
	db 7
	dw 99
	db   "うすい　カラに　つつまれているが"
	next "なかみは　とても　やわらかく"
	next "つよい　こうげきには　たえられない。@"

ButterfreeDexEntry:
	db "ちょうちょ@"
	db 11
	dw 320
	db   "ハネは　みずを　はじく　りんぷんに"
	next "まもられている。あめの　ひでも"
	next "そらを　とぶことが　できる。@"

WeedleDexEntry:
	db "けむし@"
	db 3
	dw 32
	db   "もりに　おおく　ハッパを　たべる。"
	next "あたまに　するどい　ハリをもち"
	next "さされると　どくに　おかされる。@"

KakunaDexEntry:
	db "さなぎ@"
	db 6
	dw 100
	db   "おとなの　からだを　つくるため"
	next "カラのなかで　へんしんちゅう。"
	next "ほとんど　うごけない。@"

BeedrillDexEntry:
	db "どくばち@"
	db 10
	dw 295
	db   "しゅうだんで　あらわれることもある。"
	next "もうスピードで　とびまわり"
	next "おしりの　どくばりで　さしまくる。@"

PidgeyDexEntry:
	db "ことり@"
	db 3
	dw 18
	db   "もりや　はやしに　おおく　ぶんぷ。"
	next "ちじょうに　おりてきたとき"
	next "はばたいて　すなを　かけたりする。@"

PidgeottoDexEntry:
	db "とり@"
	db 11
	dw 300
	db   "あしの　ツメが　はったつしている。"
	next "エサの　タマタマを　つかんで"
	next "１００キロさきの　す　まで　はこぶ。@"

PidgeotDexEntry:
	db "とり@"
	db 15
	dw 395
	db   "うつくしい　ハネを　ひろげて"
	next "あいてを　いかくする。"
	next "マッハ２で　そらを　とびまわる。@"

RattataDexEntry:
	db "ねずみ@"
	db 3
	dw 35
	db   "なんでも　かじって　こうげき。"
	next "ちいさいうえに　うごきが　すばやく"
	next "いろんな　ところに　しゅつぼつする。@"

RaticateDexEntry:
	db "ねずみ@"
	db 7
	dw 185
	db   "うしろあしの　ゆびは　３ぼんで"
	next "ちいさな　みずかきが　ついている。"
	next "かわを　およいで　わたる。@"

SpearowDexEntry:
	db "ことり@"
	db 3
	dw 20
	db   "くさむらの　むしなどを　たべる。"
	next "はねが　みじかいために　いつも"
	next "いそがしく　はばたいている。@"

FearowDexEntry:
	db "くちばし@"
	db 12
	dw 380
	db   "おおきな　つばさで　おおぞらを"
	next "とびつづけることが　できる。"
	next "１かいも　おりなくても　へいきだ。@"

EkansDexEntry:
	db "へび@"
	db 20
	dw 69
	db   "くさちに　おおく　かくれている。"
	next "こどもの　アーボは　どくをもたない。"
	next "かまれても　だいじょうぶだ。@"

ArbokDexEntry:
	db "コブラ@"
	db 35
	dw 650
	db   "おなかの　もようが　こわいかおに"
	next "みえる。よわいてきは　そのもようを"
	next "みただけで　にげだしてしまう。@"

PikachuDexEntry:
	db "ねずみ@"
	db 4
	dw 60
	db   "ほっぺたの　りょうがわに"
	next "ちいさい　でんきぶくろを　もっていて"
	next "ピンチのときに　ほうでんする。@"

RaichuDexEntry:
	db "ねずみ@"
	db 8
	dw 300
	db   "でんげきは　１０まんボルトに"
	next "たっする。シッポに　さわると"
	next "インドぞうでも　きぜつする。@"

SandshrewDexEntry:
	db "ねずみ@"
	db 6
	dw 120
	db   "みずけの　すくない　ばしょに"
	next "ふかい　あなを　ほって　かくれる。"
	next "えものを　ねらうときは　でてくる。@"

SandslashDexEntry:
	db "ねずみ@"
	db 10
	dw 295
	db   "せなかを　まるめると　トゲトゲの"
	next "ボールみたいだ。そのまま　ころがって"
	next "ぶつかってきたり　にげたりする。　@"

NidoranFDexEntry:
	db "どくばり@"
	db 4
	dw 70
	db   "ちいさくても　どくばりの　いりょくは"
	next "きょうれつで　ちゅういが　ひつよう。"
	next "メスのほうが　つのが　ちいさい。@"

NidorinaDexEntry:
	db "どくばり@"
	db 8
	dw 200
	db   "メスなので　ツノのそだちが　おそい。"
	next "ひっかいたり　かみついたりと"
	next "にくだんせんを　このむ。@"

NidoqueenDexEntry:
	db "ドリル@"
	db 13
	dw 600
	db   "せなかに　はりのような　ウロコが"
	next "びっしりと　はえている。"
	next "こうふんすると　はりが　さかだつ。@"

NidoranMDexEntry:
	db "どくばり@"
	db 5
	dw 90
	db   "ながい　みみを　たてて　きけんを"
	next "かんじとる。からだの　とげが"
	next "おおきいほど　つよい　どくをだす。@"

NidorinoDexEntry:
	db "どくばり@"
	db 9
	dw 195
	db   "すぐに　おこって　たたかおうとする。"
	next "しかも　あたまの　ツノは　ささると"
	next "きょうれつな　どくそをだす　しくみ。@"

NidokingDexEntry:
	db "ドリル@"
	db 14
	dw 620
	db   "ダイヤのように　かたい　ひふと"
	next "ながく　のびた　ツノが　とくちょう。"
	next "ツノに　どくがあるので　ちゅうい。@"

ClefairyDexEntry:
	db "ようせい@"
	db 6
	dw 75
	db   "ふしぎで　かわいいので　おおくの"
	next "ファンがいる。ただし　せいそくちが"
	next "かぎられ　みつけるのが　たいへん。@"

ClefableDexEntry:
	db "ようせい@"
	db 13
	dw 400
	db   "みみが　よくて　１キロ　はなれた"
	next "ところで　おとした　はりのおとを"
	next "みごとに　ききわけられる。@"

VulpixDexEntry:
	db "きつね@"
	db 6
	dw 99
	db   "こどもだが　６ほんの　しっぽが"
	next "うつくしい。せいちょうすると"
	next "さらに　しっぽが　ふえる。@"

NinetalesDexEntry:
	db "きつね@"
	db 11
	dw 199
	db   "おうごんに　かがやく　たいもうと"
	next "９ほんの　ながい　しっぽを　もつ。"
	next "１０００ねん　いきると　いわれる。@"

JigglypuffDexEntry:
	db "ふうせん@"
	db 5
	dw 55
	db   "つぶらな　ひとみが　ゆれるとき"
	next "ねむけを　もよおす　ふしぎで"
	next "きもちのいい　うたを　うたう。@"

WigglytuffDexEntry:
	db "ふうせん@"
	db 10
	dw 120
	db   "キメこまかい　たいもうは"
	next "しなやかで　さわると　きもちいい。"
	next "けがわにすると　うれるという。@"

ZubatDexEntry:
	db "こうもり@"
	db 8
	dw 75
	db   "くらい　ばしょに　しゅうだんで"
	next "はっせいする。ちょうおんぱを　だして"
	next "ターゲットに　ちかづいていく。@"

GolbatDexEntry:
	db "こうもり@"
	db 16
	dw 550
	db   "するどいキバで　かみついて"
	next "いちどに　３００シーシーの"
	next "ちを　すいとってしまう。@"

OddishDexEntry:
	db "ざっそう@"
	db 5
	dw 54
	db   "ひるまは　かおを　じめんに　うめて"
	next "あまり　うごかない。よるに　なると"
	next "たねをまきながら　あるきまわる。@"

GloomDexEntry:
	db "ざっそう@"
	db 8
	dw 86
	db   "めしべが　はなつ　とてつもなく"
	next "くさい　においは　２キロさきまで"
	next "とどき　きを　うしなわせる。@"

VileplumeDexEntry:
	db "フラワー@"
	db 12
	dw 186
	db   "せかいいち　おおきい　はなびらから"
	next "アレルギーを　おこす　かふんを"
	next "オニの　ように　ばらまく。@"

ParasDexEntry:
	db "きのこ@"
	db 3
	dw 54
	db   "むしの　せなかに　はえているのは"
	next "とうちゅうかそう　という　キノコ。"
	next "キノコは　そだって　おおきくなる。@"

ParasectDexEntry:
	db "きのこ@"
	db 10
	dw 295
	db   "キノコの　カサから　どくほうしを"
	next "まきちらす。しかし　ちゅうごくでは"
	next "このほうしを　かんぽうやくに　する。@"

VenonatDexEntry:
	db "こんちゅう@"
	db 10
	dw 300
	db   "おおきな　きのなかに　すみかをつくり"
	next "ほかのむしなどを　たべてるらしい。"
	next "よるは　あかりのそばに　やってくる。@"

VenomothDexEntry:
	db "どくが@"
	db 15
	dw 125
	db   "はねに　りんぷんが　ついていて"
	next "ヒラヒラと　はばたくたびに"
	next "もうどくの　こなを　ばらまく。@"

DiglettDexEntry:
	db "もぐら@"
	db 2
	dw 8
	db   "ちか１メートルくらいを　ほりすすみ"
	next "きのねっこなどを　かじって　いきる。"
	next "たまに　ちじょうに　かおをだす。@"

DugtrioDexEntry:
	db "もぐら@"
	db 7
	dw 333
	db   "ちちゅうを　ほりすすんで"
	next "ゆだんしている　ところを"
	next "べつの　ばしょから　こうげきする。@"

MeowthDexEntry:
	db "ばけねこ@"
	db 4
	dw 42
	db   "ひかる　ものが　だいすきで"
	next "あちこち　おちている　おかねを"
	next "ひろって　くることも　おおい。@"

PersianDexEntry:
	db "シャムネコ@"
	db 10
	dw 320
	db   "きしょうが　はげしく　しっぽを"
	next "まっすぐ　たてたら　よう　ちゅうい。"
	next "とびかかって　かみつく　まえぶれだ。@"

PsyduckDexEntry:
	db "あひる@"
	db 8
	dw 196
	db   "いつも　ずつうに　なやまされている。"
	next "この　ずつうが　はげしくなると"
	next "ふしぎな　ちからを　つかいはじめる。@"

GolduckDexEntry:
	db "あひる@"
	db 17
	dw 766
	db   "てのひらが　みずかきに　なっていて"
	next "およぐのが　とくい。みずうみなどで"
	next "ゆうがな　すがたが　みかけられる。@"

MankeyDexEntry:
	db "ぶたざる@"
	db 5
	dw 280
	db   "みのこなしが　かるく　きょうぼうな"
	next "せいかく。おこって　あばれだすと"
	next "てが　つけられなくなる。@"

PrimeapeDexEntry:
	db "ぶたざる@"
	db 10
	dw 320
	db   "なぜか　もうれつに　おこって"
	next "にげても　にげても　どこまでも"
	next "おいかけてくる　せいかくだ。@"

GrowlitheDexEntry:
	db "こいぬ@"
	db 7
	dw 190
	db   "ひとなつこい　せいかくだが　ひろい"
	next "なわばりを　もっており　ゆだんして"
	next "ちかずくと　こうげきされる。@"

ArcanineDexEntry:
	db "でんせつ@"
	db 19
	dw 1550
	db   "むかしから　おおくの　ひとを"
	next "とりこにした　うつくしい　ポケモン。"
	next "とぶように　かろやかに　はしる。@"

PoliwagDexEntry:
	db "おたま@"
	db 6
	dw 124
	db   "スベスベした　くろいひふは　うすい。"
	next "おなかの　なかが　すけて"
	next "うずまきじょうに　みえる。@"

PoliwhirlDexEntry:
	db "おたま@"
	db 10
	dw 200
	db   "りくでも　すいちゅうでも　くらせる。"
	next "ちじょうでは　いつも　あせをかき"
	next "からだを　ぬめぬめ　させている。@"

PoliwrathDexEntry:
	db "おたま@"
	db 13
	dw 540
	db   "クロールや　バタフライが　とくいで"
	next "オリンピックの　せんしゅでも　"
	next "ぐんぐんと　おいぬいていく。@"

AbraDexEntry:
	db "ねんりき@"
	db 9
	dw 195
	db   "１にち　１８じかんは　ねている。"
	next "ねむってる　あいだでも　さまざまな"
	next "ちょうのうりょくを　つかう。@"

KadabraDexEntry:
	db "ねんりき@"
	db 13
	dw 565
	db   "からだから　とくべつな　アルファはが"
	next "でていて　そばに　ちかよるだけで"
	next "あたまが　いたくなってくる。@"

AlakazamDexEntry:
	db "ねんりき@"
	db 15
	dw 480
	db   "スーパーコンピュータより　すばやく"
	next "けいさんする　ずのうを　もつ。"
	next "ちのうしすうは　だいたい５０００。@"

MachopDexEntry:
	db "かいりき@"
	db 8
	dw 195
	db   "ぜんしんが　きんにくで　できている。"
	next "こどものようで　ありながら"
	next "おとな　１００にんを　なげとばす。@"

MachokeDexEntry:
	db "かいりき@"
	db 15
	dw 705
	db   "つかれることのない　きょうじんな"
	next "にくたい。すごくおもい　にもつを"
	next "はこぶ　しごとなどを　てつだう。@"

MachampDexEntry:
	db "かいりき@"
	db 16
	dw 1300
	db   "はったつした　４ほんの　うでは"
	next "２びょうかんに　１０００ぱつの"
	next "パンチを　くりだすことができる。@"

BellsproutDexEntry:
	db "フラワー@"
	db 7
	dw 40
	db   "ひとの　かおのような　ツボミから"
	next "でんせつの　マンドラゴラの　いっしゅ"
	next "ではないかと　ささやかれている。@"

WeepinbellDexEntry:
	db "ハエとり@"
	db 10
	dw 64
	db   "ハッパの　ぶぶんは　カッターになって"
	next "あいてを　きりさく。くちからは"
	next "なんでも　とかす　えきたいを　はく。@"

VictreebelDexEntry:
	db "ハエとり@"
	db 17
	dw 155
	db   "なんごくに　おおく　はっせいする"
	next "きょうぼうな　しょくぶつ　ポケモン。"
	next "ようかいえきで　なんでも　とかす。@"

TentacoolDexEntry:
	db "くらげ@"
	db 9
	dw 455
	db   "まるで　すいしょうのような"
	next "めだまから　ふしぎな　ひかりの"
	next "ビームを　はっしゃする。@"

TentacruelDexEntry:
	db "くらげ@"
	db 16
	dw 550
	db   "８０ぽん　の　しょくしゅが　じゆうに"
	next "うごく。さされると　どくに　おかされ"
	next "するどい　いたみが　はしる。@"

GeodudeDexEntry:
	db "がんせき@"
	db 4
	dw 20
	db   "そうげんや　やまに　せいそくする。"
	next "いしころに　にていて　きがつかずに"
	next "ふんだり　つまずいたり　してしまう。@"

GravelerDexEntry:
	db "がんせき@"
	db 10
	dw 1050
	db   "たかい　やまの　さかみちを"
	next "ころがりながら　いどうするとき"
	next "じゃまものは　おしつぶしていく。@"

GolemDexEntry:
	db "メガトン@"
	db 14
	dw 3000
	db   "がんせきのような　かたい　からだで"
	next "できている。ダイナマイトで"
	next "ばくはしても　ダメージを　うけない。@"

PonytaDexEntry:
	db "ひのうま@"
	db 10
	dw 300
	db   "からだが　かるく　あしの　ちからが"
	next "ものすごい。１かいの　ジャンプで"
	next "とうきょうタワーも　とびこえる。@"

RapidashDexEntry:
	db "ひのうま@"
	db 17
	dw 950
	db   "じそくは　さいこう　２４０キロ。"
	next "メラメラ　もえながら　しんかんせんと"
	next "おなじ　スピードで　かけぬける。@"

SlowpokeDexEntry:
	db "まぬけ@"
	db 12
	dw 360
	db   "うごきが　のろく　まぬけ。"
	next "たたかれても　５びょう　たってから"
	next "いたさを　かんじるほどだ。@"

SlowbroDexEntry:
	db "やどかり@"
	db 16
	dw 785
	db   "ヤドンが　うみへ　エサを"
	next "とりにいったとき　シェルダーに"
	next "しっぽをかまれ　ヤドランになった。@"

MagnemiteDexEntry:
	db "じしゃく@"
	db 3
	dw 60
	db   "くうちゅうに　ういたまま　いどうして"
	next "さゆうの　ユニットから"
	next "でんじはなどを　ほうしゃする。@"

MagnetonDexEntry:
	db "じしゃく@"
	db 10
	dw 600
	db   "ふくすうの　コイルが　れんけつして"
	next "きょうりょくな　じりょくせんと"
	next "こうでんあつを　ほうしゃする。@"

FarfetchdDexEntry:
	db "かるがも@"
	db 8
	dw 150
	db   "じぶんの　すを　つくるための"
	next "しょくぶつの　クキを　１ぽん"
	next "いつも　もって　あるいている。@"

DoduoDexEntry:
	db "ふたごどり@"
	db 14
	dw 392
	db   "とぶのは　にがてだが　はしるのは　"
	next "はやく　きょだいな　あしあとを"
	next "のこして　だいちを　かけぬける。@"

DodrioDexEntry:
	db "みつごどり@"
	db 18
	dw 852
	db   "３つの　あたまで　こうどな"
	next "さくせんを　あやつる。ねるときも"
	next "どれか　１つは　おきているという。@"

SeelDexEntry:
	db "あしか@"
	db 11
	dw 900
	db   "みずいろの　たいもうに　おおわれた"
	next "ひふは　ぶあつくて　じょうぶ。"
	next "れいか４０ど　でも　かつどうできる。@"

DewgongDexEntry:
	db "あしか@"
	db 17
	dw 1200
	db   "ぜんしんが　まっしろな　けで"
	next "おおわれている。さむさに　つよく"
	next "むしろ　さむいほど　げんきになる。@"

GrimerDexEntry:
	db "ヘドロ@"
	db 9
	dw 300
	db   "つきからの　エックスせんをあびた"
	next "ヘドロが　ベトベターにへんかした。"
	next "きたないモノが　だいこうぶつ。@"

MukDexEntry:
	db "ヘドロ@"
	db 12
	dw 300
	db   "ふだんは　じめんに　まざっていて"
	next "わからない。からだに　さわると"
	next "もうどくに　おかされる。@"

ShellderDexEntry:
	db "２まいがい@"
	db 3
	dw 40
	db   "ダイヤモンドよりも　かたいカラに"
	next "おおわれている。しかし　なかは"
	next "とても　やわらかい。@"

CloysterDexEntry:
	db "２まいがい@"
	db 15
	dw 1325
	db   "カラが　ひじょうに　かたく"
	next "ナパームだんでも　こわせない。"
	next "こうげきするときだけ　ひらく。@"

GastlyDexEntry:
	db "ガスじょう@"
	db 13
	dw 1
	db   "うすい　ガスじょうの　せいめいたい。"
	next "ガスに　つつまれると"
	next "インドぞうも　２びょうで　たおれる。@"

HaunterDexEntry:
	db "ガスじょう@"
	db 16
	dw 1
	db   "くらやみで　だれもいないのに"
	next "みられているような　きがしたら"
	next "そこに　ゴーストが　いるのだ。@"

GengarDexEntry:
	db "シャドー@"
	db 15
	dw 405
	db   "やまで　そうなんしたとき"
	next "いのちをうばいに　くらやみから"
	next "あらわれることが　あるという。@"

OnixDexEntry:
	db "いわへび@"
	db 88
	dw 2100
	db   "せいちょうすると　からだの"
	next "がんせきせいぶんが　へんかして"
	next "くろい　ダイヤモンドのようになる。@"

DrowzeeDexEntry:
	db "さいみん@"
	db 10
	dw 324
	db   "ユメをたべるという　でんせつの　"
	next "いきもの　バクの　しそん。"
	next "さいみんじゅつが　とくいだ。@"

HypnoDexEntry:
	db "さいみん@"
	db 16
	dw 756
	db   "ふりこのようなものを　もちあるく。"
	next "こどもに　さいみんじゅつを　かけて"
	next "どこかへ　つれさるじけんが　あった。@"

KrabbyDexEntry:
	db "さわがに@"
	db 4
	dw 65
	db   "ハサミは　きょうりょくな　ぶきであり"
	next "よこに　あるくとき　からだの"
	next "バランスをとる　やくめも　はたす。@"

KinglerDexEntry:
	db "はさみ@"
	db 13
	dw 600
	db   "ハサミは　１まんばりきの"
	next "スーパーパワーを　ひめているのだが"
	next "おおきすぎて　うまく　うごかない。@"

PokedexEntryPointers2::
	dw VoltorbDexEntry
	dw ElectrodeDexEntry
	dw ExeggcuteDexEntry
	dw ExeggutorDexEntry
	dw CuboneDexEntry
	dw MarowakDexEntry
	dw HitmonleeDexEntry
	dw HitmonchanDexEntry
	dw LickitungDexEntry
	dw KoffingDexEntry
	dw WeezingDexEntry
	dw RhyhornDexEntry
	dw RhydonDexEntry
	dw ChanseyDexEntry
	dw TangelaDexEntry
	dw KangaskhanDexEntry
	dw HorseaDexEntry
	dw SeadraDexEntry
	dw GoldeenDexEntry
	dw SeakingDexEntry
	dw StaryuDexEntry
	dw StarmieDexEntry
	dw MrMimeDexEntry
	dw ScytherDexEntry
	dw JynxDexEntry
	dw ElectabuzzDexEntry
	dw MagmarDexEntry
	dw PinsirDexEntry
	dw TaurosDexEntry
	dw MagikarpDexEntry
	dw GyaradosDexEntry
	dw LaprasDexEntry
	dw DittoDexEntry
	dw EeveeDexEntry
	dw VaporeonDexEntry
	dw JolteonDexEntry
	dw FlareonDexEntry
	dw PorygonDexEntry
	dw OmanyteDexEntry
	dw OmastarDexEntry
	dw KabutoDexEntry
	dw KabutopsDexEntry
	dw AerodactylDexEntry
	dw SnorlaxDexEntry
	dw ArticunoDexEntry
	dw ZapdosDexEntry
	dw MoltresDexEntry
	dw DratiniDexEntry
	dw DragonairDexEntry
	dw DragoniteDexEntry
	dw MewtwoDexEntry
	dw MewDexEntry
	dw HappaDexEntry
	dw HanamoguraDexEntry
	dw HanaryuDexEntry
	dw HonogumaDexEntry
	dw VolbearDexEntry
	dw DynabearDexEntry
	dw KurusuDexEntry
	dw AquaDexEntry
	dw AquariaDexEntry
	dw HohoDexEntry
	dw BoboDexEntry
	dw PachimeeDexEntry
	dw MokokoDexEntry
	dw DenryuDexEntry
	dw MikonDexEntry
	dw MonjaDexEntry
	dw JaranraDexEntry
	dw HaneeiDexEntry
	dw PukuDexEntry
	dw ShibirefuguDexEntry
	dw PichuDexEntry
	dw PyDexEntry
	dw PupurinDexEntry
	dw MizuuoDexEntry
	dw NatyDexEntry
	dw NatioDexEntry
	dw GyopinDexEntry
	dw MarilDexEntry
	dw Manbo1DexEntry
	dw IkariDexEntry
	dw GrotessDexEntry
	dw EksingDexEntry
	dw ParaDexEntry
	dw KokumoDexEntry
	dw TwoheadDexEntry
	dw YoroidoriDexEntry
	dw AnimonDexEntry
	dw HinazuDexEntry
	dw SunnyDexEntry
	dw PaonDexEntry
	dw DonphanDexEntry
	dw TwinzDexEntry
	dw KirinrikiDexEntry
	dw PainterDexEntry
	dw KounyaDexEntry
	dw RinrinDexEntry
	dw BerurunDexEntry
	dw NyorotonoDexEntry
	dw YadokingDexEntry
	dw AnnonDexEntry
	dw RedibaDexEntry
	dw MitsuboshiDexEntry
	dw PuchicornDexEntry
	dw EifieDexEntry
	dw BlackyDexEntry
	dw TurbanDexEntry
	dw BetbabyDexEntry
	dw TeppouoDexEntry
	dw OkutankDexEntry
	dw GonguDexEntry
	dw KapoererDexEntry
	dw PudieDexEntry
	dw HanekoDexEntry
	dw PoponekoDexEntry
	dw WatanekoDexEntry
	dw BaririnaDexEntry
	dw LipDexEntry
	dw NorowaraDexEntry ; should be ElebabyDexEntry
	dw BoobyDexEntry
	dw KireihanaDexEntry
	dw TsubomittoDexEntry
	dw MiltankDexEntry
	dw BombseekerDexEntry
	dw GiftDexEntry
	dw KotoraDexEntry
	dw RaitoraDexEntry
	dw MadameDexEntry
	dw NorowaraDexEntry
	dw KyonpanDexEntry
	dw YamikarasuDexEntry
	dw HappiDexEntry
	dw ScissorsDexEntry
	dw PurakkusuDexEntry
	dw DevilDexEntry
	dw HelgaaDexEntry
	dw WolfmanDexEntry
	dw WarwolfDexEntry
	dw Porygon2DexEntry
	dw NameilDexEntry
	dw HaganeilDexEntry
	dw KingdraDexEntry
	dw RaiDexEntry
	dw EnDexEntry
	dw SuiDexEntry
	dw NyulaDexEntry
	dw HououDexEntry
	dw TogepyDexEntry
	dw BuluDexEntry
	dw TailDexEntry
	dw LeafyDexEntry

VoltorbDexEntry:
	db "ボール@"
	db 5
	dw 104
	db   "はつでんしょなどに　あらわれる。"
	next "モンスターボールと　まちがえて"
	next "さわって　しびれるひとが　おおい。@"

ElectrodeDexEntry:
	db "ボール@"
	db 12
	dw 666
	db   "ぼうだいな　エレクトン　エネルギーを"
	next "ためこんでおり　ちょっとした"
	next "しげきで　だいばくはつを　おこす。@"

ExeggcuteDexEntry:
	db "たまご@"
	db 4
	dw 25
	db   "たまごの　ようだが　じつは"
	next "しょくぶつの　タネのような"
	next "いきものだと　いうことが　わかった。@"

ExeggutorDexEntry:
	db "やしのみ@"
	db 20
	dw 1200
	db   "あるく　ねったいうりん。"
	next "みの　ひとつひとつに"
	next "それぞれ　いしを　もっている。@"

CuboneDexEntry:
	db "こどく@"
	db 4
	dw 65
	db   "しにわかれた　ははおやの　ほねを"
	next "あたまに　かぶっている。さびしいとき"
	next "おおごえで　なくという。@"

MarowakDexEntry:
	db "ほねずき@"
	db 10
	dw 450
	db   "からだも　ちいさく　もともと　"
	next "よわかった。ホネを　つかうようになり"
	next "せいかくが　きょうぼうか　した。@"

HitmonleeDexEntry:
	db "キック@"
	db 15
	dw 498
	db   "あしが　じゆうに　のびちぢみする。"
	next "あいてが　とおく　はなれていても"
	next "かんたんに　けりあげてしまう。@"

HitmonchanDexEntry:
	db "パンチ@"
	db 14
	dw 502
	db   "プロボクサーの　たましいが"
	next "のりうつった。パンチのスピードは"
	next "しんかんせんよりも　はやい。@"

LickitungDexEntry:
	db "なめまわし@"
	db 12
	dw 655
	db   "ベロが　からだの　２ばいも　のびる。"
	next "エサをとったり　こうげきをしたりと"
	next "まるで　てのように　うごくのだ。@"

KoffingDexEntry:
	db "どくガス@"
	db 6
	dw 10
	db   "うすい　バルーンじょうの　からだに"
	next "もうどくの　ガスが　つまっている。"
	next "ちかくに　くるだけで　くさい。@"

WeezingDexEntry:
	db "どくガス@"
	db 12
	dw 95
	db   "ごくまれに　とつぜんへんいで"
	next "ふたごの　ちいさい　ドガースが"
	next "れんけつしたまま　でることがある。@"

RhyhornDexEntry:
	db "とげとげ@"
	db 10
	dw 1150
	db   "あたまは　わるいが　ちからが　つよく"
	next "こうそうビルでも　たいあたりで"
	next "コナゴナに　ふんさいしてしまう。@"

RhydonDexEntry:
	db "ドリル@"
	db 19
	dw 1200
	db   "ぜんしんを　よろいのような　ひふで"
	next "まもっている。２０００どの"
	next "マグマの　なかでも　いきられる。@"

ChanseyDexEntry:
	db "たまご@"
	db 11
	dw 346
	db   "せいそくすうが　すくない。"
	next "つかまえた　ひとには　しあわせを"
	next "もたらすと　いわれている。@"

TangelaDexEntry:
	db "ツルじょう@"
	db 10
	dw 350
	db   "ブルーの　つるしょくぶつが"
	next "からみあい　しょうたいは　みえない。"
	next "ちかずくものに　からみついてくる。@"

KangaskhanDexEntry:
	db "おやこ@"
	db 22
	dw 800
	db   "こどもは　ははおやの　おなかにある"
	next "ふくろから　ほとんど　でてこない。"
	next "やく３ねんで　おやばなれする。@"

HorseaDexEntry:
	db "ドラゴン@"
	db 4
	dw 80
	db   "ぜんまいのように　クルクルまいた"
	next "しっぽで　バランスをとる。"
	next "スミを　はいて　こうげきする。@"

SeadraDexEntry:
	db "ドラゴン@"
	db 12
	dw 250
	db   "ハネと　しっぽを　すばやく　うごかし"
	next "まえを　むいたまま　うしろへ"
	next "およぐことも　できる　ポケモン。@"

GoldeenDexEntry:
	db "きんぎょ@"
	db 6
	dw 150
	db   "せビレ　むなビレが　きんにくのように"
	next "はったつしており　すいちゅうを"
	next "５ノットの　はやさで　およぐ。@"

SeakingDexEntry:
	db "きんぎょ@"
	db 13
	dw 390
	db   "ツノが　ドリルのように　とがっていて"
	next "いわはだを　ツノで　くりぬき"
	next "じぶんの　すを　つくっている。@"

StaryuDexEntry:
	db "ほしがた@"
	db 8
	dw 345
	db   "うみべに　おおく　あらわれ"
	next "よるになると　ちゅうしんが"
	next "あかく　てんめつする。@"

StarmieDexEntry:
	db "なぞの@"
	db 11
	dw 800
	db   "きかがくてきな　ボディーから"
	next "うちゅうせいぶつ　ではないかと"
	next "じもとでは　うたがわれている。@"

MrMimeDexEntry:
	db "バリアー@"
	db 13
	dw 545
	db   "ひとを　しんじこませるのが　うまい。"
	next "パントマイムで　つくったカベが"
	next "ほんとうに　あらわれるという。@"

ScytherDexEntry:
	db "かまきり@"
	db 15
	dw 560
	db   "するどいカマで　えものを　きりさき"
	next "いきのねを　とめる。ごくまれに"
	next "ハネをつかって　とぶことがある。@"

JynxDexEntry:
	db "ひとがた@"
	db 14
	dw 406
	db   "こしを　ふるように　あるいている。"
	next "ゆだんをすると　おもわず　つられて"
	next "おどってしまうという。@"

ElectabuzzDexEntry:
	db "でんげき@"
	db 11
	dw 300
	db   "つよい　でんきが　だいこうぶつで"
	next "おおきな　はつでんしょ　などに　"
	next "しばしば　あらわれる。@"

MagmarDexEntry:
	db "ひふき@"
	db 13
	dw 445
	db   "かざんの　かこうちかくで"
	next "みつかった。くちから　ほのおをはく。"
	next "たいおんは　１２００ど　もある。@"

PinsirDexEntry:
	db "くわがた@"
	db 15
	dw 550
	db   "２ほんの　ながいツノに"
	next "はさまれたら　ちぎれるまで"
	next "はなさないという。@"

TaurosDexEntry:
	db "あばれうし@"
	db 14
	dw 884
	db   "えものに　ねらいを　つけると"
	next "しっぽで　からだを　たたきながら"
	next "まっすぐ　つっこんでくる。@"

MagikarpDexEntry:
	db "さかな@"
	db 9
	dw 100
	db   "ちからも　スピードも　ほとんどダメ。"
	next "せかいで　いちばん　よわくて"
	next "なさけない　ポケモンだ。@"

GyaradosDexEntry:
	db "きょうあく@"
	db 65
	dw 2350
	db   "ひじょうに　きょうぼうで"
	next "くちからだす　はかいこうせんは"
	next "すべてのものを　やきつくす。@"

LaprasDexEntry:
	db "のりもの@"
	db 25
	dw 2200
	db   "かつて　たくさん　つかまえたため"
	next "ぜつめつ　すんぜんに　なっている。"
	next "ひとをのせて　すすむ。@"

DittoDexEntry:
	db "へんしん@"
	db 3
	dw 40
	db   "さいぼうそしきを　いっしゅんで"
	next "コピーして　あいて　そっくりに"
	next "へんしんする　のうりょくがある。@"

EeveeDexEntry:
	db "しんか@"
	db 3
	dw 65
	db   "ふきそくな　いでんしを　もつ。"
	next "いしからでる　ほうしゃせんによって"
	next "からだが　とつぜんへんいを　おこす。@"

VaporeonDexEntry:
	db "あわはき@"
	db 10
	dw 290
	db   "みずべに　すむが　しっぽには"
	next "さかなのような　ひれが　のこっていて"
	next "にんぎょと　まちがう　ひともいる。@"

JolteonDexEntry:
	db "かみなり@"
	db 8
	dw 245
	db   "くうきちゅうの　マイナスイオンを"
	next "すいこんで　やく１００００ボルトの"
	next "でんきを　はきだすことができる。@"

FlareonDexEntry:
	db "ほのお@"
	db 9
	dw 250
	db   "からだに　ほのおを　ためてるとき"
	next "たいおんが　１０００ど　いじょうに"
	next "あがるので　ひじょうに　きけん。@"

PorygonDexEntry:
	db "バーチャル@"
	db 8
	dw 365
	db   "さいこうの　かがくりょくを　あつめ"
	next "ついに　じんこうの　ポケモンを"
	next "つくることに　せいこうした。@"

OmanyteDexEntry:
	db "うずまき@"
	db 4
	dw 75
	db   "ぜつめつした　ポケモンだが　まれに"
	next "かせきが　はっけんされ　そこから"
	next "いきかえらせることが　できる。@"

OmastarDexEntry:
	db "うずまき@"
	db 10
	dw 350
	db   "するどい　キバと　しょくしゅで"
	next "えものに　かみついたら　さいご。"
	next "たいえきを　すいだしてしまう。@"

KabutoDexEntry:
	db "こうら@"
	db 5
	dw 115
	db   "こだい　せいぶつの　かせきから"
	next "さいせいしたポケモン。"
	next "かたい　カラで　みを　まもっている。@"

KabutopsDexEntry:
	db "こうら@"
	db 13
	dw 405
	db   "すいちゅうを　じゆうに　およぎ"
	next "するどい　カマで　えものを　とらえ"
	next "たいえきを　すいとってしまう。@"

AerodactylDexEntry:
	db "かせき@"
	db 18
	dw 590
	db   "こはくに　のこされた　きょうりゅうの"
	next "いでんしから　ふっかつさせた。"
	next "たかいこえで　なきながら　とぶ。@"

SnorlaxDexEntry:
	db "いねむり@"
	db 21
	dw 4600
	db   "１にちに　たべものを　４００キロ"
	next "たべないと　きが　すまない。"
	next "たべおわると　ねむってしまう。@"

ArticunoDexEntry:
	db "れいとう@"
	db 17
	dw 554
	db   "ゆきやまで　さむくて　しにそうなとき"
	next "めのまえに　あらわれるといわれる"
	next "でんせつの　れいとうポケモン。@"

ZapdosDexEntry:
	db "でんげき@"
	db 16
	dw 526
	db   "くもの　うえから　きょだいな"
	next "いなづまを　おとしながら　あらわれる"
	next "でんせつの　とりポケモンである。@"

MoltresDexEntry:
	db "かえん@"
	db 20
	dw 600
	db   "むかしから　ひのとりでんせつとして"
	next "しられる。　はばたくたびに　はねが"
	next "あかるく　もえあがり　うつくしい。@"

DratiniDexEntry:
	db "ドラゴン@"
	db 18
	dw 33
	db   "ながいあいだ　まぼろしの　ポケモンと"
	next "よばれた。わずかだが　すいちゅうに"
	next "すんでいることが　わかった。@"

DragonairDexEntry:
	db "ドラゴン@"
	db 40
	dw 165
	db   "ハネは　ないが　そらを　とべる。"
	next "とぶとき　からだを　しなやかに"
	next "くねらせて　とても　うつくしい。@"

DragoniteDexEntry:
	db "ドラゴン@"
	db 22
	dw 2100
	db   "すがたを　みたひとは　すくないが"
	next "じつざいする　うみのけしん。ちのうも"
	next "にんげんに　ひってき　するらしい。@"

MewtwoDexEntry:
	db "いでんし@"
	db 20
	dw 1220
	db   "けんきゅうの　ために　いでんしを"
	next "どんどん　くみかえていった　けっか"
	next "きょうぼうな　ポケモンに　なった。@"

MewDexEntry:
	db "しんしゅ@"
	db 4
	dw 40
	db   "いまでも　まぼろしの　ポケモンと"
	next "いわれる。そのすがたを　みたものは"
	next "ぜんこくでも　ほとんど　いない。@"

HappaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HanamoguraDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HanaryuDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HonogumaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

VolbearDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DynabearDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KurusuDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

AquaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

AquariaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HohoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

BoboDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PachimeeDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

MokokoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DenryuDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

MikonDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

MonjaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

JaranraDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HaneeiDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PukuDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

ShibirefuguDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PichuDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PupurinDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

MizuuoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

NatyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

NatioDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

GyopinDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

MarilDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

Manbo1DexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

IkariDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

GrotessDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

EksingDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

ParaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KokumoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

TwoheadDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

YoroidoriDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

AnimonDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HinazuDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

SunnyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PaonDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DonphanDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

TwinzDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KirinrikiDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PainterDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KounyaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

RinrinDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

BerurunDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

NyorotonoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

YadokingDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

AnnonDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

RedibaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

MitsuboshiDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PuchicornDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

EifieDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

BlackyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

TurbanDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

BetbabyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

TeppouoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

OkutankDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

GonguDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KapoererDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PudieDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HanekoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PoponekoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

WatanekoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

BaririnaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

LipDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

ElebabyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

BoobyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KireihanaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

TsubomittoDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

MiltankDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

BombseekerDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

GiftDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KotoraDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

RaitoraDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

MadameDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

NorowaraDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KyonpanDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

YamikarasuDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HappiDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

ScissorsDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

PurakkusuDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DevilDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HelgaaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

WolfmanDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

WarwolfDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

Porygon2DexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

NameilDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HaganeilDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

KingdraDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

RaiDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

EnDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

SuiDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

NyulaDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

HououDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

TogepyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

BuluDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

TailDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

LeafyDexEntry:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"
