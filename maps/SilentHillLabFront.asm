	map_attributes SilentHillLabFront, SILENT_HILL_LAB_FRONT

	object_const_def
	const SILENT_HILL_LAB_FRONT_OAK1
	const SILENT_HILL_LAB_FRONT_OAK2
	const SILENT_HILL_LAB_FRONT_RIVAL1
	const SILENT_HILL_LAB_FRONT_RIVAL2
	const SILENT_HILL_LAB_FRONT_BLUE1
	const SILENT_HILL_LAB_FRONT_BLUE2
	const SILENT_HILL_LAB_FRONT_NANAMI
	const SILENT_HILL_LAB_FRONT_OAKS_AIDE1
	const SILENT_HILL_LAB_FRONT_OAKS_AIDE2
	const SILENT_HILL_LAB_FRONT_POKEDEX1
	const SILENT_HILL_LAB_FRONT_POKEDEX2
	
SilentHillLabFront_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3, 15, SILENT_HILL, 4, 82
	warp_event  4, 15, SILENT_HILL, 5, 83
	warp_event  4,  0, SILENT_HILL_LAB_BACK, 2, 13

	def_bg_events
	bg_event  6,  1, 1
	bg_event  2,  0, 2
	bg_event  0,  7, 3
	bg_event  1,  7, 4
	bg_event  2,  7, 5
	bg_event  5,  7, 6
	bg_event  6,  7, 7
	bg_event  7,  7, 8
	bg_event  0, 11, 9
	bg_event  1, 11, 10
	bg_event  2, 11, 11
	bg_event  5, 11, 12
	bg_event  6, 11, 13
	bg_event  7, 11, 14
	bg_event  4,  0, 15

	def_object_events
	object_event  4,  2, SPRITE_OKIDO, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  0, SPRITE_OKIDO, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  4, SPRITE_SILVER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  0, SPRITE_SILVER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4, 14, SPRITE_BLUE, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  3, SPRITE_BLUE, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1, 13, SPRITE_NANAMI, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  8, SPRITE_SCIENTIST, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6, 12, SPRITE_SCIENTIST, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  1, SPRITE_POKEDEX, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  1, SPRITE_POKEDEX, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillLabFront_Blocks::
INCBIN "maps/SilentHillLabFront.blk"

	map_generic_scriptloader

SilentHillLabFrontScriptPointers::
	def_script_pointers
	script_pointer SilentHillLabFrontDefaultScript, SilentHillLabFrontDefaultNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_DEFAULT
	script_pointer SilentHillLabFrontStartBlueCutsceneScript, SilentHillLabFrontStartBlueCutsceneNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_START_BLUE_CUTSCENE
	script_pointer SilentHillLabFrontBlueCutsceneScript, SilentHillLabFrontBlueCutsceneNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_BLUE_CUTSCENE
	script_pointer SilentHillLabFrontBlueCutscene2Script, SilentHillLabFrontBlueCutscene2NPCIDs, SCENE_SILENT_HILL_LAB_FRONT_BLUE_CUTSCENE_2
	script_pointer SilentHillLabFrontBlueCutsceneConversationScript, SilentHillLabFrontBlueCutsceneConversationNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_BLUE_CUTSCENE_CONVERSATION
	script_pointer SilentHillLabFrontRivalEnterBackScript, SilentHillLabFrontRivalEnterBackNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_ENTER_BACK
	script_pointer SilentHillLabFrontPlayerEnterBackScript, SilentHillLabFrontPlayerEnterBackNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_PLAYER_ENTER_BACK
	script_pointer SilentHillLabFrontReturnFromBackScript, SilentHillLabFrontReturnFromBackNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_RETURN_FROM_BACK
	script_pointer SilentHillLabFrontRivalCutsceneScript, SilentHillLabFrontRivalCutsceneNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_CUTSCENE
	script_pointer SilentHillLabFrontRivalCutscene2Script, SilentHillLabFrontRivalCutscene2NPCIDs, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_CUTSCENE_2
	script_pointer SilentHillLabFrontGetPokedexScript, SilentHillLabFrontGetPokedexNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_GET_POKEDEX
	script_pointer SilentHillLabFrontGotPokedexScript, SilentHillLabFrontGotPokedexNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_GOT_POKEDEX
	script_pointer SilentHillLabFrontRivalStartBattleScript, SilentHillLabFrontRivalStartBattleNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_START_BATTLE
	script_pointer SilentHillLabFrontRivalBattleEndScript, SilentHillLabFrontRivalBattleEndNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_BATTLE_END
	script_pointer SilentHillLabFrontStartRivalLeaveScript, SilentHillLabFrontStartRivalLeaveNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_START_RIVAL_LEAVE
	script_pointer SilentHillLabFrontRivalLeaveScript, SilentHillLabFrontRivalLeaveNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_LEAVE
	script_pointer SilentHillLabFrontGetPokeballsScript, SilentHillLabFrontGetPokeballsNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_GET_POKEBALLS
	script_pointer SilentHillLabFrontExitLabScript, SilentHillLabFrontExitLabNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_EXIT_LAB
	script_pointer SilentHillLabFrontFinishedScript, SilentHillLabFrontFinishedNPCIDs, SCENE_SILENT_HILL_LAB_FRONT_FINISHED

