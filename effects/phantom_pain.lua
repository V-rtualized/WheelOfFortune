WOF.phantom_pain_saved_card = nil
WOF.phantom_pain_saved_key = nil
WOF.phantom_pain_locked_key = nil

local function lock_phantom_pain_key()
	if WOF.phantom_pain_saved_key and G.GAME and G.GAME.used_jokers then
		WOF.phantom_pain_locked_key = WOF.phantom_pain_saved_key
		G.GAME.used_jokers[WOF.phantom_pain_saved_key] = true
	end
end

WOF.Effect({
	key = "phantom_pain",
	display_name = "Phantom Pain",
	message = "k_wof_effect_phantom_pain",
	is_shared = false,
	on_add = function(self)
		local eligible = {}
		for _, card in ipairs(G.jokers.cards) do
			if not card.ability.eternal and SMODS.add_to_pool(card.config.center, {}) then
				eligible[#eligible + 1] = card
			end
		end
		if #eligible == 0 then
			return
		end
		local target = eligible[math.random(#eligible)]
		local saved = target:save()
		local saved_key = target.config and target.config.center and target.config.center.key
		G.E_MANAGER:add_event(Event({
			func = function()
				target:start_dissolve()
				ease_dollars(15)
				WOF.phantom_pain_saved_card = saved
				WOF.phantom_pain_saved_key = saved_key
				WOF.flags.phantom_pain = true
				WOF.flags.phantom_pain_past_blind = false
				lock_phantom_pain_key()
				return true
			end,
		}))
	end,
}):inject()

local select_blind_ref = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
	if WOF.flags.phantom_pain then
		WOF.flags.phantom_pain_past_blind = true
	end
	select_blind_ref(e)
end

local emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	emplace_ref(self, card, ...)
	if WOF.flags.phantom_pain and WOF.flags.phantom_pain_past_blind and self == G.shop_jokers then
		local saved = WOF.phantom_pain_saved_card
		WOF.flags.phantom_pain = false
		WOF.flags.phantom_pain_past_blind = false
		WOF.phantom_pain_saved_card = nil
		G.E_MANAGER:add_event(Event({
			func = function()
				local new_card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS.j_joker, G.P_CENTERS.c_base)
				new_card:load(saved)
				new_card.added_to_deck = nil
				new_card:set_rental(true)
				new_card:set_cost()
				G.shop_jokers:emplace(new_card)
				create_shop_card_ui(new_card, "Joker", G.shop_jokers)
				WOF.phantom_pain_saved_key = nil
				WOF.phantom_pain_locked_key = nil
				return true
			end,
		}))
	end
end

local add_to_pool_ref = SMODS.add_to_pool
function SMODS.add_to_pool(center, args)
	if
		WOF.flags.phantom_pain
		and WOF.phantom_pain_saved_key
		and center
		and center.key == WOF.phantom_pain_saved_key
		and not SMODS.showman(center.key)
	then
		return false
	end
	return add_to_pool_ref(center, args)
end

local create_card_for_shop_ref = create_card_for_shop
function create_card_for_shop(area)
	lock_phantom_pain_key()
	local card = create_card_for_shop_ref(area)
	lock_phantom_pain_key()
	return card
end
