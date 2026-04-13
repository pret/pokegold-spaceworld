INCLUDE "constants.asm"

SECTION "data/tileset_headers.asm", ROMX

MACRO tileset
	db BANK(\1_GFX) ; shared bank
	dw \1_Meta, \1_GFX, \1_Coll
	dw \2, ; animation set
	dw NULL ; unused
ENDM

Tilesets:
	; name, animation set
	tileset SilentHill, TilesetGenericAnim
	tileset OldCity, TilesetWaterAnim
	tileset West, TilesetFlowerAnim
	tileset HighTech, TilesetFlowerAnim
	tileset Birdon, TilesetWaterAnim
	tileset Font, TilesetFontAnim
	tileset North, TilesetWaterAnim
	tileset Kanto, TilesetFlowerAnim
	tileset South, TilesetWaterAnim
	tileset House, TilesetNoAnim
	tileset Lab, TilesetNoAnim
	tileset TraditionalHouse, TilesetNoAnim
	tileset Pokecenter, TilesetNoAnim
	tileset Mart, TilesetNoAnim
	tileset Aquarium, TilesetNoAnim
	tileset Tower, TilesetNoAnim
	tileset DeptStore, TilesetNoAnim
	tileset Gate, TilesetNoAnim
	tileset RadioTower, TilesetNoAnim
	tileset RocketHouse, TilesetRocketHouseAnim
	tileset Gym, TilesetNoAnim
	tileset Office, TilesetNoAnim
	tileset RuinsOfAlph, TilesetNoAnim
	tileset Cave, TilesetNoAnim
	tileset PowerPlant, TilesetNoAnim
	tileset Ship, TilesetNoAnim
	tileset ShipPort, TilesetNoAnim
	tileset Forest, TilesetGenericAnim
