WOF.Effect({
	key = "indigo_blessing",
	message = "k_wof_effect_indigo_blessing",
	is_shared = false,
	removal_mode = "end_ante",
	on_add = function(self)
		G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + 1
	end,
	on_remove = function(self)
		G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 1) - 1
	end,
}):inject()
