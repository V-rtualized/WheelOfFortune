local ENHANCEMENTS = {
	'm_bonus', 'm_mult', 'm_wild', 'm_steel', 'm_stone', 'm_gold', 'm_lucky',
}

SMODS.Joker({
	key = "vampire_dream",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			local key = ENHANCEMENTS[math.random(#ENHANCEMENTS)]
			context.other_card:set_ability(G.P_CENTERS[key], nil, true)
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
