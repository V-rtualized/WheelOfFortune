WOF.find_me_round = { id = nil, label = nil }

WOF.pick_find_me_rank = function()
	local valid = {}
	for _, v in ipairs(G.playing_cards) do
		if v.ability.effect ~= "Stone Card" and not SMODS.has_no_rank(v) then
			valid[#valid + 1] = v
		end
	end
	if not valid[1] then
		return
	end

	local blind_states = G.GAME.round_resets.blind_states
	local offset = 0
	if blind_states.Big == "Current" then
		offset = 1
	elseif blind_states.Boss == "Current" then
		offset = 2
	end

	local ante = G.GAME.round_resets.ante or 0
	local card = pseudorandom_element(valid, pseudoseed("wof_find_me" .. ante .. offset))
	WOF.find_me_round.id = card.base.id
	WOF.find_me_round.label = card.base.value
end

-- Called by SMODS at end of each round (reset_deck=false) and run start (reset_deck=true)
WOF.reset_game_globals = function(reset_deck)
	if not reset_deck and WOF.flags.find_me then
		WOF.pick_find_me_rank()
	end
end

WOF.Effect({
	key = "find_me",
	message = "k_wof_effect_find_me",
	is_shared = true,
	removal_mode = "end_ante",
	flag = "find_me",
	joker_key = "j_wheeloffortune_find_me",
	on_add = function(self)
		WOF.default_on_add(self)
		WOF.pick_find_me_rank()
	end,
}):inject()
