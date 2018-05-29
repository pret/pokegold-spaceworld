	db DEX_YADORAN ; 080

	db  95,  75, 110,  30,  80,  65
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_PSYCHIC ; type
	db 75 ; catch rate
	db 164 ; base exp
	db ITEM_BERRY, ITEM_SLOWPOKETAIL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw YadoranPicFront, dw YadoranPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 26, 27, 28, 29, 30, 31, 32, 33, 34, 38, 39, 40, 44, 45, 46, 49, 50, 53, 54, 55
	; end

