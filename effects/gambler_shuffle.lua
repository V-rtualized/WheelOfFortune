local EDITIONS = { { foil = true }, { holo = true }, { polychrome = true } }

WOF.Effect({
	key = "gambler_shuffle",
	message = "k_wof_effect_gambler_shuffle",
	is_shared = false,
	on_add = function(self)
		if not G.playing_cards or #G.playing_cards == 0 then
			return
		end

		local old_card = G.playing_cards[math.random(#G.playing_cards)]
		local edition = EDITIONS[math.random(#EDITIONS)]

		G.E_MANAGER:add_event(Event({
			func = function()
				local new_card = create_playing_card(
					{ front = pseudorandom_element(G.P_CARDS, pseudoseed("wof_gambler")) },
					G.deck,
					true,
					true
				)
				new_card:set_edition(edition, true)
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				old_card:start_dissolve()
				return true
			end,
		}))
	end,
}):inject()
