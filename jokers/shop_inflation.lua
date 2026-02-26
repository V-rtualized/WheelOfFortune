SMODS.Joker({
    key = "shop_inflation",
    atlas = "centers",
    pos = { x = 1, y = 4 },
    prefix_config = { atlas = false },
    rarity = 4,
    discovered = true,
    cost = 0,
    no_collection = true,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                string.format("%.1f", 1 + 0.1 * (G.GAME.round_resets.ante or 1)),
            },
        }
    end,
    in_pool = function(self, args)
        return false
    end,
})
