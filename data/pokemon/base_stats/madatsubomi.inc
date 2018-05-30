	db DEX_MADATSUBOMI ; 069

	db  50,  75,  35,  40,  55,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GRASS, TYPE_POISON ; type
	db 255 ; catch rate
	db 84 ; base exp
	db ITEM_BERRY, ITEM_BIG_LEAF ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw MadatsubomiPicFront, MadatsubomiPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 9, 10, 20, 21, 22, 31, 32, 33, 34, 44, 50, 51
	; end

