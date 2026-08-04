SMODS.Joker({
	key = "shop_taxes",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { WOF.shop_taxes_count or 0 },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and WOF.flags.shop_taxes and not context.blueprint and WOF.shop_taxes_count > 0 then
			G.E_MANAGER:add_event(Event({
				func = function()
					local hands_left = G.GAME.current_round.hands_left or 0
					local hands_to_remove = math.min(WOF.shop_taxes_count, math.max(0, hands_left - 1))
					if hands_to_remove > 0 then
						ease_hands_played(-hands_to_remove, true)
					end
					G.GAME.current_round.hands_left = math.max(1, G.GAME.current_round.hands_left or 0)
					return true
				end,
			}))
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
