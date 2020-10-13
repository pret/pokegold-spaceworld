	db DEX_HYPNO ; 097

	db  85,  73,  70,  67,  70, 115
	;   hp  atk  def  spd  sat  sdf

	db TYPE_PSYCHIC, TYPE_PSYCHIC ; type
	db 75 ; catch rate
	db 165 ; base exp
	db ITEM_APPLE, ITEM_5_YEN_COIN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw HypnoPicFront, HypnoPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 29, 30, 31, 32, 33, 34, 35, 40, 42, 44, 45, 46, 49, 50, 55
	; end

