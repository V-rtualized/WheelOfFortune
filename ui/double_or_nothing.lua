WOF.don_state = { amount = 5, max_bet = 5, amount_label = "$5" }

local function don_set(amount)
	WOF.don_state.amount = math.max(5, math.min(amount, WOF.don_state.max_bet))
	WOF.don_state.amount_label = localize("$") .. WOF.don_state.amount
end

G.FUNCS.wof_don_change = function(e)
	don_set(WOF.don_state.amount + e.config.ref_table.delta)
end

G.FUNCS.wof_can_don_change = function(e)
	local new_val = WOF.don_state.amount + e.config.ref_table.delta
	if new_val >= 5 and new_val <= WOF.don_state.max_bet then
		e.config.colour = G.C.BLUE
		e.config.button = "wof_don_change"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.wof_don_submit = function(e)
	local bet = WOF.don_state.amount
	G.FUNCS.exit_overlay_menu()
	G.E_MANAGER:add_event(Event({
		func = function()
			if math.random() < 0.5 then
				ease_dollars(bet)
			else
				ease_dollars(-bet, true)
			end
			return true
		end,
	}))
end

function WOF.show_double_or_nothing_ui()
	WOF.don_state.max_bet = math.max(5, G.GAME.dollars)
	don_set(5)

	local contents = {
		-- Title
		{
			n = G.UIT.R,
			config = { align = "cm", padding = 0.1 },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize("k_wof_effect_double_or_nothing"),
						scale = 0.5,
						colour = G.C.WHITE,
						shadow = true,
					},
				},
			},
		},
		-- Bet display
		{
			n = G.UIT.R,
			config = { align = "cm", padding = 0.1 },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.L_BLACK, emboss = 0.05, minw = 3 },
					nodes = {
						{
							n = G.UIT.T,
							config = {
								ref_table = WOF.don_state,
								ref_value = "amount_label",
								scale = 0.8,
								colour = G.C.MONEY,
								shadow = true,
							},
						},
					},
				},
			},
		},
		-- Adjust buttons row
		{
			n = G.UIT.R,
			config = { align = "cm", padding = 0.08 },
			nodes = {
				UIBox_button({
					col = true,
					ref_table = { delta = -5 },
					button = "wof_don_change",
					func = "wof_can_don_change",
					label = { "-5" },
					colour = G.C.BLUE,
					scale = 0.4,
					minw = 1.1,
					minh = 0.6,
				}),
				UIBox_button({
					col = true,
					ref_table = { delta = -1 },
					button = "wof_don_change",
					func = "wof_can_don_change",
					label = { "-1" },
					colour = G.C.BLUE,
					scale = 0.4,
					minw = 1.1,
					minh = 0.6,
				}),
				UIBox_button({
					col = true,
					ref_table = { delta = 1 },
					button = "wof_don_change",
					func = "wof_can_don_change",
					label = { "+1" },
					colour = G.C.BLUE,
					scale = 0.4,
					minw = 1.1,
					minh = 0.6,
				}),
				UIBox_button({
					col = true,
					ref_table = { delta = 5 },
					button = "wof_don_change",
					func = "wof_can_don_change",
					label = { "+5" },
					colour = G.C.BLUE,
					scale = 0.4,
					minw = 1.1,
					minh = 0.6,
				}),
			},
		},
		-- BET button
		UIBox_button({
			button = "wof_don_submit",
			one_press = true,
			label = { localize("b_wof_bet") },
			colour = G.C.GREEN,
			scale = 0.55,
			minw = 4,
			minh = 1.0,
			focus_args = { nav = "wide", snap_to = true },
		}),
	}

	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({ no_back = true, contents = contents }),
		config = { no_esc = true },
	})
end
