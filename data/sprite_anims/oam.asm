MACRO spriteanimoam
; vtile offset, data pointer
	db \1
	dw \2
ENDM

SpriteAnimOAMData:
	spriteanimoam $00, .OAMData_Walk                     ; SPRITE_ANIM_OAMSET_WALK_1
	spriteanimoam $04, .OAMData_Walk                     ; SPRITE_ANIM_OAMSET_WALK_2
	spriteanimoam $4c, .OAMData_1x1_Palette0             ; SPRITE_ANIM_OAMSET_GS_INTRO_BUBBLE_1
	spriteanimoam $5c, .OAMData_1x1_Palette0             ; SPRITE_ANIM_OAMSET_GS_INTRO_BUBBLE_2
	spriteanimoam $6c, .OAMData_GSIntroOmanyte           ; SPRITE_ANIM_OAMSET_GS_INTRO_OMANYTE_1
	spriteanimoam $6e, .OAMData_GSIntroOmanyte           ; SPRITE_ANIM_OAMSET_GS_INTRO_OMANYTE_2
	spriteanimoam $2d, .OAMData_GSIntroMagikarp          ; SPRITE_ANIM_OAMSET_GS_INTRO_MAGIKARP_1
	spriteanimoam $4d, .OAMData_GSIntroMagikarp          ; SPRITE_ANIM_OAMSET_GS_INTRO_MAGIKARP_2
	spriteanimoam $60, .OAMData_UnusedIntroAerodactyl    ; SPRITE_ANIM_OAMSET_UNUSED_INTRO_AERODACTYL
	spriteanimoam $00, .OAMData_GSIntroLapras1           ; SPRITE_ANIM_OAMSET_GS_INTRO_LAPRAS_1
	spriteanimoam $00, .OAMData_GSIntroLapras2           ; SPRITE_ANIM_OAMSET_GS_INTRO_LAPRAS_2
	spriteanimoam $06, .OAMData_GSIntroLapras3           ; SPRITE_ANIM_OAMSET_GS_INTRO_LAPRAS_3
	spriteanimoam $0c, .OAMData_GSIntroNote              ; SPRITE_ANIM_OAMSET_GS_INTRO_NOTE
	spriteanimoam $0d, .OAMData_1x1_Palette0             ; SPRITE_ANIM_OAMSET_GS_INTRO_SMALLER_NOTE
	spriteanimoam $00, .OAMData_GSIntroJigglypuffPikachu ; SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_1
	spriteanimoam $04, .OAMData_GSIntroJigglypuffPikachu ; SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_2
	spriteanimoam $08, .OAMData_GSIntroJigglypuffPikachu ; SPRITE_ANIM_OAMSET_GS_INTRO_JIGGLYPUFF_3
	spriteanimoam $40, .OAMData_GSIntroJigglypuffPikachu ; SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_1
	spriteanimoam $44, .OAMData_GSIntroJigglypuffPikachu ; SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_2
	spriteanimoam $48, .OAMData_GSIntroJigglypuffPikachu ; SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_3
	spriteanimoam $4c, .OAMData_GSIntroJigglypuffPikachu ; SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_4
	spriteanimoam $80, .OAMData_GSIntroPikachuTail       ; SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_TAIL_1
	spriteanimoam $85, .OAMData_GSIntroPikachuTail       ; SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_TAIL_2
	spriteanimoam $8a, .OAMData_GSIntroPikachuTail       ; SPRITE_ANIM_OAMSET_GS_INTRO_PIKACHU_TAIL_3
	spriteanimoam $00, .OAMData_GSIntroSmallFireball     ; SPRITE_ANIM_OAMSET_GS_INTRO_SMALL_FIREBALL
	spriteanimoam $01, .OAMData_TradePoofBubble          ; SPRITE_ANIM_OAMSET_GS_INTRO_MED_FIREBALL
	spriteanimoam $09, .OAMData_GSIntroBigFireball       ; SPRITE_ANIM_OAMSET_GS_INTRO_BIG_FIREBALL
	spriteanimoam $10, .OAMData_GSIntroVenusaurBlastoise ; SPRITE_ANIM_OAMSET_GS_INTRO_BLASTOISE
	spriteanimoam $40, .OAMData_GSIntroVenusaurBlastoise ; SPRITE_ANIM_OAMSET_GS_INTRO_VENUSAUR
	spriteanimoam $00, .OAMData_Walk                     ; SPRITE_ANIM_OAMSET_GS_TITLE_FLAME_NOTE_1
	spriteanimoam $04, .OAMData_Walk                     ; SPRITE_ANIM_OAMSET_GS_TITLE_FLAME_NOTE_2
	spriteanimoam $00, .OAMData_MinigamePicrossCursor    ; SPRITE_ANIM_OAMSET_MINIGAME_PICROSS_CURSOR
	spriteanimoam $01, .OAMData_1x1_Palette0             ; SPRITE_ANIM_OAMSET_MINIGAME_PICROSS_DUST_1
	spriteanimoam $02, .OAMData_Walk                     ; SPRITE_ANIM_OAMSET_MINIGAME_PICROSS_DUST_1
	spriteanimoam $04, .OAMData_PokedexCursor            ; SPRITE_ANIM_OAMSET_POKEDEX_CURSOR
	spriteanimoam $00, .OAMData_PokedexSlowpoke1         ; SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_1
	spriteanimoam $00, .OAMData_PokedexSlowpoke2         ; SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_2
	spriteanimoam $00, .OAMData_PokedexSlowpoke3         ; SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_3
	spriteanimoam $00, .OAMData_PokedexSlowpoke4         ; SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_4
	spriteanimoam $00, .OAMData_PokedexSlowpoke5         ; SPRITE_ANIM_OAMSET_POKEDEX_SLOWPOKE_5
	spriteanimoam $00, .OAMData_TextEntryCursor          ; SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR
	spriteanimoam $00, .OAMData_GSGameFreakLogo          ; SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO
	spriteanimoam $0f, .OAMData_GSGameFreakLogoStar      ; SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_STAR
	spriteanimoam $11, .OAMData_1x1_Palette0             ; SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_SPARKLE_1
	spriteanimoam $12, .OAMData_1x1_Palette0             ; SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_SPARKLE_2
	spriteanimoam $13, .OAMData_1x1_Palette0             ; SPRITE_ANIM_OAMSET_GS_GAMEFREAK_LOGO_SPARKLE_3
	spriteanimoam $00, .OAMData_SlotsGolem               ; SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1
	spriteanimoam $08, .OAMData_SlotsGolem               ; SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2
	spriteanimoam $10, .OAMData_SlotsChansey1            ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1
	spriteanimoam $10, .OAMData_SlotsChansey2            ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_2
	spriteanimoam $10, .OAMData_SlotsChansey3            ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_3
	spriteanimoam $10, .OAMData_SlotsChansey4            ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4
	spriteanimoam $10, .OAMData_SlotsChansey5            ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_5
	spriteanimoam $3a, .OAMData_1x1_Palette0             ; SPRITE_ANIM_OAMSET_SLOTS_EGG
	spriteanimoam $00, .OAMData_Walk                     ; SPRITE_ANIM_OAMSET_STILL_CURSOR
	spriteanimoam $00, .OAMData_TradePokeBall1           ; SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1
	spriteanimoam $02, .OAMData_WalkPriority             ; SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2
	spriteanimoam $06, .OAMData_TradePoofBubble          ; SPRITE_ANIM_OAMSET_TRADE_POOF_1
	spriteanimoam $0a, .OAMData_TradePoofBubble          ; SPRITE_ANIM_OAMSET_TRADE_POOF_2
	spriteanimoam $0e, .OAMData_TradePoofBubble          ; SPRITE_ANIM_OAMSET_TRADE_POOF_3
	spriteanimoam $12, .OAMData_GSIntroSmallFireball     ; SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_1
	spriteanimoam $13, .OAMData_GSIntroSmallFireball     ; SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_2
	spriteanimoam $00, .OAMData_Walk                     ; SPRITE_ANIM_OAMSET_TRADEMON_ICON_1
	spriteanimoam $04, .OAMData_Walk                     ; SPRITE_ANIM_OAMSET_TRADEMON_ICON_2
	spriteanimoam $10, .OAMData_TradePoofBubble          ; SPRITE_ANIM_OAMSET_TRADEMON_BUBBLE
	spriteanimoam $00, .OAMData_Unknown1                 ; SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT
	spriteanimoam $00, .OAMData_RadioFrequencyMeter      ; SPRITE_ANIM_OAMSET_RADIO_FREQUENCY_METER

