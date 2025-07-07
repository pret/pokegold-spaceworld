; Format:
; Y offset, X offset, vTile offset, tile properties
MinorObjectSpriteTiles:
	dw .Null
	dw .Emote
	dw .Shadow
	dw .BoulderDust1
	dw .BoulderDust2

.Null:
	db 0 ; tiles

.Emote:
	db 4 ; tiles
	db 0, 0, $00, 0
	db 0, 8, $01, 0
	db 8, 0, $02, 0
	db 8, 8, $03, 0

.Shadow:
	db 2 ; tiles
	db 0, 0, $00, 0
	db 0, 8, $00, X_FLIP

.BoulderDust1:
	db 4 ; tiles
	db 0, 0, $00, 0
	db 0, 8, $00, 0
	db 8, 0, $00, 0
	db 8, 8, $00, 0

.BoulderDust2:
	db 4 ; tiles
	db 0, 0, $00, Y_FLIP
	db 0, 8, $00, Y_FLIP
	db 8, 0, $00, Y_FLIP
	db 8, 8, $00, Y_FLIP
