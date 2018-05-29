	db DEX_PIGEON ; 017

	db  63,  60,  55,  71,  50,  50
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_FLYING ; type
	db 120 ; catch rate
	db 113 ; base exp
	db ITEM_BERRY, ITEM_WHITE_FEATHER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw PigeonPicFront, dw PigeonPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 20, 31, 32, 33, 34, 39, 43, 44, 50, 52
	; end

