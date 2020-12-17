INCLUDE "constants.asm"

SECTION "audio/engine.asm@Audio", ROMX

_DisableAudio::
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

_UpdateSound::
; Called once per frame
	xor a
	ld [wCurChannel], a
	ld [wSoundOutput], a
	ld bc, wChannel1

.loop
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .nextchannel

	call UpdateChannel

.nextchannel
	; Next channel
	ld hl, CHANNEL_STRUCT_LENGTH
	add hl, bc
	ld c, l
	ld b, h
	ld a, [wCurChannel]
	inc a
	ld [wCurChannel], a
	cp NUM_CHANNELS
	jr nz, .loop

	call Functione82f0
	ret

UpdateChannel:
	; Get the note's duration
	ld hl, CHANNEL_NOTE_DURATION
	add hl, bc
	ld a, [hl]

	; Check if this is the last frame
	cp 1
	jr z, .noteover
	and a
	jr z, .noteover

	dec [hl]
	jr .continue_sound_update

.noteover
	call DisablePitchWheel
	call Functione884f

.continue_sound_update
	call Functione80b6
	ret

DisablePitchWheel:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	res SOUND_PITCH_WHEEL, [hl]
	ret

Unreferenced_Functione8081:
	ld a, [wMapMusic]
	bit 0, a
	jr nz, .disable_music

	bit 1, a
	jr nz, .disable_sfx

.fail
	and a
	ret

.disable_music
	call _DisableAudio
	jr .done

.disable_sfx
	call IsChannelSFXOn
	jr c, .fail

	; Clear the registers of the channel
	call GetChannelRegisters
	ld e, rNR20 - rNR10
	xor a

.clear_loop
	ld [hli], a
	dec e
	jr nz, .clear_loop

.done
	scf
	ret

GetChannelRegisters:
	ld a, [wCurChannel]
	ld e, a
	ld d, $00
	ld hl, .registers
	add hl, de
	ld l, [hl]
	ld h, $ff ; HIGH(rNR10, rNR20, rNR30, rNR40)
	ret

.registers
	db LOW(rNR10), LOW(rNR20), LOW(rNR30), LOW(rNR40)

Functione80b6:
	ld hl, CHANNEL_DUTY_CYCLE
	add hl, bc
	ld a, [hl]
	ld [wCurTrackDuty], a

	ld hl, CHANNEL_INTENSITY
	add hl, bc
	ld a, [hl]
	ld [wCurTrackIntensity], a

	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld a, [hli]
	ld [wCurTrackFrequency], a
	ld a, [hl]
	ld [wCurTrackFrequency + 1], a
	ld a, $3F
	ld [wSoundLength], a
	call Functione85d8
	call Functione87f9
	call Functione8839
	call IsChannelSFXOn
	jr nc, .end

	call UpdateChannels
	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld a, [wSoundOutput]
	or [hl]
	ld [wSoundOutput], a

.end
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	xor a
	ld [hl], a
	ret

UpdateChannels:
	ld hl, .jumptable
	ld a, [wCurChannel]
	maskbits NUM_CHANNELS
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.jumptable
; Music channels
	dw .Channel1
	dw .Channel2
	dw .Channel3
	dw .Channel4
; SFX channels
	dw .Channel5
	dw .Channel6
	dw .Channel7
	dw .Channel8

.Channel1:
	ld a, [wLowHealthAlarm]
	bit 7, a
	ret nz

.Channel5:
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	bit NOTE_PITCH_SWEEP, [hl]
	jr z, .ch1_no_sweep

	ld a, [wPitchSweep]
	ldh [rNR10], a

.ch1_no_sweep
	bit NOTE_REST, [hl]
	jr nz, .ch1_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch1_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	call nz, .ch1_freq_override
	bit NOTE_INTENSITY_OVERRIDE, [hl]
	call nz, .ch1_intensity_override
	bit NOTE_DUTY_OVERRIDE, [hl]
	call nz, .ch1_duty_override
	ret

.ch1_rest
	ld a, %1000	; stop envelope
	ldh [rNR12], a
	ld a, [wCurTrackFrequency + 1]
	or $80		; restart ch1
	ldh [rNR14], a
	ret

.ch1_noise_sampling
	ld hl, wCurTrackDuty
	ld a, [wSoundLength]
	or [hl]
	ldh [rNR11], a
	ld a, [wCurTrackIntensity]
	ldh [rNR12], a
	ld a, [wCurTrackFrequency]
	ldh [rNR13], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR14], a
	ret

.ch1_duty_override
	ld a, [wCurTrackDuty]
	ldh a, [rNR11]
	and $3f
	or d
	ldh [rNR11], a
	ret

.ch1_intensity_override
	ld a, [wCurTrackIntensity]
	ldh [rNR12], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR14], a
	ret

.ch1_freq_override
	ld a, [wCurTrackFrequency]
	ldh [rNR13], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR14], a
	ret

.Channel2:
.Channel6:
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	bit NOTE_REST, [hl]
	jr nz, .ch2_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch2_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	call nz, .ch2_freq_override
	bit NOTE_INTENSITY_OVERRIDE, [hl]
	call nz, .ch2_intensity_override
	bit NOTE_DUTY_OVERRIDE, [hl]
	call nz, .ch2_duty_override
	ret

.ch2_rest
	ld a, $08
	ldh [rNR22], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR24], a
	ret

.ch2_noise_sampling
	ld hl, wCurTrackDuty
	ld a, [wSoundLength]
	or [hl]
	ldh [rNR21], a
	ld a, [wCurTrackIntensity]
	ldh [rNR22], a
	ld a, [wCurTrackFrequency]
	ldh [rNR23], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR24], a
	ret

.ch2_duty_override
	ld a, [wCurTrackDuty]
	ld d, a
	ldh a, [rNR21]
	and $3f
	or d
	ldh [rNR21], a
	ret

.ch2_intensity_override
	ld a, [wCurTrackIntensity]
	ldh [rNR22], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR24], a
	ret

.ch2_freq_override
	ld a, [wCurTrackFrequency]
	ldh [rNR23], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR24], a
	ret

.Channel3:
.Channel7:
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	bit NOTE_REST, [hl]
	jr nz, .ch3_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch3_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	call nz, .ch3_freq_override
	bit NOTE_INTENSITY_OVERRIDE, [hl]
	call nz, .ch3_intensity_override
	ret

.ch3_rest
	xor a
	ldh [rNR30], a
	ret

.ch3_noise_sampling
	ld a, [wSoundLength]
	ldh [rNR31], a
	xor a
	ldh [rNR30], a
	call .load_wave_pattern
	ld a, $80
	ldh [rNR30], a
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR34], a
	ret

.ch3_freq_override
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR34], a
	ret

.ch3_intensity_override
	xor a
	ldh [rNR30], a
	call .load_wave_pattern
	ld a, $80
	ldh [rNR30], a
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR34], a
	ret

