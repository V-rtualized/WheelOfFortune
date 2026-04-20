SMODS.Joker({
	key = "find_me",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		local rank_label = WOF.find_me_round.label and localize(WOF.find_me_round.label, 'ranks') or '?'
		return { vars = { rank_label } }
	end,
	calculate = function(self, card, context)
		if context.repetition_only and context.cardarea == G.play
		   and WOF.flags.find_me and not context.blueprint
		   and context.other_card:get_id() == (WOF.find_me_round.id or -1) then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = self,
			}
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
