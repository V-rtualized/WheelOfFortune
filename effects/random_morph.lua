WOF.random_morph_fired = false

WOF.Effect({
	key = "random_morph",
	message = "k_wof_effect_random_morph",
	is_shared = true,
	removal_mode = "end_ante",
	flag = "random_morph",
	joker_key = "j_wheeloffortune_random_morph",
}):inject()
