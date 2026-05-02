SMODS.Joker({
	key = "dicarderito",
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
		if context.setting_blind and WOF.flags.dicarderito and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					local h = G.GAME.current_round.hands_left
					local d = G.GAME.current_round.discards_left
					ease_hands_played(d - h)
					ease_discard(h - d, nil, true)
					return true
				end,
			}))
		end
	end,
})
