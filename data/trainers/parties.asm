; Trainer data structure:
; - db "NAME@", TRAINERTYPE_* constant
; - 1 to 6 Pokémon:
;    * for TRAINERTYPE_NORMAL:     db level, species
;    * for TRAINERTYPE_ITEM:       db level, species, item
;    * for TRAINERTYPE_MOVES:      db level, species, 4 moves
;    * for TRAINERTYPE_ITEM_MOVES: db level, species, item, 4 moves
; - db -1 ; end


; TODO: decode data from the beginning

SECTION "TrainerGroups", ROMX[$5110],BANK[$E]
INCLUDE "data/trainers/party_pointers.asm"

SECTION "HayatoGroup", ROMX[$518A],BANK[$E]
HayatoGroup::

SECTION "AkaneGroup", ROMX[$51BF],BANK[$E]
AkaneGroup::

SECTION "TsukishiGroup", ROMX[$521A],BANK[$E]
TsukishiGroup::

SECTION "EnokiGroup", ROMX[$526F],BANK[$E]
EnokiGroup::

SECTION "OkeraGroup", ROMX[$528F],BANK[$E]
OkeraGroup::

SECTION "MikanGroup", ROMX[$52B4],BANK[$E]
MikanGroup::

SECTION "BlueGroup", ROMX[$5320],BANK[$E]
BlueGroup::

SECTION "GamaGroup", ROMX[$533D],BANK[$E]
GamaGroup::

SECTION "RivalGroup", ROMX[$5375],BANK[$E]
RivalGroup::

SECTION "OkidoGroup", ROMX[$53BC],BANK[$E]
OkidoGroup::

SECTION "SakakiGroup", ROMX[$5404],BANK[$E]
SakakiGroup::

SECTION "ProtagonistGroup", ROMX[$5427],BANK[$E]
ProtagonistGroup::

SECTION "SibaGroup", ROMX[$5433],BANK[$E]
SibaGroup::

SECTION "KasumiGroup", ROMX[$5433],BANK[$E]
KasumiGroup::

SECTION "KannaGroup", ROMX[$5472],BANK[$E]
KannaGroup::

SECTION "WataruGroup", ROMX[$54B6],BANK[$E]
WataruGroup::

SECTION "GerugeMemberMGroup", ROMX[$54DC],BANK[$E]
GerugeMemberMGroup::

SECTION "Trio1Group", ROMX[$54FA],BANK[$E]
Trio1Group::

SECTION "Trio2Group", ROMX[$554B],BANK[$E]
Trio2Group::

SECTION "Trio3Group", ROMX[$555D],BANK[$E]
Trio3Group::

SECTION "RocketFGroup", ROMX[$5566],BANK[$E]
RocketFGroup::

SECTION "YoungsterGroup", ROMX[$5587],BANK[$E]
YoungsterGroup::

SECTION "SchoolboyGroup", ROMX[$597F],BANK[$E]
SchoolboyGroup::
	; SCHOOLBOY TETSUYA
	db "てつや@", TRAINERTYPE_ITEM_MOVES
	db  9, DEX_YADOKING, ITEM_NONE, MOVE_DISABLE, MOVE_CONFUSION, MOVE_NONE, MOVE_NONE
	db -1 ; end

SECTION "FledglingGroup", ROMX[$55F4],BANK[$E]
FledglingGroup::

SECTION "LassGroup", ROMX[$521A],BANK[$E]
LassGroup::

SECTION "ProdigyGroup", ROMX[$5658],BANK[$E]
ProdigyGroup::

SECTION "ProfessionalMGroup", ROMX[$567C],BANK[$E]
ProfessionalMGroup::

SECTION "ProfessionalFGroup", ROMX[$567C],BANK[$E]
ProfessionalFGroup::

SECTION "BeautyGroup", ROMX[$54FA],BANK[$E]
BeautyGroup::
	; BEAUTY MEGUMI
	db "めぐみ@", TRAINERTYPE_ITEM_MOVES
	db 10, DEX_NYARTH, ITEM_NONE, MOVE_PAY_DAY, MOVE_GROWL, MOVE_NONE, MOVE_NONE
	db -1 ; end

SECTION "PokeManiacGroup", ROMX[$56D7],BANK[$E]
PokeManiacGroup::

SECTION "RocketMGroup", ROMX[$5795],BANK[$E]
RocketMGroup::

SECTION "GentlemanGroup", ROMX[$57C5],BANK[$E]
GentlemanGroup::

SECTION "TeacherMGroup", ROMX[$57E9],BANK[$E]
TeacherMGroup::