.load_wave_pattern
	push hl
	ld a, [wCurTrackIntensity]
; only patterns 0 - 9 are valid
	and $f
	ld l, a
	ld h, 0
; hl << 4 (hl * $10), because each pattern is $f bytes
rept 4
	add hl, hl
endr
	ld de, WaveSamples
	add hl, de
	ld de, rWave_0
	push bc
	ld b, $10
.load_pattern
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .load_pattern

	pop bc
	pop hl
	ld a, [wCurTrackIntensity]
	and $f0
	sla a
	ldh [rNR32], a
	ret

.Channel4:
.Channel8:
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	bit NOTE_REST, [hl]
	jr nz, .ch4_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch4_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	call nz, .ch4_freq_override
	bit NOTE_INTENSITY_OVERRIDE, [hl]
	call nz, .ch4_intensity_override
	ret

.ch4_rest
	ld a, $08
	ldh [rNR42], a
	ld a, $80
	ldh [rNR44], a
	ret

.ch4_noise_sampling
	ld a, [wSoundLength]
	ldh [rNR41], a
	ld a, [wCurTrackIntensity]
	ldh [rNR42], a
	ld a, [wCurTrackFrequency]
	ldh [rNR43], a
	ld a, $80
	ldh [rNR44], a
	ret

.ch4_freq_override
	ld a, [wCurTrackFrequency]
	ldh [rNR43], a
	ret

.ch4_intensity_override
	ld a, [wCurTrackIntensity]
	ldh [rNR42], a
	ld a, $80
	ldh [rNR44], a
	ret

IsChannelSFXOn:
	; If it's not a valid channel, return
	ld a, [wCurChannel]
	cp NUM_MUSIC_CHANS
	jr nc, .off

	; Check if the corresponding SFX channel is on
	ld hl, CHANNEL_STRUCT_LENGTH * NUM_MUSIC_CHANS + CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .off

	and a
	ret

.off
	scf
	ret

IsAnySFXOn:
	ld hl, wChannel5Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .on
	ld hl, wChannel6Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .on
	ld hl, wChannel7Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .on
	ld hl, wChannel8Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .on

	and a
	ret

.on
	scf
	ret

Functione82f0:
	call IncrementTempo
	call PlayDanger
	call FadeMusic
	call DoSweepingFade
	ld a, [wVolume]
	ld [rNR50], a
	ld a, [wSoundOutput]
	ld [rNR51], a
	ret

PlayDanger:
	ld a, [wLowHealthAlarm]
	bit DANGER_ON_F, a
	ret z

	; Don't do anything if SFX is being played
	and $ff ^ (1 << DANGER_ON_F)
	ld d, a
	call IsAnySFXOn
	jr c, .increment

	; Play the high tone
	and a
	jr z, .begin

	; Play the low tone
	cp 16
	jr z, .halfway

	jr .increment

.halfway
	ld hl, DangerSoundLow
	jr .applychannel

.begin
	ld hl, DangerSoundHigh

.applychannel
	xor a
	ld [rNR10], a
	ld a, [hli]
	ld [rNR11], a
	ld a, [hli]
	ld [rNR12], a
	ld a, [hli]
	ld [rNR13], a
	ld a, [hli]
	ld [rNR14], a

.increment
	ld a, d
	inc a
	cp 30 ; Ending frame
	jr c, .noreset
	xor a
.noreset
	; Make sure the danger sound is kept on
	or 1 << DANGER_ON_F
	ld [wLowHealthAlarm], a

	; Make sure channel 1 is on
	ld a, [wSoundOutput]
	or $11
	ld [wSoundOutput], a
	ret

DangerSoundHigh:
	db $80 ; duty 50%
	db $e2 ; volume 14, envelope decrease sweep 2
	db $50 ; frequency: $750
	db $87 ; restart sound

DangerSoundLow:
	db $80 ; duty 50%
	db $e2 ; volume 14, envelope decrease sweep 2
	db $ee ; frequency: $6ee
	db $86 ; restart sound

IncrementTempo:
	call IsAnyChannelOn
	ret c

	ld a, [wIncrementTempo]
	ld e, a
	ld a, [wIncrementTempo + 1]
	ld d, a
	or e
	ret z

	ld hl, wChannel1Tempo
	call .addtempo
	ld hl, wChannel2Tempo
	call .addtempo
	ld hl, wChannel3Tempo
	call .addtempo
	ld hl, wChannel4Tempo
	call .addtempo
	xor a
	ld [wIncrementTempo], a
	ld [wIncrementTempo + 1], a
	ret

.addtempo
	; (int16)[hl] += de
	push de
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	ret

IsAnyChannelOn:
; Check if any music channel is on and isn't on the last frame

	ld hl, wChannel1Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .check_channel2

	ld hl, wChannel1NoteDuration
	ld a, [hl]
	cp 1
	jr nz, .on

.check_channel2
	ld hl, wChannel2Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .check_channel3

	ld hl, wChannel2NoteDuration
	ld a, [hl]
	cp 1
	jr nz, .on

.check_channel3
	ld hl, wChannel3Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .check_channel4

	ld hl, wChannel3NoteDuration
	ld a, [hl]
	cp 1
	jr nz, .on

.check_channel4
	ld hl, wChannel4Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .off

	ld hl, wChannel4NoteDuration
	ld a, [hl]
	cp 1
	jr nz, .on

.off
	and a
	ret

.on
	scf
	ret

FadeMusic:
; Fade music if applicable
; usage:
;	write to wMusicFade
;	song fades out at the given rate
;	load song id in wMusicFadeID
;	fade new song in
; notes:
;	max # frames per volume level is $7f

	; Exit early if not fading
	ld a, [wMusicFade]
	and a
	ret z

	; If it doesn't have a count, assign it
	ld a, [wMusicFadeCount]
	and a
	jr z, .update

	; Count down
	dec a
	ld [wMusicFadeCount], a
	ret

.update
	ld a, [wMusicFade]
	ld d, a

	; Get new count
	and $7f
	ld [wMusicFadeCount], a

	; Get SO1 volume
	ld a, [wVolume]
	and VOLUME_SO1_LEVEL

	; Which way are we fading?
	bit MUSIC_FADE_IN_F, d
	jr nz, .fadein

	; Decrement volume
	and a
	jr z, .novolume
	dec a
	jr .updatevolume

.novolume
	; Fade in new song
	ld a, [wMusicFadeID]
	ld e, a
	ld a, [wMusicFadeID + 1]
	ld d, a
	push bc
	call _PlayMusic
	pop bc
	ld hl, wMusicFade
	set 7, [hl]
	ret

.fadein
	; Increment volume
	cp MAX_VOLUME & $f
	jr nc, .maxvolume
	inc a
	jr .updatevolume

