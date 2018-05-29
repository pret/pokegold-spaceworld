	db DEX_NYOROMO ; 060

	db  40,  50,  40,  90,  40,  45
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 255 ; catch rate
	db 77 ; base exp
	db ITEM_BERRY, ITEM_STRANGE_WATER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw NyoromoPicFront, dw NyoromoPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 13, 14, 20, 29, 31, 32, 34, 40, 44, 46, 50, 53
	; end

