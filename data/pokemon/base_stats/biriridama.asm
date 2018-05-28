	db DEX_BIRIRIDAMA ; 100

	db  40,  30,  50, 100,  55,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ELECTRIC, TYPE_ELECTRIC ; type
	db 190 ; catch rate
	db 103 ; base exp
	db ITEM_BERRY, ITEM_STIMULUS_ORB ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $433d, $43c6 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 20, 24, 25, 30, 31, 32, 33, 34, 36, 39, 44, 45, 47, 50, 55
	; end
