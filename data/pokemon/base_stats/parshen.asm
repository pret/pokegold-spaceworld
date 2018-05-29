	db DEX_PARSHEN ; 091

	db  50,  95, 180,  70,  85,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_ICE ; type
	db 60 ; catch rate
	db 203 ; base exp
	db ITEM_APPLE, ITEM_BIG_PEARL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw ParshenPicFront, dw ParshenPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 11, 12, 13, 14, 15, 20, 30, 31, 32, 33, 34, 36, 39, 44, 47, 49, 50, 53
	; end

