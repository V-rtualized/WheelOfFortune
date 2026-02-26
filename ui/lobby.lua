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
