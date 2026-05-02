WOF.Effect({
	key = "rents_due",
	message = "k_wof_effect_rents_due",
	is_shared = false,
	on_add = function(self)
		local eligible = {}
		for _, card in ipairs(G.jokers.cards) do
			if not card.ability.rental and SMODS.add_to_pool(card.config.center, {}) then
				eligible[#eligible + 1] = card
			end
		end
		if #eligible == 0 then
			return
		end
		eligible[math.random(#eligible)]:set_rental(true)
	end,
}):inject()
