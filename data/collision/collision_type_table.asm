MACRO collperm
	if _NARG <= 8
	; collisions with COLLFLAG_ENCOUNTER have the same permissions as ones without.
	db \1_TILE, \2_TILE, \3_TILE, \4_TILE, \5_TILE, \6_TILE, \7_TILE, \8_TILE
	db \1_TILE, \2_TILE, \3_TILE, \4_TILE, \5_TILE, \6_TILE, \7_TILE, \8_TILE
	else
	; handle $FF seperately
	db \1_TILE, \2_TILE, \3_TILE, \4_TILE, \5_TILE, \6_TILE, \7_TILE, \8_TILE
	db \1_TILE, \2_TILE, \3_TILE, \4_TILE, \5_TILE, \6_TILE, \7_TILE, \9_TILE
	endc
ENDM

CollisionTypeTable:
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  WALL        ; Regular     ($00)
	collperm LAND,  LAND,  WATER, LAND,  LAND,  LAND,  LAND,  LAND        ; Cuttable    ($10)
	collperm WATER, WATER, WATER, WATER, WATER, WATER, WATER, WALL        ; Water       ($20)
	collperm WATER, WATER, WATER, WATER, WATER, WATER, WATER, WATER       ; Water 2     ($30)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND        ; Land        ($40)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND        ; Land 2      ($50)
	collperm LAND,  LAND,  WALL,  LAND,  LAND,  LAND,  LAND,  LAND        ; Pits        ($60)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND        ; Warps       ($70)
	collperm WALL,  WALL,  WALL,  WALL,  WALL,  LAND,  LAND,  LAND        ; Minigames   ($80)
	collperm WALL,  WALL,  WALL,  WALL,  WALL,  WALL,  LAND,  WALL        ; Special     ($90)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND        ; Jump        ($A0)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND        ; unused      ($B0)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND        ; unused      ($C0)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND        ; unused      ($D0)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND        ; unused      ($E0)
	collperm LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  LAND,  WALL ; unused + FF ($F0)
