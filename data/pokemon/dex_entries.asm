INCLUDE "constants.asm"

; entry format:
;	db category
;	db height (meters * 10)
;	dw weight (kilograms * 10)
;	db entry text

SECTION "data/pokemon/dex_entries.asm", ROMX

PokedexEntryPointers1::
	dw DexEntry_4a0b
	dw DexEntry_4a3e
	dw DexEntry_4a72
	dw DexEntry_4aa8
	dw DexEntry_4adf
	dw DexEntry_4b16
	dw DexEntry_4b4d
	dw DexEntry_4b89
	dw DexEntry_4bc5
	dw DexEntry_4bfe
	dw DexEntry_4c39
	dw DexEntry_4c73
	dw DexEntry_4cad
	dw DexEntry_4ce7
	dw DexEntry_4d1a
	dw DexEntry_4d55
	dw DexEntry_4d8e
	dw DexEntry_4dc8
	dw DexEntry_4dfa
	dw DexEntry_4e36
	dw DexEntry_4e6d
	dw DexEntry_4ea4
	dw DexEntry_4edd
	dw DexEntry_4f16
	dw DexEntry_4f50
	dw DexEntry_4f87
	dw DexEntry_4fbb
	dw DexEntry_4ff5
	dw DexEntry_5032
	dw DexEntry_5071
	dw DexEntry_50a8
	dw DexEntry_50df
	dw DexEntry_5119
	dw DexEntry_5159
	dw DexEntry_5195
	dw DexEntry_51d2
	dw DexEntry_520a
	dw DexEntry_523e
	dw DexEntry_527a
	dw DexEntry_52b1
	dw DexEntry_52e8
	dw DexEntry_5323
	dw DexEntry_5354
	dw DexEntry_5391
	dw DexEntry_53c9
	dw DexEntry_5401
	dw DexEntry_543d
	dw DexEntry_547a
	dw DexEntry_54bb
	dw DexEntry_54f0
	dw DexEntry_552d
	dw DexEntry_5560
	dw DexEntry_5596
	dw DexEntry_55d5
	dw DexEntry_5612
	dw DexEntry_564f
	dw DexEntry_5687
	dw DexEntry_56bd
	dw DexEntry_56f7
	dw DexEntry_5732
	dw DexEntry_5767
	dw DexEntry_57a3
	dw DexEntry_57db
	dw DexEntry_5815
	dw DexEntry_5850
	dw DexEntry_588c
	dw DexEntry_58c7
	dw DexEntry_5902
	dw DexEntry_593b
	dw DexEntry_5978
	dw DexEntry_59b6
	dw DexEntry_59f4
	dw DexEntry_5a26
	dw DexEntry_5a62
	dw DexEntry_5aa1
	dw DexEntry_5ad8
	dw DexEntry_5b13
	dw DexEntry_5b4f
	dw DexEntry_5b8c
	dw DexEntry_5bc1
	dw DexEntry_5bf8
	dw DexEntry_5c2f
	dw DexEntry_5c69
	dw DexEntry_5c9f
	dw DexEntry_5cdb
	dw DexEntry_5d15
	dw DexEntry_5d51
	dw DexEntry_5d8a
	dw DexEntry_5dc4
	dw DexEntry_5df9
	dw DexEntry_5e2e
	dw DexEntry_5e65
	dw DexEntry_5e9f
	dw DexEntry_5ed7
	dw DexEntry_5f0c
	dw DexEntry_5f44
	dw DexEntry_5f7a
	dw DexEntry_5fb9
	dw DexEntry_5ff5

DexEntry_4a0b:
	db "たね@"
	db 7
	dw 69
	db   "うまれたときから　せなかに"
	next "なにかの　タネが　うえてあり"
	next "からだと　いっしょに　そだつ。@"

DexEntry_4a3e:
	db "たね@"
	db 10
	dw 130
	db   "せなかに　ハナのつぼみが　あり"
	next "ようぶんを　きゅうしゅう　すると"
	next "だんだん　そだってくる。@"

DexEntry_4a72:
	db "たね@"
	db 20
	dw 1000
	db   "おおきな　はなを　いじするため"
	next "ひなたをみつけると　まるで"
	next "ひきよせられるように　いどうする。@"

DexEntry_4aa8:
	db "とかげ@"
	db 6
	dw 85
	db   "あついものを　このむ　せいかく。"
	next "しっぽの　ほのおは　こうふんすると"
	next "おんどが　あがっていく。@"

DexEntry_4adf:
	db "かえん@"
	db 11
	dw 190
	db   "もえる　シッポを　ふりまわすと"
	next "まわりの　おんどが　どんどん"
	next "あがって　あいてを　くるしめる。@"

DexEntry_4b16:
	db "かえん@"
	db 17
	dw 905
	db   "がんせきも　もえあがるような　"
	next "こうねつの　ほのおを　はいて"
	next "やまかじを　おこすことも　ある。@"

DexEntry_4b4d:
	db "かめのこ@"
	db 5
	dw 90
	db   "うまれたあと　せなかが　ふくらんで"
	next "かたい　こうらが　できる。くちから"
	next "きょうりょくな　あわを　だす。@"

DexEntry_4b89:
	db "かめ@"
	db 10
	dw 225
	db   "しばしば　すいちゅうに　かくれ"
	next "えものを　ねらう。はやく　およぐとき"
	next "みみを　うごかして　バランスをとる。@"

DexEntry_4bc5:
	db "こうら@"
	db 16
	dw 855
	db   "おもたくて　カラが　かたいため"
	next "のしかかられると　たいていの"
	next "ポケモンは　きを　うしなってしまう。@"

