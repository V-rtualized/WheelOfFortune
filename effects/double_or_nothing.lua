WOF.Effect({
	key = "double_or_nothing",
	display_name = "Double or Nothing",
	message = "k_wof_effect_double_or_nothing",
	on_add = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				WOF.show_double_or_nothing_ui()
				return true
			end,
		}))
	end,
}):inject()