.OAMData_1x1_Palette0:
	db 1
	dbsprite -1, -1,  4,  4, $00, 0

.OAMData_GSIntroOmanyte:
	db 4
	dbsprite -1, -1,  0,  0, $00, 0
	dbsprite  0, -1,  0,  0, $01, 0
	dbsprite -1,  0,  0,  0, $10, 0
	dbsprite  0,  0,  0,  0, $11, 0

.OAMData_GSGameFreakLogoStar:
	db 4
	dbsprite -1, -1,  0,  0, $00, 0
	dbsprite  0, -1,  0,  0, $00, 0 | X_FLIP
	dbsprite -1,  0,  0,  0, $01, 0
	dbsprite  0,  0,  0,  0, $01, 0 | X_FLIP

.OAMData_TradePokeBall1:
	db 4
	dbsprite -1, -1,  0,  0, $00, 0 | PRIORITY
	dbsprite  0, -1,  0,  0, $00, 0 | X_FLIP | PRIORITY
	dbsprite -1,  0,  0,  0, $01, 0 | PRIORITY
	dbsprite  0,  0,  0,  0, $01, 0 | X_FLIP | PRIORITY

.OAMData_GSIntroSmallFireball:
	db 4
	dbsprite -1, -1,  0,  0, $00, 0
	dbsprite  0, -1,  0,  0, $00, 0 | X_FLIP
	dbsprite -1,  0,  0,  0, $00, 0 | Y_FLIP
	dbsprite  0,  0,  0,  0, $00, 0 | X_FLIP | Y_FLIP

