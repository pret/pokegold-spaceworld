_DisableAudio:: ; 3a:4000
    push hl
    push de
    push bc
    push af
    ld hl, rNR50
    xor a
    ld [hli], a
    ld [hli], a
    ld a, $80
    ld [hli], a
    ld hl, rNR10
    ld e, 4
.init_channel
    xor a
    ld [hli], a
    ld [hli], a
    ld a, 8
    ld [hli], a
    xor a
    ld [hli], a
    ld a, $80
    ld [hli], a
    dec e
    jr nz, .init_channel

    ld hl, wMusic
    ld de, wMusicInitEnd - wMusic
.clear
    xor a
    ld [hli], a
    dec de
    ld a, e
    or d
    jr nz, .clear

    ld a, $77
    ld [wVolume], a

    pop af
    pop bc
    pop de
    pop hl
    ret


_UpdateSound:: ; 3a:4037
    xor a
    ; So, I'm being told I need to disassemble this...
    ; OH HELL NO

    ; ... TODO :/



SECTION "Audio engine, part 2", ROMX[$4CEE],BANK[$3A] ; TODO: disassemble what's above (gulp) and remove this

SetGlobalTempo: ; 3a:4cee
    push bc
    ld a, [wCurChannel]
    cp CHAN5
    jr nc, .sfxchannels
    ld bc, wChannel1
    call Tempo
    ld bc, wChannel2
    call Tempo
    ld bc, wChannel3
    call Tempo
    ld bc, wChannel4
    call Tempo
    jr .end

.sfxchannels
    ld bc, wChannel5
    call Tempo
    ld bc, wChannel6
    call Tempo
    ld bc, wChannel7
    call Tempo
    ld bc, wChannel8
    call Tempo

.end
    pop bc
    ret

Tempo: ; 3a:4d2a
    ld hl, wChannel1Tempo - wChannel1
    add hl, bc
    ld [hl], e
    inc hl
    ld [hl], d
    xor a
    ld hl, wChannel1Field16 - wChannel1
    add hl, bc
    ld [hl], a
    ret


StartChannel: ; 3a:4d38
    call SetLRTracks
    ld hl, wChannel1Flags - wChannel1
    add hl, bc
    set SOUND_CHANNEL_ON, [hl]
    ret


StopChannel: ; 3a:4d42
    ld hl, wChannel1Flags - wChannel1
    add hl, bc
    res SOUND_CHANNEL_ON, [hl]
    ld hl, wChannel1MusicID - wChannel1
    add hl, bc
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ret


SetLRTracks: ; 3a:4d51
    push de
    ld a, [wCurChannel]
    maskbits NUM_MUSIC_CHANS
    ld e, a
    ld d, 0
    ld hl, $52B3 ; FIXME
    add hl, de
    ld a, [hl]
    ld hl, wChannel1Tracks - wChannel1
    add hl, bc
    ld [hl], a
    pop de
    ret


_PlayMusic:: ; 3a:4d66
    ld hl, wMusicID
    ld [hl], e
    inc hl
    ld [hl], d
    ld hl, Music
    add hl, de
    add hl, de
    add hl, de
    ld a, [hli]
    ld [wMusicBank], a
    ld e, [hl]
    inc hl
    ld d, [hl]
    call LoadMusicByte
    rlca
    rlca
    maskbits NUM_MUSIC_CHANS
    inc a
.loop
    push af
    call LoadChannel
    call StartChannel
    pop af
    dec a
    jr nz, .loop
    xor a
    ; TODO
