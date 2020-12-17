SoundTestTextPointers:
;            id?  bank? description
	dbbw $00,  $3A, SoundTest_PalletTownText
 	dbbw $00,  $3A, SoundTest_PokecenterText
 	dbbw $00,  $3A, SoundTest_PokegymText
 	dbbw $07,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $0C,  $3A, SoundTest_PokeEvolutionText
 	dbbw $08,  $3A, SoundTest_HealingText
 	dbbw $02,  $3A, SoundTest_QuestionMarkText
 	dbbw $03,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_HurryAlongText
 	dbbw $00,  $3A, SoundTest_MeetOakText
 	dbbw $00,  $3A, SoundTest_RivalText
 	dbbw $00,  $3A, SoundTest_SSAnneText
 	dbbw $66,  $3A, SoundTest_Fanfare3Text
 	dbbw $68,  $3A, SoundTest_Fanfare5Text
 	dbbw $69,  $3A, SoundTest_Fanfare6Text
 	dbbw $63,  $3A, SoundTest_FanfareText
 	dbbw $21,  $3A, SoundTest_FluteText
 	dbbw $04,  $3B, SoundTest_BattleText
 	dbbw $05,  $3B, SoundTest_BattleText
 	dbbw $00,  $3B, SoundTest_BattleText
 	dbbw $00,  $3B, SoundTest_ChampionBattleText
 	dbbw $0B,  $3B, SoundTest_VictoryText
 	dbbw $00,  $3B, SoundTest_VictoryText
 	dbbw $00,  $3B, SoundTest_VictoryText
 	dbbw $67,  $3B, SoundTest_Fanfare4Text
 	dbbw $68,  $3B, SoundTest_Fanfare5Text_2
 	dbbw $6B,  $3B, SoundTest_Fanfare8Text
 	dbbw $00,  $3C, SoundTest_TitleText
 	dbbw $00,  $3C, SoundTest_EndingText
 	dbbw $00,  $3C, SoundTest_HallOfFameText
 	dbbw $00,  $3C, SoundTest_OaksLabText
 	dbbw $00,  $3C, SoundTest_JigglypuffSongText
 	dbbw $09,  $3C, SoundTest_BikeText
 	dbbw $00,  $3C, SoundTest_SurfText
 	dbbw $00,  $3C, SoundTest_CasinoText
 	dbbw $00,  $3C, SoundTest_IntroBattleText
 	dbbw $00,  $3C, SoundTest_CaveText
 	dbbw $00,  $3C, SoundTest_CaveText
 	dbbw $00,  $3C, SoundTest_CaveText
 	dbbw $00,  $3C, SoundTest_CaveText
 	dbbw $00,  $3C, SoundTest_PokemonTowerText
 	dbbw $00,  $3C, SoundTest_PokemonTowerText
 	dbbw $0A,  $3C, SoundTest_DealerText
 	dbbw $00,  $3C, SoundTest_DealerText
 	dbbw $00,  $3C, SoundTest_DealerText
 	dbbw $66,  $3C, SoundTest_Fanfare3Text_2
 	dbbw $69,  $3C, SoundTest_Fanfare6Text_2
 	dbbw  -1,   -1, SoundTestTextPointers

SoundTest_PalletTownText:     db "マサラタウン@"
SoundTest_PokecenterText:     db "#センター@"
SoundTest_PokegymText:        db "#ジム@"
SoundTest_PokeEvolutionText:  db "#しんか@"
SoundTest_HealingText:        db "あさあさあさ@"
SoundTest_HurryAlongText:     db "つれていかれる@"
SoundTest_MeetOakText:        db "オーキドとともに@"
SoundTest_RivalText:          db "ライバル@"
SoundTest_SSAnneText:         db "サントアンヌゴウ@"
SoundTest_FluteText:          db "ふえ@"
SoundTest_BattleText:         db "せんとう@"
SoundTest_ChampionBattleText: db "さいしゆうせんとう@"
SoundTest_VictoryText:        db "かち@"
SoundTest_FanfareText:        db "フぁンファーレ@"
SoundTest_Fanfare3Text:       db "フぁンファーレ３@"
SoundTest_Fanfare5Text:       db "フぁンファーレ５@"
SoundTest_Fanfare6Text:       db "フぁンファーレ６@"
SoundTest_Fanfare4Text:       db "フぁンファーレ４@"
SoundTest_Fanfare5Text_2:     db "フぁンファーレ５@"
SoundTest_Fanfare8Text:       db "フぁンファーレ８@"
SoundTest_Fanfare3Text_2:     db "フぁンファーレ３@"
SoundTest_Fanfare6Text_2:     db "フぁンファーレ６@"
SoundTest_TitleText:          db "タイトル@"
SoundTest_EndingText:         db "エンディング@"
SoundTest_HallOfFameText:     db "でんどういり@"
SoundTest_OaksLabText:        db "けんきゆうじよ@"
SoundTest_JigglypuffSongText: db "プりンノうた@"
SoundTest_BikeText:           db "じてんしや@"
SoundTest_SurfText:           db "うみ@"
SoundTest_CasinoText:         db "カジノ@"
SoundTest_IntroBattleText:    db "オープニングデモ@"
SoundTest_CaveText:           db "どうくつ@"
SoundTest_PokemonTowerText:   db "とう@"
SoundTest_DealerText:         db "ディーラー@"
SoundTest_QuestionMarkText:   db "？@"
