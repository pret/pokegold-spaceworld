	db DEX_KONGPANG ; 048

	db  60,  55,  50,  45,  40,  50
	;   hp  atk  def  spd  sat  sdf

	db TYPE_BUG, TYPE_POISON ; type
	db 190 ; catch rate
	db 75 ; base exp
	db ITEM_BERRY, ITEM_SILVERPOWDER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $72e7, $7404 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 20, 21, 22, 29, 31, 32, 33, 34, 44, 46, 50
	; end
