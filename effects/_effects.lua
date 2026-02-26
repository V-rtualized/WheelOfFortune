WOF.Effects = {}

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
	on_add = function(self)
		if self.joker_key then
			local card = create_card("Joker", G.jokers, false, nil, nil, nil, self.joker_key)
			card.ability.eternal = true
			card:set_edition("e_negative")
			card.ability.extra_value = -2
			card:set_cost()
			card:add_to_deck()
			G.jokers:emplace(card)
		end
	end,
	on_remove = function(self)
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
	end,
	inject = function(self)
		WOF.Effects[self.key] = self
	end,
})

function WOF.get_random_effect(shared)
	local eligible = {}
	local current_ante = G.GAME.round_resets.ante or 0
	for _, effect in pairs(WOF.Effects) do
		if effect.is_shared == shared and current_ante >= effect.min_ante then
			eligible[#eligible + 1] = effect
		end
	end
	if #eligible == 0 then return nil end
	return eligible[math.random(#eligible)]
end

function WOF.show_effect(effect)
	play_sound("tarot1")

	local msg_scale = math.max(0.6, math.min(1.4, 1.4 - (#effect.message - 18) * 0.4 / 27))

	attention_text({
		text = effect.message,
		scale = msg_scale,
		hold = 8,
		align = "cm",
		major = G.play,
		backdrop_colour = G.C.GOLD,
	})

	effect:on_add()
end