; Unreferenced in pokegold
.OAMData_Unknown1:
	db 4
	dbsprite -1, -1,  0,  0, $00, 0 | PRIORITY
	dbsprite  0, -1,  0,  0, $00, 0 | X_FLIP | PRIORITY
	dbsprite -1,  0,  0,  0, $00, 0 | Y_FLIP | PRIORITY
	dbsprite  0,  0,  0,  0, $00, 0 | X_FLIP | Y_FLIP | PRIORITY

.OAMData_TradePoofBubble:
	db 16
	dbsprite -2, -2,  0,  0, $00, 0
	dbsprite -1, -2,  0,  0, $01, 0
	dbsprite -2, -1,  0,  0, $02, 0
	dbsprite -1, -1,  0,  0, $03, 0
	dbsprite  0, -2,  0,  0, $01, 0 | X_FLIP
	dbsprite  1, -2,  0,  0, $00, 0 | X_FLIP
	dbsprite  0, -1,  0,  0, $03, 0 | X_FLIP
	dbsprite  1, -1,  0,  0, $02, 0 | X_FLIP
	dbsprite -2,  0,  0,  0, $02, 0 | Y_FLIP
	dbsprite -1,  0,  0,  0, $03, 0 | Y_FLIP
	dbsprite -2,  1,  0,  0, $00, 0 | Y_FLIP
	dbsprite -1,  1,  0,  0, $01, 0 | Y_FLIP
	dbsprite  0,  0,  0,  0, $03, 0 | X_FLIP | Y_FLIP
	dbsprite  1,  0,  0,  0, $02, 0 | X_FLIP | Y_FLIP
	dbsprite  0,  1,  0,  0, $01, 0 | X_FLIP | Y_FLIP
	dbsprite  1,  1,  0,  0, $00, 0 | X_FLIP | Y_FLIP

.OAMData_GSIntroBigFireball:
	db 36
	dbsprite -3, -3,  0,  0, $00, 0
	dbsprite -2, -3,  0,  0, $01, 0
	dbsprite -1, -3,  0,  0, $02, 0
	dbsprite -3, -2,  0,  0, $03, 0
	dbsprite -2, -2,  0,  0, $04, 0
	dbsprite -1, -2,  0,  0, $05, 0
	dbsprite -3, -1,  0,  0, $06, 0
	dbsprite -2, -1,  0,  0, $05, 0
	dbsprite -1, -1,  0,  0, $05, 0
	dbsprite  0, -3,  0,  0, $02, 0 | X_FLIP
	dbsprite  1, -3,  0,  0, $01, 0 | X_FLIP
	dbsprite  2, -3,  0,  0, $00, 0 | X_FLIP
	dbsprite  0, -2,  0,  0, $05, 0 | X_FLIP
	dbsprite  1, -2,  0,  0, $04, 0 | X_FLIP
	dbsprite  2, -2,  0,  0, $03, 0 | X_FLIP
	dbsprite  0, -1,  0,  0, $05, 0 | X_FLIP
	dbsprite  1, -1,  0,  0, $05, 0 | X_FLIP
	dbsprite  2, -1,  0,  0, $06, 0 | X_FLIP
	dbsprite -3,  0,  0,  0, $06, 0 | Y_FLIP
	dbsprite -2,  0,  0,  0, $05, 0 | Y_FLIP
	dbsprite -1,  0,  0,  0, $05, 0 | Y_FLIP
	dbsprite -3,  1,  0,  0, $03, 0 | Y_FLIP
	dbsprite -2,  1,  0,  0, $04, 0 | Y_FLIP
	dbsprite -1,  1,  0,  0, $05, 0 | Y_FLIP
	dbsprite -3,  2,  0,  0, $00, 0 | Y_FLIP
	dbsprite -2,  2,  0,  0, $01, 0 | Y_FLIP
	dbsprite -1,  2,  0,  0, $02, 0 | Y_FLIP
	dbsprite  0,  0,  0,  0, $05, 0 | X_FLIP | Y_FLIP
	dbsprite  1,  0,  0,  0, $05, 0 | X_FLIP | Y_FLIP
	dbsprite  2,  0,  0,  0, $06, 0 | X_FLIP | Y_FLIP
	dbsprite  0,  1,  0,  0, $05, 0 | X_FLIP | Y_FLIP
	dbsprite  1,  1,  0,  0, $04, 0 | X_FLIP | Y_FLIP
	dbsprite  2,  1,  0,  0, $03, 0 | X_FLIP | Y_FLIP
	dbsprite  0,  2,  0,  0, $02, 0 | X_FLIP | Y_FLIP
	dbsprite  1,  2,  0,  0, $01, 0 | X_FLIP | Y_FLIP
	dbsprite  2,  2,  0,  0, $00, 0 | X_FLIP | Y_FLIP

