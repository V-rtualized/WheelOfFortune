WOF.resource_drain_hands_saved = nil
WOF.resource_drain_discards_saved = nil

WOF.Effect({
	key = "resource_drain",
	display_name = "Resource Drain",
	message = "k_wof_effect_resource_drain",
	is_shared = true,
	removal_mode = "end_ante",
	flag = "resource_drain",
	joker_key = "j_wheeloffortune_resource_drain",
	on_add = function(self)
		WOF.default_on_add(self)
		WOF.resource_drain_hands_saved = nil
		WOF.resource_drain_discards_saved = nil
	end,
	on_remove = function(self)
		WOF.resource_drain_hands_saved = nil
		WOF.resource_drain_discards_saved = nil
		WOF.default_on_remove(self)
	end,
}):inject()
