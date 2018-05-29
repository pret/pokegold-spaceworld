	db DEX_ROUGELA ; 124

	db  65,  50,  35,  95,  95,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ICE, TYPE_PSYCHIC ; type
	db 45 ; catch rate
	db 137 ; base exp
	db ITEM_BERRY, ITEM_ICE_BIKINI ; items
	db GENDER_FEMALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw RougelaPicFront, dw RougelaPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 29, 30, 31, 32, 33, 34, 35, 40, 44, 46, 50
	; end

