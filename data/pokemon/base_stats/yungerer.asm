	db DEX_YUNGERER ; 064

	db  40,  35,  30, 105, 120,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_PSYCHIC, TYPE_PSYCHIC ; type
	db 100 ; catch rate
	db 145 ; base exp
	db ITEM_BERRY, ITEM_TWISTEDSPOON ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw YungererPicFront, YungererPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 17, 18, 19, 20, 28, 29, 30, 31, 32, 33, 34, 35, 40, 44, 45, 46, 49, 50, 55
	; end

