; collision IDs are built like this:
; 76543210
; \__/|\_/
;   | | \-- SubType
;   | \---- Flag
;   \------ Type
;
; What exactly flag means or if it
; means anything is up to Type,
; FF is a unique exception.
; Old Types:
; 0 - Regular            8 - Cuttable
; 1 - ???                9 - unused
; 2 - Water              A - unused
; 3 - ???                B - unused
; 4 - Water 2            C - unused
; 5 - Pits               D - unused
; 6 - Warps              E - unused
; 7 - Special Talk Act   F - unused
; New Types:
; 0 - Regular            8 - Minigame Talk Action
; 1 - Cuttable           9 - Special Talk Action
; 2 - Water              A - Jump Action
; 3 - Water 2            B - unused
; 4 - Land               C - unused
; 5 - Land 2             D - unused
; 6 - Pits               E - unused
; 7 - Warps              F - unused

MACRO tilecoll
; used in data/tilesets/*_collision.inc
	db COLL_\1, COLL_\2, COLL_\3, COLL_\4
ENDM

DEF COLLMASK_TYPE          EQU $f0
DEF COLLMASK_SUBTYPE       EQU $07 ; LO_NYBBLE_GRASS in final
DEF COLLMASK_WATER_SUBTYPE EQU $03

DEF COLLFLAG_ENCOUNTER EQU $08 ; enables encounters or special actions depending on the type.

; old collision data type nybbles for "COLLMASK_TYPE"
DEF COLLMASK_TYPE_OLD_WATER      EQU $20 ; matches COLLMASK_TYPE_WATER
DEF COLLMASK_TYPE_OLD_WATER_ALT  EQU $40
DEF COLLMASK_TYPE_OLD_PITS       EQU $50
DEF COLLMASK_TYPE_OLD_WARPS      EQU $60
DEF COLLMASK_TYPE_OLD_SPECIAL    EQU $70
DEF COLLMASK_TYPE_OLD_TALL_GRASS EQU $80

; collision data type nybbles for "COLLMASK_TYPE"
DEF COLLMASK_TYPE_TALL_GRASS EQU $10
DEF COLLMASK_TYPE_WATER      EQU $20
DEF COLLMASK_TYPE_WATER_ALT  EQU $30 ; HI_NYBBLE_CURRENT in final
DEF COLLMASK_TYPE_WALK       EQU $40
DEF COLLMASK_TYPE_WALK_ALT   EQU $50
DEF COLLMASK_TYPE_PITS       EQU $60
DEF COLLMASK_TYPE_WARPS      EQU $70
DEF COLLMASK_TYPE_MINIGAME   EQU $80
DEF COLLMASK_TYPE_SPECIAL    EQU $90
DEF COLLMASK_TYPE_LEDGES     EQU $a0

; old collision constants

DEF COLL_OLD_FLOOR         EQU $00 ; matches COLL_FLOOR
DEF COLL_OLD_WALL          EQU $01
DEF COLL_OLD_FLOOR_INSIDE  EQU $03
DEF COLL_OLD_WALL_INSIDE   EQU $04

; $10 (old)
DEF COLL_OLD_LEDGE EQU $11
DEF COLL_OLD_STEPS EQU $13

; water collisions (old)
DEF COLL_OLD_WATER     EQU $21 ; matches COLL_WATER
DEF COLL_OLD_WATER_ENCOUNTER EQU $24

; water collisions (hm) (old)
DEF COLL_OLD_WATERFALL EQU $40 ; HM07
DEF COLL_OLD_MUDPIT    EQU $41 ; NEWTYPE
DEF COLL_OLD_42        EQU $42 ; only referenced in encounter tiles
DEF COLL_OLD_43        EQU $43 ; only referenced in encounter tiles
DEF COLL_OLD_WHIRLPOOL EQU $44 ; HM06

; falling warp collisions (old)
DEF COLL_OLD_PIT       EQU $50
DEF COLL_OLD_PIT_SKATE EQU $51
DEF COLL_OLD_PIT_CAVE  EQU $57

; warp collisions (old)
DEF COLL_OLD_CARPET EQU $60
DEF COLL_OLD_DOOR   EQU $61
DEF COLL_OLD_LADDER EQU $62

; special collisions (old)
DEF COLL_OLD_SIGNPOST  EQU $70
DEF COLL_OLD_SHOP_SIGN EQU $71
DEF COLL_OLD_MART_ITEM EQU $72
DEF COLL_OLD_COUNTER   EQU $73

; cuttable tiles (old)
DEF COLL_OLD_CUT_TREE EQU $80
DEF COLL_OLD_GRASS_81 EQU $81
DEF COLL_OLD_GRASS_82 EQU $82
DEF COLL_OLD_GRASS    EQU $83

; junk data constants
DEF COLL_JUNK_02 EQU $02
DEF COLL_JUNK_03 EQU $03
DEF COLL_JUNK_12 EQU $12
DEF COLL_JUNK_13 EQU $13
DEF COLL_JUNK_22 EQU $22
DEF COLL_JUNK_23 EQU $23
DEF COLL_JUNK_36 EQU $36
DEF COLL_JUNK_50 EQU $50
DEF COLL_JUNK_51 EQU $51
DEF COLL_JUNK_56 EQU $56
DEF COLL_JUNK_57 EQU $57
DEF COLL_JUNK_60 EQU $60
DEF COLL_JUNK_61 EQU $61
DEF COLL_JUNK_62 EQU $62
DEF COLL_JUNK_63 EQU $63
DEF COLL_JUNK_64 EQU $64
DEF COLL_JUNK_65 EQU $65
DEF COLL_JUNK_66 EQU $66
DEF COLL_JUNK_67 EQU $67
DEF COLL_JUNK_A0 EQU $A0
DEF COLL_JUNK_A1 EQU $A1

; new collision constants

DEF COLL_FLOOR     EQU $00
DEF COLL_OOB       EQU $05 ; first block in TILESET_SILENT_HILL and TILESET_ROCKET_HOUSE
DEF COLL_WALL      EQU $07

; cuttable collisions
DEF COLL_GRASS     EQU $10
DEF COLL_CUT_TREE  EQU $12

; water collisions
DEF COLL_WATER_20    EQU $20
DEF COLL_WATER       EQU $21
DEF COLL_WATERFALL   EQU $22
DEF COLL_WATER_SOLID EQU $27

; water collisions 2
DEF COLL_WATER2_E EQU $30
DEF COLL_WATER2_W EQU $31
DEF COLL_WATER2_N EQU $32
DEF COLL_WATER2_S EQU $33
; $34..$37 will behave like COLL_WATER2_E..COLL_WATER2_S

; land collisions
DEF COLL_LAND_SLOW EQU $40
DEF COLL_LAND_E    EQU $41
DEF COLL_LAND_W    EQU $42
DEF COLL_LAND_N    EQU $43
DEF COLL_LAND_S    EQU $44
; $45..$47 will behave like COLL_LAND_E

; land collisions 2
DEF COLL_LAND2_E EQU $50
DEF COLL_LAND2_W EQU $51
DEF COLL_LAND2_N EQU $52
DEF COLL_LAND2_S EQU $53
; $54..$57 will behave like COLL_LAND2_E

; falling warp collisions
DEF COLL_PIT       EQU $60
DEF COLL_PIT_VB    EQU $61 ; Why is this a pit?
DEF COLL_PIT_SKATE EQU $62 ; unused

; warp collisions
DEF COLL_CARPET EQU $70
DEF COLL_DOOR   EQU $71
DEF COLL_LADDER EQU $72
DEF COLL_CAVE   EQU $73
DEF COLL_STAIRS EQU $75

; minigame collisions
DEF COLL_SLOTS             EQU $80
DEF COLL_POKER             EQU $81 ; unused
DEF COLL_MEMORY            EQU $82 ; unused
DEF COLL_CONSOLE           EQU $83 ; scrapped soon after demo
DEF COLL_GAME_84           EQU $84 ; unused

; special collisions
DEF COLL_COUNTER           EQU $90
DEF COLL_BOOKCASE          EQU $91
DEF COLL_VENDING_MACHINE   EQU $92
DEF COLL_PC                EQU $93
DEF COLL_RADIO             EQU $94
DEF COLL_SIGNPOST          EQU $95
DEF COLL_SPECIAL_96        EQU $96 ; unused
DEF COLL_STRAIGHT_SIGNPOST EQU $97

; jump collisions
; perform jump in marked direction, else
; regular walking
DEF COLL_JUMP_E  EQU $a0
DEF COLL_JUMP_W  EQU $a1
DEF COLL_JUMP_N  EQU $a2
DEF COLL_JUMP_S  EQU $a3
DEF COLL_JUMP_SE EQU $a4
DEF COLL_JUMP_SW EQU $a5
DEF COLL_JUMP_NE EQU $a6
DEF COLL_JUMP_NW EQU $a7

DEF COLL_FF EQU $ff

DEF LAND_TILE  EQU 0
DEF WATER_TILE EQU 1
DEF WALL_TILE  EQU 15
