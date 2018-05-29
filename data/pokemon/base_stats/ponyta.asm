	db DEX_PONYTA ; 077

	db  50,  85,  55,  90,  65,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 190 ; catch rate
	db 152 ; base exp
	db ITEM_BERRY, ITEM_FIRE_MANE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw PonytaPicFront, dw PonytaPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 20, 31, 32, 33, 34, 38, 39, 40, 44, 50
	; end

