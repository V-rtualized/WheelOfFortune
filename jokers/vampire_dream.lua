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
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			for _, v in ipairs(context.scoring_hand) do
				if not v.debuff then
					local key = ENHANCEMENTS[math.random(#ENHANCEMENTS)]
					v:set_ability(G.P_CENTERS[key], nil, true)
					G.E_MANAGER:add_event(Event({ func = function()
						v:juice_up()
						return true
					end }))
				end
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
