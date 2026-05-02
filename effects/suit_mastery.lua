WOF.suit_mastery_suit = nil
local SUITS = { "Hearts", "Diamonds", "Clubs", "Spades" }

WOF.Effect({
	key = "suit_mastery",
	message = "k_wof_effect_suit_mastery",
	is_shared = false,
	removal_mode = "end_ante",
	flag = "suit_mastery",
	joker_key = "j_wheeloffortune_suit_mastery",
	on_add = function(self)
		WOF.suit_mastery_suit = SUITS[math.random(#SUITS)]
		WOF.default_on_add(self)
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
		WOF.suit_mastery_suit = nil
	end,
}):inject()

local is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if WOF.flags.suit_mastery and WOF.suit_mastery_suit and self.base and self.base.suit == WOF.suit_mastery_suit then
		if flush_calc then
			if not SMODS.has_no_suit(self) then
				return true
			end
		else
			if not (self.debuff and not bypass_debuff) then
				return true
			end
		end
	end
	return is_suit_ref(self, suit, bypass_debuff, flush_calc)
end