SilentHillLabFrontDefaultNPCIDs:
	npc_id SILENT_HILL_LAB_FRONT_RIVAL1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX2
	db -1

SilentHillLabFrontStartBlueCutsceneNPCIDs:
SilentHillLabFrontBlueCutsceneNPCIDs:
SilentHillLabFrontBlueCutscene2NPCIDs:
SilentHillLabFrontBlueCutsceneConversationNPCIDs:

	npc_id SILENT_HILL_LAB_FRONT_OAK1
	npc_id SILENT_HILL_LAB_FRONT_RIVAL1
	npc_id SILENT_HILL_LAB_FRONT_BLUE1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX2
	db -1

SilentHillLabFrontRivalEnterBackNPCIDs:
	npc_id SILENT_HILL_LAB_FRONT_RIVAL1
	npc_id SILENT_HILL_LAB_FRONT_BLUE1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX2
	db -1

SilentHillLabFrontPlayerEnterBackNPCIDs:
	npc_id SILENT_HILL_LAB_FRONT_BLUE1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX2
	db -1

SilentHillLabFrontReturnFromBackNPCIDs:
SilentHillLabFrontRivalCutsceneNPCIDs:
SilentHillLabFrontRivalCutscene2NPCIDs:
SilentHillLabFrontGetPokedexNPCIDs:
	npc_id SILENT_HILL_LAB_FRONT_OAK2
	npc_id SILENT_HILL_LAB_FRONT_RIVAL2
	npc_id SILENT_HILL_LAB_FRONT_BLUE2
	npc_id SILENT_HILL_LAB_FRONT_NANAMI
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE1
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE2
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX2
	db -1

SilentHillLabFrontGotPokedexNPCIDs:
SilentHillLabFrontRivalStartBattleNPCIDs:
SilentHillLabFrontRivalBattleEndNPCIDs:
	npc_id SILENT_HILL_LAB_FRONT_OAK2
	npc_id SILENT_HILL_LAB_FRONT_RIVAL2
	npc_id SILENT_HILL_LAB_FRONT_BLUE2
	npc_id SILENT_HILL_LAB_FRONT_NANAMI
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE1
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE2
	db -1

SilentHillLabFrontStartRivalLeaveNPCIDs:
SilentHillLabFrontRivalLeaveNPCIDs:
SilentHillLabFrontGetPokeballsNPCIDs:
SilentHillLabFrontExitLabNPCIDs:
	npc_id SILENT_HILL_LAB_FRONT_OAK1
	npc_id SILENT_HILL_LAB_FRONT_BLUE2
	npc_id SILENT_HILL_LAB_FRONT_NANAMI
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE1
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE2
	db -1
	
SilentHillLabFrontLabReturnNPCIDs: ; unreferenced
	npc_id SILENT_HILL_LAB_FRONT_OAK1
	npc_id SILENT_HILL_LAB_FRONT_RIVAL2
	npc_id SILENT_HILL_LAB_FRONT_BLUE2
	npc_id SILENT_HILL_LAB_FRONT_NANAMI
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE1
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE2
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX1
	npc_id SILENT_HILL_LAB_FRONT_POKEDEX2
	db -1

