WOF.Effect({
	key = "master_thief",
	message = "k_wof_effect_master_thief",
	is_shared = false,
	min_ante = 0,
	on_add = function(self)
		if MP and MP.ACTIONS then
			MP.ACTIONS.modded("WheelOfFortune", "master_thief_request", {})
		end
	end,
}):inject()
