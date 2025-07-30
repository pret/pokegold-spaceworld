INCLUDE "constants.asm"

SECTION "engine/events/starter_dex.asm", ROMX

; Brings up the Pokédex entry of the index in wTempSpecies/wNamedObjectIndex to show as if it were caught.
StarterDex::
	call RefreshScreen
	call LowVolume
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call ClearBGPalettes
	call ClearSprites
	call LoadStandardMenuHeader
	callfar LoadPokeDexGraphics
	call ClearTileMap
	callfar _NewPokedexEntry
	call ClearBGPalettes
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call ExitMenu
	call LoadTilesetGFX_LCDOff
	call RestoreScreenAndReloadTiles
	call UpdateTimePals
	pop af
	ldh [hMapAnims], a
	call MaxVolume
	call ScreenCleanup
	ret