DexEntry_4bfe:
	db "いもむし@"
	db 3
	dw 29
	db   "みどりの　ひふに　おおわれている。"
	next "だっぴして　せいちょうすると"
	next "いとを　かけて　サナギに　かわる。@"

DexEntry_4c39:
	db "さなぎ@"
	db 7
	dw 99
	db   "うすい　カラに　つつまれているが"
	next "なかみは　とても　やわらかく"
	next "つよい　こうげきには　たえられない。@"

DexEntry_4c73:
	db "ちょうちょ@"
	db 11
	dw 320
	db   "ハネは　みずを　はじく　りんぷんに"
	next "まもられている。あめの　ひでも"
	next "そらを　とぶことが　できる。@"

DexEntry_4cad:
	db "けむし@"
	db 3
	dw 32
	db   "もりに　おおく　ハッパを　たべる。"
	next "あたまに　するどい　ハりをもち"
	next "さされると　どくに　おかされる。@"

DexEntry_4ce7:
	db "さなぎ@"
	db 6
	dw 100
	db   "おとなの　からだを　つくるため"
	next "カラのなかで　へんしんちゅう。"
	next "ほとんど　うごけない。@"

DexEntry_4d1a:
	db "どくばち@"
	db 10
	dw 295
	db   "しゅうだんで　あらわれることもある。"
	next "もうスピードで　とびまわり"
	next "おしりの　どくばりで　さしまくる。@"

DexEntry_4d55:
	db "ことり@"
	db 3
	dw 18
	db   "もりや　はやしに　おおく　ぶんぷ。"
	next "ちじょうに　おりてきたとき"
	next "はばたいて　すなを　かけたりする。@"

DexEntry_4d8e:
	db "とり@"
	db 11
	dw 300
	db   "あしの　ツメが　はったつしている。"
	next "エサの　タマタマを　つかんで"
	next "１００キロさきの　す　まで　はこぶ。@"

DexEntry_4dc8:
	db "とり@"
	db 15
	dw 395
	db   "うつくしい　ハネを　ひろげて"
	next "あいてを　いかくする。"
	next "マッハ２で　そらを　とびまわる。@"

DexEntry_4dfa:
	db "ねずみ@"
	db 3
	dw 35
	db   "なんでも　かじって　こうげき。"
	next "ちいさいうえに　うごきが　すばやく"
	next "いろんな　ところに　しゅつぼつする。@"

DexEntry_4e36:
	db "ねずみ@"
	db 7
	dw 185
	db   "うしろあしの　ゆびは　３ぼんで"
	next "ちいさな　みずかきが　ついている。"
	next "かわを　およいで　わたる。@"

DexEntry_4e6d:
	db "ことり@"
	db 3
	dw 20
	db   "くさむらの　むしなどを　たべる。"
	next "はねが　みじかいために　いつも"
	next "いそがしく　はばたいている。@"

DexEntry_4ea4:
	db "くちばし@"
	db 12
	dw 380
	db   "おおきな　つばさで　おおぞらを"
	next "とびつづけることが　できる。"
	next "１かいも　おりなくても　へいきだ。@"

DexEntry_4edd:
	db "へび@"
	db 20
	dw 69
	db   "くさちに　おおく　かくれている。"
	next "こどもの　アーボは　どくをもたない。"
	next "かまれても　だいじょうぶだ。@"

DexEntry_4f16:
	db "コブラ@"
	db 35
	dw 650
	db   "おなかの　もようが　こわいかおに"
	next "みえる。よわいてきは　そのもようを"
	next "みただけで　にげだしてしまう。@"

DexEntry_4f50:
	db "ねずみ@"
	db 4
	dw 60
	db   "ほっぺたの　りょうがわに"
	next "ちいさい　でんきぶくろを　もっていて"
	next "ピンチのときに　ほうでんする。@"

DexEntry_4f87:
	db "ねずみ@"
	db 8
	dw 300
	db   "でんげきは　１０まんボルトに"
	next "たっする。シッポに　さわると"
	next "インドぞうでも　きぜつする。@"

DexEntry_4fbb:
	db "ねずみ@"
	db 6
	dw 120
	db   "みずけの　すくない　ばしょに"
	next "ふかい　あなを　ほって　かくれる。"
	next "えものを　ねらうときは　でてくる。@"

DexEntry_4ff5:
	db "ねずみ@"
	db 10
	dw 295
	db   "せなかを　まるめると　トゲトゲの"
	next "ボールみたいだ。そのまま　ころがって"
	next "ぶつかってきたり　にげたりする。　@"

DexEntry_5032:
	db "どくばり@"
	db 4
	dw 70
	db   "ちいさくても　どくばりの　いりょくは"
	next "きょうれつで　ちゅういが　ひつよう。"
	next "メスのほうが　つのが　ちいさい。@"

DexEntry_5071:
	db "どくばり@"
	db 8
	dw 200
	db   "メスなので　ツノのそだちが　おそい。"
	next "ひっかいたり　かみついたりと"
	next "にくだんせんを　このむ。@"

DexEntry_50a8:
	db "ドりル@"
	db 13
	dw 600
	db   "せなかに　はりのような　ウロコが"
	next "びっしりと　はえている。"
	next "こうふんすると　はりが　さかだつ。@"

DexEntry_50df:
	db "どくばり@"
	db 5
	dw 90
	db   "ながい　みみを　たてて　きけんを"
	next "かんじとる。からだの　とげが"
	next "おおきいほど　つよい　どくをだす。@"

DexEntry_5119:
	db "どくばり@"
	db 9
	dw 195
	db   "すぐに　おこって　たたかおうとする。"
	next "しかも　あたまの　ツノは　ささると"
	next "きょうれつな　どくそをだす　しくみ。@"

