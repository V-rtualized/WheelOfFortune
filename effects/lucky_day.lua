WOF.lucky_day_converted = nil

WOF.Effect({
	key = "lucky_day",
	message = "k_wof_effect_lucky_day",
	is_shared = true,
	removal_mode = "end_ante",
	on_add = function(self)
		WOF.lucky_day_converted = {}
		for _, card in ipairs(G.playing_cards) do
			if card.base.id == 7 and not SMODS.has_enhancement(card, "m_lucky") then
				WOF.lucky_day_converted[#WOF.lucky_day_converted + 1] = {
					playing_card = card.playing_card,
					original_center = card.config.center.key,
				}
				card:set_ability(G.P_CENTERS.m_lucky, nil, true)
			end
		end
		for k, v in pairs(G.GAME.probabilities) do
			G.GAME.probabilities[k] = v * 2
		end
	end,
	on_remove = function(self)
		if WOF.lucky_day_converted then
			for _, entry in ipairs(WOF.lucky_day_converted) do
				for _, card in ipairs(G.playing_cards) do
					if card.playing_card == entry.playing_card then
						card:set_ability(G.P_CENTERS[entry.original_center], nil, true)
						break
					end
				end
			end
			WOF.lucky_day_converted = nil
		end
		for k, v in pairs(G.GAME.probabilities) do
			G.GAME.probabilities[k] = v / 2
		end
	end,
}):inject()
