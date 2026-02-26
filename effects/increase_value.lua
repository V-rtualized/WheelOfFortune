WOF.Effect({
	key = "increase_value",
	message = "Increase sell value of a random joker by $10",
	is_shared = false,
	min_ante = 0,
	on_add = function(self)
		if not G.jokers or not G.jokers.cards or #G.jokers.cards == 0 then return end
		local joker = G.jokers.cards[math.random(#G.jokers.cards)]
		joker.ability.extra_value = (joker.ability.extra_value or 0) + 10
		joker:set_cost()
		joker:juice_up()
	end,
}):inject()
