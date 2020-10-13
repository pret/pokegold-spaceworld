	db DEX_MRMIME ; 122

	db  40,  45,  65,  90, 100, 120
	;   hp  atk  def  spd  sat  sdf

	db TYPE_PSYCHIC, TYPE_PSYCHIC ; type
	db 45 ; catch rate
	db 136 ; base exp
	db ITEM_BERRY, ITEM_INVISIBLE_WALL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw MrMimePicFront, MrMimePicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 22, 24, 25, 29, 30, 31, 32, 33, 34, 35, 40, 44, 45, 46, 50, 55
	; end

