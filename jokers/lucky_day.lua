SMODS.Joker({
	key = "lucky_day",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			if context.identifier == "lucky_mult" or context.identifier == "lucky_money" then
				return { numerator = context.numerator * 2 }
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
