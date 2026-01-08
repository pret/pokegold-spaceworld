; AI_CAUTIOUS discourages these moves after the first turn.

ResidualMoves:
	db MOVE_MIST
	db MOVE_LEECH_SEED
	db MOVE_POISONPOWDER
	db MOVE_STUN_SPORE
	db MOVE_THUNDER_WAVE
	db MOVE_MIMIC ; Not present in the final game
	db MOVE_FOCUS_ENERGY
	db MOVE_BIDE
	db MOVE_POISON_GAS
	db MOVE_TRANSFORM
	db MOVE_CONVERSION
	db MOVE_SUBSTITUTE
; MOVE_SPIKES is not present in the proto.
	db -1 ; end
