WOF.Effect({
	key = "legendary_comeback",
	display_name = "Immolate",
	message = "k_wof_effect_legendary_comeback",
	is_shared = false,
	removal_mode = "manual",
	on_add = function(self)
		WOF.flags.legendary_comeback_target = math.random(1, 50)
		WOF.flags.legendary_comeback_count = 0
	end,
	on_remove = function(self)
		WOF.flags.legendary_comeback_target = nil
		WOF.flags.legendary_comeback_count = nil
	end,
}):inject()

local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if
		WOF.flags.legendary_comeback_target
		and (_type == "Spectral" or _type == "Tarot" or _type == "Tarot_Planet")
		and not forced_key
	then
		WOF.flags.legendary_comeback_count = WOF.flags.legendary_comeback_count + 1
		if WOF.flags.legendary_comeback_count >= WOF.flags.legendary_comeback_target then
			forced_key = "c_immolate"
			local unbanned = false
			if G.GAME.banned_keys["c_immolate"] then
				G.GAME.banned_keys["c_immolate"] = nil
				unbanned = true
			end
			local card =
				create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
			if unbanned then
				G.GAME.banned_keys["c_immolate"] = true
			end
			WOF.flags.legendary_comeback_target = nil
			WOF.flags.legendary_comeback_count = nil
			return card
		end
	end
	return create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end
