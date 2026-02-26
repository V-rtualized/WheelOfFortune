SMODS.Joker({
    key = "wrong_loyalty",
    atlas = "centers",
    pos = { x = 1, y = 4 },
    prefix_config = { atlas = false },
    rarity = 4,
    discovered = true,
    cost = 0,
    no_collection = true,
    blueprint_compat = false,
    config = { 
        extra = {
            loyalty_remaining = 4,
            Xmult = 4,
            every = 4,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult, 
                card.ability.extra.every + 1, 
                localize({
                    type = 'variable', 
                    key = (card.ability.extra.loyalty_remaining == 0 and 'loyalty_active' or 'loyalty_inactive'), 
                    vars = {card.ability.extra.loyalty_remaining}
                })
            }
        }
    end,
    calculate = function(self, card, context)
       if context.cardarea == G.jokers and context.joker_main and not context.blueprint then
            card.ability.extra.loyalty_remaining = (card.ability.extra.every-1-G.GAME.hands_played)%(card.ability.extra.every+1)
            if card.ability.extra.loyalty_remaining == 0 then
                local eval = function(card) return (card.ability.extra.loyalty_remaining == 0) end
                juice_card_until(card, eval, true)
            elseif card.ability.extra.loyalty_remaining == card.ability.extra.every then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
       end
    end,
    in_pool = function(self, args)
        return false
    end
})