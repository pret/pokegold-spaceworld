	db DEX_TATTU ; 116

	db  30,  40,  70,  60,  70,  45
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 225 ; catch rate
	db 83 ; base exp
	db ITEM_BERRY, ITEM_SMOKESCREEN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $6eab, $6f87 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 11, 12, 13, 14, 20, 31, 32, 34, 39, 40, 44, 50, 53
	; end
