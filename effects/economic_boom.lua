WOF.economic_boom_total_spent = 0
WOF.economic_boom_ante_start = 0

local ease_dollars_ref = ease_dollars
ease_dollars = function(mod, instant)
	if mod < 0 then
		WOF.economic_boom_total_spent = WOF.economic_boom_total_spent + math.abs(mod)
	end
	return ease_dollars_ref(mod, instant)
end

WOF.Effect({
	key = "economic_boom",
	message = "k_wof_effect_economic_boom",
	is_shared = false,
	removal_mode = "end_ante",
	on_remove = function(self)
		local rebate = math.floor((WOF.economic_boom_total_spent - WOF.economic_boom_ante_start) * 0.1)
		if rebate > 0 then
			ease_dollars(rebate)
		end
	end,
}):inject()