.OAMData_GSIntroJigglypuffPikachu:
	db 16
	dbsprite -2, -2,  0,  0, $00, 0
	dbsprite -1, -2,  0,  0, $01, 0
	dbsprite  0, -2,  0,  0, $02, 0
	dbsprite  1, -2,  0,  0, $03, 0
	dbsprite -2, -1,  0,  0, $10, 0
	dbsprite -1, -1,  0,  0, $11, 0
	dbsprite  0, -1,  0,  0, $12, 0
	dbsprite  1, -1,  0,  0, $13, 0
	dbsprite -2,  0,  0,  0, $20, 0
	dbsprite -1,  0,  0,  0, $21, 0
	dbsprite  0,  0,  0,  0, $22, 0
	dbsprite  1,  0,  0,  0, $23, 0
	dbsprite -2,  1,  0,  0, $30, 0
	dbsprite -1,  1,  0,  0, $31, 0
	dbsprite  0,  1,  0,  0, $32, 0
	dbsprite  1,  1,  0,  0, $33, 0

; Known as .OAMData_Unknown2 in pokegold
.OAMData_GSIntroVenusaurBlastoise:
	db 36
	dbsprite -3, -3,  0,  0, $00, 0
	dbsprite -2, -3,  0,  0, $01, 0
	dbsprite -1, -3,  0,  0, $02, 0
	dbsprite  0, -3,  0,  0, $03, 0
	dbsprite  1, -3,  0,  0, $04, 0
	dbsprite  2, -3,  0,  0, $05, 0
	dbsprite -3, -2,  0,  0, $06, 0
	dbsprite -2, -2,  0,  0, $07, 0
	dbsprite -1, -2,  0,  0, $08, 0
	dbsprite  0, -2,  0,  0, $09, 0
	dbsprite  1, -2,  0,  0, $0a, 0
	dbsprite  2, -2,  0,  0, $0b, 0
	dbsprite -3, -1,  0,  0, $0c, 0
	dbsprite -2, -1,  0,  0, $0d, 0
	dbsprite -1, -1,  0,  0, $0e, 0
	dbsprite  0, -1,  0,  0, $0f, 0
	dbsprite  1, -1,  0,  0, $10, 0
	dbsprite  2, -1,  0,  0, $11, 0
	dbsprite -3,  0,  0,  0, $12, 0
	dbsprite -2,  0,  0,  0, $13, 0
	dbsprite -1,  0,  0,  0, $14, 0
	dbsprite  0,  0,  0,  0, $15, 0
	dbsprite  1,  0,  0,  0, $16, 0
	dbsprite  2,  0,  0,  0, $17, 0
	dbsprite -3,  1,  0,  0, $18, 0
	dbsprite -2,  1,  0,  0, $19, 0
	dbsprite -1,  1,  0,  0, $1a, 0
	dbsprite  0,  1,  0,  0, $1b, 0
	dbsprite  1,  1,  0,  0, $1c, 0
	dbsprite  2,  1,  0,  0, $1d, 0
	dbsprite -3,  2,  0,  0, $1e, 0
	dbsprite -2,  2,  0,  0, $1f, 0
	dbsprite -1,  2,  0,  0, $20, 0
	dbsprite  0,  2,  0,  0, $21, 0
	dbsprite  1,  2,  0,  0, $22, 0
	dbsprite  2,  2,  0,  0, $23, 0

.OAMData_Walk:
	db 4
	dbsprite -1, -1,  0,  0, $00, 0
	dbsprite  0, -1,  0,  0, $01, 0
	dbsprite -1,  0,  0,  0, $02, 0
	dbsprite  0,  0,  0,  0, $03, 0

.OAMData_WalkPriority:
	db 4
	dbsprite -1, -1,  0,  0, $00, 0 | PRIORITY
	dbsprite  0, -1,  0,  0, $01, 0 | PRIORITY
	dbsprite -1,  0,  0,  0, $02, 0 | PRIORITY
	dbsprite  0,  0,  0,  0, $03, 0 | PRIORITY

.OAMData_GSIntroMagikarp:
	db 6
	dbsprite -2, -1,  4,  0, $00, 0
	dbsprite -1, -1,  4,  0, $01, 0
	dbsprite  0, -1,  4,  0, $02, 0
	dbsprite -2,  0,  4,  0, $10, 0
	dbsprite -1,  0,  4,  0, $11, 0
	dbsprite  0,  0,  4,  0, $12, 0

