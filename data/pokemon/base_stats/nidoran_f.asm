	db DEX_NIDORAN_F ; 029

	db  55,  47,  52,  41,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 235 ; catch rate
	db 59 ; base exp
	db ITEM_BERRY, ITEM_TOXIC_NEEDLE ; items
	db GENDER_FEMALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw Nidoran_FPicFront, dw Nidoran_FPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 14, 20, 24, 25, 31, 32, 33, 34, 40, 44, 50
	; end