.maxvolume
	; Clear wMusicFade
	xor a
	ld [wMusicFade], a
	ret

.updatevolume
	; Set the current volume for both speakers
	ld d, a
	swap a
	or d
	ld [wVolume], a
	ret

DoSweepingFade::
; performs a sweeping fade effect starting from the
; left channel, then the right, then repeats

	ld a, [wSweepingFadeIndex]
	and a
	ret z

; first nybble of wSweepingFadeIndex is the subroutine index
; second is the fade length
	swap a
	and 7
	ld e, a
	ld d, 0
	ld hl, .jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.jumptable
	dw .DoFade1
	dw .DoFade2
	dw .DoFade3
	dw .DoFade4
	dw .DoFade5
	dw .DoFade6
	dw .DoFade1
	dw .DoFade1

.DoFade1:
	ld a, 1
	call .SetIndex
	xor a
	ld [wSweepingFadeCounter], a
	ld [wVolume], a

.DoFade2:
	call .LeftChannel
	call .DecrementCounter
	ret nc
	call .IncreaseVolume
	ret nc
	ld a, 2
	call .SetIndex

.DoFade3:
	call .LeftChannel
	call .DecrementCounter
	ret nc
	call .DecreaseVolume
	ret nc
	ld a, 3
	call .SetIndex

.DoFade4:
	call .RightChannel
	call .DecrementCounter
	ret nc
	call .IncreaseVolume
	ret nc
	ld a, 4
	call .SetIndex
.DoFade5:
	call .RightChannel
	call .DecrementCounter
	ret nc
	call .DecreaseVolume
	ret nc
	ld a, 0
	call .SetIndex
	ret

.DoFade6:
	xor a
	ld [wSweepingFadeIndex], a
	ld a, $77
	ld [wVolume], a
	ret

.SetIndex:
	swap a
	ld d, a
	ld a, [wSweepingFadeIndex]
	and $f
	or d
	ld [wSweepingFadeIndex], a
	ret

.DecrementCounter:
	ld a, [wSweepingFadeCounter]
	and a
	jr z, .reset_counter
	dec a
	ld [wSweepingFadeCounter], a
	and a
	ret
 .reset_counter
	ld a, [wSweepingFadeIndex]
	and $f
	ld [wSweepingFadeCounter], a
	scf
	ret

.IncreaseVolume:
	ld a, [wVolume]
	and 7
	cp 7
	jr nc, .max_volume
	inc a
	ld d, a
	swap a
	or d
	ld [wVolume], a
	and a
	ret
.max_volume
	scf
	ret

.DecreaseVolume:
	ld a, [wVolume]
	and $f
	jr z, .min_volume
	dec a
	ld d, a
	swap a
	or d
	ld [wVolume], a
	and a
	ret
.min_volume
	scf
	ret

.LeftChannel:
	call IsAnySFXOn
	ret c
	ld a, [wSoundOutput]
	and $f0
	ld [wSoundOutput], a
	ret

.RightChannel:
	call IsAnySFXOn
	ret c
	ld a, [wSoundOutput]
	and $0f
	ld [wSoundOutput], a
	ret

Call_03a_44fe:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	bit SOUND_PITCH_WHEEL, [hl]
	call nz, .pitch_wheel
	bit SOUND_VIBRATO, [hl]
	call nz, .vibrato
	bit SOUND_UNKN_0E, [hl]
	call nz, .flag_0e
	bit SOUND_UNKN_0D, [hl]
	call nz, .flag_0d
	bit SOUND_UNKN_0B, [hl]
	call nz, .flag_0b
	ret

.pitch_wheel:
	push hl
	ld hl, CHANNEL_NOTE_DURATION
	add hl, bc
	ld a, [hl]
	ld hl, wc196
	sub [hl]
	jr nc, .jr_03a_452a

	ld a, $01

.jr_03a_452a
	ld [hl], a
	ld hl, $0010
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0021
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	ld a, d
	sbc $00
	ld d, a
	ld hl, $0022
	add hl, bc
	sub [hl]
	jr nc, .jr_03a_4565

	ld hl, $0005
	add hl, bc
	set 1, [hl]
	ld hl, $0010
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0021
	add hl, bc
	ld a, [hl]
	sub e
	ld e, a
	ld a, d
	sbc $00
	ld d, a
	ld hl, $0022
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	jr .jr_03a_4583

.jr_03a_4565
	ld hl, $0005
	add hl, bc
	res 1, [hl]
	ld hl, $0010
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0021
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	ld a, d
	sbc $00
	ld d, a
	ld hl, $0022
	add hl, bc
	sub [hl]
	ld d, a

.jr_03a_4583
	push bc
	ld hl, wc196
	ld b, $00

.jr_03a_4589
	inc b
	ld a, e
	sub [hl]
	ld e, a
	jr nc, .jr_03a_4589

	ld a, d
	and a
	jr z, .jr_03a_4596

	dec d
	jr .jr_03a_4589

.jr_03a_4596
	ld a, e
	add [hl]
	ld d, b
	pop bc
	ld hl, $0023
	add hl, bc
	ld [hl], d
	ld hl, $0024
	add hl, bc
	ld [hl], a
	ld hl, $0025
	add hl, bc
	xor a
	ld [hl], a
	pop hl
	ret


.vibrato:
	push hl
	ld hl, $001e
	add hl, bc
	ld a, [hl]
	ld hl, $001d
	add hl, bc
	ld [hl], a
	pop hl
	ret


.flag_0e:
	push hl
	ld hl, $0005
	add hl, bc
	res 2, [hl]
	pop hl
	ret


.flag_0d:
	push hl
	ld hl, $002b
	add hl, bc

.Call_03a_45c7:
	xor a
	ld [hl], a
	pop hl
	ret


.flag_0b:
	push hl
	ld hl, $002c
	add hl, bc
	ld a, [hl]
	ld hl, $0026
	add hl, bc
	ld [hl], a

.Call_03a_45d6:
	pop hl
	ret


Functione85d8::
	ld hl, $0004
	add hl, bc
	bit 2, [hl]
	call nz, Call_03a_4605
	bit 6, [hl]
	call nz, Call_03a_472b
	bit 4, [hl]
	call nz, Call_03a_4713
	bit 1, [hl]
	call nz, Call_03a_461b
	bit 0, [hl]
	call nz, Call_03a_46ad
	bit 5, [hl]
	call nz, Call_03a_475e
	bit 3, [hl]
	call nz, Call_03a_46ff
	bit 7, [hl]
	call nz, Call_03a_47bb
	ret


Call_03a_4605:
	push hl
	ld hl, $001c
	add hl, bc
	ld a, [hl]
	rlca
	rlca
	ld [hl], a
	and $c0
	ld [wCurTrackDuty], a
	ld hl, $000c
	add hl, bc
	set 0, [hl]
	pop hl
	ret


