SpriteAnimFrameData:
	dw .Frameset_00                     ; SPRITE_ANIM_FRAMESET_00
	dw .Frameset_PartyMon               ; SPRITE_ANIM_FRAMESET_PARTY_MON
	dw .Frameset_GSIntroBubble          ; SPRITE_ANIM_FRAMESET_GS_INTRO_BUBBLE
	dw .Frameset_GSIntroOmanyte         ; SPRITE_ANIM_FRAMESET_GS_INTRO_OMANYTE
	dw .Frameset_GSIntroMagikarp        ; SPRITE_ANIM_FRAMESET_GS_INTRO_MAGIKARP
	dw .Frameset_UnusedIntroAerodactyl  ; SPRITE_ANIM_FRAMESET_UNUSED_INTRO_AERODACTYL
	dw .Frameset_GSIntroLapras          ; SPRITE_ANIM_FRAMESET_GS_INTRO_LAPRAS
	dw .Frameset_GSIntroNote            ; SPRITE_ANIM_FRAMESET_GS_INTRO_NOTE
	dw .Frameset_GSIntroSmallerNote     ; SPRITE_ANIM_FRAMESET_GS_INTRO_SMALLER_NOTE
	dw .Frameset_GSIntroJigglypuff      ; SPRITE_ANIM_FRAMESET_GS_INTRO_JIGGLYPUFF
	dw .Frameset_GSIntroPikachu         ; SPRITE_ANIM_FRAMESET_GS_INTRO_PIKACHU
	dw .Frameset_GSIntroPikachu2        ; SPRITE_ANIM_FRAMESET_GS_INTRO_PIKACHU_2
	dw .Frameset_GSIntroPikachuTail     ; SPRITE_ANIM_FRAMESET_GS_INTRO_PIKACHU_TAIL
	dw .Frameset_GSIntroPikachuTail2    ; SPRITE_ANIM_FRAMESET_GS_INTRO_PIKACHU_TAIL_2
	dw .Frameset_GSIntroFireball        ; SPRITE_ANIM_FRAMESET_GS_INTRO_FIREBALL
	dw .Frameset_GSIntroBlastoise       ; SPRITE_ANIM_FRAMESET_GS_INTRO_BLASTOISE
	dw .Frameset_GSIntroVenusaur        ; SPRITE_ANIM_FRAMESET_GS_INTRO_VENUSAUR
	dw .Frameset_GSTitleFlameNote       ; SPRITE_ANIM_FRAMESET_GS_TITLE_FLAME_NOTE
	dw .Frameset_GSIntroPikachu         ; SPRITE_ANIM_FRAMESET_GS_MINIGAME_PIKACHU
	dw .Frameset_GSIntroPikachu2        ; SPRITE_ANIM_FRAMESET_GS_MINIGAME_PIKACHU_2
	dw .Frameset_GSIntroPikachu3        ; SPRITE_ANIM_FRAMESET_GS_MINIGAME_PIKACHU_3
	dw .Frameset_MinigamePicrossCursor  ; SPRITE_ANIM_FRAMESET_MINIGAME_PICROSS_CURSOR
	dw .Frameset_MinigamePicrossDust    ; SPRITE_ANIM_FRAMESET_MINIGAME_PICROSS_DUST
	dw .Frameset_MinigamePicrossGold1   ; SPRITE_ANIM_FRAMESET_MINIGAME_PICROSS_GOLD
	dw .Frameset_MinigamePicrossGold2   ; SPRITE_ANIM_FRAMESET_MINIGAME_PICROSS_GOLD_2
	dw .Frameset_PokedexCursor          ; SPRITE_ANIM_FRAMESET_POKEDEX_CURSOR
	dw .Frameset_PokedexSlowpoke1       ; SPRITE_ANIM_FRAMESET_POKEDEX_SLOWPOKE
	dw .Frameset_PokedexSlowpoke2       ; SPRITE_ANIM_FRAMESET_POKEDEX_SLOWPOKE_2
	dw .Frameset_PokedexSlowpoke3       ; SPRITE_ANIM_FRAMESET_POKEDEX_SLOWPOKE_3
	dw .Frameset_TextEntryCursor        ; SPRITE_ANIM_FRAMESET_TEXT_ENTRY_CURSOR
	dw .Frameset_GSGameFreakLogo        ; SPRITE_ANIM_FRAMESET_GAMEFREAK_LOGO
	dw .Frameset_GSGameFreakLogoStar    ; SPRITE_ANIM_FRAMESET_GS_GAMEFREAK_LOGO_STAR
	dw .Frameset_GSGameFreakLogoSparkle ; SPRITE_ANIM_FRAMESET_GS_GAMEFREAK_LOGO_SPARKLE
	dw .Frameset_SlotsGolem             ; SPRITE_ANIM_FRAMESET_SLOTS_GOLEM
	dw .Frameset_SlotsChansey           ; SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY
	dw .Frameset_SlotsChansey2          ; SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY_2
	dw .Frameset_SlotsEgg               ; SPRITE_ANIM_FRAMESET_SLOTS_EGG
	dw .Frameset_Walk                   ; SPRITE_ANIM_FRAMESET_WALK
	dw .Frameset_StillCursor            ; SPRITE_ANIM_FRAMESET_STILL_CURSOR
	dw .Frameset_TradePokeBall          ; SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL
	dw .Frameset_TradePokeBallWobble    ; SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL_WOBBLE
	dw .Frameset_TradePoof              ; SPRITE_ANIM_FRAMESET_TRADE_POOF
	dw .Frameset_TradeTubeBulge         ; SPRITE_ANIM_FRAMESET_TRADE_TUBE_BULGE
	dw .Frameset_TrademonIcon           ; SPRITE_ANIM_FRAMESET_TRADEMON_ICON
	dw .Frameset_TrademonBubble         ; SPRITE_ANIM_FRAMESET_TRADEMON_BUBBLE
	dw .Frameset_EvolutionBallOfLight   ; SPRITE_ANIM_FRAMESET_EVOLUTION_BALL_OF_LIGHT
	dw .Frameset_RadioFrequencyMeter    ; SPRITE_ANIM_FRAMESET_RADIO_FREQUENCY_METER

