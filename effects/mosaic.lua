WOF.mosaic_suit = nil

local SUITS = { "Hearts", "Diamonds", "Clubs", "Spades" }

WOF.Effect({
	key = "mosaic",
	display_name = "Mosaic",
	message = "k_wof_effect_mosaic",
	is_shared = false,
	removal_mode = "end_ante",
	flag = "mosaic",
	joker_key = "j_wheeloffortune_mosaic",
	on_add = function(self)
		WOF.mosaic_suit = SUITS[math.random(#SUITS)]
		WOF.default_on_add(self)
	end,
}):inject()
