	db DEX_FOODIN ; 065

	db  55,  50,  45, 120, 135,  95
	;   hp  atk  def  spd  sat  sdf

	db TYPE_PSYCHIC, TYPE_PSYCHIC ; type
	db 50 ; catch rate
	db 186 ; base exp
	db ITEM_APPLE, ITEM_TWISTEDSPOON ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw FoodinPicFront, FoodinPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 28, 29, 30, 31, 32, 33, 34, 35, 40, 44, 45, 46, 49, 50, 55
	; end