Call_03a_461b:
	push hl
	ld hl, $0010
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0005
	add hl, bc
	bit 1, [hl]
	jr z, .jr_03a_465e

	ld hl, $0023
	add hl, bc
	ld l, [hl]
	ld h, $00
	add hl, de
	ld d, h
	ld e, l
	ld hl, $0024
	add hl, bc
	ld a, [hl]
	ld hl, $0025
	add hl, bc
	add [hl]
	ld [hl], a
	ld a, $00
	adc e
	ld e, a
	ld a, $00
	adc d
	ld d, a
	ld hl, $0022
	add hl, bc
	ld a, [hl]
	cp d
	jp c, .Jump_03a_468b

	jr nz, .jr_03a_469e

	ld hl, $0021
	add hl, bc
	ld a, [hl]
	cp e
	jp c, .Jump_03a_468b

	jr .jr_03a_469e

.jr_03a_465e
	ld a, e
	ld hl, $0023
	add hl, bc
	ld e, [hl]
	sub e
	ld e, a
	ld a, d
	sbc $00
	ld d, a
	ld hl, $0024
	add hl, bc
	ld a, [hl]
	add a
	ld [hl], a
	ld a, e
	sbc $00
	ld e, a
	ld a, d
	sbc $00
	ld d, a
	ld hl, $0022
	add hl, bc
	ld a, d
	cp [hl]
	jr c, .jr_03a_468b

	jr nz, .jr_03a_469e

	ld hl, $0021
	add hl, bc
	ld a, e
	cp [hl]
	jr nc, .jr_03a_469e

.Jump_03a_468b
.jr_03a_468b
	ld hl, $0004
	add hl, bc
	res 1, [hl]
	ld hl, $0005
	add hl, bc
	res 1, [hl]
	ld hl, $0022
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]

.jr_03a_469e
	ld hl, $0010
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, $000c
	add hl, bc
	set 1, [hl]
	pop hl
	ret


Call_03a_46ad:
	push hl
	ld hl, $001d
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .jr_03a_46bf

	ld hl, $0020
	add hl, bc
	ld a, [hl]
	and $0f
	jr z, .jr_03a_46c2

.jr_03a_46bf
	dec [hl]
	jr .jr_03a_46fd

.jr_03a_46c2
	ld a, [hl]
	swap [hl]
	or [hl]
	ld [hl], a
	ld hl, $001f
	add hl, bc
	ld a, [hl]
	and a
	jr z, .jr_03a_46fd

	ld hl, $0005
	add hl, bc
	bit 0, [hl]
	jr z, .jr_03a_46e5

	res 0, [hl]
	and $0f
	ld d, a
	ld a, [wCurTrackFrequency]
	sub d
	jr nc, .jr_03a_46f4

	xor a
	jr .jr_03a_46f4

.jr_03a_46e5
	set 0, [hl]
	and $f0
	swap a
	ld d, a
	ld a, [wCurTrackFrequency]
	add d
	jr nc, .jr_03a_46f4

	ld a, $ff

.jr_03a_46f4
	ld [wCurTrackFrequency], a
	ld hl, $000c
	add hl, bc
	set 1, [hl]

.jr_03a_46fd
	pop hl
	ret


Call_03a_46ff:
	push hl
	ld hl, $0026
	add hl, bc
	ld a, [hl]
	and a
	jr z, .jr_03a_470b

	dec [hl]
	jr .jr_03a_4711

.jr_03a_470b
	ld hl, $000c
	add hl, bc
	set 5, [hl]

.jr_03a_4711
	pop hl
	ret


Call_03a_4713:
	push hl
	ld hl, $0027
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wCurTrackFrequency
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ret


Call_03a_472b:
	push hl
	ld hl, $0005
	add hl, bc
	bit 2, [hl]
	jr nz, .jr_03a_4738

	set 2, [hl]
	jr .jr_03a_4756

.jr_03a_4738
	res 2, [hl]
	ld hl, $0012
	add hl, bc
	ld a, [hl]
	and a
	jr z, .jr_03a_4756

	ld hl, $0029
	add hl, bc
	add [hl]
	ld e, a
	ld hl, $0013
	add hl, bc
	ld d, [hl]
	call Call_03a_4c84
	ld hl, wCurTrackFrequency
	ld [hl], e
	inc hl
	ld [hl], d

.jr_03a_4756
	ld hl, $000c
	add hl, bc
	set 1, [hl]
	pop hl
	ret


Call_03a_475e:
	push hl
	ld hl, $002a
	add hl, bc
	ld e, [hl]
	ld d, $00
	ld a, [wCurChannel]
	and $03
	cp $02
	jr nz, .jr_03a_4780

	ld hl, $5125
	call Call_03a_479b
	jr c, .jr_03a_4788

	ld d, a
	ld a, [wCurTrackIntensity]
	and $c0
	or d
	jr .jr_03a_4790

.jr_03a_4780
	ld hl, $5140
	call Call_03a_479b
	jr nc, .jr_03a_4790

.jr_03a_4788
	ld hl, $000c
	add hl, bc
	set 5, [hl]
	pop hl
	ret


.jr_03a_4790
	ld [wCurTrackIntensity], a
	ld hl, $000c
	add hl, bc
	set 2, [hl]
	pop hl
	ret


Call_03a_479b:
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $002b
	add hl, bc
	push hl
	ld l, [hl]
	ld h, $00
	add hl, de
	ld a, [hl]
	pop hl
	cp $ff
	jr z, .jr_03a_47b9

	cp $fe
	jr nz, .jr_03a_47b6

	xor a
	ld [hl], a
	ld a, [de]

.jr_03a_47b6
	inc [hl]
	and a
	ret


.jr_03a_47b9
	scf
	ret


Call_03a_47bb:
	ld hl, $002e
	add hl, bc
	ld a, [hl]
	and a
	jr z, .jr_03a_47cf

	dec [hl]
	ld hl, $0030
	add hl, bc
	ld a, [hl]
	ld hl, $001b
	add hl, bc
	ld [hl], a
	ret


.jr_03a_47cf
	ld hl, $002f
	add hl, bc
	ld a, [hl]
	and a
	jr z, .jr_03a_47e6

	dec [hl]
	ld hl, $0030
	add hl, bc
	ld a, [hl]
	swap a
	or [hl]
	ld hl, $001b
	add hl, bc
	ld [hl], a
	ret


.jr_03a_47e6
	ld hl, $0030
	add hl, bc
	ld a, [hl]
	swap a
	ld hl, $001b
	add hl, bc
	ld [hl], a
	ld hl, $0004
	add hl, bc
	res 7, [hl]
	ret


Functione87f9::
	ld hl, $0003
	add hl, bc
	bit 4, [hl]
	ret z

	ld a, [wc1a1]
	and a
	jr z, .jr_03a_480b

	dec a
	ld [wc1a1], a
	ret


