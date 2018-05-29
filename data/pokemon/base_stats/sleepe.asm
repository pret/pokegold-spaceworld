	db DEX_SLEEPE ; 096

	db  60,  48,  45,  42,  45,  90
	;   hp  atk  def  spd  sat  sdf

	db TYPE_PSYCHIC, TYPE_PSYCHIC ; type
	db 190 ; catch rate
	db 102 ; base exp
	db ITEM_BERRY, ITEM_5_YEN_COIN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw SleepePicFront, dw SleepePicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 17, 18, 19, 20, 29, 30, 31, 32, 33, 34, 35, 40, 42, 44, 45, 46, 49, 50, 55
	; end

