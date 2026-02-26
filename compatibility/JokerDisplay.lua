if SMODS.Mods["JokerDisplay"] and SMODS.Mods["JokerDisplay"].can_load then
	if JokerDisplay then
		local jd_def = JokerDisplay.Definitions

		jd_def["j_wheeloffortune_wrong_loyalty"] = {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "x_mult" },
					},
				},
			},
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "loyalty_status" },
				{ text = ")" },
			},
			calc_function = function(card)
				card.joker_display_values.x_mult = card.ability.extra.loyalty_remaining == card.ability.extra.every
						and card.ability.extra.Xmult
					or 1
				card.joker_display_values.loyalty_status = localize({
					type = "variable",
					key = (card.ability.extra.loyalty_remaining == 0 and "loyalty_active" or "loyalty_inactive"),
					vars = { card.ability.extra.loyalty_remaining },
				})
			end,
		}

		jd_def["j_wheeloffortune_haha"] = {}
	end
end