SilentHillLabFrontFinishedNPCIDs:
	npc_id SILENT_HILL_LAB_FRONT_OAK1
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE1
	npc_id SILENT_HILL_LAB_FRONT_OAKS_AIDE2
	db -1

SilentHillLabFront_TextPointers::
	dw SilentHillLabFrontOak1Script
	dw SilentHillLabFrontOak2Script
	dw SilentHillLabFrontText10
	dw SilentHillLabFrontText11
	dw SilentHillLabFrontTextString20
	dw SilentHillLabFrontText12
	dw SilentHillLabFrontText13
	dw SilentHillLabFrontText14
	dw SilentHillLabFrontText15
	dw SilentHillLabFrontText16
	dw SilentHillLabFrontText16

SilentHillLabFrontDefaultScript:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontDefaultNPCIDs
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontMoveDown:
	ld a, [wXCoord]
	cp 4
	ret nz
	ld a, [wYCoord]
	cp 1
	ret nz
	ldh a, [hJoyState]
	bit B_PAD_UP, a
	jp z, xor_a_dec_a
	call SilentHillLabFrontBackLockedScript
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, PLAYER_OBJECT
	call FreezeAllOtherObjects
	ld a, PLAYER_OBJECT
	ld hl, .movement
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	call xor_a
	ret

.movement
	slow_step LEFT
	step_end

SilentHillLabFrontStartBlueCutsceneScript:
	ld a, SCENE_SILENT_HILL_LAB_FRONT_BLUE_CUTSCENE
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontBlueCutsceneScript:
	ld a, SILENT_HILL_LAB_FRONT_BLUE1
	call FreezeAllOtherObjects
	ld a, PLAYER_OBJECT
	call UnfreezeObject
	ld b, SILENT_HILL_LAB_FRONT_BLUE1
	ld c, PLAYER_OBJECT
	call StartFollow
	ld hl, .movement
	ld a, SILENT_HILL_LAB_FRONT_BLUE1
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_BLUE_CUTSCENE_2
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.movement
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	slow_step UP
	slow_step RIGHT
	turn_head UP
	step_end

SilentHillLabFrontBlueCutscene2Script:
	call FreezeAllObjects
	ld a, SCENE_SILENT_HILL_LAB_FRONT_BLUE_CUTSCENE_CONVERSATION
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontBlueCutsceneConversationScript:
	ld a, SILENT_HILL_LAB_FRONT_RIVAL1
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString20
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString4
	call OpenTextbox
	ld a, SILENT_HILL_LAB_FRONT_RIVAL1
	ld d, UP
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString28
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString5
	call OpenTextbox
	ld a, SILENT_HILL_LAB_FRONT_RIVAL1
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString29
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString7
	call OpenTextbox
	call SilentHillLabFrontOakEnterBack
	ret

SilentHillLabFrontOakEnterBack:
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, SILENT_HILL_LAB_FRONT_OAK1
	call FreezeAllOtherObjects
	ld a, SILENT_HILL_LAB_FRONT_OAK1
	ld hl, .movement
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_ENTER_BACK
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.movement
	step UP
	slow_step UP
	remove_object

SilentHillLabFrontRivalEnterBackScript:
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, SILENT_HILL_LAB_FRONT_RIVAL1
	call FreezeAllOtherObjects
	ld a, SILENT_HILL_LAB_FRONT_RIVAL1
	ld hl, .movement
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_PLAYER_ENTER_BACK
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.movement
	big_step UP
	big_step UP
	big_step RIGHT
	big_step UP
	big_step UP
	remove_object

SilentHillLabFrontPlayerEnterBackScript:
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, PLAYER_OBJECT
	call FreezeAllOtherObjects
	ld a, PLAYER_OBJECT
	ld hl, .movement
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_RETURN_FROM_BACK
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.movement
	step UP
	step UP
	step UP
	slow_step UP
	step_end

SilentHillLabFrontReturnFromBackScript:
	ld a, SILENT_HILL_LAB_FRONT_OAK2
	call SetObjectLowPriority
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	call SetObjectLowPriority
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, PLAYER_OBJECT
	call FreezeAllOtherObjects
	ld a, PLAYER_OBJECT
	ld hl, .movement
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_CUTSCENE
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.movement
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	slow_step LEFT
	step_end

