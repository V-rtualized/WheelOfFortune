local function find_parent_by_child_id(node, target_id)
	if node.nodes then
		for i, child in ipairs(node.nodes) do
			if child.config and child.config.id == target_id then
				return node, i
			end
			local result, idx = find_parent_by_child_id(child, target_id)
			if result then
				return result, idx
			end
		end
	end
	return nil
end

local shop_ref = G.UIDEF.shop
function G.UIDEF.shop()
	WOF.wheel_spin_count = 0
	WOF.spin_cost_display = tostring(WOF.spin_cost())
	WOF.shared_spin_done_this_round = false
	WOF.awaiting_shared_spin = false
	WOF.shared_spin_complete = false
	WOF.guest_ready_for_spin = false
	WOF.shared_spin_sent = false

	local t = shop_ref()

	local button_column = find_parent_by_child_id(t, "next_round_button")

	if button_column and WOF.is_active() then
		-- Shrink the existing Next Round and Reroll buttons to fit all 3
		for _, node in ipairs(button_column.nodes) do
			if node.config and node.config.minh then
				node.config.minh = 1.2
			end
		end

		table.insert(button_column.nodes, {
			n = G.UIT.R,
			config = {
				id = "wof_spin_button",
				align = "cm",
				minw = 2.8,
				minh = 1.2,
				r = 0.15,
				colour = HEX("FFD700"),
				button = "wof_spin_wheel",
				func = "wof_can_spin",
				hover = true,
				shadow = true,
			},
			nodes = {
				{
					n = G.UIT.R,
					config = { align = "cm", padding = 0.07 },
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm", maxw = 1.3 },
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = localize("k_wof_spin"),
										scale = 0.4,
										colour = G.C.WHITE,
										shadow = true,
									},
								},
							},
						},
						{
							n = G.UIT.R,
							config = { align = "cm", maxw = 1.3, minw = 1 },
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = "$",
										scale = 0.7,
										colour = G.C.WHITE,
										shadow = true,
									},
								},
								{
									n = G.UIT.T,
									config = {
										ref_table = WOF,
										ref_value = "spin_cost_display",
										scale = 0.75,
										colour = G.C.WHITE,
										shadow = true,
									},
								},
							},
						},
					},
				},
			},
		})
	end

	return t
end

G.FUNCS.wof_can_spin = function(e)
	local count = WOF.wheel_spin_count or 0
	local cost = count == 0 and WOF.spin_cost() or WOF.second_spin_cost()
	WOF.spin_cost_display = tostring(cost)
	if count >= 2 or (G.GAME.dollars - G.GAME.bankrupt_at) < cost or WOF.anim_state ~= nil then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		e.config.colour = HEX("FFD700")
		e.config.button = "wof_spin_wheel"
	end
end

G.FUNCS.wof_spin_wheel = function(e)
	local effect = WOF.get_random_effect(false)
	if not effect then
		return
	end

	local count = WOF.wheel_spin_count or 0
	local cost = count == 0 and WOF.spin_cost() or WOF.second_spin_cost()
	WOF.wheel_spin_count = count + 1
	ease_dollars(-cost)
	WOF.show_effect(effect)
end
