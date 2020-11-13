	db DEX_MEOWTH ; 052

	db  40,  45,  35,  90,  40,  50
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 255 ; catch rate
	db 69 ; base exp
	db ITEM_BERRY, ITEM_AMULET_COIN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw MeowthPicFront, MeowthPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 16, 20, 24, 25, 31, 32, 34, 39, 40, 44, 50
	; end

