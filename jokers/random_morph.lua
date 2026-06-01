SMODS.Joker({
	key = "random_morph",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	in_pool = function(self, args)
		return false
	end,
	calculate = function(self, card, context)
		if context.after and WOF.flags.random_morph and not context.blueprint then
			local scored = {}
			if SMODS.last_hand and SMODS.last_hand.scoring_hand then
				for _, c in ipairs(SMODS.last_hand.scoring_hand) do
					if c and type(c) == "table" and not c.destroyed then
						scored[#scored + 1] = c
					end
				end
			end

			if #scored == 0 then
				return
			end

			if math.random() < 0.5 then
				-- Destroy
				G.E_MANAGER:add_event(Event({
					func = function()
						for _, c in ipairs(scored) do
							c:start_dissolve()
						end
						card_eval_status_text(card, "extra", nil, nil, nil, {
							message = localize("k_wof_random_morph_destroy"),
							colour = G.C.RED,
						})
						return true
					end,
				}))
			else
				-- Copy
				G.E_MANAGER:add_event(Event({
					func = function()
						for _, c in ipairs(scored) do
							if c.ability and c.ability.effect == "Stone Card" then goto continue end
							if SMODS.has_no_rank and SMODS.has_no_rank(c) then goto continue end
							local front = c.config.card_key and G.P_CARDS[c.config.card_key]
							if not front or not next(front) then
								local suit = c.base and c.base.suit and SMODS.Suits[c.base.suit]
								local rank = c.base and c.base.value and SMODS.Ranks[c.base.value]
								if suit and rank then
									front = G.P_CARDS[suit.card_key .. "_" .. rank.card_key]
								end
							end
							if front and next(front) then
								create_playing_card({ front = front }, G.deck, nil, true)
								G.deck.config.card_limit = G.deck.config.card_limit + 1
							end
							::continue::
						end
						card_eval_status_text(card, "extra", nil, nil, nil, {
							message = localize("k_wof_random_morph_copy"),
							colour = G.C.GREEN,
						})
						return true
					end,
				}))
			end
		end
	end,
})
