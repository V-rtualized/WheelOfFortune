WOF.Effect({
	key = "pack_insight",
	message = "k_wof_effect_pack_insight",
	is_shared = false,
	on_add = function(self)
		local arcana_keys = {
			"p_arcana_normal_1",
			"p_arcana_normal_2",
			"p_arcana_normal_3",
			"p_arcana_normal_4",
			"p_arcana_jumbo_1",
			"p_arcana_jumbo_2",
			"p_arcana_mega_1",
			"p_arcana_mega_2",
		}
		local buffoon_keys = {
			"p_buffoon_normal_1",
			"p_buffoon_normal_2",
			"p_buffoon_jumbo_1",
			"p_buffoon_mega_1",
		}
		local pool = math.random(2) == 1 and arcana_keys or buffoon_keys
		local key = pool[math.random(#pool)]
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
