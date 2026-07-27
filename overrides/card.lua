local function without_effect_jokers(callback)
	if not G.jokers or not G.jokers.cards then
		return callback()
	end

	local original_cards = G.jokers.cards
	local copyable_cards = {}
	for _, card in ipairs(original_cards) do
		if not WOF.is_effect_joker(card) then
			copyable_cards[#copyable_cards + 1] = card
		end
	end

	if #copyable_cards == #original_cards then
		return callback()
	end

	G.jokers.cards = copyable_cards
	local results = { pcall(callback) }
	for _, card in ipairs(copyable_cards) do
		local already_present = false
		for _, original_card in ipairs(original_cards) do
			if original_card == card then
				already_present = true
				break
			end
		end
		if not already_present then
			original_cards[#original_cards + 1] = card
		end
	end
	G.jokers.cards = original_cards
	if not results[1] then
		error(results[2])
	end
	return unpack(results, 2)
end

local can_use_consumeable_ref = Card.can_use_consumeable
function Card:can_use_consumeable(...)
	if self.config and self.config.center_key == "c_ankh" then
		local args = { ... }
		return without_effect_jokers(function()
			return can_use_consumeable_ref(self, unpack(args))
		end)
	end
	return can_use_consumeable_ref(self, ...)
end

local use_consumeable_ref = Card.use_consumeable
function Card:use_consumeable(...)
	if self.config and self.config.center_key == "c_ankh" then
		local args = { ... }
		return without_effect_jokers(function()
			return use_consumeable_ref(self, unpack(args))
		end)
	end
	return use_consumeable_ref(self, ...)
end

local calculate_joker_ref = Card.calculate_joker
function Card:calculate_joker(context)
	if self.config and self.config.center_key == "j_invisible" and context and context.selling_self then
		return without_effect_jokers(function()
			return calculate_joker_ref(self, context)
		end)
	end
	return calculate_joker_ref(self, context)
end
