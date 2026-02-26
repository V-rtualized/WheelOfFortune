SMODS.Joker({
    key = "ouija_funboy",
    atlas = "centers",
    pos = { x = 1, y = 4 },
    prefix_config = { atlas = false },
    rarity = 4,
    discovered = true,
    cost = 0,
    no_collection = true,
    blueprint_compat = false,
    in_pool = function(self, args)
        return false
    end,
})
