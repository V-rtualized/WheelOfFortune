SMODS.Joker({
	key = "mosaic",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		local suit = WOF.mosaic_suit or 'Hearts'
		return {
			vars = {
				localize(suit, 'suits_plural'),
				colours = { G.C.SUITS[suit] },
			},
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play
		   and WOF.flags.mosaic and not context.blueprint then
			if context.other_card:is_suit(WOF.mosaic_suit or '') then
				return { mult = 10, card = self }
			else
				return { mult = -5, card = self }
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
