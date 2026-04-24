SMODS.Booster({
	key = "doing_nothing_pack",
	atlas = "Booster",
	pos = { x = 3, y = 4 },
	prefix_config = { atlas = false },
	cost = 0,
	weight = 0,
	kind = "Spectral",
	config = { extra = 8, choose = 2 },
	loc_txt = {
		name = "Mega Spectral Pack",
		text = {
			"Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} cards",
		},
		group_name = "Spectral Pack",
	},
	in_pool = function(self, args)
		return false
	end,
})
