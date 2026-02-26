function WOF.show_shared_spin_ui()
	WOF.shared_spin_ui = UIBox({
		definition = {
			n = G.UIT.ROOT,
			config = { align = "cm", colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize("k_wait_enemy"),
						scale = 0.8,
						colour = G.C.WHITE,
						shadow = true,
					},
				},
			},
		},
		config = { align = "cm", offset = { x = 0, y = -1.5 }, major = G.play },
	})

	if not MP.LOBBY.is_host then
		MP.ACTIONS.modded("WheelOfFortune", "ready_for_spin", {})
	end
end

function WOF.do_shared_spin()
	if WOF.shared_spin_sent then return end
	WOF.shared_spin_sent = true

	local effect = WOF.get_random_effect(true)
	if not effect then
		WOF.shared_spin_complete = true
		return
	end

	MP.ACTIONS.modded("WheelOfFortune", "shared_spin", {
		effect_key = effect.key,
	}, "all")
end
