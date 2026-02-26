local evaluate_round_ref = G.FUNCS.evaluate_round
G.FUNCS.evaluate_round = function()
	if G.after_pvp then
		WOF.needs_shared_spin = true
	end
	evaluate_round_ref()
end

local update_shop_ref = Game.update_shop

function Game:update_shop(dt)
	if MP and MP.LOBBY and MP.LOBBY.code and WOF.needs_shared_spin then
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
