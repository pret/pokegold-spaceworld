SECTION "Tilemap copy/restore funcs", ROM0[$3355]

BackUpTilesToBuffer:: ; 3355
    hlcoord 0, 0
    decoord 0, 0, wTileMapBackup
    ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
    jp CopyBytes

ReloadTilesFromBuffer:: ; 3361
    xor a
    ldh [hBGMapMode], a
    hlcoord 0, 0, wTileMapBackup
    decoord 0, 0
    ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
    call CopyBytes
    ld a, 1
    ldh [hBGMapMode], a
    ret