SilentHillLabFrontRivalCutsceneScript:
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	call FreezeAllOtherObjects
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	call ResetObjectLowPriority
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	ld hl, .movement
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_CUTSCENE_2
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.movement
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	slow_step LEFT
	step_end

SilentHillLabFrontRivalCutscene2Script:
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString21
	call OpenTextbox
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, PLAYER_OBJECT
	ld d, RIGHT
	call SetObjectFacing
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	ld d, RIGHT
	call SetObjectFacing
	ld a, SILENT_HILL_LAB_FRONT_OAK2
	call FreezeAllOtherObjects
	ld a, SILENT_HILL_LAB_FRONT_OAK2
	call ResetObjectLowPriority
	ld a, SILENT_HILL_LAB_FRONT_OAK2
	ld hl, .movement
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_GET_POKEDEX
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.movement
	step DOWN
	slow_step DOWN
	step_end

SilentHillLabFrontGetPokedexScript:
	ld hl, SilentHillLabFrontTextString8
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString9
	call OpenTextbox
	ld a, SILENT_HILL_LAB_FRONT_POKEDEX1
	call ApplyDeletionToMapObject
	ld a, SILENT_HILL_LAB_FRONT_POKEDEX2
	call ApplyDeletionToMapObject
	ld hl, SilentHillLabFrontTextString10
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString15
	call OpenTextbox
	SetEvent SILENT_HILL_LAB_FRONT_GOT_POKEDEX
	call UnfreezeEverything
	ld a, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_GOT_POKEDEX
	ld [wMapScriptNumber], a
	call InitObjectMasks
	ret

SilentHillLabFrontGotPokedexScript:
	call SilentHillLabFrontMoveDown
	ret z
	call SilentHillLabFrontRivalMoveForBattle
	ret z
	ld hl, SilentHillLabFrontGotPokedexNPCIDs
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontRivalMoveForBattle:
	ld a, [wYCoord]
	cp 8
	ret nz
	ld hl, .movement
	ld a, [wXCoord]
	cp 3
	jr z, .jump
	cp 4
	ret nz
	ld hl, .movement2
.jump
	push hl
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	call FreezeAllOtherObjects
	pop hl
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_START_BATTLE
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	call xor_a
	ret

.movement
	step DOWN
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	slow_step DOWN
	step_end

.movement2
	step DOWN
	step RIGHT
	step DOWN
	step DOWN
	slow_step DOWN
	step_end

SilentHillLabFrontRivalStartBattleScript:
	ld hl, SilentHillLabFrontTextString17
	call OpenTextbox
	call GetLabPokemon
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_START_TRAINER_BATTLE
	ld [wMapStatus], a
	ld a, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_BATTLE_END
	ld [wMapScriptNumber], a
	call InitObjectMasks
	ret

GetLabPokemon:
	ld hl, LabPokemon
	ld a, [wRivalStarter]
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr nz, .jump
	ld a, [hl]
	ld [wOtherTrainerID], a
	ld a, TRAINER_RIVAL
	ld [wOtherTrainerClass], a
	ret
.jump
	inc hl
	jr .loop

LabPokemon:
	db DEX_CRUISE
	db 1
	db DEX_HAPPA
	db 2
	db DEX_HONOGUMA
	db 3

SilentHillLabFrontRivalBattleEndScript:
	ld hl, SilentHillLabFrontTextString19
	ld a, [wBattleResult]
	and a
	jr nz, .skip
	ld hl, SilentHillLabFrontTextString18
.skip
	call OpenTextbox
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	call FreezeAllOtherObjects
	ld a, SILENT_HILL_LAB_FRONT_RIVAL2
	ld hl, .movement
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_START_RIVAL_LEAVE
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.movement
	slow_step DOWN
	step DOWN
	step DOWN
	step DOWN
	remove_object

SilentHillLabFrontStartRivalLeaveScript:
	call UnfreezeEverything
	ld a, SCENE_SILENT_HILL_LAB_FRONT_RIVAL_LEAVE
	ld [wMapScriptNumber], a
	call InitObjectMasks
	ret

