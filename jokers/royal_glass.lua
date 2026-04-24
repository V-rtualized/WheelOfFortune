SMODS.Joker({
	key = "royal_glass",
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
		if context.joker_main and WOF.flags.royal_glass and not context.blueprint then
			if context.scoring_name == "Straight Flush" then
				local royal = true
				for _, v in ipairs(context.scoring_hand) do
					local rank = SMODS.Ranks[v.base.value]
					royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
				end
				if royal then
					G.E_MANAGER:add_event(Event({
						func = function()
							local center = G.P_CENTERS["c_justice"]
							local tarot = Card(
								G.consumeables.T.x + G.consumeables.T.w / 2,
								G.consumeables.T.y,
								G.CARD_W, G.CARD_H, nil, center,
								{ bypass_discovery_center = true, bypass_discovery_ui = true, discover = true }
							)
							tarot:start_materialize()
							tarot:add_to_deck()
							G.consumeables:emplace(tarot)
							card_eval_status_text(card, "extra", nil, nil, nil, {
								message = localize("k_wof_royal_glass_trigger"),
								colour = G.C.PURPLE,
							})
							return true
						end,
					}))
				end
			end
		end
	end,
})
