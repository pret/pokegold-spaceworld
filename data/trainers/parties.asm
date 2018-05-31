INCLUDE "constants.asm"

; Trainer data structure:
; - db "NAME@", TRAINERTYPE_* constant
; - 1 to 6 Pokémon:
;    * for TRAINERTYPE_NORMAL:     db level, species
;    * for TRAINERTYPE_ITEM:       db level, species, item
;    * for TRAINERTYPE_MOVES:      db level, species, 4 moves
;    * for TRAINERTYPE_ITEM_MOVES: db level, species, item, 4 moves
; - db -1 ; end


; TODO: decode all data

SECTION "Trainer Parties 1 TEMPORARY", ROMX[$51BF],BANK[$E]
AkaneGroup::
BugCatcherBoyGroup::
	; BUG_CATCHER_BOY_JUNICHI
	db "じゅんいち@", TRAINERTYPE_ITEM_MOVES
	db  7, DEX_PARAS, ITEM_NONE, MOVE_STUN_SPORE, MOVE_LEECH_LIFE, MOVE_NONE, MOVE_NONE
	db -1 ; end

	; BUG_CATCHER_BOY_SOUSUKE
	db "そうすけ@", TRAINERTYPE_ITEM_MOVES
	db  9, DEX_REDIBA, ITEM_NONE, MOVE_SCRATCH, MOVE_QUICK_ATTACK, MOVE_NONE, MOVE_NONE
	db -1 ; end

SECTION "Trainer Parties 2 TEMPORARY", ROMX[$52B4],BANK[$E]
MikanGroup::

SECTION "Trainer Parties 3 TEMPORARY", ROMX[$53BC],BANK[$E]
OkidoGroup::

SECTION "Trainer Parties 4 TEMPORARY", ROMX[$54B6],BANK[$E]
WataruGroup::

SECTION "Trainer Parties 5 TEMPORARY", ROMX[$54DC],BANK[$E]
GerugeMemberMGroup::

SECTION "Trainer Parties 6 TEMPORARY", ROMX[$54FA],BANK[$E]
Trio1Group::
BeautyGroup::
	; BEAUTY_MEGUMI
	db "めぐみ@", TRAINERTYPE_ITEM_MOVES
	db 10, DEX_NYARTH, ITEM_NONE, MOVE_PAY_DAY, MOVE_GROWL, MOVE_NONE, MOVE_NONE
	db -1 ; end

SECTION "Trainer Parties 7 TEMPORARY", ROMX[$55F4],BANK[$E]
FledglingGroup::

SECTION "Trainer Parties 8 TEMPORARY", ROMX[$56D7],BANK[$E]
PokeManiacGroup::

SECTION "Trainer Parties 9 TEMPORARY", ROMX[$57C5],BANK[$E]
GentlemanGroup::

SECTION "Trainer Parties 10 TEMPORARY", ROMX[$57E9],BANK[$E]
TeacherMGroup::

SECTION "Trainer Parties 11 TEMPORARY", ROMX[$57F5],BANK[$E]
TeacherFGroup::

SECTION "Trainer Parties 12 TEMPORARY", ROMX[$57FB],BANK[$E]
ManchildGroup::

SECTION "Trainer Parties 13 TEMPORARY", ROMX[$58CC],BANK[$E]
RockerGroup::

SECTION "Trainer Parties 14 TEMPORARY", ROMX[$58FB],BANK[$E]
HikerGroup::

SECTION "Trainer Parties 15 TEMPORARY", ROMX[$59A2],BANK[$E]
KimonoGirlGroup::
	; KIMONO_GIRL_TAMAO
	db "たまお@", TRAINERTYPE_ITEM_MOVES
	db 12, DEX_PURIN, ITEM_NONE, MOVE_CHARM, MOVE_ENCORE, MOVE_POUND, MOVE_NONE
	db -1 ; end

	; KIMONO_GIRL_KOUME
	db "こうめ@", TRAINERTYPE_ITEM_MOVES
	db 10, DEX_PIPPI, ITEM_NONE, MOVE_CHARM, MOVE_SWEET_KISS, MOVE_POUND, MOVE_NONE
	db -1 ; end

SECTION "Trainer Parties 16 TEMPORARY", ROMX[$518A],BANK[$E]
HayatoGroup::

SECTION "Trainer Parties 17 TEMPORARY", ROMX[$521A],BANK[$E]
TsukishiGroup::
LassGroup::

SECTION "Trainer Parties 18 TEMPORARY", ROMX[$526F],BANK[$E]
EnokiGroup::

SECTION "Trainer Parties 19 TEMPORARY", ROMX[$528F],BANK[$E]
OkeraGroup::

