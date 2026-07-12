WOF.economic_boom_total_spent = 0
WOF.economic_boom_ante_start = 0
WOF.economic_boom_effect_start = nil
WOF.economic_boom_paid = false
WOF.economic_boom_pending_rebate = nil

local ease_dollars_ref = ease_dollars
ease_dollars = function(mod, instant)
	if mod < 0 then
		WOF.economic_boom_total_spent = WOF.economic_boom_total_spent + math.abs(mod)
	end
	return ease_dollars_ref(mod, instant)
end

WOF.Effect({
	key = "economic_boom",
	display_name = "Economic Boom",
	message = "k_wof_effect_economic_boom",
	is_shared = false,
	removal_mode = "end_ante",
	on_add = function(self)
		WOF.economic_boom_effect_start = WOF.economic_boom_ante_start or WOF.economic_boom_total_spent or 0
		WOF.economic_boom_paid = false
		WOF.economic_boom_pending_rebate = nil
	end,
	on_remove = function(self)
		WOF.economic_boom_pending_rebate = math.floor(
			((WOF.economic_boom_total_spent or 0) - (WOF.economic_boom_effect_start or WOF.economic_boom_ante_start or 0))
				* 0.1
		)
		WOF.economic_boom_effect_start = nil
		WOF.economic_boom_paid = false
	end,
}):inject()

local add_round_eval_row_ref = add_round_eval_row
function add_round_eval_row(config)
	if
		config
		and config.name == "bottom"
		and WOF.economic_boom_pending_rebate
		and WOF.economic_boom_pending_rebate > 0
		and not WOF.economic_boom_paid
	then
		local rebate = WOF.economic_boom_pending_rebate
		WOF.economic_boom_paid = true
		WOF.economic_boom_pending_rebate = nil
		if rebate > 0 then
			add_round_eval_row_ref({
				dollars = rebate,
				bonus = true,
				name = "custom_wof_economic_boom",
				pitch = 1.15,
				text = "Economic Boom",
				text_colour = G.C.MONEY,
				number = "10%",
				number_colour = G.C.MONEY,
			})
			config.dollars = (config.dollars or 0) + rebate
		end
	end
	return add_round_eval_row_ref(config)
end
