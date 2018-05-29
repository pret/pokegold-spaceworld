	db DEX_GARDIE ; 058

	db  55,  70,  45,  60,  50,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 190 ; catch rate
	db 91 ; base exp
	db ITEM_BERRY, ITEM_TALISMAN_TAG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw GardiePicFront, dw GardiePicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 20, 23, 28, 31, 32, 33, 34, 38, 39, 40, 44, 50
	; end

