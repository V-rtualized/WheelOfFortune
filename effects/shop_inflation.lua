local function wof_inflate_card(card)
	if not card.ability.wof_inflated then
		card.ability.wof_inflated = true
		local multiplier = 1 + 0.1 * (G.GAME.round_resets.ante or 1)
		card.cost = math.floor(card.cost * multiplier + 0.5)
		card.sell_cost = math.max(1, math.floor(card.cost / 2)) + (card.ability.extra_value or 0)
		card.sell_cost_label = card.facing == "back" and "?" or card.sell_cost
	end
end

WOF.Effect({
	key = "shop_inflation",
	message = localize("k_wof_effect_shop_inflation"),
	is_shared = false,
	min_ante = 0,
	removal_mode = "end_ante",
	flag = "shop_inflation",
	joker_key = "j_wheeloffortune_shop_inflation",
	on_add = function(self)
		WOF.default_on_add(self)
		for _, area in ipairs({ G.shop_jokers, G.shop_booster, G.shop_vouchers }) do
			if area and area.cards then
				for _, card in ipairs(area.cards) do
					wof_inflate_card(card)
				end
			end
		end
	end,
}):inject()

local emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	emplace_ref(self, card, ...)
	if WOF.flags.shop_inflation and card and (self == G.shop_jokers or self == G.shop_booster or self == G.shop_vouchers) then
		wof_inflate_card(card)
	end
end
