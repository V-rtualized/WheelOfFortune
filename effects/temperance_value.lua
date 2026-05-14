WOF.Effect({
	key = "temperance_value",
	display_name = "Temperance Value",
	message = "k_wof_effect_temperance_value",
	is_shared = false,
	min_ante = 0,
	on_add = function(self)
		if not G.jokers or not G.jokers.cards or #G.jokers.cards == 0 then return end
		local indicator_keys = {}
		for _, effect in pairs(WOF.Effects) do
			if effect.joker_key then indicator_keys[effect.joker_key] = true end
		end
		local eligible = {}
		for _, card in ipairs(G.jokers.cards) do
			if not indicator_keys[card.config.center_key] then
				eligible[#eligible + 1] = card
			end
		end
		if #eligible == 0 then return end
		local joker = eligible[math.random(#eligible)]
		joker.ability.extra_value = (joker.ability.extra_value or 0) + 10
		joker:set_cost()
		joker:juice_up()
	end,
}):inject()
