	rsreset
DEF OBJECT_SPRITE           rb ; 00
DEF OBJECT_MAP_OBJECT_INDEX rb ; 01
DEF OBJECT_SPRITE_TILE      rb ; 02
DEF OBJECT_MOVEMENT_TYPE    rb ; 03
DEF OBJECT_FLAGS1           rb ; 04
DEF OBJECT_FLAGS2           rb ; 05
DEF OBJECT_WALKING          rb ; 06
DEF OBJECT_DIRECTION        rb ; 07
DEF OBJECT_STEP_TYPE        rb ; 08
DEF OBJECT_STEP_DURATION    rb ; 09
DEF OBJECT_ACTION           rb ; 0a
DEF OBJECT_STEP_FRAME       rb ; 0b
DEF OBJECT_0C               rb ; 0c
DEF OBJECT_FACING           rb ; 0d
DEF OBJECT_TILE_COLLISION   rb ; 0e
DEF OBJECT_LAST_TILE        rb ; 0f
DEF OBJECT_MAP_X            rb ; 10
DEF OBJECT_MAP_Y            rb ; 11
DEF OBJECT_LAST_MAP_X       rb ; 12
DEF OBJECT_LAST_MAP_Y       rb ; 13
DEF OBJECT_INIT_X           rb ; 14
DEF OBJECT_INIT_Y           rb ; 15
DEF OBJECT_RADIUS_X         rb ; 16
DEF OBJECT_RADIUS_Y         rb ; 17
DEF OBJECT_SPRITE_X         rb ; 18
DEF OBJECT_SPRITE_Y         rb ; 19
DEF OBJECT_SPRITE_X_OFFSET  rb ; 1a
DEF OBJECT_SPRITE_Y_OFFSET  rb ; 1b
DEF OBJECT_MOVEMENT_INDEX   rb ; 1c
DEF OBJECT_JUMPTABLE_INDEX  rb ; 1d
DEF OBJECT_1E               rb ; 1e
DEF OBJECT_JUMP_HEIGHT      rb ; 1f
DEF OBJECT_RANGE            rb ; 20
DEF OBJECT_SIGHT_RANGE      rb ; 21
                            rb_skip 6
DEF OBJECT_LENGTH EQU _RS
DEF NUM_OBJECT_STRUCTS EQU 10
DEF UNKNOWN_STRUCT  EQU 0
DEF PLAYER_STRUCT   EQU 1
DEF FOLLOWER_STRUCT EQU 2

; object_struct OBJECT_DIRECTION values
DEF OW_DOWN  EQU DOWN  << 2
DEF OW_UP    EQU UP    << 2
DEF OW_LEFT  EQU LEFT  << 2
DEF OW_RIGHT EQU RIGHT << 2

; object_struct OBJECT_FLAGS1 bit flags
	const_def
	shift_const INVISIBLE       ; 0
	shift_const WONT_DELETE     ; 1
	shift_const FIXED_FACING    ; 2
	shift_const SLIDING         ; 3
	shift_const COLLISION_TILES ; 4
	shift_const NOCLIP_NOT_SET  ; 5
	shift_const COLLISION_OBJS  ; 6
	shift_const CENTERED_OBJECT ; 7

; object_struct OBJECT_FLAGS2 bit flags
	const_def
	shift_const LOW_PRIORITY   ; 0
	shift_const HIGH_PRIORITY  ; 1
	shift_const BOULDER_MOVING ; 2
	shift_const OVERHEAD       ; 3
	shift_const USE_OBP1       ; 4
	shift_const FROZEN         ; 5
	shift_const OFF_SCREEN     ; 6
	shift_const OBJ_FLAGS2_7   ; 7

; facing attribute bit flags
	const_def
	shift_const FACING_DONE        ; 0
	shift_const RELATIVE_ATTRIBUTES ; 1

; Minor object struct
	rsreset
DEF MINOR_OBJECT_PARENT_OBJECT   rb ; 00
DEF MINOR_OBJECT_TYPE            rb ; 01
DEF MINOR_OBJECT_ANIM            rb ; 02
DEF MINOR_OBJECT_SPRITE_TILE     rb ; 03
DEF MINOR_OBJECT_X_POS           rb ; 04
DEF MINOR_OBJECT_Y_POS           rb ; 05
DEF MINOR_OBJECT_X_OFFSET        rb ; 06
DEF MINOR_OBJECT_Y_OFFSET        rb ; 07
DEF MINOR_OBJECT_08              rb ; 08
DEF MINOR_OBJECT_ANIM_TIMER      rb ; 09
DEF MINOR_OBJECT_JUMPTABLE_INDEX rb ; 0a
DEF MINOR_OBJECT_TIMER           rb ; 0b
DEF MINOR_OBJECT_FRAME           rb ; 0c
DEF MINOR_OBJECT_VAR1            rb ; 0d
DEF MINOR_OBJECT_VAR2            rb ; 0e
DEF MINOR_OBJECT_VAR3            rb ; 0f
DEF MINOR_OBJECT_LENGTH EQU _RS
DEF NUM_MINOR_OBJECTS EQU 4

