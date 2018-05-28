	db DEX_CASEY ; 063

	db  25,  20,  15,  90, 105,  65
	;   hp  atk  def  spd  sat  sdf

	db TYPE_PSYCHIC, TYPE_PSYCHIC ; type
	db 200 ; catch rate
	db 73 ; base exp
	db ITEM_BERRY, ITEM_TWISTEDSPOON ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $5acb, $5bce ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 17, 18, 19, 20, 29, 30, 31, 32, 33, 34, 35, 40, 44, 45, 46, 49, 50, 55
	; end
