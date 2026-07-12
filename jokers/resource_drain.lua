SMODS.Joker({
	key = "resource_drain",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.end_of_round and WOF.flags.resource_drain and not context.blueprint then
			WOF.resource_drain_hands_saved = math.max(1, G.GAME.current_round.hands_left or 0)
			WOF.resource_drain_discards_saved = G.GAME.current_round.discards_left or 0
			G.GAME.current_round.hands_left = WOF.resource_drain_hands_saved
		end
		if
			context.setting_blind
			and WOF.flags.resource_drain
			and not context.blueprint
			and WOF.resource_drain_hands_saved ~= nil
		then
			local saved_hands = WOF.resource_drain_hands_saved
			local saved_discards = WOF.resource_drain_discards_saved or 0
			WOF.resource_drain_hands_saved = nil
			WOF.resource_drain_discards_saved = nil
			G.E_MANAGER:add_event(Event({
				func = function()
					local target_hands = math.max(1, saved_hands or 0)
					G.GAME.current_round.hands_left = target_hands
					local discards_delta = saved_discards - (G.GAME.current_round.discards_left or 0)
					if discards_delta ~= 0 then
						ease_discard(discards_delta)
					end
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.1,
						func = function()
							G.GAME.current_round.hands_left = math.max(1, G.GAME.current_round.hands_left or 0)
							return true
						end,
					}))
					return true
				end,
			}))
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
