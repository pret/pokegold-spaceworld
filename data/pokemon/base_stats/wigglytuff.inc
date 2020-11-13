	db DEX_WIGGLYTUFF ; 040

	db 140,  70,  45,  45,  50,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 50 ; catch rate
	db 109 ; base exp
	db ITEM_APPLE, ITEM_STRANGE_POWER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw WigglytuffPicFront, WigglytuffPicBack ; sprites
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 22, 24, 25, 29, 30, 31, 32, 33, 34, 38, 40, 44, 45, 46, 49, 50, 54, 55
	; end