SECTION "Trainer Parties 20 TEMPORARY", ROMX[$533D],BANK[$E]
GamaGroup::

SECTION "Trainer Parties 21 TEMPORARY", ROMX[$554B],BANK[$E]
Trio2Group::

SECTION "Trainer Parties 22 TEMPORARY", ROMX[$555D],BANK[$E]
Trio3Group::

SECTION "Trainer Parties 23 TEMPORARY", ROMX[$567C],BANK[$E]
ProfessionalMGroup::
ProfessionalFGroup::

SECTION "Trainer Parties 24 TEMPORARY", ROMX[$581B],BANK[$E]
SwimmerMGroup::

SECTION "Trainer Parties 25 TEMPORARY", ROMX[$582A],BANK[$E]
SuperNerdGroup::

SECTION "Trainer Parties 26 TEMPORARY", ROMX[$583C],BANK[$E]
EngineerGroup::

SECTION "Trainer Parties 27 TEMPORARY", ROMX[$596E],BANK[$E]
JugglerGroup::

SECTION "Trainer Parties 28 TEMPORARY", ROMX[$597A],BANK[$E]
TwinsGroup::

SECTION "Trainer Parties 29 TEMPORARY", ROMX[$597F],BANK[$E]
SchoolboyGroup::
	; SCHOOLBOY_TETSUYA
	db "てつや@", TRAINERTYPE_ITEM_MOVES
	db  9, DEX_YADOKING, ITEM_NONE, MOVE_DISABLE, MOVE_CONFUSION, MOVE_NONE, MOVE_NONE
	db -1 ; end

SECTION "Trainer Parties 30 TEMPORARY", ROMX[$598C],BANK[$E]
FirebreatherGroup::
	; FIREBREATHER_AKITO
	db "あきと@", TRAINERTYPE_ITEM_MOVES
	db 10, DEX_BOOBY, ITEM_NONE, MOVE_SCRATCH, MOVE_SMOG, MOVE_NONE, MOVE_NONE
	db -1 ; end

SECTION "Trainer Parties 31 TEMPORARY", ROMX[$5320],BANK[$E]
BlueGroup::

SECTION "Trainer Parties 32 TEMPORARY", ROMX[$5375],BANK[$E]
RivalGroup::

SECTION "Trainer Parties 33 TEMPORARY", ROMX[$5404],BANK[$E]
SakakiGroup::

SECTION "Trainer Parties 34 TEMPORARY", ROMX[$5427],BANK[$E]
ProtagonistGroup::

SECTION "Trainer Parties 35 TEMPORARY", ROMX[$5433],BANK[$E]
SibaGroup::
KasumiGroup::
FisherGroup::

SECTION "Trainer Parties 36 TEMPORARY", ROMX[$5472],BANK[$E]
KannaGroup::

SECTION "Trainer Parties 37 TEMPORARY", ROMX[$5566],BANK[$E]
RocketFGroup::

SECTION "Trainer Parties 38 TEMPORARY", ROMX[$5587],BANK[$E]
YoungsterGroup::

SECTION "Trainer Parties 39 TEMPORARY", ROMX[$5658],BANK[$E]
ProdigyGroup::

SECTION "Trainer Parties 40 TEMPORARY", ROMX[$5795],BANK[$E]
RocketMGroup::

SECTION "Trainer Parties 41 TEMPORARY", ROMX[$5811],BANK[$E]
SwimmerFGroup::

SECTION "Trainer Parties 42 TEMPORARY", ROMX[$5820],BANK[$E]
SailorGroup::

SECTION "Trainer Parties 43 TEMPORARY", ROMX[$5907],BANK[$E]
BikerGroup::

SECTION "Trainer Parties 44 TEMPORARY", ROMX[$5956],BANK[$E]
RockClimberGroup::

SECTION "Trainer Parties 45 TEMPORARY", ROMX[$5962],BANK[$E]
BurglarGroup::

SECTION "Trainer Parties 46 TEMPORARY", ROMX[$5972],BANK[$E]
BlackbeltGroup::

SECTION "Trainer Parties 47 TEMPORARY", ROMX[$5976],BANK[$E]
PsychicGroup::
KungFuMasterGroup::
FortuneTellerGroup::
HooliganGroup::
SageGroup::
MediumGroup::
SoldierGroup::
GerugeMemberFGroup::

SECTION "Trainer Parties 48 TEMPORARY", ROMX[$5999],BANK[$E]
SportsmanGroup::
	; SPORTSMAN_SHIGEKI
	db "しげき@", TRAINERTYPE_ITEM
	db  8, DEX_DONPHAN, ITEM_NONE
	db -1 ; end
