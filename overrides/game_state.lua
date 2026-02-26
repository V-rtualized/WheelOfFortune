local reset_game_states_ref = MP.reset_game_states
function MP.reset_game_states()
	WOF.wheel_spun_this_shop = false
	WOF.awaiting_shared_spin = false
	WOF.shared_spin_complete = false
	WOF.shared_spin_done_this_round = false
	WOF.needs_shared_spin = false
	WOF.guest_ready_for_spin = false
	WOF.shared_spin_sent = false
	WOF.active_shared_effect = nil
	WOF.active_effects = {}
	WOF.flags = {}
	G.after_pvp = nil
	reset_game_states_ref()
end

local ease_ante_ref = ease_ante
function ease_ante(mod)
	for i = #WOF.active_effects, 1, -1 do
		local effect = WOF.Effects[WOF.active_effects[i]]
		if effect and effect.removal_mode == "end_ante" then
			effect:on_remove()
			table.remove(WOF.active_effects, i)
		end
	end
	ease_ante_ref(mod)
end

local evaluate_round_ref = G.FUNCS.evaluate_round
G.FUNCS.evaluate_round = function()
	if G.after_pvp then
		WOF.needs_shared_spin = true
	end
	evaluate_round_ref()
end

local update_shop_ref = Game.update_shop

function Game:update_shop(dt)
	if WOF.is_active() and WOF.needs_shared_spin then
		if not WOF.shared_spin_done_this_round then
			if not WOF.awaiting_shared_spin then
				WOF.awaiting_shared_spin = true
				WOF.show_shared_spin_ui()
			end

			if MP.LOBBY.is_host and WOF.guest_ready_for_spin and not WOF.shared_spin_sent then
				WOF.do_shared_spin()
			end

			if not WOF.shared_spin_complete then
				return
			end

			WOF.awaiting_shared_spin = false
			WOF.shared_spin_complete = false
			WOF.shared_spin_done_this_round = true
			WOF.needs_shared_spin = false
		end
	end

	update_shop_ref(self, dt)
end
