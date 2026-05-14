WOF.Effect({
	key = "overflow",
	display_name = "Ov6rf7ow",
	message = "k_wof_effect_overflow",
	is_shared = true,
	removal_mode = "manual",
	on_add = function(self)
		local ante = G.GAME.round_resets.ante or 1
		G.E_MANAGER:add_event(Event({
			func = function()
				for i = 1, 67 do
					local card = create_playing_card(
						{ front = pseudorandom_element(G.P_CARDS, pseudoseed("wof_overflow_card" .. ante .. i)) },
						G.deck,
						true,
						true
					)
					G.deck.config.card_limit = G.deck.config.card_limit + 1
				end
				return true
			end,
		}))
	end,
}):inject()
