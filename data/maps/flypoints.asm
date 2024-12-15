INCLUDE "constants.asm"

SECTION "data/maps/flypoints.asm", ROMX

;
; Table that the game reads for determining which Fly point to move to depending on D-Pad input.
; Each row corresponds to the index of a Fly point.
; 
;   db UP, DOWN, LEFT, RIGHT
;
FlyPointPaths:

	db FLY_POINT_PRINCE, FLY_POINT_N_A, FLY_POINT_OLD, FLY_POINT_KANTO                  ; FLY_POINT_SILENT_HILL    
	db FLY_POINT_HAITEKU, FLY_POINT_SILENT_HILL, FLY_POINT_WEST, FLY_POINT_SILENT_HILL  ; FLY_POINT_OLD
	db FLY_POINT_BAADON, FLY_POINT_OLD, FLY_POINT_HAITEKU, FLY_POINT_OLD                ; FLY_POINT_WEST
	db FLY_POINT_FONTO, FLY_POINT_WEST, FLY_POINT_SOUTH, FLY_POINT_WEST                 ; FLY_POINT_HAITEKU
	db FLY_POINT_SOUTH, FLY_POINT_HAITEKU, FLY_POINT_SOUTH, FLY_POINT_BAADON            ; FLY_POINT_FONTO
	db FLY_POINT_FONTO, FLY_POINT_WEST, FLY_POINT_FONTO, FLY_POINT_NEWTYPE              ; FLY_POINT_BAADON
	db FLY_POINT_SUGAR, FLY_POINT_N_A, FLY_POINT_BAADON, FLY_POINT_BULL_FOREST          ; FLY_POINT_NEWTYPE
	db FLY_POINT_N_A, FLY_POINT_NEWTYPE, FLY_POINT_N_A, FLY_POINT_N_A                   ; FLY_POINT_SUGAR
	db FLY_POINT_NORTH, FLY_POINT_STAND, FLY_POINT_NEWTYPE, FLY_POINT_NORTH             ; FLY_POINT_BULL_FOREST
	db FLY_POINT_BULL_FOREST, FLY_POINT_KANTO, FLY_POINT_KANTO, FLY_POINT_BULL_FOREST   ; FLY_POINT_STAND
	db FLY_POINT_STAND, FLY_POINT_SILENT_HILL, FLY_POINT_SILENT_HILL, FLY_POINT_STAND   ; FLY_POINT_KANTO
	db FLY_POINT_MT_FUJI, FLY_POINT_SILENT_HILL, FLY_POINT_N_A, FLY_POINT_N_A           ; FLY_POINT_PRINCE
	db FLY_POINT_N_A, FLY_POINT_PRINCE, FLY_POINT_N_A, FLY_POINT_N_A                    ; FLY_POINT_MT_FUJI
	db FLY_POINT_FONTO, FLY_POINT_HAITEKU, FLY_POINT_N_A, FLY_POINT_FONTO               ; FLY_POINT_SOUTH
	db FLY_POINT_N_A, FLY_POINT_BULL_FOREST, FLY_POINT_BULL_FOREST, FLY_POINT_N_A       ; FLY_POINT_NORTH