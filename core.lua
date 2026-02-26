WOF = SMODS.current_mod

WOF.SPIN_COST_BASE = 5
function WOF.spin_cost()
	return WOF.SPIN_COST_BASE * (G.GAME.round_resets.ante or 1)
end
WOF.wheel_spun_this_shop = false

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

WOF.load_dir("effects")
WOF.load_file("ui/shop.lua")