DexEntry_5159:
	db "ドりル@"
	db 14
	dw 620
	db   "ダイヤのように　かたい　ひふと"
	next "ながく　のびた　ツノが　とくちょう。"
	next "ツノに　どくがあるので　ちゅうい。@"

DexEntry_5195:
	db "ようせい@"
	db 6
	dw 75
	db   "ふしぎで　かわいいので　おおくの"
	next "ファンがいる。ただし　せいそくちが"
	next "かぎられ　みつけるのが　たいへん。@"

DexEntry_51d2:
	db "ようせい@"
	db 13
	dw 400
	db   "みみが　よくて　１キロ　はなれた"
	next "ところで　おとした　はりのおとを"
	next "みごとに　ききわけられる。@"

DexEntry_520a:
	db "きつね@"
	db 6
	dw 99
	db   "こどもだが　６ほんの　しっぽが"
	next "うつくしい。せいちょうすると"
	next "さらに　しっぽが　ふえる。@"

DexEntry_523e:
	db "きつね@"
	db 11
	dw 199
	db   "おうごんに　かがやく　たいもうと"
	next "９ほんの　ながい　しっぽを　もつ。"
	next "１０００ねん　いきると　いわれる。@"

DexEntry_527a:
	db "ふうせん@"
	db 5
	dw 55
	db   "つぶらな　ひとみが　ゆれるとき"
	next "ねむけを　もよおす　ふしぎで"
	next "きもちのいい　うたを　うたう。@"

DexEntry_52b1:
	db "ふうせん@"
	db 10
	dw 120
	db   "キメこまかい　たいもうは"
	next "しなやかで　さわると　きもちいい。"
	next "けがわにすると　うれるという。@"

DexEntry_52e8:
	db "こうもり@"
	db 8
	dw 75
	db   "くらい　ばしょに　しゅうだんで"
	next "はっせいする。ちょうおんぱを　だして"
	next "ターゲットに　ちかづいていく。@"

DexEntry_5323:
	db "こうもり@"
	db 16
	dw 550
	db   "するどいキバで　かみついて"
	next "いちどに　３００シーシーの"
	next "ちを　すいとってしまう。@"

DexEntry_5354:
	db "ざっそう@"
	db 5
	dw 54
	db   "ひるまは　かおを　じめんに　うめて"
	next "あまり　うごかない。よるに　なると"
	next "たねをまきながら　あるきまわる。@"

DexEntry_5391:
	db "ざっそう@"
	db 8
	dw 86
	db   "めしべが　はなつ　とてつもなく"
	next "くさい　においは　２キロさきまで"
	next "とどき　きを　うしなわせる。@"

DexEntry_53c9:
	db "フラワー@"
	db 12
	dw 186
	db   "せかいいち　おおきい　はなびらから"
	next "アレルギーを　おこす　かふんを"
	next "オニの　ように　ばらまく。@"

DexEntry_5401:
	db "きのこ@"
	db 3
	dw 54
	db   "むしの　せなかに　はえているのは"
	next "とうちゅうかそう　という　キノコ。"
	next "キノコは　そだって　おおきくなる。@"

DexEntry_543d:
	db "きのこ@"
	db 10
	dw 295
	db   "キノコの　カサから　どくほうしを"
	next "まきちらす。しかし　ちゅうごくでは"
	next "このほうしを　かんぽうやくに　する。@"

DexEntry_547a:
	db "こんちゅう@"
	db 10
	dw 300
	db   "おおきな　きのなかに　すみかをつくり"
	next "ほかのむしなどを　たべてるらしい。"
	next "よるは　あかりのそばに　やってくる。@"

DexEntry_54bb:
	db "どくが@"
	db 15
	dw 125
	db   "はねに　りんぷんが　ついていて"
	next "ヒラヒラと　はばたくたびに"
	next "もうどくの　こなを　ばらまく。@"

DexEntry_54f0:
	db "もぐら@"
	db 2
	dw 8
	db   "ちか１メートルくらいを　ほりすすみ"
	next "きのねっこなどを　かじって　いきる。"
	next "たまに　ちじょうに　かおをだす。@"

DexEntry_552d:
	db "もぐら@"
	db 7
	dw 333
	db   "ちちゅうを　ほりすすんで"
	next "ゆだんしている　ところを"
	next "べつの　ばしょから　こうげきする。@"

DexEntry_5560:
	db "ばけねこ@"
	db 4
	dw 42
	db   "ひかる　ものが　だいすきで"
	next "あちこち　おちている　おかねを"
	next "ひろって　くることも　おおい。@"

DexEntry_5596:
	db "シャムネコ@"
	db 10
	dw 320
	db   "きしょうが　はげしく　しっぽを"
	next "まっすぐ　たてたら　よう　ちゅうい。"
	next "とびかかって　かみつく　まえぶれだ。@"

DexEntry_55d5:
	db "あひる@"
	db 8
	dw 196
	db   "いつも　ずつうに　なやまされている。"
	next "この　ずつうが　はげしくなると"
	next "ふしぎな　ちからを　つかいはじめる。@"

DexEntry_5612:
	db "あひる@"
	db 17
	dw 766
	db   "てのひらが　みずかきに　なっていて"
	next "およぐのが　とくい。みずうみなどで"
	next "ゆうがな　すがたが　みかけられる。@"

DexEntry_564f:
	db "ぶたざる@"
	db 5
	dw 280
	db   "みのこなしが　かるく　きょうぼうな"
	next "せいかく。おこって　あばれだすと"
	next "てが　つけられなくなる。@"

DexEntry_5687:
	db "ぶたざる@"
	db 10
	dw 320
	db   "なぜか　もうれつに　おこって"
	next "にげても　にげても　どこまでも"
	next "おいかけてくる　せいかくだ。@"

