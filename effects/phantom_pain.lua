WOF.phantom_pain_joker_key = nil

WOF.Effect({
	key = "phantom_pain",
	message = "k_wof_effect_phantom_pain",
	is_shared = false,
	on_add = function(self)
		local eligible = {}
		for _, card in ipairs(G.jokers.cards) do
			if not card.ability.eternal and SMODS.add_to_pool(card.config.center, {}) then
				eligible[#eligible + 1] = card
			end
		end
		if #eligible == 0 then return end
		local target = eligible[math.random(#eligible)]
		local key = target.config.center_key
		G.E_MANAGER:add_event(Event({ func = function()
			target:start_dissolve()
			ease_dollars(20)
			if math.random() < 0.5 then
				WOF.phantom_pain_joker_key = key
				WOF.flags.phantom_pain = true
				WOF.flags.phantom_pain_past_blind = false
			end
			return true
		end }))
	end,
}):inject()

local select_blind_ref = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
	if WOF.flags.phantom_pain then
		WOF.flags.phantom_pain_past_blind = true
	end
	select_blind_ref(e)
end

local emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	emplace_ref(self, card, ...)
	if WOF.flags.phantom_pain and WOF.flags.phantom_pain_past_blind and self == G.shop_jokers then
		local key = WOF.phantom_pain_joker_key
		WOF.flags.phantom_pain = false
		WOF.flags.phantom_pain_past_blind = false
		WOF.phantom_pain_joker_key = nil
		G.E_MANAGER:add_event(Event({ func = function()
			local new_card = create_card("Joker", G.shop_jokers, nil, nil, nil, nil, key)
			new_card:set_cost()
			G.shop_jokers:emplace(new_card)
			return true
		end }))
	end
end
