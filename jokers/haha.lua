SMODS.Joker({
    key = "haha",
    atlas = "centers",
    pos = { x = 1, y = 4 },
    prefix_config = { atlas = false },
    rarity = 4,
    discovered = true,
    cost = 0,
    no_collection = true,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and not context.blueprint then
            return {
                remove = true
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end
})