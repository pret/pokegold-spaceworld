	db DEX_SIDON ; 112

	db 105, 130, 120,  40,  45,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GROUND, TYPE_ROCK ; type
	db 60 ; catch rate
	db 204 ; base exp
	db ITEM_APPLE, ITEM_SHARP_HORN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw SidonPicFront, SidonPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 24, 25, 26, 27, 28, 31, 32, 34, 38, 40, 44, 48, 50, 53, 54
	; end

