WOF.shop_taxes_count = 0

WOF.Effect({
	key = "shop_taxes",
	display_name = "Shop Taxes",
	message = "k_wof_effect_shop_taxes",
	is_shared = true,
	removal_mode = "end_ante",
	flag = "shop_taxes",
	joker_key = "j_wheeloffortune_shop_taxes",
	on_add = function(self)
		WOF.default_on_add(self)
		WOF.shop_taxes_count = 0
	end,
}):inject()

local emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	emplace_ref(self, card, ...)
	if
		WOF.flags.shop_taxes
		and self == G.jokers
		and card
		and card.ability
		and card.ability.set == "Joker"
		and not card.ability.eternal
		and G.STATE == G.STATES.SHOP
	then
		WOF.shop_taxes_count = WOF.shop_taxes_count + 1
	end
end
