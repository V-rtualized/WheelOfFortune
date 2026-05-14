WOF.Effect({
	key = "tarot_god",
	display_name = "Tarot God",
	message = "k_wof_effect_tarot_god",
	is_shared = false,
	removal_mode = "end_ante",
	flag = "tarot_god",
	joker_key = "j_wheeloffortune_tarot_god",
	on_add = function(self)
		WOF.default_on_add(self)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
	end,
	on_remove = function(self)
		WOF.default_on_remove(self)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
		if #G.consumeables.cards > G.consumeables.config.card_limit then
			G.consumeables.cards[#G.consumeables.cards]:start_dissolve()
		end
	end,
}):inject()
