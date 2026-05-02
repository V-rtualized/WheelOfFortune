local function pick_boss_blind(seed_str)
	local ante = G.GAME.round_resets.ante or 1
	local win_ante = G.GAME.win_ante or 8
	local is_showdown_ante = (ante % win_ante == 0) and (ante >= 2)
	local eligible = {}
	for k, v in pairs(G.P_BLINDS) do
		if v.boss then
			local is_showdown = v.boss.showdown or false
			if is_showdown == is_showdown_ante then
				eligible[k] = true
			end
		end
	end
	local _, chosen = pseudorandom_element(eligible, pseudoseed(seed_str .. ante))
	return chosen
end

WOF.Effect({
	key = "boss_interference",
	message = "k_wof_effect_boss_interference",
	is_shared = true,
	removal_mode = "end_ante",
	flag = "boss_interference",
	on_add = function(self)
		WOF.flags[self.flag] = true
		local small_boss = pick_boss_blind("wof_bi_small")
		local big_boss = pick_boss_blind("wof_bi_big")
		if small_boss then
			G.GAME.round_resets.blind_choices.Small = small_boss
		end
		if big_boss then
			G.GAME.round_resets.blind_choices.Big = big_boss
		end
	end,
	on_remove = function(self)
		WOF.flags[self.flag] = false
		if G.GAME and G.GAME.round_resets and G.GAME.round_resets.blind_choices then
			G.GAME.round_resets.blind_choices.Small = "bl_small"
			G.GAME.round_resets.blind_choices.Big = "bl_big"
		end
	end,
}):inject()
