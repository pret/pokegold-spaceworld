	db DEX_ONIDRILL ; 022

	db  65,  90,  65, 100,  61,  61
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_FLYING ; type
	db 90 ; catch rate
	db 162 ; base exp
	db ITEM_APPLE, ITEM_BLACK_FEATHER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw OnidrillPicFront, OnidrillPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 15, 20, 31, 32, 34, 39, 43, 44, 50, 52
	; end

