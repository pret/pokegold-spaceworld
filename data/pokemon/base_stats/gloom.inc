	db DEX_GLOOM ; 044

	db  60,  65,  70,  40,  85,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GRASS, TYPE_POISON ; type
	db 120 ; catch rate
	db 132 ; base exp
	db ITEM_BERRY, ITEM_MYSTIC_PETAL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw GloomPicFront, GloomPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 9, 10, 20, 21, 22, 31, 32, 33, 34, 44, 50, 51
	; end

