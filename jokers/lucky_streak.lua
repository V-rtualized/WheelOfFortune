SMODS.Joker({
    key = "lucky_streak",
    atlas = "centers",
    pos = { x = 1, y = 4 },
    prefix_config = { atlas = false },
    rarity = 4,
    discovered = true,
    cost = 0,
    no_collection = true,
    blueprint_compat = false,
    config = { extra = { numerator = 1, denominator = 10 } },
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { num, denom } }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint and WOF.flags.lucky_streak and not WOF.flags.lucky_streak_is_replaying then
            if SMODS.pseudorandom_probability(card, 'wof_lucky_streak', card.ability.extra.numerator, card.ability.extra.denominator) then
                WOF.flags.lucky_streak_replay_cards = {}
                for _, c in ipairs(G.play.cards) do
                    WOF.flags.lucky_streak_replay_cards[#WOF.flags.lucky_streak_replay_cards + 1] = c
                end
                return {
                    extra = { message = localize('k_wof_lucky_streak_trigger'), colour = G.C.GOLD },
                    card = card
                }
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end,
})
