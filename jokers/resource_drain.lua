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
		if context.setting_blind and WOF.resource_drain_hands_saved ~= nil then
			G.GAME.current_round.hands_left = WOF.resource_drain_hands_saved
			G.GAME.current_round.discards_left = WOF.resource_drain_discards_saved
			WOF.resource_drain_hands_saved = nil
			WOF.resource_drain_discards_saved = nil
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
