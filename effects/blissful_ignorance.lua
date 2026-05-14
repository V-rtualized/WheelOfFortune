WOF.Effect({
	key = "blissful_ignorance",
	display_name = "Blissful Ignorance",
	message = "k_wof_effect_blissful_ignorance",
	is_shared = true,
	removal_mode = "end_ante",
	flag = "blissful_ignorance",
}):inject()

local blind_chip_UI_scale_ref = G.FUNCS.multiplayer_blind_chip_UI_scale
G.FUNCS.multiplayer_blind_chip_UI_scale = function(e)
	blind_chip_UI_scale_ref(e)
	if WOF.flags.blissful_ignorance and MP and MP.GAME and MP.GAME.enemy and MP.GAME.enemy.score then
		local my_chips = G.GAME.chips or 0
		local enemy_score = MP.GAME.enemy.score
		local enemy_gt_mine = MP.INSANE_INT.greater_than(enemy_score, MP.INSANE_INT.create(my_chips, 0, 0))
		MP.GAME.enemy.score_text = enemy_gt_mine and localize("k_wof_blissful_higher")
			or localize("k_wof_blissful_lower")
	end
end
