WOF.Effects = {}

function WOF.default_on_add(self)
	if self.flag then
		WOF.flags[self.flag] = true
	end
	if self.joker_key then
		for _, card in ipairs(G.jokers.cards) do
			if card.config.center_key == self.joker_key then
				return
			end
		end
		local card = create_card("Joker", G.jokers, false, nil, nil, nil, self.joker_key)
		card.ability.eternal = true
		card:set_edition("e_negative")
		card.ability.extra_value = -2
		card:set_cost()
		card:add_to_deck()
		G.jokers:emplace(card)
	end
end

function WOF.default_on_remove(self)
	if self.flag then
		WOF.flags[self.flag] = false
	end
	if self.joker_key then
		for i = #G.jokers.cards, 1, -1 do
			if G.jokers.cards[i].config.center_key == self.joker_key then
				local card = G.jokers.cards[i]
				card.ability.eternal = false
				card:start_dissolve()
				break
			end
		end
	end
end

WOF.Effect = SMODS.GameObject:extend({
	obj_table = {},
	obj_buffer = {},
	required_params = {
		"key",
		"message",
	},
	class_prefix = "wof_effect",
	is_shared = false,
	min_ante = 0,
	removal_mode = "manual",
	on_add = WOF.default_on_add,
	on_remove = WOF.default_on_remove,
	inject = function(self)
		WOF.Effects[self.key] = self
	end,
})

-- Set keys to true to restrict which effects can roll (nil = no restriction)
WOF.debug_whitelist = {
	personal = { wof_effect_wheeloffortune_we_are_rich = true },
	shared = { wof_effect_wheeloffortune_wrong_loyalty = true },
}

function WOF.get_random_effect(shared)
	local whitelist = shared and WOF.debug_whitelist and WOF.debug_whitelist.shared
		or (not shared and WOF.debug_whitelist and WOF.debug_whitelist.personal)
	local current_ante = G.GAME.round_resets.ante or 0

	local function is_flag_blocked(effect)
		if effect.incompatible_flags then
			for _, flag in ipairs(effect.incompatible_flags) do
				if WOF.flags[flag] then
					return true
				end
			end
		end
		return false
	end

	local all_eligible = {}
	for _, effect in pairs(WOF.Effects) do
		if effect.is_shared == shared and current_ante >= effect.min_ante then
			if not whitelist or whitelist[effect.key] then
				if not is_flag_blocked(effect) then
					all_eligible[#all_eligible + 1] = effect
				end
			end
		end
	end
	if #all_eligible == 0 then
		return nil
	end

	if shared then
		-- Exclude effects seen this cycle; when all have been seen, reset and pick freely
		local unseen = {}
		for _, effect in ipairs(all_eligible) do
			if not WOF.shared_seen[effect.key] then
				unseen[#unseen + 1] = effect
			end
		end
		if #unseen == 0 then
			WOF.shared_seen = {}
			return all_eligible[math.random(#all_eligible)]
		end
		return unseen[math.random(#unseen)]
	else
		-- Exclude effects in the last-3 cooldown queue; fall back to full pool if all blocked
		local on_cooldown = {}
		for _, key in ipairs(WOF.personal_cooldown) do
			on_cooldown[key] = true
		end
		local eligible = {}
		for _, effect in ipairs(all_eligible) do
			if not on_cooldown[effect.key] then
				eligible[#eligible + 1] = effect
			end
		end
		if #eligible == 0 then
			eligible = all_eligible
		end
		return eligible[math.random(#eligible)]
	end
end

function WOF.show_announcement(msg_key)
	local msg = localize(msg_key)
	local entry = { key = msg_key, message = msg, is_shared = false }
	table.insert(WOF.effect_history, 1, entry)
	if #WOF.effect_history > 10 then
		table.remove(WOF.effect_history)
	end
	play_sound("tarot1")
	local msg_scale = math.max(0.6, math.min(1.4, 1.4 - (#msg - 18) * 0.4 / 27))
	attention_text({
		text = msg,
		scale = msg_scale,
		hold = 8,
		align = "cm",
		major = G.play,
		backdrop_colour = G.C.GOLD,
	})
end

function WOF.show_effect(effect)
	local msg = type(effect.message) == "function" and effect.message() or localize(effect.message)
	local entry = {
		key = effect.key,
		message = msg,
		is_shared = effect.is_shared,
	}
	if effect.removal_mode == "shared" or effect.removal_mode == "end_ante" then
		entry.ante = G.GAME.round_resets.ante or 0
	end
	table.insert(WOF.effect_history, 1, entry)
	if #WOF.effect_history > 10 then
		table.remove(WOF.effect_history)
	end

	play_sound("tarot1")

	local msg_scale = math.max(0.6, math.min(1.4, 1.4 - (#msg - 18) * 0.4 / 27))

	attention_text({
		text = msg,
		scale = msg_scale,
		hold = 8,
		align = "cm",
		major = G.play,
		backdrop_colour = G.C.GOLD,
	})

	-- Capture before on_add because doing_nothing sets the flag inside on_add
	local is_first_doing_nothing = (effect.key == "wof_effect_wheeloffortune_doing_nothing")
		and not WOF.doing_nothing_triggered

	effect:on_add()

	if effect.removal_mode == "end_ante" then
		table.insert(WOF.active_effects, effect.key)
	end

	if effect.is_shared then
		WOF.shared_seen[effect.key] = true
	elseif not is_first_doing_nothing then
		table.insert(WOF.personal_cooldown, effect.key)
		if #WOF.personal_cooldown > 3 then
			table.remove(WOF.personal_cooldown, 1)
		end
	end
end
