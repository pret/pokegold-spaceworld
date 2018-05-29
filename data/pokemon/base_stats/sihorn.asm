	db DEX_SIHORN ; 111

	db  80,  85,  95,  25,  30,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GROUND, TYPE_ROCK ; type
	db 120 ; catch rate
	db 135 ; base exp
	db ITEM_BERRY, ITEM_SHARP_HORN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw SihornPicFront, SihornPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 20, 24, 25, 26, 27, 28, 31, 32, 34, 38, 40, 44, 48, 50, 54
	; end