.Frameset_00:
	oamframe SPRITE_ANIM_OAMSET_WALK_1, 32
	oamend

.Frameset_PartyMon:
	oamframe SPRITE_ANIM_OAMSET_WALK_1, 8
	oamframe SPRITE_ANIM_OAMSET_WALK_2, 8
	oamrestart

.Frameset_Walk:
	oamframe SPRITE_ANIM_OAMSET_WALK_1,  8
	oamframe SPRITE_ANIM_OAMSET_WALK_2,  8
	oamframe SPRITE_ANIM_OAMSET_WALK_1,  8
	oamframe SPRITE_ANIM_OAMSET_WALK_2,  8, OAM_X_FLIP
	oamrestart

.Frameset_GSIntroBubble:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_BUBBLE_1,  8
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_BUBBLE_2,  8
	oamrestart

.Frameset_GSIntroOmanyte:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_OMANYTE_1,  8
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_OMANYTE_2,  8
	oamrestart

.Frameset_GSIntroMagikarp:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_MAGIKARP_1,  1, OAM_X_FLIP
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_MAGIKARP_2,  1, OAM_X_FLIP
	oamrestart

.Frameset_UnusedIntroAerodactyl:
	oamframe SPRITE_ANIM_OAMSET_UNUSED_INTRO_AERODACTYL,  7, OAM_X_FLIP
	oamend

.Frameset_GSIntroLapras:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_LAPRAS_1,  7
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_LAPRAS_2,  7
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_LAPRAS_3,  15
	oamrestart

.Frameset_GSIntroNote:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_NOTE,  8
	oamend

.Frameset_GSIntroSmallerNote:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_SMALLER_NOTE,  8
	oamend

.Frameset_GSIntroJigglypuff:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_1, 23, OAM_X_FLIP
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_2,  3, OAM_X_FLIP
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_3,  7
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_2,  3
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_1, 23
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_2,  3
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_3,  7
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_2,  3, OAM_X_FLIP
	oamrestart

.Frameset_GSIntroPikachu:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_1, 3
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_2, 3
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_3, 3
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_4, 3
	oamrestart

.Frameset_GSIntroPikachu2:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_2, 8
	oamend

.Frameset_GSIntroPikachuTail:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_TAIL_1,  3
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_TAIL_2,  3
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_TAIL_3,  3
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_TAIL_2,  3
	oamrestart

.Frameset_GSIntroPikachuTail2:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_TAIL_1, 31
	oamend

.Frameset_GSIntroFireball:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_SMALL_FIREBALL,  1
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_MED_FIREBALL,  1
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_BIG_FIREBALL,  1
	oamdelete

.Frameset_GSIntroBlastoise:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_BLASTOISE, 24
	oamdelete

.Frameset_GSIntroVenusaur:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_VENUSAUR, 24, OAM_X_FLIP
	oamdelete

