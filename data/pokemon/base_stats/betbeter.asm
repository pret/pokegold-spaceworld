	db DEX_BETBETER ; 088

	db  80,  80,  50,  25,  55,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 190 ; catch rate
	db 90 ; base exp
	db ITEM_BERRY, ITEM_GROSS_GARBAGE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw BetbeterPicFront, BetbeterPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 20, 21, 24, 25, 31, 32, 34, 36, 38, 44, 47, 50
	; end

