	db DEX_MARUMINE ; 101

	db  60,  50,  70, 140,  80,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ELECTRIC, TYPE_ELECTRIC ; type
	db 60 ; catch rate
	db 150 ; base exp
	db ITEM_APPLE, ITEM_STIMULUS_ORB ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $4467, $452e ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 15, 20, 24, 25, 30, 31, 32, 33, 34, 36, 39, 40, 44, 45, 47, 50, 55
	; end
