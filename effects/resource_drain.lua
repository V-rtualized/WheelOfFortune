WOF.resource_drain_hands_saved = nil
WOF.resource_drain_discards_saved = nil

WOF.Effect({
	key = "resource_drain",
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

local select_blind_ref = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
	if WOF.flags.resource_drain then
		local bs = G.GAME.round_resets.blind_states
		-- Only preserve when selecting Big or Boss (not the first blind of the ante)
		if bs and bs.Small == "Defeated" then
			WOF.resource_drain_hands_saved = G.GAME.current_round.hands_left
			WOF.resource_drain_discards_saved = G.GAME.current_round.discards_left
		end
	end
	select_blind_ref(e)
end
