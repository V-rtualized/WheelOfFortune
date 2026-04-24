local reset_game_states_ref = MP.reset_game_states
function MP.reset_game_states()
	WOF.wheel_spun_this_shop = false
	WOF.awaiting_shared_spin = false
	WOF.shared_spin_complete = false
	WOF.shared_spin_done_this_round = false
	WOF.needs_shared_spin = false
	WOF.guest_ready_for_spin = false
	WOF.shared_spin_sent = false
	WOF.active_shared_effect = nil
	WOF.active_effects = {}
	WOF.effect_history = {}
	WOF.flags = {}
	WOF.find_me_round = { id = nil, label = nil }
	WOF.lucky_day_converted = nil
	G.after_pvp = nil
	WOF.cards_are_tired_debuffed = nil
	WOF.dementia_decrements = nil

	WOF.doing_nothing_triggered = false
	local dn = WOF.Effects.doing_nothing
	if dn then dn.message = "k_wof_effect_doing_nothing_first" end
	WOF.planetary_alignment_count = 0
	WOF.suit_mastery_suit = nil
	WOF.tea_break_end_time = nil
	WOF.shop_taxes_count = 0
	WOF.shop_taxes_zero_hands = false
	WOF.shop_taxes_force_loss = false
	WOF.resource_drain_hands_saved = nil
	WOF.resource_drain_discards_saved = nil
	WOF.phantom_pain_saved_card = nil
	WOF.random_morph_fired = false
	if WOF.tea_break_audio then
		WOF.tea_break_audio:stop()
		WOF.tea_break_audio = nil
	end
	reset_game_states_ref()
end

local ease_ante_ref = ease_ante
function ease_ante(mod)
	for i = #WOF.active_effects, 1, -1 do
		local effect = WOF.Effects[WOF.active_effects[i]]
		if effect and effect.removal_mode == "end_ante" then
			effect:on_remove()
			table.remove(WOF.active_effects, i)
		end
	end
	ease_ante_ref(mod)
	WOF.economic_boom_ante_start = WOF.economic_boom_total_spent
end

local update_selecting_hand_wof_ref = Game.update_selecting_hand
function Game:update_selecting_hand(dt)
	if WOF.shop_taxes_zero_hands and MP.LOBBY.code and not MP.is_pvp_boss() then
		WOF.shop_taxes_zero_hands = false
		WOF.shop_taxes_force_loss = true
		G.STATE = G.STATES.NEW_ROUND
		G.STATE_COMPLETE = false
		return
	end
	update_selecting_hand_wof_ref(self, dt)
end

-- update_new_round is where the MP mod checks chips vs blind.chips and calls fail_round.
-- For Blinds! we intercept here first to flip the result before the MP check runs.
local update_new_round_ref = Game.update_new_round
function Game:update_new_round(dt)
	if WOF.shop_taxes_force_loss and MP.LOBBY.code and not MP.is_pvp_boss() then
		WOF.shop_taxes_force_loss = false
		G.GAME.blind.chips = -1
		MP.ACTIONS.fail_round(1)
		update_new_round_ref(self, dt)
		return
	end
	if WOF.flags.blinds_inverted and G.GAME and G.GAME.blind
	   and not MP.is_pvp_boss() and (G.GAME.blind.chips or 0) >= 0 then
		local chips = G.GAME.chips
		local blind_chips = G.GAME.blind.chips
		if to_big(chips) >= to_big(blind_chips) then
			-- Inverted loss: call fail_round directly, set guard so MP skips its own check
			G.GAME.blind.chips = -1
			MP.ACTIONS.fail_round(G.GAME.current_round.hands_played)
		else
			-- Inverted win: spoof chips so MP sees a win and skips fail_round
			G.GAME.chips = blind_chips
		end
		update_new_round_ref(self, dt)
		G.GAME.chips = chips
		return
	end
	update_new_round_ref(self, dt)
end

local evaluate_round_ref = G.FUNCS.evaluate_round
G.FUNCS.evaluate_round = function()
	if G.after_pvp then
		WOF.needs_shared_spin = true
	end
	if WOF.flags.blinds_inverted and G.GAME and G.GAME.blind and not MP.is_pvp_boss() then
		local chips = G.GAME.chips
		local blind_chips = G.GAME.blind.chips or 0
		if chips >= blind_chips then
			-- Inverted loss: no reward
			G.GAME.chips = 0
			evaluate_round_ref()
			G.GAME.chips = chips
		else
			-- Inverted win: give reward
			G.GAME.chips = blind_chips
			evaluate_round_ref()
			G.GAME.chips = chips
		end
	else
		evaluate_round_ref()
	end
end

local select_blind_morph_ref = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
	WOF.random_morph_fired = false
	select_blind_morph_ref(e)
end

local toggle_shop_ref = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
	if WOF.flags.tea_break then
		-- one_press sets disable_button=true before calling us; reset it so the button stays clickable
		if e then e.disable_button = false end
		return
	end
	toggle_shop_ref(e)
end

local update_shop_ref = Game.update_shop

function Game:update_shop(dt)
	if WOF.is_active() and WOF.needs_shared_spin then
		if not WOF.shared_spin_done_this_round then
			if not WOF.awaiting_shared_spin then
				WOF.awaiting_shared_spin = true
				WOF.show_shared_spin_ui()
			end

			if MP.LOBBY.is_host and WOF.guest_ready_for_spin and not WOF.shared_spin_sent then
				WOF.do_shared_spin()
			end

			if not WOF.shared_spin_complete then
				return
			end

			WOF.awaiting_shared_spin = false
			WOF.shared_spin_complete = false
			WOF.shared_spin_done_this_round = true
			WOF.needs_shared_spin = false
		end
	end

	if WOF.flags.tea_break then
		if G.TIMERS.REAL < (WOF.tea_break_end_time or 0) then
			return
		else
			WOF.flags.tea_break = false
			WOF.tea_break_end_time = nil
			if WOF.tea_break_audio then
				WOF.tea_break_audio:stop()
				WOF.tea_break_audio = nil
			end
		end
	end

	update_shop_ref(self, dt)
end
