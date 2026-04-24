SMODS.Booster({
	key = "doing_nothing_pack",
	atlas = "Booster",
	pos = { x = 3, y = 4 },
	prefix_config = { atlas = false },
	cost = 0,
	weight = 0,
	kind = "Spectral",
	draw_hand = true,
	config = { extra = 8, choose = 2 },
	loc_txt = {
		name = "Mega Spectral Pack",
		text = {
			"Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{} cards",
		},
		group_name = "Spectral Pack",
	},
	ease_background_colour = function(self)
		ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
	end,
	particles = function(self)
		G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
			timer = 0.015,
			scale = 0.1,
			initialize = true,
			lifespan = 3,
			speed = 0.2,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
			fill = true,
		})
		G.booster_pack_sparkles.fade_alpha = 1
		G.booster_pack_sparkles:fade(1, 0)
	end,
	create_card = function(self, card, i)
		return { set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "spe" }
	end,
	in_pool = function(self, args)
		return false
	end,
})
