	db DEX_MANKEY ; 056

	db  40,  80,  35,  70,  35,  45
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIGHTING, TYPE_FIGHTING ; type
	db 190 ; catch rate
	db 74 ; base exp
	db ITEM_LOTTO_TICKET, ITEM_POWER_BRACER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $4a29, $4b3c ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 16, 17, 18, 19, 20, 24, 25, 28, 31, 32, 34, 35, 39, 40, 44, 48, 50, 54
	; end
