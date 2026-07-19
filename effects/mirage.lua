WOF.Effect({
	key = "mirage",
	display_name = "Mirage",
	message = "k_wof_effect_mirage",
	is_shared = false,
	on_add = function(self)
		WOF.flags.mirage = true
		WOF.flags.mirage_past_blind = false
	end,
}):inject()

local select_blind_ref = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
	if WOF.flags.mirage then
		WOF.flags.mirage_past_blind = true
	end
	select_blind_ref(e)
end

local emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	emplace_ref(self, card, ...)
	if WOF.flags.mirage and WOF.flags.mirage_past_blind and self == G.shop_jokers then
		WOF.flags.mirage = false
		WOF.flags.mirage_past_blind = false
		G.E_MANAGER:add_event(Event({
			func = function()
				local new_card = create_card("Joker", G.shop_jokers, true, nil, nil, nil, nil, "mir")
				new_card:set_edition({ negative = true }, true)
				if new_card.config.center.perishable_compat then
					new_card:set_perishable(true)
					new_card.ability.perish_tally = 2
				end
				new_card.base_cost = 10
				new_card:set_cost()
				G.shop_jokers:emplace(new_card)
				create_shop_card_ui(new_card, "Joker", G.shop_jokers)
				return true
			end,
		}))
	end
end
