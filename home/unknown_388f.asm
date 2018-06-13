include "constants.asm"

if DEBUG
SECTION "Unknown 388F", ROM0 [$388F]
else
SECTION "Unknown 388F", ROM0 [$3853]
endc


Function388f::
	ret

Function3890::
	callba Function14cac
	ret

Function3899::
	callba Function14dac
	ret

Function38a2::
	callba Function14dc4
	ret

Function38ab::
	callba Function14ddd
	ret

Function38b4::
	callba Function14e00
	ret

Function38bd::
	callba Function14e5f
	ret

Function38c6::
	callba Function14e27
	ret

Function38cf::
	callba Function14e4a
	ret

Function38d8::
	ld hl, wc5ed
	set 7, [hl]
	ld a, $8
	ld [wd637], a
	ret

Function38e3::
	ldh a, [hJoyState]
	and $f0
	ret z
	call Function3233
	jp nz, Function323e
	callab Function3ee3e
	ld a, [wBattleMode]
	and a
	ret z
	ld a, $3
	call WriteIntod637
	call Function3240
	ret

Function3904::
	predef Function3ef19
	ld a, $f3
	ldh [hMapEntryMethod], a
	ld hl, wd4a9
	set 5, [hl]
	ld hl, wJoypadFlags
	set 4, [hl]
	set 6, [hl]
	ld a, $b
	call WriteIntod637
	ret

Function391f::
	ret

Function3920::
	ld a, [wcd5d]
	cp $1
	jr z, .asm_392d
	ld a, $4
	call WriteIntod637
	ret

.asm_392d: ; 00:392d
	ld hl, wJoypadFlags
	res 4, [hl]
	ld hl, .text
	call PrintFieldText
	call RotateFourPalettesLeft
	jp Init

.text:
	text "つぎは　がんばるぞ！！"
	done
