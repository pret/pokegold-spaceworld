; wOptions
DEF TEXT_DELAY_MASK EQU %111
	const_def 3
	shift_const SGB_BORDER     ; 3
	shift_const NO_TEXT_SCROLL ; 4
	shift_const STEREO         ; 5
	shift_const BATTLE_SHIFT   ; 6
	shift_const BATTLE_SCENE   ; 7

DEF TEXT_DELAY_FAST EQU %001 ; 1
DEF TEXT_DELAY_MED  EQU %011 ; 3
DEF TEXT_DELAY_SLOW EQU %101 ; 5

DEF START_MONEY EQU 3000

; wStateFlags
DEF SPRITE_UPDATES_DISABLED_F EQU 0
DEF SCRIPTED_MOVEMENT_STATE_F EQU 7

; wSpriteFlags::
DEF SPRITES_SKIP_WALKING_GFX_F  EQU 6
DEF SPRITES_SKIP_STANDING_GFX_F EQU 7

; wPokemonWithdrawDepositParameter::
DEF PC_WITHDRAW        EQU 0
DEF PC_DEPOSIT         EQU 1
DEF REMOVE_PARTY       EQU 0
DEF REMOVE_BOX         EQU 1
DEF BUFFERMON_WITHDRAW EQU 2
DEF BUFFERMON_DEPOSIT  EQU 3
DEF GET_BUFFER_MON     EQU 0
DEF GET_BREED_MON      EQU 1

; wBreederStatus::
DEF BREEDER_ONE_BREEDMON EQU 1
DEF BREEDER_TWO_BREEDMON EQU 2
DEF BREEDER_EGG_READY    EQU 3
DEF BREEDER_GAVE_EGG     EQU 4

; wPlayerStepFlags::
	const_def 4
	const PLAYERSTEP_MIDAIR_F   ; 4
	const PLAYERSTEP_CONTINUE_F ; 5
	const PLAYERSTEP_STOP_F     ; 6
	const PLAYERSTEP_START_F    ; 7

; wTextboxFrame::
	const_def
	const FRAME_1 ; 0
	const FRAME_2 ; 1
	const FRAME_3 ; 2
	const FRAME_4 ; 3
	const FRAME_5 ; 4
	const FRAME_6 ; 5
	const FRAME_7 ; 6
	const FRAME_8 ; 7
DEF NUM_FRAMES EQU const_value

; wTextboxFlags::
	const_def
	const FAST_TEXT_DELAY_F ; 0
	const TEXT_DELAY_F      ; 1

; wMonType::
	const_def
	const PARTYMON   ; 0
	const OTPARTYMON ; 1
	const BOXMON     ; 2
	const TEMPMON    ; 3
	const WILDMON    ; 4

; wWalkingDirection::
	const_def -1
	const STANDING ; -1
	const DOWN     ; 0
	const UP       ; 1
	const LEFT     ; 2
	const RIGHT    ; 3
DEF NUM_DIRECTIONS EQU const_value

DEF DOWN_MASK  EQU 1 << DOWN
DEF UP_MASK    EQU 1 << UP
DEF LEFT_MASK  EQU 1 << LEFT
DEF RIGHT_MASK EQU 1 << RIGHT

; wJohtoBadges:: ; d163
	const_def
	const BADGE_0
	const BADGE_1
	const BADGE_2
	const BADGE_3
	const BADGE_4
	const BADGE_5
	const BADGE_6
	const BADGE_7
DEF NUM_JOHTO_BADGES EQU const_value

; wKantoBadges:: ; d164
	const_def
	const BOULDERBADGE
	const CASCADEBADGE
	const THUNDERBADGE
	const RAINBOWBADGE
	const SOULBADGE
	const MARSHBADGE
	const VOLCANOBADGE
	const EARTHBADGE
DEF NUM_KANTO_BADGES EQU const_value
DEF NUM_BADGES EQU NUM_JOHTO_BADGES + NUM_KANTO_BADGES

; wPlayerState::
DEF PLAYER_NORMAL    EQU 0
DEF PLAYER_BIKE      EQU 1
DEF PLAYER_SKATE     EQU 2
DEF PLAYER_SURF      EQU 4
DEF PLAYER_SURF_PIKA EQU 8

; wDebugFlags::
	const_def
	const DEBUG_BATTLE_F
	const DEBUG_FIELD_F
	const CONTINUED_F

; wJumptableIndex::
DEF JUMPTABLE_INDEX_MASK EQU %01111111
	const_def 7
	shift_const JUMPTABLE_EXIT

; wCurDexMode::
	const_def
	const DEXMODE_NUMBERED
	const DEXMODE_ABC

; wToolgearFlags::
DEF SHOW_TOOLGEAR_F      EQU 0
DEF TOOLGEAR_TO_WINDOW_F EQU 2
DEF HIDE_TOOLGEAR_F      EQU 7

; wd153::
DEF TOOLGEAR_COORDS_F       EQU 0
DEF OVERWORLD_MINUTE_TIME_F EQU 7

; wTimeOfDayPalFlags::
DEF CLEAR_PALSET_F EQU 7

; wBattleAnimFlags::
const_def
const BATTLEANIM_STOP_F          ; 0
const BATTLEANIM_IN_SUBROUTINE_F ; 1
const BATTLEANIM_IN_LOOP_F       ; 2
const BATTLEANIM_KEEPSPRITES_F   ; 3