.jr_03a_480b
	ld hl, wc19f
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [de]
	inc de
	cp $ff
	jr z, .jr_03a_4838

	and $0f
	inc a
	ld [wc1a1], a
	ld a, [de]
	inc de
	ld [wCurTrackIntensity], a
	ld a, [de]
	inc de
	ld [wCurTrackFrequency], a
	xor a
	ld [wCurTrackFrequency + 1], a
	ld hl, wc19f
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, $000c
	add hl, bc
	set 4, [hl]
	ret


.jr_03a_4838
	ret


Functione8839::
	ld a, [wSFXPriority]
	and a
	ret z

	ld a, [wCurChannel]
	cp $04
	ret nc

	call IsAnySFXOn
	ret nc

	ld hl, $000c
	add hl, bc
	set 5, [hl]
	ret


Functione884f::
	call Call_03a_4c65
	cp $ff
	jr z, .jr_03a_4876

	cp $d0
	jr nc, .jr_03a_489a

	ld hl, $0003
	add hl, bc
	bit 3, [hl]
	jr nz, .jr_03a_486e

	bit 5, [hl]
	jr nz, .jr_03a_486e

	bit 4, [hl]
	jr nz, .jr_03a_4872

	call Call_03a_48be
	ret


.jr_03a_486e
	call Call_03a_48f5
	ret


.jr_03a_4872
	call Call_03a_4922
	ret


.jr_03a_4876
	ld hl, $0003
	add hl, bc
	bit 1, [hl]
	jr nz, .jr_03a_489a

	call IsChannelSFXOn
	jr nc, .jr_03a_4896

	ld hl, $0003
	add hl, bc
	bit 5, [hl]
	call nz, Call_03a_489f
	ld a, [wCurChannel]
	cp $04
	jr nz, .jr_03a_4896

	xor a
	ldh [rNR10], a

.jr_03a_4896
	call StopChannel
	ret


.jr_03a_489a
	call Call_03a_4958
	jr Functione884f

Call_03a_489f:
	ld a, [wCurChannel]
	cp $04
	ret nz

	xor a
	ld hl, wChannel6CryPitch
	ld [hli], a
	ld [hl], a
	ld hl, wChannel8CryPitch
	ld [hli], a
	ld [hl], a
	ld a, [wLastVolume]
	ld [wVolume], a
	xor a
	ld [wLastVolume], a
	ld [wSFXPriority], a
	ret


Call_03a_48be:
	ld a, [wCurMusicByte]
	and $0f
	call Call_03a_4cb4
	ld a, [wCurMusicByte]
	swap a
	and $0f
	jr z, .jr_03a_48ee

	ld hl, $0012
	add hl, bc
	ld [hl], a
	ld e, a
	ld hl, $0013
	add hl, bc
	ld d, [hl]
	call Call_03a_4c84
	ld hl, $0010
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, $000c
	add hl, bc
	set 4, [hl]
	call Call_03a_44fe
	ret


.jr_03a_48ee
	ld hl, $000c
	add hl, bc
	set 5, [hl]
	ret


Call_03a_48f5:
	ld hl, $000c
	add hl, bc
	set 4, [hl]
	ld a, [wCurMusicByte]
	call Call_03a_4cb4
	call Call_03a_4c65
	ld hl, $000f
	add hl, bc
	ld [hl], a
	call Call_03a_4c65
	ld hl, $0010
	add hl, bc
	ld [hl], a
	ld a, [wCurChannel]
	and $03
	cp $03
	ret z

	call Call_03a_4c65
	ld hl, $0011
	add hl, bc
	ld [hl], a
	ret


Call_03a_4922:
	ld a, [wCurChannel]
	cp $03
	ret nz

	ld a, [wCurMusicByte]
	and $0f
	call Call_03a_4cb4
	ld a, [wc1a3]
	ld e, a
	ld d, $00
	ld hl, $51f4
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurMusicByte]
	swap a
	and $0f
	ret z

	ld e, a
	ld d, $00
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wc19f], a
	ld a, [hl]
	ld [wc1a0], a
	xor a
	ld [wc1a1], a
	ret


Call_03a_4958:
	ld a, [wCurMusicByte]
	sub $d0
	ld e, a
	ld d, $00
	ld hl, $4969
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl


	jp nc, $d24b

	ld c, e

	db $d2, $4b, $d2, $4b, $d2, $4b, $d2, $4b, $d2, $4b

	db $d2
	ld c, e

	db $8f, $4b

	db $dd
	ld c, e

	db $c6, $4b, $b0, $4b

	cp l
	ld c, e

	db $a3, $4b

	ld b, [hl]
	ld c, e
	ld l, l
	ld c, e

	db $fd, $4a, $cb, $4a

	cp h
	ld c, d

	db $7b, $4b

	db $ec
	ld c, e

	db $f9, $4b

	inc h
	ld c, e
	scf
	ld c, e
	ld e, [hl]
	ld c, e
	ld [$2f4c], sp
	ld c, h
	ld d, a
	ld c, h
	inc h
	ld c, h
	ld a, [hli]
	ld c, h
	add a
	ld c, d
	and $4b
	ret


	ld c, c
	ret


	ld c, c
	ret


	ld c, c
	ret


	ld c, c
	ret


	ld c, c
	ret


	ld c, c
	ret


	ld c, c
	ret


	ld c, c
	ret


	ld c, c

	db $b6, $4a

	ld d, a
	ld c, d
	ld h, b
	ld c, d
	dec b
	ld c, d

	db $15, $4a, $df, $49, $ca, $49

	ret


	ld hl, $0003
	add hl, bc
	res 1, [hl]
	ld hl, $0008
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0006
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret


	call Call_03a_4c65
	ld e, a
	call Call_03a_4c65
	ld d, a
	push de
	ld hl, $0006
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0008
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	ld hl, $0006
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, $0003
	add hl, bc
	set 1, [hl]
	ret


	call Call_03a_4c65
	ld e, a
	call Call_03a_4c65
	ld d, a
	ld hl, $0006
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret


	call Call_03a_4c65
	ld hl, $0003
	add hl, bc
	bit 2, [hl]
	jr nz, .jr_03a_4a2b

	and a
	jr z, .jr_03a_4a34

	dec a
	set 2, [hl]
	ld hl, $0018
	add hl, bc
	ld [hl], a

.jr_03a_4a2b
	ld hl, $0018
	add hl, bc
	ld a, [hl]
	and a
	jr z, .jr_03a_4a44

	dec [hl]

.jr_03a_4a34
	call Call_03a_4c65
	ld e, a
	call Call_03a_4c65
	ld d, a
	ld hl, $0006
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret


.jr_03a_4a44
	ld hl, $0003
	add hl, bc
	res 2, [hl]
	ld hl, $0006
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret


	call Call_03a_4c65
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret


	call Call_03a_4c65
	ld hl, $000d
	add hl, bc
	cp [hl]
	jr z, .jr_03a_4a77

	ld hl, $0006
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret


