SMODS.Joker({
	key = "suit_mastery",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		local suit = WOF.suit_mastery_suit or "Hearts"
		return {
			vars = {
				localize(suit, "suits_singular"),
				colours = { G.C.SUITS[suit] },
			},
		}
	end,
	in_pool = function(self, args)
		return false
	end,
})
