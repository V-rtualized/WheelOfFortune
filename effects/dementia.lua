WOF.dementia_decrements = nil
WOF.dementia_blinds_remaining = nil

WOF.Effect({
	key = "dementia",
	display_name = "Dementia",
	message = "k_wof_effect_dementia",
	is_shared = false,
	removal_mode = "manual",
	flag = "dementia",
	joker_key = "j_wheeloffortune_dementia",
	on_add = function(self)
		WOF.default_on_add(self)
		WOF.dementia_blinds_remaining = 2
		WOF.dementia_decrements = {}
		G.E_MANAGER:add_event(Event({
			func = function()
				for name, hand in pairs(G.GAME.hands) do
					local decrement = hand.level
					if decrement > 0 then
						WOF.dementia_decrements[name] = decrement
						level_up_hand(G.deck.cards[1], name, true, -decrement)
					end
				end
				return true
			end,
		}))
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
		WOF.dementia_blinds_remaining = nil
		if WOF.dementia_decrements then
			for name, dec in pairs(WOF.dementia_decrements) do
				if G.GAME.hands[name] then
					level_up_hand(G.deck.cards[1], name, true, dec)
				end
			end
			WOF.dementia_decrements = nil
		end
	end,
}):inject()

local evaluate_round_dementia_ref = G.FUNCS.evaluate_round
G.FUNCS.evaluate_round = function()
	if WOF.flags.dementia and not MP.is_pvp_boss() then
		WOF.dementia_blinds_remaining = (WOF.dementia_blinds_remaining or 1) - 1
		if WOF.dementia_blinds_remaining <= 0 then
			WOF.Effects["wof_effect_wheeloffortune_dementia"]:on_remove()
		end
	end
	evaluate_round_dementia_ref()
end