DexEntry_56bd:
	db "こいぬ@"
	db 7
	dw 190
	db   "ひとなつこい　せいかくだが　ひろい"
	next "なわばりを　もっており　ゆだんして"
	next "ちかずくと　こうげきされる。@"

DexEntry_56f7:
	db "でんせつ@"
	db 19
	dw 1550
	db   "むかしから　おおくの　ひとを"
	next "とりこにした　うつくしい　ポケモン。"
	next "とぶように　かろやかに　はしる。@"

DexEntry_5732:
	db "おたま@"
	db 6
	dw 124
	db   "スべスべした　くろいひふは　うすい。"
	next "おなかの　なかが　すけて"
	next "うずまきじょうに　みえる。@"

DexEntry_5767:
	db "おたま@"
	db 10
	dw 200
	db   "りくでも　すいちゅうでも　くらせる。"
	next "ちじょうでは　いつも　あせをかき"
	next "からだを　ぬめぬめ　させている。@"

DexEntry_57a3:
	db "おたま@"
	db 13
	dw 540
	db   "クロールや　バタフライが　とくいで"
	next "オりンピックの　せんしゅでも　"
	next "ぐんぐんと　おいぬいていく。@"

DexEntry_57db:
	db "ねんりき@"
	db 9
	dw 195
	db   "１にち　１８じかんは　ねている。"
	next "ねむってる　あいだでも　さまざまな"
	next "ちょうのうりょくを　つかう。@"

DexEntry_5815:
	db "ねんりき@"
	db 13
	dw 565
	db   "からだから　とくべつな　アルファはが"
	next "でていて　そばに　ちかよるだけで"
	next "あたまが　いたくなってくる。@"

DexEntry_5850:
	db "ねんりき@"
	db 15
	dw 480
	db   "スーパーコンピュータより　すばやく"
	next "けいさんする　ずのうを　もつ。"
	next "ちのうしすうは　だいたい５０００。@"

DexEntry_588c:
	db "かいりき@"
	db 8
	dw 195
	db   "ぜんしんが　きんにくで　できている。"
	next "こどものようで　ありながら"
	next "おとな　１００にんを　なげとばす。@"

DexEntry_58c7:
	db "かいりき@"
	db 15
	dw 705
	db   "つかれることのない　きょうじんな"
	next "にくたい。すごくおもい　にもつを"
	next "はこぶ　しごとなどを　てつだう。@"

DexEntry_5902:
	db "かいりき@"
	db 16
	dw 1300
	db   "はったつした　４ほんの　うでは"
	next "２びょうかんに　１０００ぱつの"
	next "パンチを　くりだすことができる。@"

DexEntry_593b:
	db "フラワー@"
	db 7
	dw 40
	db   "ひとの　かおのような　ツボミから"
	next "でんせつの　マンドラゴラの　いっしゅ"
	next "ではないかと　ささやかれている。@"

DexEntry_5978:
	db "ハエとり@"
	db 10
	dw 64
	db   "ハッパの　ぶぶんは　カッターになって"
	next "あいてを　きりさく。くちからは"
	next "なんでも　とかす　えきたいを　はく。@"

DexEntry_59b6:
	db "ハエとり@"
	db 17
	dw 155
	db   "なんごくに　おおく　はっせいする"
	next "きょうぼうな　しょくぶつ　ポケモン。"
	next "ようかいえきで　なんでも　とかす。@"

DexEntry_59f4:
	db "くらげ@"
	db 9
	dw 455
	db   "まるで　すいしょうのような"
	next "めだまから　ふしぎな　ひかりの"
	next "ビームを　はっしゃする。@"

DexEntry_5a26:
	db "くらげ@"
	db 16
	dw 550
	db   "８０ぽん　の　しょくしゅが　じゆうに"
	next "うごく。さされると　どくに　おかされ"
	next "するどい　いたみが　はしる。@"

DexEntry_5a62:
	db "がんせき@"
	db 4
	dw 20
	db   "そうげんや　やまに　せいそくする。"
	next "いしころに　にていて　きがつかずに"
	next "ふんだり　つまずいたり　してしまう。@"

DexEntry_5aa1:
	db "がんせき@"
	db 10
	dw 1050
	db   "たかい　やまの　さかみちを"
	next "ころがりながら　いどうするとき"
	next "じゃまものは　おしつぶしていく。@"

DexEntry_5ad8:
	db "メガトン@"
	db 14
	dw 3000
	db   "がんせきのような　かたい　からだで"
	next "できている。ダイナマイトで"
	next "ばくはしても　ダメージを　うけない。@"

DexEntry_5b13:
	db "ひのうま@"
	db 10
	dw 300
	db   "からだが　かるく　あしの　ちからが"
	next "ものすごい。１かいの　ジャンプで"
	next "とうきょうタワーも　とびこえる。@"

DexEntry_5b4f:
	db "ひのうま@"
	db 17
	dw 950
	db   "じそくは　さいこう　２４０キロ。"
	next "メラメラ　もえながら　しんかんせんと"
	next "おなじ　スピードで　かけぬける。@"

DexEntry_5b8c:
	db "まぬけ@"
	db 12
	dw 360
	db   "うごきが　のろく　まぬけ。"
	next "たたかれても　５びょう　たってから"
	next "いたさを　かんじるほどだ。@"

DexEntry_5bc1:
	db "やどかり@"
	db 16
	dw 785
	db   "ヤドンが　うみへ　エサを"
	next "とりにいったとき　シェルダーに"
	next "しっぽをかまれ　ヤドランになった。@"

DexEntry_5bf8:
	db "じしゃく@"
	db 3
	dw 60
	db   "くうちゅうに　ういたまま　いどうして"
	next "さゆうの　ユニットから"
	next "でんじはなどを　ほうしゃする。@"

