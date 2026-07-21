-- End-of-round payout jokers handled via calc_dollar_bonus
local END_OF_ROUND_ECONOMY_JOKERS = {
	j_golden = true,
	j_rocket = true,
	j_cloud_9 = true,
	j_satellite = true,
	j_delayed_grat = true,
	j_to_the_moon = true,
}

local function has_joker(key)
	if not G.jokers then
		return false
	end
	for _, j in ipairs(G.jokers.cards) do
		if j.config.center.key == key then
			return true
		end
	end
	return false
end

local function we_are_rich_end_round_bonus(joker, default_dollars)
	if joker.config.center.key == "j_rocket" then
		return joker.ability.extra.dollars or default_dollars
	end
	return default_dollars
end

SMODS.Joker({
	key = "we_are_rich",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	config = { extra = { dollars = 1 } },
	loc_vars = function(self, info_queue, card)
		local count = 0
		if G.jokers then
			for _, j in ipairs(G.jokers.cards) do
				if j ~= card and END_OF_ROUND_ECONOMY_JOKERS[j.config.center.key] then
					count = count + 1
				end
			end
		end
		return { vars = { card.ability.extra.dollars, count } }
	end,
	-- +$1 per end-of-round economy joker at end of round
	calc_dollar_bonus = function(self, card)
		local bonus = 0
		for i = 1, #G.jokers.cards do
			local j = G.jokers.cards[i]
			if j ~= card and END_OF_ROUND_ECONOMY_JOKERS[j.config.center.key] then
				bonus = bonus + we_are_rich_end_round_bonus(j, card.ability.extra.dollars)
			end
		end
		return bonus > 0 and bonus or nil
	end,
	calculate = function(self, card, context)
		if context.blueprint then
			return
		end

		-- Per played card (Golden Ticket, Business Card, Rough Gem)
		if context.individual and context.cardarea == G.play then
			local dollars = 0
			if has_joker("j_ticket") and SMODS.has_enhancement(context.other_card, "m_gold") then
				dollars = dollars + 1
			end
			if has_joker("j_business") and context.other_card:is_face() then
				dollars = dollars + 1
			end
			if has_joker("j_rough_gem") and context.other_card:is_suit("Diamonds") then
				dollars = dollars + 1
			end
			if dollars > 0 then
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + dollars
				G.E_MANAGER:add_event(Event({ func = function()
					G.GAME.dollar_buffer = 0
					return true
				end }))
				return { dollars = dollars, card = card }
			end
		end

		-- Per held card (Reserved Parking)
		if context.individual and context.cardarea == G.hand then
			if has_joker("j_reserved_parking") and context.other_card:is_face() and not context.other_card.debuff then
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 1
				G.E_MANAGER:add_event(Event({ func = function()
					G.GAME.dollar_buffer = 0
					return true
				end }))
				return { dollars = 1, card = card }
			end
		end

		-- Per discard (Mail-In Rebate, Faceless Joker, Trading Card)
		if context.pre_discard then
			local dollars = 0
			if
				has_joker("j_mail")
				and context.other_card
				and not context.other_card.debuff
				and context.other_card:get_id() == G.GAME.current_round.mail_card.id
			then
				dollars = dollars + 1
			end
			if has_joker("j_faceless") and context.other_card == context.full_hand[#context.full_hand] then
				local face_count = 0
				for _, v in ipairs(context.full_hand) do
					if v:is_face() then
						face_count = face_count + 1
					end
				end
				if face_count >= 3 then
					dollars = dollars + 1
				end
			end
			if has_joker("j_trading") and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
				dollars = dollars + 1
			end
			if dollars > 0 then
				ease_dollars(dollars)
				return { message = localize("$") .. dollars, colour = G.C.MONEY }
			end
		end

		-- Per hand scored (To Do List)
		if context.joker_main and context.scoring_name then
			local dollars = 0
			for _, j in ipairs(G.jokers.cards) do
				if j.config.center.key == "j_todo_list" and context.scoring_name == j.ability.to_do_poker_hand then
					dollars = dollars + card.ability.extra.dollars
				end
			end
			if dollars > 0 then
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + dollars
				G.E_MANAGER:add_event(Event({ func = function()
					G.GAME.dollar_buffer = 0
					return true
				end }))
				return { dollars = dollars, card = card }
			end
		end

		-- Boss blind trigger (Matador)
		if context.debuffed_hand then
			if has_joker("j_matador") and G.GAME.blind.triggered then
				ease_dollars(1)
				return { message = localize("$") .. "1", colour = G.C.MONEY }
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})

local lgg_center = SMODS.Joker.obj_table["j_mp_lets_go_gambling"]
if lgg_center then
	local orig_calculate = lgg_center.calculate
	SMODS.Joker:take_ownership("mp_lets_go_gambling", {
		calculate = function(self, card, context)
			local result = orig_calculate and orig_calculate(self, card, context)
			if result and result.dollars then
				for _, j in ipairs(G.jokers.cards) do
					if j.config.center.key == "j_wheeloffortune_we_are_rich" then
						local war_card = j
						G.E_MANAGER:add_event(Event({
							func = function()
								ease_dollars(1)
								card_eval_status_text(war_card, "extra", nil, nil, nil, {
									message = localize("$") .. "1",
									colour = G.C.MONEY,
								})
								return true
							end,
						}))
						break
					end
				end
			end
			return result
		end,
	}, true)
end