; MinorObject types
	const_def
	const MINOR_OBJECT_TYPE_NULL         ; 0
	const MINOR_OBJECT_TYPE_SHADOW       ; 1
	const MINOR_OBJECT_TYPE_EMOTE        ; 2
	const MINOR_OBJECT_TYPE_03           ; 3
	const MINOR_OBJECT_TYPE_04           ; 4
	const MINOR_OBJECT_TYPE_BOULDER_DUST ; 5
DEF NUM_MINOR_OBJECT_TYPES EQU const_value

; MinorObject animations
	const_def
	const MINOR_OBJECT_ANIM_NULL         ; 0
	const MINOR_OBJECT_ANIM_SHADOW       ; 1
	const MINOR_OBJECT_ANIM_EMOTE        ; 2
	const MINOR_OBJECT_ANIM_03           ; 3
	const MINOR_OBJECT_ANIM_BOULDER_DUST ; 4
DEF NUM_MINOR_OBJECT_ANIMATIONS EQU const_value

; MinorObjectSpriteTiles indexes
	const_def
	const MINOR_OBJECT_SPRITE_NULL           ; 0
	const MINOR_OBJECT_SPRITE_EMOTE          ; 1
	const MINOR_OBJECT_SPRITE_SHADOW         ; 2
	const MINOR_OBJECT_SPRITE_BOULDER_DUST_1 ; 3
	const MINOR_OBJECT_SPRITE_BOULDER_DUST_2 ; 4
DEF NUM_MINOR_OBJECT_SPRITES EQU const_value

; MinorObjectGFX indexes (see _LoadMinorObjectGFX)
	const_def
	const MINOR_OBJECT_GFX_NULL                 ; 0
	const MINOR_OBJECT_GFX_SHADOW               ; 1
	const MINOR_OBJECT_GFX_UNKNOWN_BOUNCING_ORB ; 2
	const MINOR_OBJECT_GFX_SHOCK_EMOTE          ; 3
	const MINOR_OBJECT_GFX_QUESTION_EMOTE       ; 4
	const MINOR_OBJECT_GFX_HAPPY_EMOTE          ; 5
	const MINOR_OBJECT_GFX_BOULDER_DUST         ; 6
	const MINOR_OBJECT_GFX_GRAMPS_STAND_1       ; 7
	const MINOR_OBJECT_GFX_GRAMPS_STAND_2       ; 8
	const MINOR_OBJECT_GFX_GRAMPS_WALK_1        ; 9
	const MINOR_OBJECT_GFX_GRAMPS_WALK_2        ; a
	const MINOR_OBJECT_GFX_CLEFAIRY_STAND_1     ; b
	const MINOR_OBJECT_GFX_CLEFAIRY_STAND_2     ; c
	const MINOR_OBJECT_GFX_CLEFAIRY_WALK_1      ; d
	const MINOR_OBJECT_GFX_CLEFAIRY_WALK_2      ; e
DEF NUM_MINOR_OBJECT_GFX_ENTRIES EQU const_value


	rsreset
DEF MAPOBJECT_OBJECT_STRUCT_ID rb ; 0
DEF MAPOBJECT_SPRITE           rb ; 1
DEF MAPOBJECT_Y_COORD          rb ; 2
DEF MAPOBJECT_X_COORD          rb ; 3
DEF MAPOBJECT_MOVEMENT         rb ; 4
DEF MAPOBJECT_RADIUS           rb ; 5
DEF MAPOBJECT_HOUR             rb ; 6
DEF MAPOBJECT_TIMEOFDAY        rb ; 7
DEF MAPOBJECT_TYPE             rb ; 8, set to anything but 0 to skip trainer checks
							   rb_skip 2
DEF MAPOBJECT_SIGHT_RANGE      rb ; b
                               rb_skip 4
DEF MAPOBJECT_LENGTH EQU _RS
DEF NUM_OBJECTS EQU 16
DEF PLAYER_OBJECT EQU 0

DEF MAPOBJECT_SCREEN_WIDTH  EQU (SCREEN_WIDTH / 2) + 2
DEF MAPOBJECT_SCREEN_HEIGHT EQU (SCREEN_HEIGHT / 2) + 2

