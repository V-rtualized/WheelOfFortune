WOF = SMODS.current_mod

WOF.SPIN_COST_BASE = 3
function WOF.spin_cost()
	return math.min(WOF.SPIN_COST_BASE * (G.GAME.round_resets.ante or 1), 15)
end
WOF.wheel_spun_this_shop = false
WOF.awaiting_shared_spin = false
WOF.shared_spin_complete = false
WOF.shared_spin_done_this_round = false
WOF.needs_shared_spin = false
WOF.guest_ready_for_spin = false
WOF.shared_spin_sent = false
WOF.active_shared_effect = nil
WOF.flags = {}
WOF.active_effects = {}
WOF.effect_history = {}

function WOF.load_file(file)
	local chunk, err = SMODS.load_file(file, WOF.id)
	if chunk then
		local ok, result = pcall(chunk)
		if ok then
			return result
		else
			sendWarnMessage("Failed to process file: " .. result, WOF.id)
		end
	else
		sendWarnMessage("Failed to find or compile file: " .. tostring(err), WOF.id)
	end
	return nil
end

function WOF.load_dir(directory)
	local function has_prefix(name)
		return name:match("^_") ~= nil
	end

	local dir_path = WOF.path .. "/" .. directory
	local items = NFS.getDirectoryItemsInfo(dir_path)
	table.sort(items, function(a, b)
		if has_prefix(a.name) ~= has_prefix(b.name) then return has_prefix(a.name) end
		return false
	end)

	for _, item in ipairs(items) do
		if item.type ~= "directory" then
			WOF.load_file(directory .. "/" .. item.name)
		end
	end
end

WOF.load_dir("jokers")
WOF.load_dir("effects")
WOF.load_dir("compatibility")
WOF.load_file("ui/shop.lua")
WOF.load_file("ui/shared_spin.lua")
WOF.load_file("ui/effect_history.lua")
WOF.load_file("ui/lobby.lua")
WOF.load_file("overrides/game_state.lua")

-- Register shared spin handlers with Multiplayer mod
if MP and MP.register_mod_action then
	-- Guest sends this to host when they're ready for the shared spin
	MP.register_mod_action("ready_for_spin", function(action)
		sendDebugMessage("[WOF] Received ready_for_spin from guest", "WOF")
		WOF.guest_ready_for_spin = true
		-- Remove the waiting text on the host side
		if WOF.shared_spin_ui then
			WOF.shared_spin_ui:remove()
			WOF.shared_spin_ui = nil
		end
		-- If host is already awaiting, trigger the spin now
		if WOF.awaiting_shared_spin then
			sendDebugMessage("[WOF] Host was already waiting, triggering shared spin", "WOF")
			WOF.do_shared_spin()
		end
	end)

	MP.register_mod_action("shared_spin", function(action)
		sendDebugMessage("[WOF] Received shared_spin action. effect_key=" .. tostring(action.effect_key) .. " from=" .. tostring(action.from), "WOF")
		local effect = WOF.Effects[action.effect_key]
		if not effect then
			sendWarnMessage("[WOF] Unknown effect key: " .. tostring(action.effect_key), "WOF")
			return
		end

		-- Remove the previous shared effect if one is active
		if WOF.active_shared_effect then
			local old_effect = WOF.Effects[WOF.active_shared_effect]
			if old_effect then
				old_effect:on_remove()
			end
		end

		-- Set the new active shared effect
		WOF.active_shared_effect = action.effect_key

		-- Remove the spin UI overlay
		if WOF.shared_spin_ui then
			WOF.shared_spin_ui:remove()
			WOF.shared_spin_ui = nil
		end

		WOF.show_effect(effect)

		-- After a delay, signal that the shared spin is done
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 3,
			func = function()
				sendDebugMessage("[WOF] Shared spin delay complete, setting shared_spin_complete=true", "WOF")
				WOF.shared_spin_complete = true
				return true
			end,
		}))
	end)
end
