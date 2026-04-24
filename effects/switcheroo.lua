WOF.Effect({
	key = "switcheroo",
	message = "k_wof_effect_switcheroo",
	is_shared = false,
	on_add = function(self)
		if not (MP and MP.ACTIONS and MP.UTILS) then return end
		local my_tarots = {}
		for _, card in ipairs(G.consumeables.cards) do
			if card.ability.set == "Tarot" then
				my_tarots[#my_tarots + 1] = card:save()
			end
		end
		local encoded = MP.UTILS.str_pack_and_encode(my_tarots)
		MP.ACTIONS.modded("WheelOfFortune", "switcheroo_request", { tarots = encoded })
	end,
}):inject()