DexEntry_5c2f:
	db "じしゃく@"
	db 10
	dw 600
	db   "ふくすうの　コイルが　れんけつして"
	next "きょうりょくな　じりょくせんと"
	next "こうでんあつを　ほうしゃする。@"

DexEntry_5c69:
	db "かるがも@"
	db 8
	dw 150
	db   "じぶんの　すを　つくるための"
	next "しょくぶつの　クキを　１ぽん"
	next "いつも　もって　あるいている。@"

DexEntry_5c9f:
	db "ふたごどり@"
	db 14
	dw 392
	db   "とぶのは　にがてだが　はしるのは　"
	next "はやく　きょだいな　あしあとを"
	next "のこして　だいちを　かけぬける。@"

DexEntry_5cdb:
	db "みつごどり@"
	db 18
	dw 852
	db   "３つの　あたまで　こうどな"
	next "さくせんを　あやつる。ねるときも"
	next "どれか　１つは　おきているという。@"

DexEntry_5d15:
	db "あしか@"
	db 11
	dw 900
	db   "みずいろの　たいもうに　おおわれた"
	next "ひふは　ぶあつくて　じょうぶ。"
	next "れいか４０ど　でも　かつどうできる。@"

DexEntry_5d51:
	db "あしか@"
	db 17
	dw 1200
	db   "ぜんしんが　まっしろな　けで"
	next "おおわれている。さむさに　つよく"
	next "むしろ　さむいほど　げんきになる。@"

DexEntry_5d8a:
	db "へドロ@"
	db 9
	dw 300
	db   "つきからの　エックスせんをあびた"
	next "へドロが　べトべターにへんかした。"
	next "きたないモノが　だいこうぶつ。@"

DexEntry_5dc4:
	db "へドロ@"
	db 12
	dw 300
	db   "ふだんは　じめんに　まざっていて"
	next "わからない。からだに　さわると"
	next "もうどくに　おかされる。@"

DexEntry_5df9:
	db "２まいがい@"
	db 3
	dw 40
	db   "ダイヤモンドよりも　かたいカラに"
	next "おおわれている。しかし　なかは"
	next "とても　やわらかい。@"

DexEntry_5e2e:
	db "２まいがい@"
	db 15
	dw 1325
	db   "カラが　ひじょうに　かたく"
	next "ナパームだんでも　こわせない。"
	next "こうげきするときだけ　ひらく。@"

DexEntry_5e65:
	db "ガスじょう@"
	db 13
	dw 1
	db   "うすい　ガスじょうの　せいめいたい。"
	next "ガスに　つつまれると"
	next "インドぞうも　２びょうで　たおれる。@"

DexEntry_5e9f:
	db "ガスじょう@"
	db 16
	dw 1
	db   "くらやみで　だれもいないのに"
	next "みられているような　きがしたら"
	next "そこに　ゴーストが　いるのだ。@"

DexEntry_5ed7:
	db "シャドー@"
	db 15
	dw 405
	db   "やまで　そうなんしたとき"
	next "いのちをうばいに　くらやみから"
	next "あらわれることが　あるという。@"

DexEntry_5f0c:
	db "いわへび@"
	db 88
	dw 2100
	db   "せいちょうすると　からだの"
	next "がんせきせいぶんが　へんかして"
	next "くろい　ダイヤモンドのようになる。@"

DexEntry_5f44:
	db "さいみん@"
	db 10
	dw 324
	db   "ユメをたべるという　でんせつの　"
	next "いきもの　バクの　しそん。"
	next "さいみんじゅつが　とくいだ。@"

DexEntry_5f7a:
	db "さいみん@"
	db 16
	dw 756
	db   "ふりこのようなものを　もちあるく。"
	next "こどもに　さいみんじゅつを　かけて"
	next "どこかへ　つれさるじけんが　あった。@"

DexEntry_5fb9:
	db "さわがに@"
	db 4
	dw 65
	db   "ハサミは　きょうりょくな　ぶきであり"
	next "よこに　あるくとき　からだの"
	next "バランスをとる　やくめも　はたす。@"

DexEntry_5ff5:
	db "はさみ@"
	db 13
	dw 600
	db   "ハサミは　１まんばりきの"
	next "スーパーパワーを　ひめているのだが"
	next "おおきすぎて　うまく　うごかない。@"

