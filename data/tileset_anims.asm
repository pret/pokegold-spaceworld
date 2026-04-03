INCLUDE "constants.asm"

SECTION "data/tileset_anims.asm", ROMX

MACRO tileframe
	if _NARG == 2
		dw \2 ; argument
	else
		dw 0
	endc
	dw \1 ; function
ENDM


TilesetFlowerAnim:
; UnusedTilesetAnim1 in pokegold/pokecrystal.
; Scrolls tile $03 like cave water, but also has the standard $38 flower tile.
	tileframe ReadTileToAnimBuffer,    vTileset tile $03
	tileframe ScrollTileRightLeft,     wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $03
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe AnimateFlowerTile
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe DoneTileAnimation

TilesetWaterAnim:
; UnusedTilesetAnim2 in pokegold/pokecrystal.
; Scrolls tile $03 like cave water.
	tileframe ReadTileToAnimBuffer,    vTileset tile $03
	tileframe ScrollTileRightLeft,     wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $03
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe DoneTileAnimation

TilesetGenericAnim:
; UnusedTilesetAnim3 in pokegold/pokecrystal.
; Scrolls tile $53 like a waterfall; scrolls tile $03 like cave water.
	tileframe ReadTileToAnimBuffer,    vTileset tile $53
	tileframe ScrollTileDown,          wTileAnimBuffer
	tileframe ScrollTileDown,          wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $53
	tileframe ReadTileToAnimBuffer,    vTileset tile $03
	tileframe ScrollTileRightLeft,     wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $03
	tileframe ReadTileToAnimBuffer,    vTileset tile $53
	tileframe ScrollTileDown,          wTileAnimBuffer
	tileframe ScrollTileDown,          wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $53
	tileframe DoneTileAnimation

TilesetFontAnim:
; UnusedTilesetAnim4 in pokegold/pokecrystal.
; Scrolls tile $54 like a waterfall; scrolls tile $03 like cave water.
	tileframe ReadTileToAnimBuffer,    vTileset tile $54
	tileframe ScrollTileDown,          wTileAnimBuffer
	tileframe ScrollTileDown,          wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $54
	tileframe WaitTileAnimation
	tileframe ReadTileToAnimBuffer,    vTileset tile $03
	tileframe ScrollTileRightLeft,     wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $03
	tileframe WaitTileAnimation
	tileframe ReadTileToAnimBuffer,    vTileset tile $54
	tileframe ScrollTileDown,          wTileAnimBuffer
	tileframe ScrollTileDown,          wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $54
	tileframe DoneTileAnimation

TilesetRocketHouseAnim:
; UnusedTilesetAnim5 in pokegold/pokecrystal.
; Scrolls tile $4f like cave water.
	tileframe ReadTileToAnimBuffer,    vTileset tile $4f
	tileframe ScrollTileRightLeft,     wTileAnimBuffer
	tileframe WriteTileFromAnimBuffer, vTileset tile $4f
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe DoneTileAnimation

TilesetNoAnim:
; TilesetUndergroundAnim in pokegold/pokecrystal.
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe WaitTileAnimation
	tileframe DoneTileAnimation