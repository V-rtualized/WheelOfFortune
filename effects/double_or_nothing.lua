WOF.Effect({
	key = "double_or_nothing",
	message = "k_wof_effect_double_or_nothing",
	on_add = function(self)
		G.E_MANAGER:add_event(Event({ func = function()
			local bet = math.max(5, G.GAME.dollars)
			if math.random() < 0.5 then
				ease_dollars(bet)
			else
				ease_dollars(-bet, true)
			end
			return true
		end }))
	end,
}):inject()