.OAMData_UnusedIntroAerodactyl:
	db 10
	dbsprite -2, -2,  0,  4, $00, 0
	dbsprite -1, -2,  0,  4, $01, 0
	dbsprite  0, -2,  0,  4, $02, 0
	dbsprite  1, -2,  0,  4, $03, 0
	dbsprite -2, -1,  0,  4, $04, 0
	dbsprite -1, -1,  0,  4, $05, 0
	dbsprite  0, -1,  0,  4, $06, 0
	dbsprite -2,  0,  0,  4, $08, 0
	dbsprite -1,  0,  0,  4, $09, 0
	dbsprite  0,  0,  0,  4, $0a, 0

.OAMData_GSIntroLapras1:
db 27
	dbsprite -3, -3,  0,  0, $00, 0 | PRIORITY
	dbsprite -2, -3,  0,  0, $01, 0 | PRIORITY
	dbsprite -1, -3,  0,  0, $02, 0 | PRIORITY
	dbsprite -3, -2,  0,  0, $10, 0 | PRIORITY
	dbsprite -2, -2,  0,  0, $11, 0 | PRIORITY
	dbsprite -1, -2,  0,  0, $12, 0 | PRIORITY
	dbsprite -3, -1,  0,  0, $20, 0 | PRIORITY
	dbsprite -2, -1,  0,  0, $21, 0 | PRIORITY
	dbsprite -1, -1,  0,  0, $22, 0 | PRIORITY
	dbsprite  0, -1,  0,  0, $23, 0 | PRIORITY
	dbsprite -3,  0,  0,  0, $30, 0 | PRIORITY
	dbsprite -2,  0,  0,  0, $31, 0 | PRIORITY
	dbsprite -1,  0,  0,  0, $32, 0 | PRIORITY
	dbsprite  0,  0,  0,  0, $33, 0 | PRIORITY
	dbsprite  1,  0,  0,  0, $34, 0 | PRIORITY
	dbsprite -3,  1,  0,  0, $40, 0 | PRIORITY
	dbsprite -2,  1,  0,  0, $41, 0 | PRIORITY
	dbsprite -1,  1,  0,  0, $42, 0 | PRIORITY
	dbsprite  0,  1,  0,  0, $43, 0 | PRIORITY
	dbsprite  1,  1,  0,  0, $44, 0 | PRIORITY
	dbsprite  2,  1,  0,  0, $45, 0 | PRIORITY
	dbsprite -3,  2,  0,  0, $50, 0 | PRIORITY
	dbsprite -2,  2,  0,  0, $51, 0 | PRIORITY
	dbsprite -1,  2,  0,  0, $52, 0 | PRIORITY
	dbsprite  0,  2,  0,  0, $53, 0 | PRIORITY
	dbsprite  1,  2,  0,  0, $54, 0 | PRIORITY
	dbsprite  2,  2,  0,  0, $55, 0 | PRIORITY

.OAMData_GSIntroLapras2:
	db 27
	dbsprite -3, -3,  0,  0, $0d, 0 | PRIORITY
	dbsprite -2, -3,  0,  0, $0e, 0 | PRIORITY
	dbsprite -1, -3,  0,  0, $0f, 0 | PRIORITY
	dbsprite -3, -2,  0,  0, $1d, 0 | PRIORITY
	dbsprite -2, -2,  0,  0, $1e, 0 | PRIORITY
	dbsprite -1, -2,  0,  0, $1f, 0 | PRIORITY
	dbsprite -3, -1,  0,  0, $20, 0 | PRIORITY
	dbsprite -2, -1,  0,  0, $21, 0 | PRIORITY
	dbsprite -1, -1,  0,  0, $22, 0 | PRIORITY
	dbsprite  0, -1,  0,  0, $23, 0 | PRIORITY
	dbsprite -3,  0,  0,  0, $30, 0 | PRIORITY
	dbsprite -2,  0,  0,  0, $31, 0 | PRIORITY
	dbsprite -1,  0,  0,  0, $32, 0 | PRIORITY
	dbsprite  0,  0,  0,  0, $33, 0 | PRIORITY
	dbsprite  1,  0,  0,  0, $34, 0 | PRIORITY
	dbsprite -3,  1,  0,  0, $40, 0 | PRIORITY
	dbsprite -2,  1,  0,  0, $41, 0 | PRIORITY
	dbsprite -1,  1,  0,  0, $42, 0 | PRIORITY
	dbsprite  0,  1,  0,  0, $43, 0 | PRIORITY
	dbsprite  1,  1,  0,  0, $44, 0 | PRIORITY
	dbsprite  2,  1,  0,  0, $45, 0 | PRIORITY
	dbsprite -3,  2,  0,  0, $50, 0 | PRIORITY
	dbsprite -2,  2,  0,  0, $51, 0 | PRIORITY
	dbsprite -1,  2,  0,  0, $52, 0 | PRIORITY
	dbsprite  0,  2,  0,  0, $53, 0 | PRIORITY
	dbsprite  1,  2,  0,  0, $54, 0 | PRIORITY
	dbsprite  2,  2,  0,  0, $55, 0 | PRIORITY