SECTION "TeacherFGroup", ROMX[$57F5],BANK[$E]
TeacherFGroup::

SECTION "ManchildGroup", ROMX[$57FB],BANK[$E]
ManchildGroup::

SECTION "BugCatcherBoyGroup", ROMX[$51BF],BANK[$E]
BugCatcherBoyGroup::
	; BUG CATCHER BOY JUNICHI
	db "じゅんいち@", TRAINERTYPE_ITEM_MOVES
	db  7, DEX_PARAS, ITEM_NONE, MOVE_STUN_SPORE, MOVE_LEECH_LIFE, MOVE_NONE, MOVE_NONE
	db -1 ; end

	; BUG CATCHER BOY SOUSUKE
	db "そうすけ@", TRAINERTYPE_ITEM_MOVES
	db  9, DEX_REDIBA, ITEM_NONE, MOVE_SCRATCH, MOVE_QUICK_ATTACK, MOVE_NONE, MOVE_NONE
	db -1 ; end

SECTION "FisherGroup", ROMX[$5433],BANK[$E]
FisherGroup::

SECTION "SwimmerFGroup", ROMX[$5811],BANK[$E]
SwimmerFGroup::

SECTION "SwimmerMGroup", ROMX[$581B],BANK[$E]
SwimmerMGroup::

SECTION "SailorGroup", ROMX[$5820],BANK[$E]
SailorGroup::

SECTION "SuperNerdGroup", ROMX[$582A],BANK[$E]
SuperNerdGroup::

SECTION "EngineerGroup", ROMX[$583C],BANK[$E]
EngineerGroup::

SECTION "RockerGroup", ROMX[$58CC],BANK[$E]
RockerGroup::

SECTION "HikerGroup", ROMX[$58FB],BANK[$E]
HikerGroup::

SECTION "BikerGroup", ROMX[$5907],BANK[$E]
BikerGroup::

SECTION "RockClimberGroup", ROMX[$5956],BANK[$E]
RockClimberGroup::

SECTION "BurglarGroup", ROMX[$5962],BANK[$E]
BurglarGroup::

SECTION "FirebreatherGroup", ROMX[$598C],BANK[$E]
FirebreatherGroup::
	; FIREBREATHER AKITO
	db "あきと@", TRAINERTYPE_ITEM_MOVES
	db 10, DEX_BOOBY, ITEM_NONE, MOVE_SCRATCH, MOVE_SMOG, MOVE_NONE, MOVE_NONE
	db -1 ; end

SECTION "JugglerGroup", ROMX[$596E],BANK[$E]
JugglerGroup::

SECTION "BlackbeltGroup", ROMX[$5972],BANK[$E]
BlackbeltGroup::

SECTION "SportsmanGroup", ROMX[$5999],BANK[$E]
SportsmanGroup::
	; SPORTSMAN SHIGEKI
	db "しげき@", TRAINERTYPE_ITEM
	db  8, DEX_DONPHAN, ITEM_NONE
	db -1 ; end

SECTION "PsychicGroup", ROMX[$5976],BANK[$E]
PsychicGroup::

SECTION "KungFuMasterGroup", ROMX[$5976],BANK[$E]
KungFuMasterGroup::

SECTION "FortuneTellerGroup", ROMX[$5976],BANK[$E]
FortuneTellerGroup::

SECTION "HooliganGroup", ROMX[$5976],BANK[$E]
HooliganGroup::

SECTION "SageGroup", ROMX[$5976],BANK[$E]
SageGroup::

SECTION "MediumGroup", ROMX[$5976],BANK[$E]
MediumGroup::

SECTION "SoldierGroup", ROMX[$5976],BANK[$E]
SoldierGroup::

SECTION "GerugeMemberFGroup", ROMX[$5976],BANK[$E]
GerugeMemberFGroup::

SECTION "KimonoGirlGroup", ROMX[$59A2],BANK[$E]
KimonoGirlGroup::
	; KIMONO GIRL TAMAO
	db "たまお@", TRAINERTYPE_ITEM_MOVES
	db 12, DEX_PURIN, ITEM_NONE, MOVE_CHARM, MOVE_ENCORE, MOVE_POUND, MOVE_NONE
	db -1 ; end

	; KIMONO GIRL KOUME
	db "こうめ@", TRAINERTYPE_ITEM_MOVES
	db 10, DEX_PIPPI, ITEM_NONE, MOVE_CHARM, MOVE_SWEET_KISS, MOVE_POUND, MOVE_NONE
	db -1 ; end

SECTION "TwinsGroup", ROMX[$597A],BANK[$E]
TwinsGroup::