SilentHillLabFrontRivalLeaveScript:
	call SilentHillLabFrontMoveDown
	ret z
	call SilentHillLabFrontMoveRivalLeave
	ret z
	ld hl, SilentHillLabFrontRivalLeaveNPCIDs
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontMoveRivalLeave:
	ld a, [wYCoord]
	cp 11
	ret nz
	ld hl, .movement+1
	ld a, [wXCoord]
	cp 3
	jr z, .jump
	cp 4
	ret nz
	ld hl, .movement
.jump
	push hl
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CUTSCENE_F, [hl]
	ld a, SILENT_HILL_LAB_FRONT_NANAMI
	call FreezeAllOtherObjects
	pop hl
	ld a, SILENT_HILL_LAB_FRONT_NANAMI
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_FRONT_GET_POKEBALLS
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	call xor_a
	ret

.movement
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	slow_step UP
	step_end

SilentHillLabFrontGetPokeballsScript:
	ld hl, SilentHillLabFrontTextString23
	call OpenTextbox
	SetEvent SILENT_HILL_LAB_FRONT_RIVAL_BATTLED
	ld hl, wNumBagItems
	ld a, ITEM_POKE_BALL
	ld [wCurItem], a
	ld a, 6
	ld [wItemQuantity], a
	call ReceiveItem
	call UnfreezeEverything
	ld a, SCENE_SILENT_HILL_LAB_FRONT_EXIT_LAB
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontExitLabScript:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontExitLabNPCIDs
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontFinishedScript:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontFinishedNPCIDs
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontTextPointers2:
	dw SilentHillLabFrontPCScript
	dw SilentHillLabFrontWallScrollScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw SilentHillLabFrontBackLockedScript

SilentHillLabFrontPCScript:
	ld hl, SilentHillLabFrontPCString
	call OpenTextbox
	ret

SilentHillLabFrontPCString:
	text "パソコンを　みると"
	line "なんと　メールが　きていた！"

	para "<⋯⋯>　<⋯⋯>　<⋯⋯>"
	line "オーキドはかせ！"
	cont "あなたが　ゆくえふめいに"
	cont "なっていると　せけんは"
	cont "おおさわぎ　です！"

	para "それは　そうと"
	line "はかせ　から　みつけるように"
	cont "たのまれた　れいの#"
	cont "みつけるどころか"
	cont "まだ　てがかりも"
	cont "つかむことが　できません"

	para "やはり　あいつは"
	line "かくうの　#なのでは"
	cont "ないでしょうか<⋯⋯>"
	cont "<⋯⋯>　<⋯⋯>　<⋯⋯>じょしゅより"
	done

SilentHillLabFrontWallScrollScript:
	ld hl, wSilentHillLabFrontFlags
	bit 0, [hl]
	set 0, [hl]
	jr z, .jump
	res 0, [hl]
	ld hl, SilentHillLabFrontTextString2A
	jr .skip
.jump
	ld hl, SilentHillLabFrontTextString2B
.skip
	call OpenTextbox
	ret

SilentHillLabFrontTextString2A:
	text "スタート　ボタンを　プシュ！"
	line "おすと　メニューが　ひらくなり"
	done

SilentHillLabFrontTextString2B:
	text "セーブするには　#　レポート"
	line "こまめに　かくと　いいなり"
	done

SilentHillLabFrontBackLockedScript:
	ld hl, SilentHillLabFrontTextString3
	call OpenTextbox
	ret

SilentHillLabFrontTextString3:
	text "カギが　かかっている"
	done

SilentHillLabFrontOak1Script:
	ld a, [wMapScriptNumber]
	cp SCENE_SILENT_HILL_LAB_FRONT_START_RIVAL_LEAVE
	jp nc, SilentHillLabFrontOak2Script
	ld hl, SilentHillLabFrontTextString4
	call OpenTextbox
	ret

SilentHillLabFrontTextString4:
	text "オーキド『ごくろうさん！"
	done