; StepFunction_FromMovement.Pointers indexes (see engine/overworld/map_objects.asm)
	const_def
	const SPRITEMOVEFN_00                    ; 00
	const SPRITEMOVEFN_RANDOM_WALK_XY        ; 01
	const SPRITEMOVEFN_RANDOM_SPIN           ; 02
	const SPRITEMOVEFN_RANDOM_WALK_Y         ; 03
	const SPRITEMOVEFN_RANDOM_WALK_X         ; 04
	const SPRITEMOVEFN_TURN_DOWN             ; 05
	const SPRITEMOVEFN_TURN_UP               ; 06
	const SPRITEMOVEFN_TURN_LEFT             ; 07
	const SPRITEMOVEFN_TURN_RIGHT            ; 08
	const_skip 7                             ; 09-0f
	const SPRITEMOVEFN_OBEY_DPAD             ; 10
	const SPRITEMOVEFN_INDEXED_1             ; 11
	const SPRITEMOVEFN_INDEXED_2             ; 12
	const SPRITEMOVEFN_FOLLOW_1              ; 13
	const SPRITEMOVEFN_14                    ; 14
	const SPRITEMOVEFN_15                    ; 15
	const SPRITEMOVEFN_16                    ; 16
	const SPRITEMOVEFN_17                    ; 17, used by debug cursor
	const SPRITEMOVEFN_FOLLOW_2              ; 18
	const SPRITEMOVEFN_SCRIPTED              ; 19
	const SPRITEMOVEFN_1A                    ; 1a
DEF NUM_SPRITEMOVEFN EQU const_value

; StepTypesJumptable indexes (see engine/overworld/map_objects.asm)
	const_def
	const STEP_TYPE_RESET            ; 00
	const STEP_TYPE_FROM_MOVEMENT    ; 01
	const STEP_TYPE_NPC_WALK         ; 02
	const STEP_TYPE_SLEEP            ; 03
	const STEP_TYPE_STANDING         ; 04
	const STEP_TYPE_PLAYER_WALK      ; 05
	const STEP_TYPE_CONTINUE_WALK    ; 06
	const STEP_TYPE_OBEY_DPAD        ; 07
	const STEP_TYPE_INDEXED_1        ; 08
	const STEP_TYPE_INDEXED_2        ; 09
	const STEP_TYPE_FOLLOW           ; 0a
	const_skip 4                     ; 0b-0e
	const STEP_TYPE_NPC_JUMP         ; 0f
	const STEP_TYPE_PLAYER_JUMP      ; 10
	const STEP_TYPE_TELEPORT_FROM    ; 11
	const STEP_TYPE_TELEPORT_TO      ; 12
	const STEP_TYPE_13               ; 13
DEF NUM_STEP_TYPES EQU const_value

	rsreset
DEF MAPOBJECTTEMPLATE_SPRITE           rb 1 ; 0
DEF MAPOBJECTTEMPLATE_Y_COORD          rb 1 ; 1
DEF MAPOBJECTTEMPLATE_X_COORD          rb 1 ; 2
DEF MAPOBJECTTEMPLATE_MOVEMENT         rb 1 ; 3
DEF MAPOBJECTTEMPLATE_RADIUS           rb 1 ; 4
DEF MAPOBJECTTEMPLATE_HOUR             rb 1 ; 5
DEF MAPOBJECTTEMPLATE_TIMEOFDAY        rb 1 ; 6
DEF MAPOBJECTTEMPLATE_COLOR            rb 1 ; 7
DEF MAPOBJECTTEMPLATE_RANGE            rb 1 ; 8
DEF MAPOBJECTTEMPLATE_SCRIPT_POINTER   rb 1 ; 9
DEF MAPOBJECTTEMPLATE_POINTER_HI       rb 1 ; a
DEF MAPOBJECTTEMPLATE_EVENT_FLAG       rw 1 ; b
DEF MAP_OBJECT_TEMPLATE_LENGTH EQU _RS

DEF SPRITE_GFX_LIST_CAPACITY EQU 12 ; see wUsedSprites

DEF PLAYER_OBJECT_INDEX    EQU 1
DEF FOLLOWER_OBJECT_INDEX  EQU 2

; ObjectActionPairPointers indexes (see engine/overworld/map_object_action.asm)
	const_def
	const OBJECT_ACTION_00            ; 00
	const OBJECT_ACTION_STEP          ; 01
	const OBJECT_ACTION_STAND         ; 02
	const OBJECT_ACTION_SPIN          ; 03
DEF NUM_OBJECT_ACTIONS EQU const_value


; DoPlayerMovement.DoStep arguments (see engine/overworld/player_movement.asm)
	const_def
	const STEP_SLOW          ; 0
	const STEP_WALK          ; 1
	const STEP_BIKE          ; 2
	const STEP_FASTEST       ; 3
	const STEP_ICE           ; 4
	const STEP_TURN          ; 5
	const STEP_BACK_LEDGE    ; 6
	const STEP_WALK_IN_PLACE ; 7
DEF NUM_STEPS EQU const_value
