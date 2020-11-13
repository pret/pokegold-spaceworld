	db DEX_SLOWPOKE ; 079

	db  90,  65,  65,  15,  40,  35
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_PSYCHIC ; type
	db 190 ; catch rate
	db 99 ; base exp
	db ITEM_BERRY, ITEM_SLOWPOKETAIL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw SlowpokePicFront, SlowpokePicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 13, 14, 16, 20, 26, 27, 28, 29, 30, 31, 32, 33, 34, 38, 39, 40, 44, 45, 46, 49, 50, 53, 54, 55
	; end