PokedexEntryPointers2::
	dw DexEntry_615d
	dw DexEntry_6197
	dw DexEntry_61d2
	dw DexEntry_6208
	dw DexEntry_6238
	dw DexEntry_6270
	dw DexEntry_62ac
	dw DexEntry_62e6
	dw DexEntry_631b
	dw DexEntry_635a
	dw DexEntry_6396
	dw DexEntry_63cf
	dw DexEntry_640b
	dw DexEntry_6443
	dw DexEntry_6477
	dw DexEntry_64b3
	dw DexEntry_64ee
	dw DexEntry_6525
	dw DexEntry_6560
	dw DexEntry_659b
	dw DexEntry_65d5
	dw DexEntry_6605
	dw DexEntry_663b
	dw DexEntry_6676
	dw DexEntry_66b1
	dw DexEntry_66e9
	dw DexEntry_671f
	dw DexEntry_6757
	dw DexEntry_6783
	dw DexEntry_67ba
	dw DexEntry_67f0
	dw DexEntry_6825
	dw DexEntry_685c
	dw DexEntry_6895
	dw DexEntry_68d1
	dw DexEntry_690d
	dw DexEntry_6949
	dw DexEntry_6984
	dw DexEntry_69be
	dw DexEntry_69f9
	dw DexEntry_6a32
	dw DexEntry_6a68
	dw DexEntry_6aa1
	dw DexEntry_6adc
	dw DexEntry_6b14
	dw DexEntry_6b50
	dw DexEntry_6b8b
	dw DexEntry_6bc8
	dw DexEntry_6c04
	dw DexEntry_6c3e
	dw DexEntry_6c7c
	dw DexEntry_6cb9
	dw DexEntry_6cf5
	dw DexEntry_6d1c
	dw DexEntry_6d43
	dw DexEntry_6d6a
	dw DexEntry_6d91
	dw DexEntry_6db8
	dw DexEntry_6ddf
	dw DexEntry_6e06
	dw DexEntry_6e2d
	dw DexEntry_6e54
	dw DexEntry_6e7b
	dw DexEntry_6ea2
	dw DexEntry_6ec9
	dw DexEntry_6ef0
	dw DexEntry_6f17
	dw DexEntry_6f3e
	dw DexEntry_6f65
	dw DexEntry_6f8c
	dw DexEntry_6fb3
	dw DexEntry_6fda
	dw DexEntry_7001
	dw DexEntry_7028
	dw DexEntry_704f
	dw DexEntry_7076
	dw DexEntry_709d
	dw DexEntry_70c4
	dw DexEntry_70eb
	dw DexEntry_7112
	dw DexEntry_7139
	dw DexEntry_7160
	dw DexEntry_7187
	dw DexEntry_71ae
	dw DexEntry_71d5
	dw DexEntry_71fc
	dw DexEntry_7223
	dw DexEntry_724a
	dw DexEntry_7271
	dw DexEntry_7298
	dw DexEntry_72bf
	dw DexEntry_72e6
	dw DexEntry_730d
	dw DexEntry_7334
	dw DexEntry_735b
	dw DexEntry_7382
	dw DexEntry_73a9
	dw DexEntry_73d0
	dw DexEntry_73f7
	dw DexEntry_741e
	dw DexEntry_7445
	dw DexEntry_746c
	dw DexEntry_7493
	dw DexEntry_74ba
	dw DexEntry_74e1
	dw DexEntry_7508
	dw DexEntry_752f
	dw DexEntry_7556
	dw DexEntry_757d
	dw DexEntry_75a4
	dw DexEntry_75cb
	dw DexEntry_75f2
	dw DexEntry_7619
	dw DexEntry_7640
	dw DexEntry_7667
	dw DexEntry_768e
	dw DexEntry_76b5
	dw DexEntry_76dc
	dw DexEntry_7703
	dw DexEntry_78b0
	dw DexEntry_7751
	dw DexEntry_7778
	dw DexEntry_779f
	dw DexEntry_77c6
	dw DexEntry_77ed
	dw DexEntry_7814
	dw DexEntry_783b
	dw DexEntry_7862
	dw DexEntry_7889
	dw DexEntry_78b0
	dw DexEntry_78d7
	dw DexEntry_78fe
	dw DexEntry_7925
	dw DexEntry_794c
	dw DexEntry_7973
	dw DexEntry_799a
	dw DexEntry_79c1
	dw DexEntry_79e8
	dw DexEntry_7a0f
	dw DexEntry_7a36
	dw DexEntry_7a5d
	dw DexEntry_7a84
	dw DexEntry_7aab
	dw DexEntry_7ad2
	dw DexEntry_7af9
	dw DexEntry_7b20
	dw DexEntry_7b47
	dw DexEntry_7b6e
	dw DexEntry_7b95
	dw DexEntry_7bbc
	dw DexEntry_7be3
	dw DexEntry_7c0a

DexEntry_615d:
	db "ボール@"
	db 5
	dw 104
	db   "はつでんしょなどに　あらわれる。"
	next "モンスターボールと　まちがえて"
	next "さわって　しびれるひとが　おおい。@"

DexEntry_6197:
	db "ボール@"
	db 12
	dw 666
	db   "ぼうだいな　エレクトン　エネルギーを"
	next "ためこんでおり　ちょっとした"
	next "しげきで　だいばくはつを　おこす。@"

DexEntry_61d2:
	db "たまご@"
	db 4
	dw 25
	db   "たまごの　ようだが　じつは"
	next "しょくぶつの　タネのような"
	next "いきものだと　いうことが　わかった。@"

DexEntry_6208:
	db "やしのみ@"
	db 20
	dw 1200
	db   "あるく　ねったいうりん。"
	next "みの　ひとつひとつに"
	next "それぞれ　いしを　もっている。@"

DexEntry_6238:
	db "こどく@"
	db 4
	dw 65
	db   "しにわかれた　ははおやの　ほねを"
	next "あたまに　かぶっている。さびしいとき"
	next "おおごえで　なくという。@"

DexEntry_6270:
	db "ほねずき@"
	db 10
	dw 450
	db   "からだも　ちいさく　もともと　"
	next "よわかった。ホネを　つかうようになり"
	next "せいかくが　きょうぼうか　した。@"

DexEntry_62ac:
	db "キック@"
	db 15
	dw 498
	db   "あしが　じゆうに　のびちぢみする。"
	next "あいてが　とおく　はなれていても"
	next "かんたんに　けりあげてしまう。@"

DexEntry_62e6:
	db "パンチ@"
	db 14
	dw 502
	db   "プロボクサーの　たましいが"
	next "のりうつった。パンチのスピードは"
	next "しんかんせんよりも　はやい。@"

DexEntry_631b:
	db "なめまわし@"
	db 12
	dw 655
	db   "べロが　からだの　２ばいも　のびる。"
	next "エサをとったり　こうげきをしたりと"
	next "まるで　てのように　うごくのだ。@"

DexEntry_635a:
	db "どくガス@"
	db 6
	dw 10
	db   "うすい　バルーンじょうの　からだに"
	next "もうどくの　ガスが　つまっている。"
	next "ちかくに　くるだけで　くさい。@"

