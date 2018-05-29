	db DEX_IWARK ; 095

	db  35,  45, 160,  70,  30,  60
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ROCK, TYPE_GROUND ; type
	db 45 ; catch rate
	db 108 ; base exp
	db ITEM_BERRY, ITEM_SHARP_STONE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw IwarkPicFront, dw IwarkPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 20, 26, 27, 28, 31, 32, 34, 36, 40, 44, 47, 48, 50, 54
	; end

