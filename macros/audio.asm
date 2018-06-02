Ch0    EQU 0
Ch1    EQU 1
Ch2    EQU 2
Ch3    EQU 3
Ch4    EQU 4
Ch5    EQU 5
Ch6    EQU 6
Ch7    EQU 7

audio: MACRO
	db (_NARG - 2) << 6 | \2
	dw \1_\2
	IF _NARG > 2
		db \3
		dw \1_\3
	ENDC
	IF _NARG > 3
		db \4
		dw \1_\4
	ENDC
	IF _NARG > 4
		db \5
		dw \1_\5
	ENDC
ENDM

;format: length [0, 7], pitch change [-7, 7]
pitchenvelope: MACRO
	db $10
	IF \2 > 0
		db (\1 << 4) | \2
	ELSE
		db (\1 << 4) | (%1000 | (\2 * -1))
	ENDC
ENDM

;format: length [0, 15], volume [0, 15], volume change [-7, 7], pitch
squarenote: MACRO
	db $20 | \1
	IF \3 < 0
		db (\2 << 4) | (%1000 | (\3 * -1))
	ELSE
		db (\2 << 4) | \3
	ENDC
	dw \4
ENDM

;format: length [0, 15], volume [0, 15], volume change [-7, 7], pitch
noisenote: MACRO
	db $20 | \1
	IF \3 < 0
		db (\2 << 4) | (%1000 | (\3 * -1))
	ELSE
		db (\2 << 4) | \3
	ENDC
	db \4
ENDM

;format: rest length (in 16ths)
rest: MACRO
	db $00 | (\1 - 1)
ENDM

;format: pitch length (in 16ths)
C_: MACRO
	db $10 | (\1 - 1)
ENDM

C#: MACRO
	db $20 | (\1 - 1)
ENDM

D_: MACRO
	db $30 | (\1 - 1)
ENDM

D#: MACRO
	db $40 | (\1 - 1)
ENDM

E_: MACRO
	db $50 | (\1 - 1)
ENDM

F_: MACRO
	db $60 | (\1 - 1)
ENDM

F#: MACRO
	db $70 | (\1 - 1)
ENDM

G_: MACRO
	db $80 | (\1 - 1)
ENDM

G#: MACRO
	db $90 | (\1 - 1)
ENDM

A_: MACRO
	db $A0 | (\1 - 1)
ENDM

A#: MACRO
	db $B0 | (\1 - 1)
ENDM

B_: MACRO
	db $C0 | (\1 - 1)
ENDM

;format: instrument length (in 16ths)
snare1: MACRO
	db $10 | (\1 - 1)
ENDM

snare2: MACRO
	db $20 | (\1 - 1)
ENDM

snare3: MACRO
	db $30 | (\1 - 1)
ENDM

snare4: MACRO
	db $40 | (\1 - 1)
ENDM

snare5: MACRO
	db $50 | (\1 - 1)
ENDM

triangle1: MACRO
	db $60 | (\1 - 1)
ENDM

triangle2: MACRO
	db $70 | (\1 - 1)
ENDM

snare6: MACRO
	db $80 | (\1 - 1)
ENDM

snare7: MACRO
	db $90 | (\1 - 1)
ENDM

snare8: MACRO
	db $A0 | (\1 - 1)
ENDM

snare9: MACRO
	db $B0 | (\1 - 1)
ENDM

cymbal1: MACRO
	db $C0 | (\1 - 1)
ENDM

cymbal2: MACRO
	db $D0 | (\1 - 1)
ENDM

cymbal3: MACRO
	db $E0 | (\1 - 1)
ENDM

mutedsnare1: MACRO
	db $F0 | (\1 - 1)
ENDM

; TODO: clean up handling of drumsets
;triangle3: MACRO
;	db $10 | (\1 - 1)
;ENDM

;mutedsnare2: MACRO
;	db $11 | (\1 - 1)
;ENDM

;mutedsnare3: MACRO
;	db $12 | (\1 - 1)
;ENDM

;mutedsnare4: MACRO
;	db $13 | (\1 - 1)
;ENDM

octave: MACRO
	db $D8 - \1
ENDM

; format: notetype speed, volume, fade
notetype: MACRO
	db $D8
	db \1
	db (\2 << 4) | \3
ENDM

dspeed: MACRO
	db $D8
	db \1
ENDM

tempo: MACRO
	db $DA
	db \1 / $100
	db \1 % $100
ENDM

duty: MACRO
	db $DB
	db \1
ENDM

pitchbend: MACRO
	db $E0
	db \1
	db \2
ENDM

;format: vibrato delay, rate, depth
vibrato: MACRO
	db $E1
	db \1
	db (\2 << 4) | \3
ENDM

drumset: MACRO
	db $E3
	db \1
ENDM

volume: MACRO
	db $E5
	db (\1 << 4) | \2
ENDM

toggleperfectpitch: MACRO
	db $E6
ENDM

stereopanning: MACRO
	db $EE
	db \1
ENDM

;executemusic: MACRO
;	db $F8
;ENDM

unknown_f9: MACRO
	db $F9
ENDM

;dutycycle: MACRO
;	db $FC
;	db \1
;ENDM

;format: loopchannel count, address
loopchannel: MACRO
	db $FD
	db \1
	dw \2
ENDM

;format: callchannel address
callchannel: MACRO
	db $FE
	dw \1
ENDM

endchannel: MACRO
	db $FF
ENDM
