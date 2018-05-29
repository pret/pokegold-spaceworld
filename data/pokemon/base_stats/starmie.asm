	db DEX_STARMIE ; 121

	db  60,  75,  85, 115, 100,  85
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_PSYCHIC ; type
	db 60 ; catch rate
	db 207 ; base exp
	db ITEM_APPLE, ITEM_CRIMSON_JEWEL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw StarmiePicFront, dw StarmiePicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 11, 12, 13, 14, 15, 20, 24, 25, 29, 30, 31, 32, 33, 34, 39, 40, 44, 45, 46, 49, 50, 53, 55
	; end

