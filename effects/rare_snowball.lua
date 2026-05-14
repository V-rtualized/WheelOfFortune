WOF.Effect({
	key = "rare_snowball",
	display_name = "Rare Snowball",
	message = "k_wof_effect_rare_snowball",
	is_shared = false,
	removal_mode = "end_ante",
	on_add = function(self)
		G.GAME.rare_mod = (G.GAME.rare_mod or 1) * 2
	end,
	on_remove = function(self)
		if G.GAME.rare_mod then
			G.GAME.rare_mod = G.GAME.rare_mod / 2
			if G.GAME.rare_mod <= 1 then
				G.GAME.rare_mod = nil
			end
		end
	end,
}):inject()