.jr_03a_4a77
	call Call_03a_4c65
	ld e, a
	call Call_03a_4c65
	ld d, a
	ld hl, $0006
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret


	ld a, [wCurChannel]
	and $03
	ld e, a
	ld d, $00
	ld hl, wChannel1JumpCondition
	add hl, de
	ld a, [hl]
	and a
	jr nz, .jr_03a_4aa4

	ld hl, $0006
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret


.jr_03a_4aa4
	ld [hl], $00
	call Call_03a_4c65
	ld e, a
	call Call_03a_4c65
	ld d, a
	ld hl, $0006
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret


	ld a, $01
	ld [wc1b3], a
	ret


	call Call_03a_4c65
	ld hl, $002c
	add hl, bc
	ld [hl], a
	ld hl, $0004
	add hl, bc
	set 3, [hl]
	ret


	ld hl, $0004
	add hl, bc
	set 0, [hl]
	res 0, [hl]
	call Call_03a_4c65
	ld hl, $001e
	add hl, bc
	ld [hl], a
	call Call_03a_4c65
	ld hl, $001f
	add hl, bc
	ld d, a
	and $f0
	swap a
	srl a
	ld e, a
	adc $00
	swap a
	or e
	ld [hl], a
	ld hl, $0020
	add hl, bc
	ld a, d
	and $0f
	ld d, a
	swap a
	or d
	ld [hl], a
	ret


	call Call_03a_4c65
	ld [wc196], a
	call Call_03a_4c65
	ld d, a
	and $0f
	ld e, a
	ld a, d
	swap a
	and $0f
	ld d, a
	call Call_03a_4c84
	ld hl, $0021
	add hl, bc
	ld [hl], e
	ld hl, $0022
	add hl, bc
	ld [hl], d
	ld hl, $0004
	add hl, bc
	set 1, [hl]

Jump_03a_4b23:
	ret


	ld hl, $0004
	add hl, bc
	set 4, [hl]
	ld hl, $0028
	add hl, bc
	call Call_03a_4c65
	ld [hld], a
	call Call_03a_4c65
	ld [hl], a
	ret


	ld hl, $0004
	add hl, bc
	set 6, [hl]
	call Call_03a_4c65
	ld hl, $0029
	add hl, bc
	ld [hl], a
	ret


	ld hl, $0004
	add hl, bc
	set 2, [hl]
	call Call_03a_4c65
	rrca
	rrca
	ld hl, $001c
	add hl, bc
	ld [hl], a
	and $c0
	ld hl, $000e
	add hl, bc
	ld [hl], a
	ret


	ld hl, $0004
	add hl, bc
	set 5, [hl]
	call Call_03a_4c65
	ld hl, $002a
	add hl, bc
	ld [hl], a
	ret


	ld hl, $0003
	add hl, bc
	bit 3, [hl]
	jr z, .jr_03a_4b78

	res 3, [hl]
	ret


.jr_03a_4b78
	set 3, [hl]
	ret


	ld hl, $0003
	add hl, bc
	bit 4, [hl]
	jr z, .jr_03a_4b86

	res 4, [hl]
	ret


.jr_03a_4b86
	set 4, [hl]
	call Call_03a_4c65
	ld [wc1a3], a
	ret


	call Call_03a_4c65
	ld hl, $002d
	add hl, bc
	ld [hl], a
	ld a, [wCurChannel]
	and $03
	cp $03
	ret z

	call Call_03a_4bbd
	ret


	call Call_03a_4c65
	ld [wPitchSweep], a
	ld hl, $000c
	add hl, bc
	set 3, [hl]
	ret


	call Call_03a_4c65
	rrca
	rrca
	and $c0
	ld hl, $000e
	add hl, bc
	ld [hl], a
	ret


Call_03a_4bbd:
	call Call_03a_4c65
	ld hl, $000f
	add hl, bc
	ld [hl], a
	ret


	call Call_03a_4c65
	ld d, a
	call Call_03a_4c65
	ld e, a
	call SetGlobalTempo
	ret


	ld hl, $0013
	add hl, bc
	ld a, [wCurMusicByte]
	and $07
	ld [hl], a
	ret


	call Call_03a_4c65
	ld hl, $0014
	add hl, bc
	ld [hl], a
	ret


	ld a, [wce5f]
	bit 5, a
	ret z

	call SetLRTracks
	call Call_03a_4c65
	ld hl, $001b
	add hl, bc
	and [hl]
	ld [hl], a
	ret


	call Call_03a_4c65
	ld a, [wMusicFade]
	and a
	ret nz

	ld a, [wCurMusicByte]
	ld [wVolume], a
	ret


	call Call_03a_4c65
	ld e, a
	cp $80
	jr nc, .jr_03a_4c14

	ld d, $00
	jr .jr_03a_4c16

.jr_03a_4c14
	ld d, $ff

.jr_03a_4c16
	ld hl, $0019
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	call SetGlobalTempo
	ret


	ld a, $01
	ld [wSFXPriority], a
	ret


	xor a
	ld [wSFXPriority], a
	ret


	ld hl, $0000
	add hl, bc
	ld a, [hli]
	ld [wMusicID], a
	ld a, [hl]
	ld [wMusicID + 1], a
	ld hl, $0002
	add hl, bc
	ld a, [hl]
	ld [wMusicBank], a
	call Call_03a_4c65
	ld l, a
	call Call_03a_4c65
	ld h, a
	ld e, [hl]
	inc hl
	ld d, [hl]
	push bc
	call LoadChannel
	call StartChannel
	pop bc
	ret


	call Call_03a_4c65
	ld e, a
	call Call_03a_4c65
	ld d, a
	push bc
	call _PlayMusic
	pop bc
	ret


Call_03a_4c65:
	push hl
	push de
	ld hl, $0006
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0002
	add hl, bc
	ld a, [hl]
	call _LoadMusicByte
	ld [wCurMusicByte], a
	inc de
	ld hl, $0006
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	pop hl
	ret


Call_03a_4c84:
	ld hl, $0014
	add hl, bc
	ld a, [hl]
	swap a
	and $0f
	add d
	push af
	ld hl, $0014
	add hl, bc
	ld a, [hl]
	and $0f
	ld l, a
	ld d, $00
	ld h, d
	add hl, de
	add hl, hl
	ld de, $4f73
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop af

.jr_03a_4ca4
	cp $07
	jr nc, .jr_03a_4caf

	sra d
	rr e
	inc a
	jr .jr_03a_4ca4

.jr_03a_4caf
	ld a, d
	and $07
	ld d, a
	ret