.Frameset_GSTitleFlameNote:
	oamframe SPRITE_ANIM_OAMSET_GS_TITLE_FLAME_NOTE_1, 3
	oamframe SPRITE_ANIM_OAMSET_GS_TITLE_FLAME_NOTE_2, 3
	oamrestart

.Frameset_GSIntroPikachu3:
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_2,  0
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_3, 15
	oamframe SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_4, 15
	oamend

.Frameset_MinigamePicrossCursor:
	oamframe SPRITE_ANIM_OAMSET_MINIGAME_PICROSS_CURSOR,  8
	oamwait 8
	oamrestart

.Frameset_MinigamePicrossDust:
	oamframe SPRITE_ANIM_OAMSET_MINIGAME_PICROSS_DUST_1, 1
	oamframe SPRITE_ANIM_OAMSET_MINIGAME_PICROSS_DUST_2, 1
	oamdelete

.Frameset_MinigamePicrossGold2:
	oamframe SPRITE_ANIM_OAMSET_WALK_2, 3, OAM_X_FLIP
	oamframe SPRITE_ANIM_OAMSET_WALK_1, 3
	oamframe SPRITE_ANIM_OAMSET_WALK_2, 3, OAM_X_FLIP
	; fallthrough
.Frameset_MinigamePicrossGold1:
	oamframe SPRITE_ANIM_OAMSET_WALK_1, 8
	oamend

.Frameset_PokedexCursor:
	oamframe SPRITE_ANIM_OAMSET_POKEDEX_CURSOR, 1
	oamwait 1
	oamrestart

.Frameset_PokedexSlowpoke1:
	oamframe SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_1, 3
	oamframe SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_2, 3
	oamframe SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_3, 3
	oamframe SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_4, 3
	oamrestart

.Frameset_PokedexSlowpoke2:
	oamframe SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_5, 32
	oamdelete

.Frameset_PokedexSlowpoke3:
	oamframe SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_1, 32
	oamdelete

.Frameset_TextEntryCursor:
	oamframe SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR, 1
	oamwait 1
	oamrestart

.Frameset_GSGameFreakLogo:
	oamframe SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO, 8
	oamend

.Frameset_GSGameFreakLogoStar:
	oamframe SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_STAR,  3
	oamframe SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_STAR,  3, OAM_Y_FLIP
	oamrestart

.Frameset_GSGameFreakLogoSparkle:
	oamframe SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_SPARKLE_1,  2
	oamframe SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_SPARKLE_2,  2
	oamframe SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_SPARKLE_3,  2
	oamframe SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_SPARKLE_2,  2
	oamrestart

.Frameset_SlotsGolem:
	oamframe SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1,  7, OAM_Y_FLIP
	oamframe SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2,  7, OAM_X_FLIP
	oamrestart

.Frameset_SlotsChansey:
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_2,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_3,  7
	oamrestart

.Frameset_SlotsChansey2:
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_5,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	oamend

.Frameset_SlotsEgg:
	oamframe SPRITE_ANIM_OAMSET_SLOTS_EGG, 20
	oamend

.Frameset_StillCursor:
	oamframe SPRITE_ANIM_OAMSET_STILL_CURSOR, 32
	oamend

.Frameset_TradePokeBall:
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1, 32
	oamend

.Frameset_TradePokeBallWobble:
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1,  3
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2,  3
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1,  3
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2,  3, OAM_X_FLIP
	oamrestart

.Frameset_TradePoof
	oamframe SPRITE_ANIM_OAMSET_TRADE_POOF_1,  4
	oamframe SPRITE_ANIM_OAMSET_TRADE_POOF_2,  4
	oamframe SPRITE_ANIM_OAMSET_TRADE_POOF_3,  4
	oamdelete

.Frameset_TradeTubeBulge:
	oamframe SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_1,  3
	oamframe SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_2,  3
	oamrestart

.Frameset_TrademonIcon:
	oamframe SPRITE_ANIM_OAMSET_TRADEMON_ICON_1,  7
	oamframe SPRITE_ANIM_OAMSET_TRADEMON_ICON_2,  7
	oamrestart

.Frameset_TrademonBubble:
	oamframe SPRITE_ANIM_OAMSET_TRADEMON_BUBBLE, 32
	oamend

.Frameset_EvolutionBallOfLight:
	oamframe SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT, 32
	oamend

.Frameset_RadioFrequencyMeter:
	oamframe SPRITE_ANIM_OAMSET_RADIO_FREQUENCY_METER, 32
	oamend
