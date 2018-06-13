	rsreset
OBJECT_SPRITE              rb 1 ; 00
OBJECT_MAP_OBJECT_INDEX    rb 1 ; 01
OBJECT_SPRITE_TILE         rb 1 ; 02
OBJECT_MOVEMENTTYPE        rb 1 ; 03
OBJECT_FLAGS               rw 1 ; 04
OBJECT_PALETTE             rb 1 ; 06
OBJECT_DIRECTION_WALKING   rb 1 ; 07
OBJECT_FACING              rb 1 ; 08
OBJECT_STEP_TYPE           rb 1 ; 09
OBJECT_STEP_DURATION       rb 1 ; 0a
OBJECT_ACTION              rb 1 ; 0b
OBJECT_STEP_FRAME          rb 1 ; 0c
OBJECT_FACING_STEP         rb 1 ; 0d
OBJECT_NEXT_TILE           rb 1 ; 0e
OBJECT_STANDING_TILE       rb 1 ; 0f
OBJECT_NEXT_MAP_X          rb 1 ; 10
OBJECT_NEXT_MAP_Y          rb 1 ; 11
OBJECT_MAP_X               rb 1 ; 12
OBJECT_MAP_Y               rb 1 ; 13
OBJECT_INIT_X              rb 1 ; 14
OBJECT_INIT_Y              rb 1 ; 15
OBJECT_RADIUS              rb 1 ; 16
OBJECT_SPRITE_X            rb 1 ; 17
OBJECT_SPRITE_Y            rb 1 ; 18
OBJECT_SPRITE_X_OFFSET     rb 1 ; 19
OBJECT_SPRITE_Y_OFFSET     rb 1 ; 1a
OBJECT_MOVEMENT_BYTE_INDEX rb 1 ; 1b
OBJECT_1C                  rb 1 ; 1c
OBJECT_1D                  rb 1 ; 1d
OBJECT_1E                  rb 1 ; 1e
OBJECT_1F                  rb 1 ; 1f
OBJECT_RANGE               rb 1 ; 20
OBJECT_DATA                rb 7 ; 21
OBJECT_LENGTH SET _RS

	rsreset
CMDQUEUE_UNK0 rb 16
CMDQUEUE_ENTRY_SIZE SET _RS

	rsreset
MAPOBJECT_OBJECT_STRUCT_ID rb 1 ; 0
MAPOBJECT_SPRITE           rb 1 ; 1
MAPOBJECT_Y_COORD          rb 1 ; 2
MAPOBJECT_X_COORD          rb 1 ; 3
MAPOBJECT_MOVEMENT         rb 1 ; 4
MAPOBJECT_RADIUS           rb 1 ; 5
MAPOBJECT_HOUR             rb 1 ; 6
MAPOBJECT_TIMEOFDAY        rb 1 ; 7
MAPOBJECT_COLOR            rb 1 ; 8
MAPOBJECT_RANGE            rb 1 ; 9
MAPOBJECT_SCRIPT_POINTER   rw 1 ; a
MAPOBJECT_EVENT_FLAG       rw 1
MAPOBJECT_E                rb 1 ; unused
MAPOBJECT_F                rb 1 ; unused
MAP_OBJECT_LENGTH SET _RS

	rsreset
MAPOBJECTTEMPLATE_SPRITE           rb 1 ; 0
MAPOBJECTTEMPLATE_Y_COORD          rb 1 ; 1
MAPOBJECTTEMPLATE_X_COORD          rb 1 ; 2
MAPOBJECTTEMPLATE_MOVEMENT         rb 1 ; 3
MAPOBJECTTEMPLATE_RADIUS           rb 1 ; 4
MAPOBJECTTEMPLATE_HOUR             rb 1 ; 5
MAPOBJECTTEMPLATE_TIMEOFDAY        rb 1 ; 6
MAPOBJECTTEMPLATE_COLOR            rb 1 ; 7
MAPOBJECTTEMPLATE_RANGE            rb 1 ; 8
MAPOBJECTTEMPLATE_SCRIPT_POINTER   rw 1 ; 9
MAPOBJECTTEMPLATE_EVENT_FLAG       rw 1 ; b
MAP_OBJECT_TEMPLATE_LENGTH SET _RS
