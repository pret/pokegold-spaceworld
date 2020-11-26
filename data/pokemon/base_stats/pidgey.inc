	db DEX_PIDGEY ; 016

	db  40,  45,  40,  56,  35,  35
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_FLYING ; type
	db 255 ; catch rate
	db 55 ; base exp
	db ITEM_BERRY, ITEM_WHITE_FEATHER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw PidgeyPicFront, PidgeyPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 20, 31, 32, 33, 34, 39, 43, 44, 50, 52
	; end

