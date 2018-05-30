	db DEX_NAZONOKUSA ; 043

	db  45,  50,  55,  30,  75,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GRASS, TYPE_POISON ; type
	db 255 ; catch rate
	db 78 ; base exp
	db ITEM_BERRY, ITEM_MYSTIC_PETAL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw NazonokusaPicFront, NazonokusaPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 9, 10, 20, 21, 22, 31, 32, 33, 34, 44, 50, 51
	; end

