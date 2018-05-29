	db DEX_KABUTO ; 140

	db  30,  80,  90,  55,  55,  45
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ROCK, TYPE_WATER ; type
	db 45 ; catch rate
	db 119 ; base exp
	db ITEM_BERRY, ITEM_FOSSIL_SHARD ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw KabutoPicFront, KabutoPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 13, 14, 20, 31, 32, 33, 34, 44, 50, 53
	; end