SilentHillLabFrontTextString5:
	text "オーキド『そうとも！"
	line "わしが　オーキドじゃ！"
	cont "じじいで　わるかったな！"

	para "おまえたち　ふたりは"
	line "この　オーキドが　よんだのじゃ！"

	para "すこし　わしの　はなしを"
	line "きいては　くれんか？@"

	start_asm
	call YesNoBox
	jr c, .jump
.loop
	ld hl, SilentHillLabFrontTextString6A
	call PrintText
	call TextAsmEnd
	ret

.jump
	ld hl, SilentHillLabFrontTextString6B
	call PrintText
	call YesNoBox
	jr c, .jump
	jr .loop

SilentHillLabFrontTextString6A:
	text "オーキド『いまから　１ねんまえ"
	line "わしは　カントーで"
	cont "きみたちの　ような　しょうねんに"
	cont "#の　けんきゅうの　ため"
	cont "#と　ずかんを　わたした"

	para "そして　かれらは"
	line "じつに　よくやってくれた！"

	para "１５０しゅるいの"
	line "#を　みつけることに"
	cont "せいこう　したのじゃ！"
	cont "が　<⋯⋯>　<⋯⋯>　<⋯⋯>"
	cont "しかし　<⋯⋯>　<⋯⋯>"

	para "せかいは　ひろいものじゃ"
	line "そのご　ぜんこく　かくちで"
	cont "あたらしい　#が　ぞくぞくと"
	cont "みつかっておる！"

	para "そこで　わしは　カントーから"
	line "ここ　サイレントヒルに"
	cont "けんきゅうの　ばしょを　うつした"

	para "ばしょが　かわれば"
	line "あたらしい　#にも"
	cont "であうことが　できるからな"
	cont "<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>"

	para "これからも　どんどんと"
	line "けんきゅうを　すすめるが"
	cont "わしも　ごらんのとおりの　おいぼれ"
	cont "まごや　じょしゅたちも　おるが"
	cont "それでも　やはり　かずが　たらん！"

	para "<PLAYER>！　<RIVAL>！"
	line "#けんきゅうの　ために"
	cont "ちからを　かして　くれんか！"
	done

SilentHillLabFrontTextString6B:
	text "オーキド『そうか<⋯⋯>"
	line "わしに　ひとを　みるめが"
	cont "なかったと　いうことじゃな<⋯⋯>"

	para "いや！"
	line "わしの　ひとを　みるめは"
	cont "まちがっては　おらんはず！"

	para "な？"
	cont "わしの　はなしを　きいてくれるな？"
	done

SilentHillLabFrontTextString7:
	text "オーキド『ふたりとも！"
	line "ちょっと　わしに　ついてこい！"
	done

SilentHillLabFrontOak2Script:
	ld a, [wMapScriptNumber]
	cp SCENE_SILENT_HILL_LAB_FRONT_FINISHED
	jr z, .jump
	ld hl, SilentHillLabFrontTextString11A
	call OpenTextbox
	ret

.jump
	ld hl, SilentHillLabFrontTextString11B
	call OpenTextbox
	ret

SilentHillLabFrontTextString8:
	text "オーキド『<PLAYER>！<RIVAL>！"
	line "このずかんを"
	cont "おまえたちに　あずける！"
	done

SilentHillLabFrontTextString9:
	text "<PLAYER>は　オーキドから"
	line "#ずかんを　もらった！"
	done

SilentHillLabFrontTextString10:
	text "オーキド『この　せかいの　すべての"
	line "#を　きろくした"
	cont "かんぺきな　ずかんを　つくること！"
	cont "それが　わしの　ゆめ　だった！"

	para "しかし　しんしゅの　#は"
	cont "ぞくぞくと　みつかっている！"

	para "わしに　のこされた"
	line "じかんは　すくない！"

	para "そこで　おまえ　たちには"
	line "わしの　かわりに"
	cont "ゆめを　はたして　ほしいのじゃ！"

	para "さあ　ふたりとも"
	line "さっそく　しゅっぱつ　してくれい！"
	cont "これは　#の　れきしに　のこる"
	cont "いだいな　しごとじゃー！"
	done

SilentHillLabFrontTextString11A:
	text "オーキド『せかい　じゅうの"
	line "#たちが"
	cont "<PLAYER>を　まって　おるぞー"
	done

