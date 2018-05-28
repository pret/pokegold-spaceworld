	db DEX_PIKACHU ; 025

	db  35,  55,  30,  90,  50,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ELECTRIC, TYPE_ELECTRIC ; type
	db 190 ; catch rate
	db 82 ; base exp
	db ITEM_BERRY, ITEM_ELECTRIC_POUCH ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $7abd, $7b9d ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 16, 17, 19, 20, 24, 25, 31, 32, 33, 34, 39, 40, 44, 45, 50, 55
	; end
