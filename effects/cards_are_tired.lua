WOF.cards_are_tired_debuffed = nil

WOF.Effect({
	key = "cards_are_tired",
	display_name = "Cards Are Tired",
	message = function()
		local ante = G.GAME.round_resets.ante or 1
		return (4 * (ante - 1)) .. " cards debuffed this ante"
	end,
	is_shared = false,
	min_ante = 2,
	removal_mode = "end_ante",
	flag = "cards_are_tired",
	joker_key = "j_wheeloffortune_cards_are_tired",
	on_add = function(self)
		WOF.default_on_add(self)
		local ante = G.GAME.round_resets.ante or 1
		local count = 4 * (ante - 1)
		local pool = {}
		for _, card in ipairs(G.playing_cards) do
			if not card.debuff then
				pool[#pool + 1] = card
			end
		end
		WOF.cards_are_tired_debuffed = {}
		for i = 1, math.min(count, #pool) do
			local idx = math.random(#pool)
			local card = table.remove(pool, idx)
			card.ability.debuff_sources = card.ability.debuff_sources or {}
			card.ability.debuff_sources["wof_cards_are_tired"] = true
			SMODS.recalc_debuff(card)
			WOF.cards_are_tired_debuffed[#WOF.cards_are_tired_debuffed + 1] = card
		end
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
		if WOF.cards_are_tired_debuffed then
			for _, card in ipairs(WOF.cards_are_tired_debuffed) do
				if card.ability and card.ability.debuff_sources then
					card.ability.debuff_sources["wof_cards_are_tired"] = nil
					SMODS.recalc_debuff(card)
				end
			end
			WOF.cards_are_tired_debuffed = nil
		end
	end,
}):inject()
