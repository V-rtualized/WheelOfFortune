WOF.Effect({
	key = "shop_upgrade",
	message = "k_wof_effect_shop_upgrade",
	is_shared = false,
	min_ante = 0,
	on_add = function(self)
		if G.GAME.used_vouchers and G.GAME.used_vouchers["v_overstock_plus"] then
			return
		end
		if not G.GAME.shop then return end
		local slots_to_add = math.min(2, 4 - G.GAME.shop.joker_max)
		if slots_to_add <= 0 then return end
		WOF.flags.shop_upgrade_slots = slots_to_add
		G.E_MANAGER:add_event(Event({func = function()
			change_shop_size(slots_to_add)
			return true
		end}))
	end,
}):inject()

local select_blind_ref = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
	if WOF.flags.shop_upgrade_slots then
		G.E_MANAGER:add_event(Event({func = function()
			change_shop_size(-WOF.flags.shop_upgrade_slots)
			WOF.flags.shop_upgrade_slots = nil
			return true
		end}))
	end
	select_blind_ref(e)
end
