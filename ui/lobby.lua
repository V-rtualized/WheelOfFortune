local lobby_status_display_ref = MP.UI.lobby_status_display

function MP.UI.lobby_status_display()
	local result = lobby_status_display_ref()

	local bothPlayersInLobby = MP.LOBBY.guest and MP.LOBBY.guest.config ~= nil
	if not bothPlayersInLobby then return result end

	local hostVersion = MP.LOBBY.host
		and MP.LOBBY.host.config
		and MP.LOBBY.host.config.Mods["WheelOfFortune"]
	local guestVersion = MP.LOBBY.guest
		and MP.LOBBY.guest.config
		and MP.LOBBY.guest.config.Mods["WheelOfFortune"]

	local warning = nil

	if hostVersion ~= guestVersion then
		warning = {
			"Wheel of Fortune mismatch - both players need the same version",
			SMODS.Gradients.warning_text,
		}
	elseif hostVersion ~= nil and hostVersion == guestVersion then
		warning = {
			"Wheel of Fortune active",
			G.C.GREEN,
			0.25,
		}
	end

	if warning and result and result.nodes then
		table.insert(result.nodes, MP.UI.UTILS.create_row({ align = "cm", padding = -0.25 }, {
			MP.UI.UTILS.create_text_node(warning[1], {
				colour = warning[2],
				scale = warning[3] or 0.25,
			}),
		}))
	end

	return result
end

local lobby_info_ref = MP.UI.lobby_info
function MP.UI.lobby_info()
	if not WOF.is_active() then return lobby_info_ref() end
	return create_UIBox_generic_options({
		contents = {
			create_tabs({
				tabs = {
					{
						label = localize("b_players"),
						chosen = true,
						tab_definition_function = MP.UI.create_UIBox_players,
					},
					{
						label = localize("b_lobby_info"),
						chosen = false,
						tab_definition_function = MP.UI.create_UIBox_settings,
					},
					{
						label = "Effects",
						chosen = false,
						tab_definition_function = WOF.create_UIBox_effect_history,
					},
				},
				tab_h = 8,
				snap_to_nav = true,
			}),
		},
	})
end

function WOF.is_active()
	if not MP or not MP.LOBBY or not MP.LOBBY.code then return false end
	local hostVersion = MP.LOBBY.host
		and MP.LOBBY.host.config
		and MP.LOBBY.host.config.Mods["WheelOfFortune"]
	local guestVersion = MP.LOBBY.guest
		and MP.LOBBY.guest.config
		and MP.LOBBY.guest.config.Mods["WheelOfFortune"]
	return hostVersion ~= nil and hostVersion == guestVersion
end
