WOF.Effect({
	key = "recycling",
	display_name = "Recycling",
	message = "k_wof_effect_recycling",
	is_shared = false,
	removal_mode = "end_ante",
	flag = "recycling",
	joker_key = "j_wheeloffortune_recycling",
	on_add = function(self)
		WOF.default_on_add(self)
		for _, area in ipairs({ G.jokers, G.consumeables, G.hand }) do
			if area then
				for _, card in ipairs(area.cards) do
					card:set_cost()
				end
			end
		end
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
		for _, area in ipairs({ G.jokers, G.consumeables, G.hand }) do
			if area then
				for _, card in ipairs(area.cards) do
					card:set_cost()
				end
			end
		end
	end,
}):inject()

local set_cost_ref = Card.set_cost
function Card:set_cost(...)
	set_cost_ref(self, ...)
	if WOF.flags.recycling and self.cost and self.cost > 0 then
		self.sell_cost = self.cost + (self.ability.extra_value or 0)
		self.sell_cost_label = self.facing == "back" and "?" or self.sell_cost
	end
end
