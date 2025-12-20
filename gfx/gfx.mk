$(BUILD)/slack/corrupted_9e1c.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/slack/corrupted_a66c.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/slack/corrupted_b1e3.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/slack/sgb_border_gold_corrupted.2bpp: tools/gfx += --trim-whitespace

$(BUILD)/gfx/sgb/sgb_border_alt.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/sgb/sgb_border_gold.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/sgb/sgb_border_silver.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/sgb/sgb_border_silver.2bpp: tools/gfx += --trim-whitespace

$(BUILD)/gfx/trainer_card/leaders.2bpp: tools/gfx += --trim-whitespace

$(BUILD)/gfx/minigames/slots_1.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/minigames/slots_2.2bpp: tools/gfx += --interleave --png=$<
$(BUILD)/gfx/minigames/slots_3.2bpp: tools/gfx += --interleave --png=$< --remove-duplicates --keep-whitespace --remove-xflip
$(BUILD)/gfx/minigames/slots_4.2bpp: tools/gfx += --interleave --png=$<
$(BUILD)/gfx/minigames/poker.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/minigames/picross_numbers.2bpp: tools/gfx += --trim-whitespace

$(BUILD)/gfx/intro/jigglypuff_pikachu.2bpp: tools/gfx += --trim-whitespace

$(BUILD)/gfx/intro/%.bin: gfx/intro/%.bin
	cp $< $@

$(BUILD)/gfx/minigames/%.bin: gfx/minigames/%.bin
	cp $< $@

$(BUILD)/gfx/battle_anims/attack_animations_1.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/battle_anims/attack_animations_2.2bpp: tools/gfx += --trim-whitespace

$(BUILD)/gfx/title/title_logo.2bpp: tools/gfx += --trim-whitespace

$(BUILD)/gfx/battle_anims/angels.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/battle_anims/beam.2bpp: tools/gfx += --remove-xflip --remove-yflip --remove-whitespace
$(BUILD)/gfx/battle_anims/bubble.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/battle_anims/charge.2bpp: tools/gfx += --trim-whitespace
$(BUILD)/gfx/battle_anims/egg.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/explosion.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/hit.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/horn.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/lightning.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/misc.2bpp: tools/gfx += --remove-duplicates --remove-xflip
$(BUILD)/gfx/battle_anims/noise.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/objects.2bpp: tools/gfx += --remove-whitespace --remove-xflip
$(BUILD)/gfx/battle_anims/pokeball.2bpp: tools/gfx += --remove-xflip --keep-whitespace
$(BUILD)/gfx/battle_anims/reflect.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/rocks.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/skyattack.2bpp: tools/gfx += --remove-whitespace
$(BUILD)/gfx/battle_anims/status.2bpp: tools/gfx += --remove-whitespace

$(BUILD)/gfx/evo/bubbles.2bpp: tools/gfx += --remove-xflip --remove-yflip --remove-whitespace
