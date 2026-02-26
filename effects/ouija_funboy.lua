WOF.Effect({
	key = "ouija_funboy",
	message = "All spectrals are Ouija",
	is_shared = false,
	min_ante = 0,
	removal_mode = "end_ante",
	flag = "ouija_funboy",
	joker_key = "j_wheeloffortune_ouija_funboy",
}):inject()

local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local unbanned = false
	if WOF.flags.ouija_funboy and _type == "Spectral" and not forced_key then
		forced_key = "c_ouija"
		if G.GAME.banned_keys["c_ouija"] then
			G.GAME.banned_keys["c_ouija"] = nil
			unbanned = true
		end
	end
	local card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if unbanned then
		G.GAME.banned_keys["c_ouija"] = true
	end
	return card
end
