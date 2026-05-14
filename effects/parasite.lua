WOF.Effect({
	key = "parasite",
	display_name = "Parasite",
	message = "k_wof_effect_parasite",
	is_shared = false,
	on_add = function(self)
		local commons = {}
		for _, card in ipairs(G.jokers.cards) do
			if
				card.config.center.rarity == 1
				and not card.ability.perishable
				and not card.ability.eternal
				and SMODS.add_to_pool(card.config.center, {})
			then
				commons[#commons + 1] = card
			end
		end
		if #commons == 0 then
			return
		end
		commons[math.random(#commons)]:set_perishable(true)
	end,
}):inject()