DexEntry_6396:
	db "どくガス@"
	db 12
	dw 95
	db   "ごくまれに　とつぜんへんいで"
	next "ふたごの　ちいさい　ドガースが"
	next "れんけつしたまま　でることがある。@"

DexEntry_63cf:
	db "とげとげ@"
	db 10
	dw 1150
	db   "あたまは　わるいが　ちからが　つよく"
	next "こうそうビルでも　たいあたりで"
	next "コナゴナに　ふんさいしてしまう。@"

DexEntry_640b:
	db "ドりル@"
	db 19
	dw 1200
	db   "ぜんしんを　よろいのような　ひふで"
	next "まもっている。２０００どの"
	next "マグマの　なかでも　いきられる。@"

DexEntry_6443:
	db "たまご@"
	db 11
	dw 346
	db   "せいそくすうが　すくない。"
	next "つかまえた　ひとには　しあわせを"
	next "もたらすと　いわれている。@"

DexEntry_6477:
	db "ツルじょう@"
	db 10
	dw 350
	db   "ブルーの　つるしょくぶつが"
	next "からみあい　しょうたいは　みえない。"
	next "ちかずくものに　からみついてくる。@"

DexEntry_64b3:
	db "おやこ@"
	db 22
	dw 800
	db   "こどもは　ははおやの　おなかにある"
	next "ふくろから　ほとんど　でてこない。"
	next "やく３ねんで　おやばなれする。@"

DexEntry_64ee:
	db "ドラゴン@"
	db 4
	dw 80
	db   "ぜんまいのように　クルクルまいた"
	next "しっぽで　バランスをとる。"
	next "スミを　はいて　こうげきする。@"

DexEntry_6525:
	db "ドラゴン@"
	db 12
	dw 250
	db   "ハネと　しっぽを　すばやく　うごかし"
	next "まえを　むいたまま　うしろへ"
	next "およぐことも　できる　ポケモン。@"

DexEntry_6560:
	db "きんぎょ@"
	db 6
	dw 150
	db   "せビレ　むなビレが　きんにくのように"
	next "はったつしており　すいちゅうを"
	next "５ノットの　はやさで　およぐ。@"

DexEntry_659b:
	db "きんぎょ@"
	db 13
	dw 390
	db   "ツノが　ドりルのように　とがっていて"
	next "いわはだを　ツノで　くりぬき"
	next "じぶんの　すを　つくっている。@"

DexEntry_65d5:
	db "ほしがた@"
	db 8
	dw 345
	db   "うみべに　おおく　あらわれ"
	next "よるになると　ちゅうしんが"
	next "あかく　てんめつする。@"

DexEntry_6605:
	db "なぞの@"
	db 11
	dw 800
	db   "きかがくてきな　ボディーから"
	next "うちゅうせいぶつ　ではないかと"
	next "じもとでは　うたがわれている。@"

DexEntry_663b:
	db "バりアー@"
	db 13
	dw 545
	db   "ひとを　しんじこませるのが　うまい。"
	next "パントマイムで　つくったカべが"
	next "ほんとうに　あらわれるという。@"

DexEntry_6676:
	db "かまきり@"
	db 15
	dw 560
	db   "するどいカマで　えものを　きりさき"
	next "いきのねを　とめる。ごくまれに"
	next "ハネをつかって　とぶことがある。@"

DexEntry_66b1:
	db "ひとがた@"
	db 14
	dw 406
	db   "こしを　ふるように　あるいている。"
	next "ゆだんをすると　おもわず　つられて"
	next "おどってしまうという。@"

DexEntry_66e9:
	db "でんげき@"
	db 11
	dw 300
	db   "つよい　でんきが　だいこうぶつで"
	next "おおきな　はつでんしょ　などに　"
	next "しばしば　あらわれる。@"

DexEntry_671f:
	db "ひふき@"
	db 13
	dw 445
	db   "かざんの　かこうちかくで"
	next "みつかった。くちから　ほのおをはく。"
	next "たいおんは　１２００ど　もある。@"

DexEntry_6757:
	db "くわがた@"
	db 15
	dw 550
	db   "２ほんの　ながいツノに"
	next "はさまれたら　ちぎれるまで"
	next "はなさないという。@"

DexEntry_6783:
	db "あばれうし@"
	db 14
	dw 884
	db   "えものに　ねらいを　つけると"
	next "しっぽで　からだを　たたきながら"
	next "まっすぐ　つっこんでくる。@"

DexEntry_67ba:
	db "さかな@"
	db 9
	dw 100
	db   "ちからも　スピードも　ほとんどダメ。"
	next "せかいで　いちばん　よわくて"
	next "なさけない　ポケモンだ。@"

DexEntry_67f0:
	db "きょうあく@"
	db 65
	dw 2350
	db   "ひじょうに　きょうぼうで"
	next "くちからだす　はかいこうせんは"
	next "すべてのものを　やきつくす。@"

DexEntry_6825:
	db "のりもの@"
	db 25
	dw 2200
	db   "かつて　たくさん　つかまえたため"
	next "ぜつめつ　すんぜんに　なっている。"
	next "ひとをのせて　すすむ。@"

DexEntry_685c:
	db "へんしん@"
	db 3
	dw 40
	db   "さいぼうそしきを　いっしゅんで"
	next "コピーして　あいて　そっくりに"
	next "へんしんする　のうりょくがある。@"

DexEntry_6895:
	db "しんか@"
	db 3
	dw 65
	db   "ふきそくな　いでんしを　もつ。"
	next "いしからでる　ほうしゃせんによって"
	next "からだが　とつぜんへんいを　おこす。@"

