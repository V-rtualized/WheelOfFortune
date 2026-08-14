WOF.Effect({
	key = "lucky_streak",
	display_name = "Lucky Streak",
	message = "k_wof_effect_lucky_streak",
	is_shared = false,
	removal_mode = "end_ante",
	flag = "lucky_streak",
	joker_key = "j_wheeloffortune_lucky_streak",
	incompatible_flags = { "haha", "random_morph" },
	on_add = function(self)
		WOF.default_on_add(self)
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
		WOF.flags.lucky_streak_replay_cards = nil
		WOF.flags.lucky_streak_is_replaying = nil
	end,
}):inject()

local draw_play_to_discard_ref = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
	if WOF.flags.lucky_streak_is_replaying then
		WOF.flags.lucky_streak_is_replaying = nil
		return draw_play_to_discard_ref(e)
	end
	if WOF.flags.lucky_streak_replay_cards then
		local replay_cards = WOF.flags.lucky_streak_replay_cards
		WOF.flags.lucky_streak_replay_cards = nil
		WOF.flags.lucky_streak_is_replaying = true
		G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 1

		for i, card in ipairs(replay_cards) do
			draw_card(G.play, G.hand, i * 100 / #replay_cards, "up", false, card)
		end

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.8,
			func = function()
				if #G.play.cards == 0 then
					for _, card in ipairs(replay_cards) do
						for _, hand_card in ipairs(G.hand.cards) do
							if hand_card == card then
								G.hand:add_to_highlighted(hand_card, true)
								break
							end
						end
					end
					G.STATE = G.STATES.SELECTING_HAND
					G.STATE_COMPLETE = false
					G.FUNCS.play_cards_from_highlighted()
					return true
				end
				return false
			end,
		}))
		return
	end
	return draw_play_to_discard_ref(e)
end
