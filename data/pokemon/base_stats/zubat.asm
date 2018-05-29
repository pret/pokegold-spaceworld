	db DEX_ZUBAT ; 041

	db  40,  45,  35,  55,  30,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_FLYING ; type
	db 255 ; catch rate
	db 54 ; base exp
	db ITEM_BERRY, ITEM_POISON_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw ZubatPicFront, ZubatPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 20, 21, 31, 32, 34, 39, 44, 50
	; end

