local function create_effect_row(entry)
	local is_active = entry.ante ~= nil and entry.ante == (G.GAME.round_resets.ante or 0)

	local type_colour = entry.is_shared and HEX("5B8DEF") or HEX("FFD700")
	local type_text = entry.is_shared and "Shared" or "Personal"

	local status_colour = is_active and HEX("4CAF50") or G.C.L_BLACK
	local status_text = is_active and "Active" or "Inactive"

	return {
		n = G.UIT.R,
		config = {
			align = "cm",
			padding = 0.05,
			r = 0.1,
			colour = darken(G.C.JOKER_GREY, 0.1),
			emboss = 0.05,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = { align = "cl", padding = 0.05, minw = 5, maxw = 5 },
				nodes = {
					{ n = G.UIT.T, config = { text = entry.message, scale = 0.35, colour = G.C.UI.TEXT_LIGHT } },
				},
			},
			{
				n = G.UIT.C,
				config = { align = "cm", padding = 0.03, r = 0.1, colour = type_colour, minw = 1.5 },
				nodes = {
					{ n = G.UIT.T, config = { text = type_text, scale = 0.3, colour = G.C.WHITE } },
				},
			},
			{
				n = G.UIT.C,
				config = { align = "cm", padding = 0.03, r = 0.1, colour = status_colour, minw = 1.3 },
				nodes = {
					{ n = G.UIT.T, config = { text = status_text, scale = 0.3, colour = G.C.WHITE } },
				},
			},
		},
	}
end

function WOF.create_UIBox_effect_history()
	if #WOF.effect_history == 0 then
		return {
			n = G.UIT.ROOT,
			config = { align = "cm", minw = 3, padding = 0.2, r = 0.1, colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						{ n = G.UIT.T, config = { text = "No effects yet", scale = 0.5, colour = G.C.UI.TEXT_INACTIVE } },
					},
				},
			},
		}
	end

	local rows = {}
	for _, entry in ipairs(WOF.effect_history) do
		rows[#rows + 1] = create_effect_row(entry)
	end

	return {
		n = G.UIT.ROOT,
		config = { align = "cm", minw = 3, padding = 0.1, r = 0.1, colour = G.C.CLEAR },
		nodes = {
			MP.UI.UTILS.create_row({ align = "cm", padding = 0.04 }, rows),
		},
	}
end