DexEntry_68d1:
	db "あわはき@"
	db 10
	dw 290
	db   "みずべに　すむが　しっぽには"
	next "さかなのような　ひれが　のこっていて"
	next "にんぎょと　まちがう　ひともいる。@"

DexEntry_690d:
	db "かみなり@"
	db 8
	dw 245
	db   "くうきちゅうの　マイナスイオンを"
	next "すいこんで　やく１００００ボルトの"
	next "でんきを　はきだすことができる。@"

DexEntry_6949:
	db "ほのお@"
	db 9
	dw 250
	db   "からだに　ほのおを　ためてるとき"
	next "たいおんが　１０００ど　いじょうに"
	next "あがるので　ひじょうに　きけん。@"

DexEntry_6984:
	db "バーチャル@"
	db 8
	dw 365
	db   "さいこうの　かがくりょくを　あつめ"
	next "ついに　じんこうの　ポケモンを"
	next "つくることに　せいこうした。@"

DexEntry_69be:
	db "うずまき@"
	db 4
	dw 75
	db   "ぜつめつした　ポケモンだが　まれに"
	next "かせきが　はっけんされ　そこから"
	next "いきかえらせることが　できる。@"

DexEntry_69f9:
	db "うずまき@"
	db 10
	dw 350
	db   "するどい　キバと　しょくしゅで"
	next "えものに　かみついたら　さいご。"
	next "たいえきを　すいだしてしまう。@"

DexEntry_6a32:
	db "こうら@"
	db 5
	dw 115
	db   "こだい　せいぶつの　かせきから"
	next "さいせいしたポケモン。"
	next "かたい　カラで　みを　まもっている。@"

DexEntry_6a68:
	db "こうら@"
	db 13
	dw 405
	db   "すいちゅうを　じゆうに　およぎ"
	next "するどい　カマで　えものを　とらえ"
	next "たいえきを　すいとってしまう。@"

DexEntry_6aa1:
	db "かせき@"
	db 18
	dw 590
	db   "こはくに　のこされた　きょうりゅうの"
	next "いでんしから　ふっかつさせた。"
	next "たかいこえで　なきながら　とぶ。@"

DexEntry_6adc:
	db "いねむり@"
	db 21
	dw 4600
	db   "１にちに　たべものを　４００キロ"
	next "たべないと　きが　すまない。"
	next "たべおわると　ねむってしまう。@"

DexEntry_6b14:
	db "れいとう@"
	db 17
	dw 554
	db   "ゆきやまで　さむくて　しにそうなとき"
	next "めのまえに　あらわれるといわれる"
	next "でんせつの　れいとうポケモン。@"

DexEntry_6b50:
	db "でんげき@"
	db 16
	dw 526
	db   "くもの　うえから　きょだいな"
	next "いなづまを　おとしながら　あらわれる"
	next "でんせつの　とりポケモンである。@"

DexEntry_6b8b:
	db "かえん@"
	db 20
	dw 600
	db   "むかしから　ひのとりでんせつとして"
	next "しられる。　はばたくたびに　はねが"
	next "あかるく　もえあがり　うつくしい。@"

DexEntry_6bc8:
	db "ドラゴン@"
	db 18
	dw 33
	db   "ながいあいだ　まぼろしの　ポケモンと"
	next "よばれた。わずかだが　すいちゅうに"
	next "すんでいることが　わかった。@"

DexEntry_6c04:
	db "ドラゴン@"
	db 40
	dw 165
	db   "ハネは　ないが　そらを　とべる。"
	next "とぶとき　からだを　しなやかに"
	next "くねらせて　とても　うつくしい。@"

DexEntry_6c3e:
	db "ドラゴン@"
	db 22
	dw 2100
	db   "すがたを　みたひとは　すくないが"
	next "じつざいする　うみのけしん。ちのうも"
	next "にんげんに　ひってき　するらしい。@"

DexEntry_6c7c:
	db "いでんし@"
	db 20
	dw 1220
	db   "けんきゅうの　ために　いでんしを"
	next "どんどん　くみかえていった　けっか"
	next "きょうぼうな　ポケモンに　なった。@"

DexEntry_6cb9:
	db "しんしゅ@"
	db 4
	dw 40
	db   "いまでも　まぼろしの　ポケモンと"
	next "いわれる。そのすがたを　みたものは"
	next "ぜんこくでも　ほとんど　いない。@"

DexEntry_6cf5:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6d1c:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6d43:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6d6a:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6d91:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6db8:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6ddf:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6e06:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6e2d:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6e54:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6e7b:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6ea2:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6ec9:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6ef0:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6f17:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6f3e:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6f65:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6f8c:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6fb3:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_6fda:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7001:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7028:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_704f:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7076:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_709d:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_70c4:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_70eb:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7112:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7139:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7160:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7187:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_71ae:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_71d5:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_71fc:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7223:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_724a:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7271:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7298:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_72bf:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_72e6:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_730d:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7334:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_735b:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7382:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_73a9:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_73d0:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_73f7:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_741e:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7445:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_746c:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7493:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_74ba:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_74e1:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7508:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_752f:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7556:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_757d:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_75a4:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_75cb:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_75f2:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7619:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7640:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7667:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_768e:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_76b5:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_76dc:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7703:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_772a:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7751:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7778:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_779f:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_77c6:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_77ed:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7814:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_783b:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7862:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7889:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_78b0:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_78d7:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_78fe:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7925:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_794c:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7973:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_799a:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_79c1:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_79e8:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7a0f:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7a36:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7a5d:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7a84:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7aab:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7ad2:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7af9:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7b20:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7b47:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7b6e:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7b95:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7bbc:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7be3:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"

DexEntry_7c0a:
	db "？？？@"
	db 0
	dw 0
	db   "はっけんされた　ばかりの　ポケモン"
	next "げんざい　ちょうさちゅう。@"