Call_03a_4cb4:
	inc a
	ld e, a
	ld d, $00
	ld hl, $002d
	add hl, bc
	ld a, [hl]
	ld l, $00
	call Call_03a_4cdf
	ld a, l
	ld hl, $0019
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0016
	add hl, bc
	ld l, [hl]
	call Call_03a_4cdf
	ld e, l
	ld d, h
	ld hl, $0016
	add hl, bc
	ld [hl], e
	ld hl, $0015
	add hl, bc
	ld [hl], d
	ret


Call_03a_4cdf:
	ld h, $00

.jr_03a_4ce1
	srl a
	jr nc, .jr_03a_4ce6

	add hl, de

.jr_03a_4ce6
	sla e
	rl d
	and a
	jr nz, .jr_03a_4ce1

	ret

SetGlobalTempo:
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

Tempo:
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	xor a
	ld hl, CHANNEL_FIELD16
	add hl, bc
	ld [hl], a
	ret


StartChannel:
	call SetLRTracks
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	set SOUND_CHANNEL_ON, [hl]
	ret


StopChannel:
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	res SOUND_CHANNEL_ON, [hl]
	ld hl, CHANNEL_MUSIC_ID
	add hl, bc
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret


SetLRTracks:
	push de
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	ld e, a
	ld d, 0
	ld hl, Data_03a_52b3
	add hl, de
	ld a, [hl]
	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld [hl], a
	pop de
	ret


_PlayMusic::
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
	ld [wc1b3], a
	ld [wChannel1JumpCondition], a
	ld [wChannel2JumpCondition], a
	ld [wChannel3JumpCondition], a
	ld [wChannel4JumpCondition], a
	ret


_PlayCryHeader::
	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, CryHeaderPointers
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
	and $03
	inc a

.jr_03a_4db8
	push af
	call LoadChannel
	ld hl, $0003
	add hl, bc
	set 5, [hl]
	ld hl, $0004
	add hl, bc
	set 4, [hl]
	ld hl, $0027
	add hl, bc
	ld a, [wCryPitch]
	ld [hli], a
	ld a, [wCryPitch + 1]
	ld [hl], a
	ld a, [wCurChannel]
	and $03
	cp $03
	jr nc, .jr_03a_4de9

	ld hl, $0019
	add hl, bc
	ld a, [wCryLength]
	ld [hli], a
	ld a, [wCryLength + 1]
	ld [hl], a

.jr_03a_4de9
	call StartChannel
	ld a, [wc1b9]
	and a
	jr z, .jr_03a_4e07

	ld a, [wce5f]
	bit 5, a
	jr z, .jr_03a_4e07

	ld hl, $001b
	add hl, bc
	ld a, [hl]
	ld hl, wc1ba
	and [hl]
	ld hl, $001b
	add hl, bc
	ld [hl], a

.jr_03a_4e07
	pop af
	dec a
	jr nz, .jr_03a_4db8

	ld a, [wLastVolume]
	and a
	jr nz, .jr_03a_4e1c

	ld a, [wVolume]
	ld [wLastVolume], a
	ld a, $77
	ld [wVolume], a

.jr_03a_4e1c
	ld a, $01
	ld [wSFXPriority], a
	ret


_PlaySFX::
	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, $536d
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
	and $03
	inc a

.jr_03a_4e3d
	push af
	call LoadChannel
	ld hl, $0003
	add hl, bc
	set 3, [hl]
	call StartChannel
	pop af
	dec a
	jr nz, .jr_03a_4e3d

	ret


	ld a, [wce5f]
	bit 5, a
	jr z, _PlaySFX

	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, $536d
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
	and $03
	inc a

.jr_03a_4e71
	push af
	call LoadChannel
	ld hl, $0003
	add hl, bc
	set 3, [hl]
	push de
	ld a, [wCurChannel]
	and $03
	ld e, a
	ld d, $00
	ld hl, $52b3
	add hl, de
	ld a, [hl]
	ld hl, wc1b9
	and [hl]
	ld hl, $001b
	add hl, bc
	ld [hl], a
	ld hl, $0030
	add hl, bc
	ld [hl], a
	ld a, [wc1ba]
	cp $02
	jr c, .jr_03a_4eb1

	ld a, [wc1bb]
	ld hl, $002e
	add hl, bc
	ld [hl], a
	ld hl, $002f
	add hl, bc
	ld [hl], a
	ld hl, $0004
	add hl, bc
	set 7, [hl]

.jr_03a_4eb1
	pop de
	ld hl, $0003
	add hl, bc
	set 0, [hl]
	pop af
	dec a
	jr nz, .jr_03a_4e71

	ret


	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, $536d
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
	and $03
	inc a

.jr_03a_4ed8
	push af
	call LoadChannel
	ld hl, $0003
	add hl, bc
	set 3, [hl]
	ld hl, $0004
	add hl, bc
	set 4, [hl]
	ld hl, $0027
	add hl, bc
	ld a, [wCryPitch]
	ld [hli], a
	ld a, [wCryPitch + 1]
	ld [hl], a
	ld a, [wCurChannel]
	and $03
	cp $03
	jr nc, .jr_03a_4f09

	ld hl, $0019
	add hl, bc
	ld a, [wCryLength]
	ld [hli], a
	ld a, [wCryLength + 1]
	ld [hl], a

.jr_03a_4f09
	call StartChannel
	pop af
	dec a
	jr nz, .jr_03a_4ed8

	ret


LoadChannel::
	call LoadMusicByte
	inc de
	and $07
	ld [wCurChannel], a
	ld c, a
	ld b, $00
	ld hl, $52b7
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, $0003
	add hl, bc
	res 0, [hl]
	call Call_03a_4f51
	ld hl, $0006
	add hl, bc
	call LoadMusicByte
	ld [hli], a
	inc de
	call LoadMusicByte
	ld [hl], a
	inc de
	ld hl, $0000
	add hl, bc
	ld a, [wMusicID]
	ld [hli], a
	ld a, [wMusicID + 1]
	ld [hl], a
	ld hl, $0002
	add hl, bc
	ld a, [wMusicBank]
	ld [hl], a
	ret


Call_03a_4f51:
	push de
	xor a
	ld hl, $0000
	add hl, bc
	ld e, $32

.jr_03a_4f59
	ld [hli], a
	dec e
	jr nz, .jr_03a_4f59

	ld hl, $0019
	add hl, bc
	xor a
	ld [hli], a
	inc a
	ld [hl], a
	ld hl, $002d
	add hl, bc
	ld [hl], a
	pop de
	ret


LoadMusicByte::
	ld a, [wMusicBank]
	call _LoadMusicByte
	ret

Data_4f73:
	db $00, $00, $2C, $F8, $9D, $F8, $07, $F9, $6B, $F9, $CA, $F9, $23, $FA, $77, $FA, $C7, $FA, $12, $FB, $58, $FB, $9B, $FB, $DA, $FB, $16, $FC, $4E, $FC, $83, $FC, $B5, $FC, $E5, $FC, $11, $FD, $3B, $FD, $63, $FD, $89, $FD, $AC, $FD, $CD, $FD, $ED, $FD

