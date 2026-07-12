WOF.Effect({
	key = "overflow",
	display_name = "Ov6rf7ow",
	message = "k_wof_effect_overflow",
	is_shared = true,
	removal_mode = "manual",
	on_add = function(self)
		local ante = G.GAME.round_resets.ante or 1
		local enhancements = { "m_bonus", "m_mult", "m_wild", "m_steel", "m_stone", "m_gold", "m_lucky" }
		local editions = {
			{ foil = true },
			{ holo = true },
			{ polychrome = true },
		}
		local seals = { "Gold", "Red", "Blue", "Purple" }
		G.E_MANAGER:add_event(Event({
			func = function()
				for i = 1, 67 do
					local seed = "wof_overflow_" .. ante .. "_" .. i
					local enhancement = nil
					if pseudorandom(seed .. "_enhancement") < 0.35 then
						enhancement = pseudorandom_element(enhancements, pseudoseed(seed .. "_enhancement_pick"))
					end
					local card = create_playing_card({
						front = pseudorandom_element(G.P_CARDS, pseudoseed(seed .. "_card")),
						center = enhancement and G.P_CENTERS[enhancement] or G.P_CENTERS.c_base,
					}, G.deck, nil, true)
					local edition = pseudorandom(seed .. "_edition") < 0.08
							and pseudorandom_element(editions, pseudoseed(seed .. "_edition_pick"))
						or nil
					if edition then
						card:set_edition(edition, true, true)
					end
					local seal = pseudorandom(seed .. "_seal") < 0.12
							and pseudorandom_element(seals, pseudoseed(seed .. "_seal_pick"))
						or nil
					if seal then
						card:set_seal(seal, true, true)
						card.ability.delay_seal = false
					end
					G.deck.config.card_limit = G.deck.config.card_limit + 1
				end
				return true
			end,
		}))
	end,
}):inject()