.OAMData_GSIntroLapras3:
	db 29
	dbsprite -3, -3,  0,  0, $00, 0 | PRIORITY
	dbsprite -2, -3,  0,  0, $01, 0 | PRIORITY
	dbsprite -1, -3,  0,  0, $02, 0 | PRIORITY
	dbsprite  0, -3,  0,  0, $03, 0 | PRIORITY
	dbsprite -3, -2,  0,  0, $10, 0 | PRIORITY
	dbsprite -2, -2,  0,  0, $11, 0 | PRIORITY
	dbsprite -1, -2,  0,  0, $12, 0 | PRIORITY
	dbsprite  0, -2,  0,  0, $13, 0 | PRIORITY
	dbsprite -3, -1,  0,  0, $20, 0 | PRIORITY
	dbsprite -2, -1,  0,  0, $21, 0 | PRIORITY
	dbsprite -1, -1,  0,  0, $22, 0 | PRIORITY
	dbsprite  0, -1,  0,  0, $23, 0 | PRIORITY
	dbsprite  1, -1,  0,  0, $24, 0 | PRIORITY
	dbsprite -3,  0,  0,  0, $30, 0 | PRIORITY
	dbsprite -2,  0,  0,  0, $31, 0 | PRIORITY
	dbsprite -1,  0,  0,  0, $32, 0 | PRIORITY
	dbsprite  0,  0,  0,  0, $33, 0 | PRIORITY
	dbsprite  1,  0,  0,  0, $34, 0 | PRIORITY
	dbsprite -3,  1,  0,  0, $40, 0 | PRIORITY
	dbsprite -2,  1,  0,  0, $41, 0 | PRIORITY
	dbsprite -1,  1,  0,  0, $42, 0 | PRIORITY
	dbsprite  0,  1,  0,  0, $43, 0 | PRIORITY
	dbsprite  1,  1,  0,  0, $44, 0 | PRIORITY
	dbsprite  2,  1,  0,  0, $45, 0 | PRIORITY
	dbsprite -2,  2,  0,  0, $51, 0 | PRIORITY
	dbsprite -1,  2,  0,  0, $52, 0 | PRIORITY
	dbsprite  0,  2,  0,  0, $53, 0 | PRIORITY
	dbsprite  1,  2,  0,  0, $54, 0 | PRIORITY
	dbsprite  2,  2,  0,  0, $55, 0 | PRIORITY

.OAMData_GSIntroNote:
	db 2
	dbsprite -1, -1,  4,  0, $00, 0
	dbsprite -1,  0,  4,  0, $10, 0

.OAMData_GSIntroPikachuTail:
	db 5
	dbsprite  3, -2,  0,  0, $00, 0
	dbsprite  4, -2,  0,  0, $01, 0
	dbsprite  2, -1,  0,  0, $02, 0
	dbsprite  3, -1,  0,  0, $03, 0
	dbsprite  2,  0,  0,  0, $04, 0

.OAMData_MinigamePicrossCursor:
	db 1
	dbsprite -1, -1,  7,  7, $00, 0

.OAMData_PokedexCursor:
	db 10
	dbsprite  0, -1,  0,  0, $00, 0
	dbsprite  1, -1,  0,  0, $01, 0
	dbsprite  2, -1,  0,  0, $01, 0
	dbsprite  3, -1,  0,  0, $01, 0
	dbsprite  4, -1,  0,  0, $00, 0 | X_FLIP
	dbsprite  0,  0,  0,  0, $00, 0 | Y_FLIP
	dbsprite  1,  0,  0,  0, $01, 0 | Y_FLIP
	dbsprite  2,  0,  0,  0, $01, 0 | Y_FLIP
	dbsprite  3,  0,  0,  0, $01, 0 | Y_FLIP
	dbsprite  4,  0,  0,  0, $00, 0 | X_FLIP | Y_FLIP

.OAMData_PokedexSlowpoke1:
	db 15
	dbsprite -2, -2,  4,  0, $06, 0
	dbsprite -1, -2,  4,  0, $07, 0
	dbsprite  0, -2,  4,  0, $08, 0
	dbsprite -2, -1,  4,  0, $09, 0
	dbsprite -1, -1,  4,  0, $0a, 0
	dbsprite  0, -1,  4,  0, $0b, 0
	dbsprite -2,  0,  4,  0, $0c, 0
	dbsprite -1,  0,  4,  0, $0d, 0
	dbsprite  0,  0,  4,  0, $0e, 0
	dbsprite -2,  1,  4,  0, $10, 0
	dbsprite -1,  1,  4,  0, $11, 0
	dbsprite  0,  1,  4,  0, $12, 0
	dbsprite  1, -2,  4,  0, $16, 0
	dbsprite  1, -1,  4,  0, $17, 0
	dbsprite  1,  0,  4,  0, $18, 0

