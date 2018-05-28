	db DEX_NIDORINO ; 033

	db  61,  72,  57,  65,  45,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 120 ; catch rate
	db 118 ; base exp
	db ITEM_BERRY, ITEM_TOXIC_NEEDLE ; items
	db GENDER_MALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $4e28, $4f96 ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 11, 12, 13, 14, 20, 24, 25, 31, 32, 33, 34, 40, 44, 50
	; end