SilentHillLabFrontTextString11B:
	text "オーキド『おう！　<PLAYER>"
	line "どうだ？"
	cont "わしの　あげた　#は<⋯⋯>？"

	para "ほう！"
	cont "だいぶ　なついた　みたいだな"

	para "おまえには　#トレーナーの"
	line "さいのうが　あるかもしれん"
	cont "これからも　ときどきは"
	cont "わしのところへ　かおを　だせ！"

	para "#ずかんの　ページが"
	line "きに　なるからな"
	done

SilentHillLabFrontTextLabReturn: ; unreferenced
	ld hl, SilentHillLabFrontTextString12
	call OpenTextbox
	ret

SilentHillLabFrontTextString12:
	text "オーキド『よく　きたな！"
	line "#ずかんの"
	cont "ちょうしは　どうかな？"

	para "どれ<⋯⋯>　ちょっと"
	cont "みて　あげようか！"
	done

SilentHillLabFrontTextLabReturn2: ; unreferenced
	ld hl, SilentHillLabFrontTextString13
	call OpenTextbox
	ret

SilentHillLabFrontTextString13:
	text "オーキド『<⋯⋯>　おっほんッ！"
	line "よくやったな　<PLAYER>！"

	para "ちょっと"
	line "わしに　ついて　きなさい！"

	para "<RIVAL>は　すまんが"
	line "そこで　まっていなさい！"

	para "<RIVAL>『えー！"
	line "なんだよ　ケチー！"

	para "オーキド『<RIVAL>は"
	line "でんせつの　#が"
	cont "ほしかった　だけじゃないのか？"
	cont "<RIVAL>『ギクッ！"
	done

SilentHillLabFrontText10: ; unreferenced
	ld hl, SilentHillLabFrontTextString14
	call OpenTextbox
	ret

SilentHillLabFrontTextString14:
	text "<RIVAL>『なんだ"
	line "<PLAYER>じゃないか！"
	cont "おれも　ここが"
	cont "あやしいと　おもって　きたんだけど"
	cont "だれも　いないみたいだな<⋯⋯>"
	done

SilentHillLabFrontText11:
	ld hl, SilentHillLabFrontTextString16
	call OpenTextbox
	ret

SilentHillLabFrontTextString15:
	text "<RIVAL>『よっしゃあ！"
	line "じいさん！　おれにまかせな！"
	done

SilentHillLabFrontTextString16:
	text "<RIVAL>『おれが　えらんだ"
	line "#のほうが　つよそうだぜ！"
	cont "こっちに　したかったんじゃないの？"
	done

SilentHillLabFrontTextString17:
	text "<RIVAL>『<PLAYER>！"
	line "せっかく　じいさんに"
	cont "#　もらったんだから"
	cont "<⋯⋯>　ちょっと"
	cont "たたかわせて　みようぜ！"
	done

SilentHillLabFrontTextString18:
	text "<RIVAL>『くっそー！"
	line "こんどは　ぜったい　まけないぞ！"
	done

SilentHillLabFrontTextString19:
	text "<RIVAL>『よーし！"
	line "ほかの　#と　たたかわせて"
	cont "もっと　もっと　つよくしよう！"

	para "そんじゃ　ばいばい！"
	done

SilentHillLabFrontTextString20:
	text "じいちゃん！"
	line "つれてきたよー！"
	done

SilentHillLabFrontTextString21:
	text "ぼくは　かつて"
	line "#トレーナーの　ちょうてんを"
	cont "めざしたことが　あるんだ"
	cont "そのとき　いいきに　なっていた"
	cont "ぼくの　てんぐのはなを"
	cont "へしおった　やつに"
	cont "きみは　どことなく　にている"

	para "あいつの　おかげで　ぼくは"
	line "こころを　いれかえて"
	cont "じいさんの　けんきゅうを"
	cont "てつだうように　なったのさ"
	cont "<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>"

	para "さあ！"
	line "これが　#ずかんだ！"

	para "みつけた　#の　データが"
	line "じどうてきに　かきこまれて"
	cont "ページが　ふえて　いく　という"
	cont "とても　ハイテクな　ずかん　だよ！"
	done

