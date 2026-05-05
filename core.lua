WOF = SMODS.current_mod

function WOF.spin_cost()
	return math.min(2 + (G.GAME.round_resets.ante or 1), 8)
end
function WOF.second_spin_cost()
	return math.min(WOF.spin_cost() + 2, 10)
end
WOF.wheel_spin_count = 0
WOF.spin_cost_display = "3"
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
		if has_prefix(a.name) ~= has_prefix(b.name) then
			return has_prefix(a.name)
		end
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
WOF.load_file("ui/double_or_nothing.lua")
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
		sendDebugMessage(
			"[WOF] Received shared_spin action. effect_key="
				.. tostring(action.effect_key)
				.. " from="
				.. tostring(action.from),
			"WOF"
		)
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

	MP.register_mod_action("master_thief_request", function(action)
		local eligible = {}
		for _, card in ipairs(G.jokers.cards) do
			local center = card.config.center
			if center and center.rarity == 1 and not center.no_collection then
				eligible[#eligible + 1] = card
			end
		end
		local joker_key = nil
		if #eligible > 0 then
			joker_key = eligible[math.random(#eligible)].config.center.key
		end
		MP.ACTIONS.modded("WheelOfFortune", "master_thief_response", { joker_key = joker_key })
	end)

	MP.register_mod_action("master_thief_response", function(action)
		if not action.joker_key then
			return
		end
		if not G.shop_jokers then
			return
		end
		local card = create_card("Joker", G.shop_jokers, false, nil, nil, nil, action.joker_key)
		card:set_cost()
		G.shop_jokers:emplace(card)
		create_shop_card_ui(card, "Joker", G.shop_jokers)
	end)

	MP.register_mod_action("switcheroo_request", function(action)
		WOF.show_announcement("k_wof_effect_switcheroo_stolen")
		local my_tarots = {}
		for _, card in ipairs(G.consumeables.cards) do
			if card.ability.set == "Tarot" then
				my_tarots[#my_tarots + 1] = card:save()
			end
		end
		local encoded = MP.UTILS.str_pack_and_encode(my_tarots)
		local their_tarots, err = MP.UTILS.str_decode_and_unpack(action.tarots)
		if not their_tarots then
			sendWarnMessage("[WOF] switcheroo_request decode failed: " .. tostring(err), "WOF")
			return
		end
		for i = #G.consumeables.cards, 1, -1 do
			if G.consumeables.cards[i].ability.set == "Tarot" then
				G.consumeables.cards[i]:start_dissolve()
			end
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, saved in ipairs(their_tarots) do
					local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS.j_joker, G.P_CENTERS.c_base)
					card:load(saved)
					G.consumeables:emplace(card)
				end
				return true
			end,
		}))
		MP.ACTIONS.modded("WheelOfFortune", "switcheroo_response", { tarots = encoded })
	end)

	MP.register_mod_action("switcheroo_response", function(action)
		local their_tarots, err = MP.UTILS.str_decode_and_unpack(action.tarots)
		if not their_tarots then
			sendWarnMessage("[WOF] switcheroo_response decode failed: " .. tostring(err), "WOF")
			return
		end
		for i = #G.consumeables.cards, 1, -1 do
			if G.consumeables.cards[i].ability.set == "Tarot" then
				G.consumeables.cards[i]:start_dissolve()
			end
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, saved in ipairs(their_tarots) do
					local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS.j_joker, G.P_CENTERS.c_base)
					card:load(saved)
					G.consumeables:emplace(card)
				end
				return true
			end,
		}))
	end)
end
