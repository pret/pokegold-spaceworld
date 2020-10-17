	db DEX_CHANSEY ; 113

	db 250,   5,   5,  50,  35, 105
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 30 ; catch rate
	db 255 ; base exp
	db ITEM_BERRY, ITEM_LUCKY_EGG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw ChanseyPicFront, ChanseyPicBack ; sprites
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 22, 24, 25, 29, 30, 31, 32, 33, 34, 35, 37, 38, 40, 41, 44, 45, 46, 49, 50, 54, 55
	; end

