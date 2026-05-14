WOF.Effect({
	key = "experience_exchange",
	display_name = "Experience Exchange",
	message = "k_wof_effect_experience_exchange",
	on_add = function(self)
		local names = {}
		for name in pairs(G.GAME.hands) do
			names[#names + 1] = name
		end
		if #names < 2 then
			return
		end
		local i = math.random(#names)
		local j = math.random(#names - 1)
		if j >= i then
			j = j + 1
		end
		local a, b = names[i], names[j]
		G.E_MANAGER:add_event(Event({
			func = function()
				local diff = G.GAME.hands[b].level - G.GAME.hands[a].level
				if diff ~= 0 then
					level_up_hand(G.deck.cards[1], a, true, diff)
					level_up_hand(G.deck.cards[1], b, true, -diff)
				end
				return true
			end,
		}))
	end,
}):inject()
