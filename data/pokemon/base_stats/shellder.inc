	db DEX_SHELLDER ; 090

	db  30,  65, 100,  40,  45,  30
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 190 ; catch rate
	db 97 ; base exp
	db ITEM_BERRY, ITEM_BIG_PEARL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw ShellderPicFront, ShellderPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 11, 12, 13, 14, 20, 30, 31, 32, 33, 34, 36, 39, 44, 47, 49, 50, 53
	; end

