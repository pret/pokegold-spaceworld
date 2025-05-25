; SFX indexes (see audio/sfx_pointers.asm)
; Asterisk (*) means the sound effect is an unused leftover from Generation I.
	const_def
	const SFX_BALL_WOBBLE           ; 00
	const SFX_POTION                ; 01
	const SFX_FULL_HEAL             ; 02
	const SFX_MENU                  ; 03
	const SFX_READ_TEXT             ; 04
	const SFX_READ_TEXT_2           ; 05
	const SFX_POISON                ; 06
	const SFX_TRADE_MACHINE         ; 07*
	const SFX_BOOT_PC               ; 08*
	const SFX_SHUT_DOWN_PC          ; 09*
	const SFX_CHOOSE_PC_OPTION      ; 0a, used when booting PC
	const SFX_ESCAPE_ROPE           ; 0b, player shrink
	const SFX_PRESS_SWITCH          ; 0c*
	const SFX_HEALING_MACHINE       ; 0d*
	const SFX_WARP_TO               ; 0e, SFX_TELEPORT_EXIT_1 in pokered
	const SFX_TELEPORT_ENTER_1      ; 0f*
	const SFX_TELEPORT_EXIT_2       ; 10*
	const SFX_JUMP_OVER_LEDGE       ; 11*
	const SFX_TELEPORT_ENTER_2      ; 12*
	const SFX_FLY                   ; 13*
	const SFX_WRONG                 ; 14
	const SFX_ARROW_TILES           ; 15*
	const SFX_STRENGTH              ; 16
	const SFX_MEGAPHONE             ; 17, SFX_SS_ANNE_HORN in pokered
	const SFX_WITHDRAW_DEPOSIT      ; 18*
	const SFX_CUT_RG                ; 19*
	const SFX_GO_INSIDE             ; 1a*
	const SFX_SWITCH_POKEMON        ; 1b
	const SFX_BELLY_DRUM            ; 1c, SFX_59 in pokered
	const SFX_PURCHASE              ; 1d*
	const SFX_COLLISION             ; 1e, only used in debug
	const SFX_GO_OUTSIDE            ; 1f*
	const SFX_SAVE                  ; 20
	const SFX_POKEFLUTE             ; 21
	const SFX_SAFARI_ZONE_PA        ; 22*        
	const SFX_THROW_BALL            ; 23*
	const SFX_BALL_POOF             ; 24*
	const SFX_FAINT                 ; 25
	const SFX_RUN                   ; 26
	const SFX_POKEDEX_REGISTRATION  ; 27
	const SFX_INTRO_LUNGE_RG        ; 28*
	const SFX_UNKNOWN_29            ; 29*, doesn't match pokered
	const SFX_UNKNOWN_2A            ; 2a*, doesn't match pokered
	const SFX_INTRO_RAISE_RG        ; 2b*
	const SFX_INTRO_CRASH_RG        ; 2c*
	const SFX_TITLE_ENTRANCE        ; 2d, SFX_INTRO_WHOOSH in pokered
	const SFX_SLOTS_STOP_WHEEL      ; 2e*
	const SFX_SLOTS_REWARD          ; 2f*
	const SFX_PAY_DAY               ; 30, SFX_SLOTS_NEW_SPIN in pokered
	const SFX_GAME_FREAK_LOGO_RG    ; 31
	const SFX_PECK                  ; 32
	const SFX_KINESIS               ; 33
	const SFX_LICK                  ; 34
	const SFX_POUND                 ; 35
	const SFX_THRASH                ; 36, SFX_MOVE_PUZZLE_PIECE in pokegold
	const SFX_COMET_PUNCH           ; 37
	const SFX_MEGA_PUNCH            ; 38
	const SFX_SCRATCH               ; 39
	const SFX_VICEGRIP              ; 3a
	const SFX_RAZOR_WIND            ; 3b
	const SFX_CUT                   ; 3c
	const SFX_WING_ATTACK           ; 3d
	const SFX_WHIRLWIND             ; 3e
	const SFX_BIND                  ; 3f
	const SFX_VINE_WHIP             ; 40
	const SFX_DOUBLE_KICK           ; 41
	const SFX_MEGA_KICK             ; 42
	const SFX_HEADBUTT              ; 43
	const SFX_HORN_ATTACK           ; 44
	const SFX_TACKLE                ; 45
	const SFX_POISON_STING          ; 46
	const SFX_POWDER                ; 47
	const SFX_DOUBLESLAP            ; 48
	const SFX_BITE                  ; 49
	const SFX_JUMP_KICK             ; 4a
	const SFX_STOMP                 ; 4b
	const SFX_TAIL_WHIP             ; 4c
	const SFX_KARATE_CHOP           ; 4d
	const SFX_SUBMISSION            ; 4e
	const SFX_WATER_GUN             ; 4f
	const SFX_SWORDS_DANCE          ; 50
	const SFX_THUNDER               ; 51
	const SFX_SUPERSONIC            ; 52
	const SFX_LEER                  ; 53
	const SFX_EMBER                 ; 54
	const SFX_BUBBLEBEAM            ; 55
	const SFX_HYDRO_PUMP            ; 56
	const SFX_SURF                  ; 57
	const SFX_PSYBEAM               ; 58
	const SFX_CHARGE                ; 59
	const SFX_THUNDERSHOCK          ; 5a
	const SFX_PSYCHIC               ; 5b
	const SFX_SCREECH               ; 5c
	const SFX_BONE_CLUB             ; 5d
	const SFX_SHARPEN               ; 5e
	const SFX_EGG_BOMB              ; 5f
	const SFX_SING                  ; 60
	const SFX_HYPER_BEAM            ; 61
	const SFX_SHINE                 ; 62

; R/G/B/Y fanfares
	const SFX_GET_ITEM_RG           ; 63
	const SFX_UNUSED_FANFARE_1      ; 64
	const SFX_POKEDEX_EVALUATION_RG ; 65
	const SFX_LEVEL_UP_RG           ; 66
	const SFX_EVOLUTION_COMPLETE_RG ; 67
	const SFX_GET_KEY_ITEM_RG       ; 68
	const SFX_UNUSED_FANFARE_2      ; 69*
	const SFX_CAUGHT_POKEMON_RG     ; 6a*
	const SFX_UNUSED_FANFARE_3      ; 6b*
