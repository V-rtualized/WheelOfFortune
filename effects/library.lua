WOF.Effect({
	key = "library",
	message = "k_wof_effect_library",
	is_shared = false,
	removal_mode = "end_ante",
	flag = "library",
	joker_key = "j_wheeloffortune_library",
	on_add = function(self)
		WOF.default_on_add(self)
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
	end,
}):inject()

local create_card_ref_library = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local unbanned = false
	if WOF.flags.library and _type == "Tarot" and not forced_key and key_append == "ar1" then
		forced_key = "c_fool"
		if G.GAME.banned_keys["c_fool"] then
			G.GAME.banned_keys["c_fool"] = nil
			unbanned = true
		end
	end
	local card =
		create_card_ref_library(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if unbanned then
		G.GAME.banned_keys["c_fool"] = true
	end
	return card
end
