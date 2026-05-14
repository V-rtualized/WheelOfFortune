WOF.planetary_alignment_count = 0

WOF.Effect({
	key = "planetary_alignment",
	display_name = "Planetary Alignment",
	message = "k_wof_effect_planetary_alignment",
	is_shared = false,
	on_add = function(self)
		WOF.planetary_alignment_count = 3
		WOF.flags.planetary_alignment = true
	end,
	on_remove = function(self)
		WOF.flags.planetary_alignment = false
		WOF.planetary_alignment_count = 0
	end,
}):inject()

local use_consumeable_ref = Card.use_consumeable
function Card:use_consumeable(area, copier)
	if
		WOF.flags.planetary_alignment
		and self.ability.set == "Planet"
		and WOF.planetary_alignment_count > 0
		and not copier
	then
		WOF.planetary_alignment_count = WOF.planetary_alignment_count - 1
		if WOF.planetary_alignment_count <= 0 then
			WOF.flags.planetary_alignment = false
		end
		use_consumeable_ref(self, area, copier)
		local hand_type = self.ability.consumeable and self.ability.consumeable.hand_type
		local center = self.config.center
		if hand_type then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					level_up_hand(self, hand_type)
					return true
				end,
			}))
		elseif center.use and type(center.use) == "function" then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					center:use(self, area, copier)
					return true
				end,
			}))
		end
		return
	end
	return use_consumeable_ref(self, area, copier)
end
