local function rank_suffix(id)
	local next_id = id == 14 and 2 or math.min(id + 1, 14)
	if next_id < 10 then return tostring(next_id)
	elseif next_id == 10 then return 'T'
	elseif next_id == 11 then return 'J'
	elseif next_id == 12 then return 'Q'
	elseif next_id == 13 then return 'K'
	else return 'A' end
end

SMODS.Joker({
	key = "evolution",
	atlas = "centers",
	pos = { x = 1, y = 4 },
	prefix_config = { atlas = false },
	rarity = 4,
	discovered = true,
	cost = 0,
	no_collection = true,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.after and not context.blueprint then
			local cards_to_evolve = {}
			for _, c in ipairs(G.play.cards) do
				if c.ability.effect ~= 'Stone Card' and not SMODS.has_no_rank(c) then
					cards_to_evolve[#cards_to_evolve + 1] = c
				end
			end
			if #cards_to_evolve > 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						for _, c in ipairs(cards_to_evolve) do
							local suit_prefix = string.sub(c.base.suit, 1, 1) .. '_'
							local suffix = rank_suffix(c.base.id)
							c:set_base(G.P_CARDS[suit_prefix .. suffix])
							c:juice_up(0.3, 0.3)
						end
						return true
					end,
				}))
			end
		end
	end,
	in_pool = function(self, args)
		return false
	end,
})
