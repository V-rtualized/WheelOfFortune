local TRAINING_WEIGHTS_MODS = {
	-- Flat +Mult (ability.mult)
	j_joker = function(a)
		a.mult = a.mult * 2
	end,
	j_popcorn = function(a)
		a.mult = a.mult * 2
	end,
	j_swashbuckler = function(a)
		a.mult = a.mult * 2
	end,

	-- Type-conditional +Mult (ability.t_mult)
	j_jolly = function(a)
		a.t_mult = a.t_mult * 2
	end,
	j_zany = function(a)
		a.t_mult = a.t_mult * 2
	end,
	j_mad = function(a)
		a.t_mult = a.t_mult * 2
	end,
	j_crazy = function(a)
		a.t_mult = a.t_mult * 2
	end,
	j_droll = function(a)
		a.t_mult = a.t_mult * 2
	end,

	-- Type-conditional +Chips (ability.t_chips)
	j_sly = function(a)
		a.t_chips = a.t_chips * 2
	end,
	j_wily = function(a)
		a.t_chips = a.t_chips * 2
	end,
	j_clever = function(a)
		a.t_chips = a.t_chips * 2
	end,
	j_devious = function(a)
		a.t_chips = a.t_chips * 2
	end,
	j_crafty = function(a)
		a.t_chips = a.t_chips * 2
	end,

	-- ability.extra.mult (sub-table)
	j_half = function(a)
		a.extra.mult = a.extra.mult * 2
	end,
	j_mystic_summit = function(a)
		a.extra.mult = a.extra.mult * 2
	end,
	j_gros_michel = function(a)
		a.extra.mult = a.extra.mult * 2
	end,
	j_bootstraps = function(a)
		a.extra.mult = a.extra.mult * 2
	end,

	-- ability.extra.mult AND ability.extra.chips
	j_scholar = function(a)
		a.extra.mult = a.extra.mult * 2
		a.extra.chips = a.extra.chips * 2
	end,
	j_walkie_talkie = function(a)
		a.extra.mult = a.extra.mult * 2
		a.extra.chips = a.extra.chips * 2
	end,

	-- ability.extra (single int: mult per scored card / hand)
	j_fibonacci = function(a)
		a.extra = a.extra * 2
	end,
	j_even_steven = function(a)
		a.extra = a.extra * 2
	end,
	j_smiley = function(a)
		a.extra = a.extra * 2
	end,
	j_abstract = function(a)
		a.extra = a.extra * 2
	end,
	j_erosion = function(a)
		a.extra = a.extra * 2
	end,
	j_shoot_the_moon = function(a)
		a.extra = a.extra * 2
	end,
	j_onyx_agate = function(a)
		a.extra = a.extra * 2
	end,

	-- ability.extra (single int: chips per scored card / resource)
	j_banner = function(a)
		a.extra = a.extra * 2
	end,
	j_odd_todd = function(a)
		a.extra = a.extra * 2
	end,
	j_arrowhead = function(a)
		a.extra = a.extra * 2
	end,
	j_scary_face = function(a)
		a.extra = a.extra * 2
	end,
	j_blue_joker = function(a)
		a.extra = a.extra * 2
	end,
	j_stone = function(a)
		a.extra = a.extra * 2
	end,
	j_bull = function(a)
		a.extra = a.extra * 2
	end,

	-- ability.extra.s_mult (suit mult per card)
	j_greedy_joker = function(a)
		a.extra.s_mult = a.extra.s_mult * 2
	end,
	j_lusty_joker = function(a)
		a.extra.s_mult = a.extra.s_mult * 2
	end,
	j_wrathful_joker = function(a)
		a.extra.s_mult = a.extra.s_mult * 2
	end,
	j_gluttenous_joker = function(a)
		a.extra.s_mult = a.extra.s_mult * 2
	end,

	-- Flat +Chips (ability.extra.chip_mod)
	j_stuntman = function(a)
		a.extra.chip_mod = a.extra.chip_mod * 2
	end,

	-- Scaling +Chips: double current chip pool
	j_ice_cream = function(a)
		a.extra.chips = a.extra.chips * 2
	end,
	j_runner = function(a)
		a.extra.chips = a.extra.chips * 2
	end,
	j_square = function(a)
		a.extra.chips = a.extra.chips * 2
	end,
	j_wee = function(a)
		a.extra.chips = a.extra.chips * 2
	end,
}

WOF.Effect({
	key = "training_weights",
	message = "k_wof_effect_training_weights",
	is_shared = false,
	min_ante = 0,
	on_add = function(self)
		if not G.jokers then
			return
		end
		for _, joker in ipairs(G.jokers.cards) do
			local mod = TRAINING_WEIGHTS_MODS[joker.config.center.key]
			if mod then
				mod(joker.ability)
				joker:juice_up()
			end
		end
	end,
}):inject()
