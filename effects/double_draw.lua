WOF.Effect({
	key = "double_draw",
	display_name = "Double Draw",
	message = "k_wof_effect_double_draw",
	is_shared = false,
	removal_mode = "end_ante",
	flag = "double_draw",
	joker_key = "j_wheeloffortune_double_draw",
	on_add = function(self)
		WOF.default_on_add(self)
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
		-- Hand size is reverted by state_events.lua after each blind defeat; new_round hook re-applies it while the flag is active
	end,
}):inject()
