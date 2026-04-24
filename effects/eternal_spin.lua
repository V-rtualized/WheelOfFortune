WOF.Effect({
	key = "eternal_spin",
	message = function()
		local ante = G.GAME.round_resets.ante or 1
		return "Gain/lose $" .. (5 * ante) .. ", then spin again"
	end,
	on_add = function(self)
		local ante = G.GAME.round_resets.ante or 1
		local delta = (math.random(2) == 1 and 1 or -1) * (5 * ante)
		G.E_MANAGER:add_event(Event({ func = function()
			ease_dollars(delta)
			return true
		end }))
		G.E_MANAGER:add_event(Event({
			trigger = "after", delay = 3.5,
			func = function()
				local saved = WOF.Effects["eternal_spin"]
				WOF.Effects["eternal_spin"] = nil
				local next_effect = WOF.get_random_effect(false)
				WOF.Effects["eternal_spin"] = saved
				if next_effect then WOF.show_effect(next_effect) end
				return true
			end,
		}))
	end,
}):inject()