.OAMData_PokedexSlowpoke2:
	db 15
	dbsprite -2, -2,  4,  0, $06, 0
	dbsprite -1, -2,  4,  0, $07, 0
	dbsprite  0, -2,  4,  0, $08, 0
	dbsprite -2, -1,  4,  0, $09, 0
	dbsprite -1, -1,  4,  0, $0a, 0
	dbsprite  0, -1,  4,  0, $0b, 0
	dbsprite -2,  0,  4,  0, $0c, 0
	dbsprite -1,  0,  4,  0, $0d, 0
	dbsprite  0,  0,  4,  0, $0e, 0
	dbsprite -2,  1,  4,  0, $13, 0
	dbsprite -1,  1,  4,  0, $14, 0
	dbsprite  0,  1,  4,  0, $15, 0
	dbsprite  1, -2,  4,  0, $16, 0
	dbsprite  1, -1,  4,  0, $17, 0
	dbsprite  1,  0,  4,  0, $18, 0

.OAMData_PokedexSlowpoke3:
	db 15
	dbsprite -2, -2,  4,  0, $08, 0 | X_FLIP
	dbsprite -1, -2,  4,  0, $07, 0 | X_FLIP
	dbsprite  0, -2,  4,  0, $06, 0 | X_FLIP
	dbsprite -2, -1,  4,  0, $09, 0
	dbsprite -1, -1,  4,  0, $0a, 0
	dbsprite  0, -1,  4,  0, $0b, 0
	dbsprite -2,  0,  4,  0, $0c, 0
	dbsprite -1,  0,  4,  0, $0d, 0
	dbsprite  0,  0,  4,  0, $0e, 0
	dbsprite -2,  1,  4,  0, $20, 0
	dbsprite -1,  1,  4,  0, $21, 0
	dbsprite  0,  1,  4,  0, $22, 0
	dbsprite  1, -2,  4,  0, $19, 0
	dbsprite  1, -1,  4,  0, $1a, 0
	dbsprite  1,  0,  4,  0, $18, 0

.OAMData_PokedexSlowpoke4:
	db 15
	dbsprite -2, -2,  4,  0, $08, 0 | X_FLIP
	dbsprite -1, -2,  4,  0, $07, 0 | X_FLIP
	dbsprite  0, -2,  4,  0, $06, 0 | X_FLIP
	dbsprite -2, -1,  4,  0, $09, 0
	dbsprite -1, -1,  4,  0, $0a, 0
	dbsprite  0, -1,  4,  0, $0b, 0
	dbsprite -2,  0,  4,  0, $0c, 0
	dbsprite -1,  0,  4,  0, $0d, 0
	dbsprite  0,  0,  4,  0, $0e, 0
	dbsprite -2,  1,  4,  0, $10, 0
	dbsprite -1,  1,  4,  0, $11, 0
	dbsprite  0,  1,  4,  0, $12, 0
	dbsprite  1, -2,  4,  0, $19, 0
	dbsprite  1, -1,  4,  0, $1a, 0
	dbsprite  1,  0,  4,  0, $18, 0

.OAMData_PokedexSlowpoke5:
	db 17
	dbsprite -2, -2,  4,  0, $08, 0 | X_FLIP
	dbsprite -1, -2,  4,  0, $07, 0 | X_FLIP
	dbsprite  0, -2,  4,  0, $06, 0 | X_FLIP
	dbsprite -2, -1,  4,  0, $09, 0
	dbsprite -1, -1,  4,  0, $0f, 0
	dbsprite  0, -1,  4,  0, $0b, 0
	dbsprite -2,  0,  4,  0, $0c, 0
	dbsprite -1,  0,  4,  0, $0d, 0
	dbsprite  0,  0,  4,  0, $0e, 0
	dbsprite -2,  1,  4,  0, $10, 0
	dbsprite -1,  1,  4,  0, $11, 0
	dbsprite  0,  1,  4,  0, $12, 0
	dbsprite  1, -2,  4,  0, $19, 0
	dbsprite  1, -1,  4,  0, $1a, 0
	dbsprite  1,  0,  4,  0, $18, 0
	; Light bulb
	dbsprite -1, -4,  4,  0, $23, 0
	dbsprite -1, -3,  4,  0, $24, 0

.OAMData_TextEntryCursor:
	db 4
	dbsprite -1, -1,  7,  7, $00, 0
	dbsprite  0, -1,  1,  7, $00, 0 | X_FLIP
	dbsprite -1,  0,  7,  1, $00, 0 | Y_FLIP
	dbsprite  0,  0,  1,  1, $00, 0 | X_FLIP | Y_FLIP

