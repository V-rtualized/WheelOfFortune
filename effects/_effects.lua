WOF.Effects = {}

WOF.Effect = SMODS.GameObject:extend({
	obj_table = {},
	obj_buffer = {},
	required_params = {
		"key",
		"message",
		"calculate",
	},
	class_prefix = "wof_effect",
	is_shared = false,
	min_ante = 0,
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

	effect:calculate()
end
