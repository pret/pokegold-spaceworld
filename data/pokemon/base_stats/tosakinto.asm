	db DEX_TOSAKINTO ; 118

	db  45,  67,  60,  63,  50,  50
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 225 ; catch rate
	db 111 ; base exp
	db ITEM_BERRY, ITEM_WET_HORN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw TosakintoPicFront, TosakintoPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 9, 10, 11, 12, 13, 14, 20, 31, 32, 34, 39, 40, 44, 50, 53
	; end