SilentHillLabFrontText12:
	ld hl, SilentHillLabFrontTextString22
	call OpenTextbox
	ret

SilentHillLabFrontTextString22:
	text "ぼくも　むかし　やったけど"
	line "なかなか　たいへんだよ<⋯⋯>"
	cont "がんばってね！"
	done

SilentHillLabFrontText13:
	ld hl, SilentHillLabFrontTextString24
	call OpenTextbox
	ret

SilentHillLabFrontTextString23:
	text "ナナミ『さっき　あなたを　"
	line "つれてきた　わかい　おとこのこ<⋯⋯>"
	cont "あれは　わたしの　おとうとなの"
	cont "<⋯⋯>ということは　つまり"

	para "そう！"
	line "わたしも　オーキドの　まご　なの！"

	para "おじいちゃんは　りっぱな"
	cont "#けんきゅうしゃよ"
	cont "わたしは　おてつだい　できることが"
	cont "とっても　うれしいの！"
	cont "あっ　こんなこと　しられたら"
	cont "おじいちゃん　ちょうしに　のるから"
	cont "ないしょに　しておいてね！"

	para "<⋯⋯>おじいちゃん　すっかり"
	line "わすれている　みたいだから"

	para "わたしが　かわりに　これを　あげる！"
	line "さいしんがた　#リュックよ"

	para "<PLAYER>は"
	line "#リュックを　もらった！"

	para "ナナミ『この　リュックには"
	line "モンスターボールを"
	cont "まとめて　いれられる"
	cont "ボールホルダと"
	cont "わざマシンを　まとめて　いれられる"
	cont "わざマシンホルダが　ついているの"

	para "モンスターボール　６こと　"
	line "わざマシンひとつは　オマケしておくわ"
	cont "ホルダに　なんにも　はいってないと"
	cont "さびしいもんね！"

	para "ねえ　<PLAYER>くン"
	line "あなたの　おかあさんが"
	cont "しんぱいすると　いけないから"
	cont "このまちを　でるまえに"
	cont "かおを　みせに　いってあげてね"

	para "<⋯⋯>あなたの　かつやく"
	line "いのっているわ"
	done

SilentHillLabFrontTextString24:
	text "<⋯⋯>あなたの　かつやく"
	line "いのってるわ"
	done

SilentHillLabFrontText14:
	ld hl, SilentHillLabFrontTextString25
	call OpenTextbox
	ret

SilentHillLabFrontTextString25:
	text "わたしは"
	line "はかせの　じょしゅ　です"

	para "わたしは　もちろん"
	line "はかせを　ソンケー　しております"

	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done

SilentHillLabFrontText15:
	ld hl, SilentHillLabFrontTextString26
	call OpenTextbox
	ret

SilentHillLabFrontTextString26:
	text "わたしは"
	line "はかせの　じょしゅ　です"

	para "わたしは　もちろん"
	line "はかせを　ソンケー　しております"

	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done

SilentHillLabFrontText16:
	ld hl, SilentHillLabFrontTextString27
	call OpenTextbox
	ret

SilentHillLabFrontTextString27:
	text "なんだろう？"
	line "でんし　てちょう　かな？"
	done

SilentHillLabFrontText17:
	ld hl, SilentHillLabFrontTextString28
	call OpenTextbox
	ret

SilentHillLabFrontTextString28:
	text "<RIVAL>『あのメールを　くれた"
	line "オーキドって　こんな　じじい<⋯⋯>"

	para "あっ　ゴメン"
	line "こんな　じいさん　なのか？"
	cont "ほんもの　はじめて　みたよ！"
	done

SilentHillLabFrontTextString29:
	text "<RIVAL>『<PLAYER>！"
	line "なんだか"
	cont "おもしろく　なってきたな！"
	done

SilentHillLabFrontText18:
	ld hl, SilentHillLabFrontTextString30
	call OpenTextbox
	ret

SilentHillLabFrontTextString30:
	text "わたしは"
	line "はかせの　じょしゅ　です"

	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done

SilentHillLabFrontText19:
	ld hl, SilentHillLabFrontTextString31
	call OpenTextbox
	ret

SilentHillLabFrontTextString31:
	text "わたしは"
	line "はかせの　じょしゅ　です"

	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done
