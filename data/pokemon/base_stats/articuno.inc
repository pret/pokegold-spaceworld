	db DEX_ARTICUNO ; 144

	db  90,  85, 100,  85,  95, 125
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ICE, TYPE_FLYING ; type
	db 3 ; catch rate
	db 215 ; base exp
	db ITEM_BERRY, ITEM_ICE_WING ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw ArticunoPicFront, ArticunoPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 11, 12, 13, 14, 15, 20, 31, 32, 33, 34, 39, 43, 44, 50, 52
	; end

