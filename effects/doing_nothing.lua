WOF.doing_nothing_triggered = false

WOF.Effect({
	key = "doing_nothing",
	display_name = "Doing Nothing?",
	message = "k_wof_effect_doing_nothing_first",
	is_shared = false,
	on_add = function(self)
		if not WOF.doing_nothing_triggered then
			WOF.doing_nothing_triggered = true
			self.message = "k_wof_effect_doing_nothing_second"
			return
		end
		local key = "p_wheeloffortune_doing_nothing_pack"
		local card = Card(
			G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
			G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
			G.CARD_W * 1.27,
			G.CARD_H * 1.27,
			G.P_CARDS.empty,
			G.P_CENTERS[key],
			{ bypass_discovery_center = true, bypass_discovery_ui = true }
		)
		card.cost = 0
		card.from_tag = true
		G.FUNCS.use_card({ config = { ref_table = card } })
		card:start_materialize()
	end,
}):inject()