.OAMData_GSGameFreakLogo:
	db 15
	dbsprite -2, -3,  4,  4, $00, 0 | OBP_NUM
	dbsprite -1, -3,  4,  4, $01, 0 | OBP_NUM
	dbsprite  0, -3,  4,  4, $02, 0 | OBP_NUM
	dbsprite -2, -2,  4,  4, $03, 0 | OBP_NUM
	dbsprite -1, -2,  4,  4, $04, 0 | OBP_NUM
	dbsprite  0, -2,  4,  4, $05, 0 | OBP_NUM
	dbsprite -2, -1,  4,  4, $06, 0 | OBP_NUM
	dbsprite -1, -1,  4,  4, $07, 0 | OBP_NUM
	dbsprite  0, -1,  4,  4, $08, 0 | OBP_NUM
	dbsprite -2,  0,  4,  4, $09, 0 | OBP_NUM
	dbsprite -1,  0,  4,  4, $0a, 0 | OBP_NUM
	dbsprite  0,  0,  4,  4, $0b, 0 | OBP_NUM
	dbsprite -2,  1,  4,  4, $0c, 0 | OBP_NUM
	dbsprite -1,  1,  4,  4, $0d, 0 | OBP_NUM
	dbsprite  0,  1,  4,  4, $0e, 0 | OBP_NUM

.OAMData_SlotsGolem:
	db 6
	dbsprite -2, -2,  4,  4, $00, 0 | OBP_NUM
	dbsprite -1, -2,  4,  4, $02, 0 | OBP_NUM
	dbsprite  0, -2,  4,  4, $00, 0 | OBP_NUM | X_FLIP
	dbsprite -2,  0,  4,  4, $04, 0 | OBP_NUM
	dbsprite -1,  0,  4,  4, $06, 0 | OBP_NUM
	dbsprite  0,  0,  4,  4, $04, 0 | OBP_NUM | X_FLIP

.OAMData_SlotsChansey1:
	db 6
	dbsprite -2, -2,  4,  4, $00, 0 | OBP_NUM
	dbsprite -1, -2,  4,  4, $02, 0 | OBP_NUM
	dbsprite  0, -2,  4,  4, $04, 0 | OBP_NUM
	dbsprite -2,  0,  4,  4, $06, 0 | OBP_NUM
	dbsprite -1,  0,  4,  4, $08, 0 | OBP_NUM
	dbsprite  0,  0,  4,  4, $0a, 0 | OBP_NUM

.OAMData_SlotsChansey2:
	db 6
	dbsprite -2, -2,  4,  4, $00, 0 | OBP_NUM
	dbsprite -1, -2,  4,  4, $02, 0 | OBP_NUM
	dbsprite  0, -2,  4,  4, $04, 0 | OBP_NUM
	dbsprite -2,  0,  4,  4, $0c, 0 | OBP_NUM
	dbsprite -1,  0,  4,  4, $0e, 0 | OBP_NUM
	dbsprite  0,  0,  4,  4, $10, 0 | OBP_NUM

.OAMData_SlotsChansey3:
	db 6
	dbsprite -2, -2,  4,  4, $00, 0 | OBP_NUM
	dbsprite -1, -2,  4,  4, $02, 0 | OBP_NUM
	dbsprite  0, -2,  4,  4, $04, 0 | OBP_NUM
	dbsprite -2,  0,  4,  4, $12, 0 | OBP_NUM
	dbsprite -1,  0,  4,  4, $14, 0 | OBP_NUM
	dbsprite  0,  0,  4,  4, $16, 0 | OBP_NUM

.OAMData_SlotsChansey4:
	db 6
	dbsprite -2, -2,  4,  4, $00, 0 | OBP_NUM
	dbsprite -1, -2,  4,  4, $02, 0 | OBP_NUM
	dbsprite  0, -2,  4,  4, $04, 0 | OBP_NUM
	dbsprite -2,  0,  4,  4, $18, 0 | OBP_NUM
	dbsprite -1,  0,  4,  4, $1a, 0 | OBP_NUM
	dbsprite  0,  0,  4,  4, $1c, 0 | OBP_NUM

.OAMData_SlotsChansey5:
	db 6
	dbsprite -2, -2,  4,  4, $1e, 0 | OBP_NUM
	dbsprite -1, -2,  4,  4, $20, 0 | OBP_NUM
	dbsprite  0, -2,  4,  4, $22, 0 | OBP_NUM
	dbsprite -2,  0,  4,  4, $24, 0 | OBP_NUM
	dbsprite -1,  0,  4,  4, $26, 0 | OBP_NUM
	dbsprite  0,  0,  4,  4, $28, 0 | OBP_NUM

.OAMData_RadioFrequencyMeter:
	db 4
	dbsprite -1, -2,  4,  0, $00, 0 | OBP_NUM
	dbsprite -1, -1,  4,  0, $00, 0 | OBP_NUM
	dbsprite -1,  0,  4,  0, $00, 0 | OBP_NUM
	dbsprite -1,  1,  4,  0, $00, 0 | OBP_NUM
