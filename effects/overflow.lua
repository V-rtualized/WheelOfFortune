WOF.Effect({
	key = "overflow",
	display_name = "Ov6rf7ow",
	message = "k_wof_effect_overflow",
	is_shared = true,
	removal_mode = "end_ante",
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
					}, G.deck, true, true)
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
	on_remove = function(self)
		local cards_to_destroy = {}
		local destroy_lookup = {}
		for _, card in ipairs(G.playing_cards or {}) do
			local rank = card.base and card.base.id
			if rank ~= 6 and rank ~= 7 then
				cards_to_destroy[#cards_to_destroy + 1] = card
				destroy_lookup[card] = true
			end
		end

		for i = #(G.playing_cards or {}), 1, -1 do
			if destroy_lookup[G.playing_cards[i]] then
				table.remove(G.playing_cards, i)
			end
		end
		for i, card in ipairs(G.playing_cards or {}) do
			card.playing_card = i
		end

		if #cards_to_destroy > 0 then
			SMODS.destroy_cards(cards_to_destroy, true)
		end
	end,
}):inject()