WaveSamples:
	db $02, $46, $8A, $CE, $FF, $FE, $ED, $DC, $CB, $A9, $87, $65, $44, $33, $22, $11 ; 0
	db $02, $46, $8A, $CE, $EF, $FF, $FE, $EE, $DD, $CB, $A9, $87, $65, $43, $22, $11 ; 1
	db $13, $69, $BD, $EE, $EE, $FF, $FF, $ED, $DE, $FF, $FF, $EE, $EE, $DB, $96, $31 ; 2
	db $02, $46, $8A, $CD, $EF, $FE, $DE, $FF, $EE, $DC, $BA, $98, $76, $54, $32, $10 ; 3
	db $01, $23, $45, $67, $8A, $CD, $EE, $F7, $7F, $EE, $DC, $A8, $76, $54, $32, $10 ; 4
	db $00, $23, $45, $67, $8A, $C7, $EE, $F7, $7F, $EE, $D7, $A8, $76, $54, $32, $14 ; 5
	db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $0F ; 6
	db $0F, $0F, $0E, $0E, $0D, $0D, $0C, $0C, $0B, $0B, $0A, $0A, $09, $09, $08, $08 ; 7
	db $07, $07, $06, $06, $05, $05, $04, $04, $03, $03, $02, $02, $01, $01, $00, $00 ; 8
	db $FF, $FF, $FF, $FF, $88, $88, $88, $88, $00, $00, $00, $00, $88, $88, $88, $88 ; 9
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00 ; a
	db $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $00, $00, $00, $00, $00, $00, $00, $00 ; b
	db $DD, $DD, $DD, $DD, $DD, $DD, $DD, $DD, $00, $00, $00, $00, $00, $00, $00, $00 ; c
	db $CC, $CC, $CC, $CC, $CC, $CC, $CC, $CC, $00, $00, $00, $00, $00, $00, $00, $00 ; d
	db $BB, $BB, $BB, $BB, $BB, $BB, $BB, $BB, $00, $00, $00, $00, $00, $00, $00, $00 ; e
	db $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $00, $00, $00, $00, $00, $00, $00, $00 ; f

Filler_03a_50a5:
	db $99, $99, $99, $99, $99, $99, $99, $99, $00, $00, $00, $00, $00, $00, $00, $00, $88, $88, $88, $88, $88, $88, $88, $88, $00, $00, $00, $00, $00, $00, $00, $00, $77, $77, $77, $77, $77, $77, $77, $77, $00, $00, $00, $00, $00, $00, $00, $00, $66, $66, $66, $66, $66, $66, $66, $66, $00, $00, $00, $00, $00, $00, $00, $00, $55, $55, $55, $55, $55, $55, $55, $55, $00, $00, $00, $00, $00, $00, $00, $00, $44, $44, $44, $44, $44, $44, $44, $44, $00, $00, $00, $00, $00, $00, $00, $00, $33, $33, $33, $33, $33, $33, $33, $33, $00, $00, $00, $00, $00, $00, $00, $00, $22, $22, $22, $22, $22, $22, $22, $22, $00, $00, $00, $00, $00, $00, $00, $00, $31, $51, $31, $51, $31, $51, $31, $51, $31, $51, $31, $51, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17, $FF, $4C, $51, $99, $51, $BA, $51, $E3, $51, $F4, $51, $F4, $51, $11, $21, $31, $41, $51, $61, $71, $81, $91, $A1, $B1, $C1, $D1, $E1, $F1, $F1, $F1, $F1, $F1, $F1, $E1, $E1, $E1, $E1, $D1, $D1, $D1, $D1, $C1, $C1, $C1, $C1, $B1, $B1, $B1, $B1, $A1, $A1, $A1, $A1, $91, $91, $91, $91, $81, $81, $81, $81, $71, $71, $71, $71, $61, $61, $61, $61, $51, $51, $51, $51, $41, $41, $41, $41, $31, $31, $31, $31, $21, $21, $21, $21, $11, $11, $11, $11, $FF, $11, $91, $D1, $F1, $F1, $F1, $F1, $F1, $D1, $D1, $D1, $D1, $A1, $A1, $A1, $A1, $81, $81, $81, $81, $61, $61, $61, $61, $41, $41, $41, $41, $21, $21, $21, $21, $FF, $31, $51, $A1, $51, $F1, $51, $F1, $51, $F1, $51, $F1, $51, $D1, $51, $D1, $51, $B1, $51, $B1, $51, $91, $51, $91, $51, $71, $51, $71, $51, $51, $51, $51, $51, $31, $51, $31, $51, $11, $51, $11, $51, $FF, $F0, $E0, $D0, $C0, $B0, $A0, $90, $80, $70, $60, $50, $40, $30, $20, $10, $00, $FF, $00, $52, $1A, $52, $34, $52, $4E, $52, $4E, $52, $4E, $52, $4E, $52, $4F, $52, $53, $52, $57, $52, $5B, $52, $5F, $52, $72, $52, $76, $52, $7D, $52, $81, $52, $85, $52, $89, $52, $8D, $52, $4E, $52, $7D, $52, $81, $52, $85, $52, $89, $52, $8D, $52, $91, $52, $95, $52, $99, $52, $A0, $52, $A7, $52, $AB, $52, $AF, $52, $4E, $52, $4F, $52, $A7, $52, $AB, $52, $AF, $52, $5F, $52, $72, $52, $76, $52, $7D, $52, $81, $52, $85, $52, $89, $52, $8D, $52, $FF, $20, $C1, $33, $FF, $20, $B1, $33, $FF, $20, $A1, $33, $FF, $20, $81, $33, $FF, $27, $84, $37, $26, $84, $36, $25, $83, $35, $24, $83, $34, $23, $82, $33, $22, $81, $32, $FF, $20, $51, $2A, $FF, $21, $41, $2B, $20, $61, $2A, $FF, $20, $81, $10, $FF, $20, $82, $23, $FF, $20, $82, $25, $FF, $20, $82, $26, $FF, $20, $A1, $10, $FF, $20, $A2, $11, $FF, $20, $A2, $50, $FF, $20, $A1, $18, $20, $31, $33, $FF, $22, $91, $28, $20, $71, $18, $FF, $20, $91, $22, $FF, $20, $71, $22, $FF, $20, $61, $22, $FF

Data_03a_52b3:
	db $11, $22, $44, $88, $00, $c0, $32, $c0, $64, $c0, $96, $c0, $c8, $c0, $fa, $c0
	db $2c, $c1, $5e, $c1


SECTION "audio/engine.asm@Song Header Pointers", ROMX

Music::
INCLUDE "audio/song_header_pointers.inc"
