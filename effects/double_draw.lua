WOF.Effect({
	key = "double_draw",
	message = "k_wof_effect_double_draw",
	is_shared = false,
	removal_mode = "end_ante",
	flag = "double_draw",
	joker_key = "j_wheeloffortune_double_draw",
	on_add = function(self)
		WOF.default_on_add(self)
		G.hand:change_size(3)
		G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + 3
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
		-- Hand size is already reverted by state_events.lua at boss defeat before ease_ante fires
	end,
}):inject()
