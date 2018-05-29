	db DEX_ONISUZUME ; 021

	db  40,  60,  30,  70,  31,  31
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_FLYING ; type
	db 255 ; catch rate
	db 58 ; base exp
	db ITEM_BERRY, ITEM_BLACK_FEATHER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw OnisuzumePicFront, OnisuzumePicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 20, 31, 32, 34, 39, 43, 44, 50, 52
	; end

