WOF.foil_factory_count = 0

WOF.Effect({
	key = "foil_factory",
	message = "k_wof_effect_foil_factory",
	is_shared = false,
	removal_mode = "manual",
	on_add = function(self)
		WOF.foil_factory_count = 5
		WOF.flags.foil_factory = true
		if G.shop_jokers and G.shop_jokers.cards then
			for _, card in ipairs(G.shop_jokers.cards) do
				if WOF.foil_factory_count <= 0 then break end
				if not card.edition then
					card:set_edition({ foil = true }, true)
				end
				WOF.foil_factory_count = WOF.foil_factory_count - 1
			end
		end
		if WOF.foil_factory_count <= 0 then
			WOF.flags.foil_factory = false
		end
	end,
}):inject()

local emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	emplace_ref(self, card, ...)
	if WOF.flags.foil_factory and self == G.shop_jokers
		and card and card.config and card.config.center and card.config.center.set == "Joker"
	then
		if not card.edition then
			card:set_edition({ foil = true }, true)
		end
		WOF.foil_factory_count = WOF.foil_factory_count - 1
		if WOF.foil_factory_count <= 0 then
			WOF.flags.foil_factory = false
		end
	end
end
