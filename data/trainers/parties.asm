; Trainer data structure:
; - db "NAME@", TRAINERTYPE_* constant
; - 1 to 6 Pokémon:
;    * for TRAINERTYPE_NORMAL:     db level, species
;    * for TRAINERTYPE_ITEM:       db level, species, item
;    * for TRAINERTYPE_MOVES:      db level, species, 4 moves
;    * for TRAINERTYPE_ITEM_MOVES: db level, species, item, 4 moves
; - db -1 ; end


; TODO: decode data from the beginning
SECTION "Trainer Parties TEMPORARY 1", ROMX[$51BF],BANK[$E]

	; BUG CATCHER BOY JUNICHI
	db "じゅんいち@", TRAINERTYPE_ITEM_MOVES
	db  7, DEX_PARAS, ITEM_NONE, MOVE_STUN_SPORE, MOVE_LEECH_LIFE, MOVE_NONE, MOVE_NONE
	db -1 ; end
