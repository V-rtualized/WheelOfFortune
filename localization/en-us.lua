return {
	descriptions = {
		Joker = {
			j_wheeloffortune_wrong_loyalty = {
				name = "Wrong Loyalty",
				text = {
					"{X:red,C:white} X#1# {} Mult every",
					"{C:attention}#2#{} hands played",
					"{C:inactive}#3#",
				},
			},
			j_wheeloffortune_haha = {
				name = "Haha",
				text = {
					"Played cards",
					"are {C:attention}destroyed",
				},
			},
			j_wheeloffortune_shop_inflation = {
				name = "Shop Inflation",
				text = {
					"All shop cards cost",
					"{C:attention}X#1#{} more",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_ouija_funboy = {
				name = "Ouija Funboy",
				text = {
					"All {C:spectral}Spectral{} cards",
					"are {C:attention}Ouija",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_double_draw = {
				name = "Double Draw",
				text = {
					"{C:attention}+3{} hand size",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_lucky_streak = {
				name = "Lucky Streak",
				text = {
					"{C:green}#1# in #2#{} chance each",
					"hand is played {C:attention}again{}",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_we_are_rich = {
				name = "We Are Rich",
				text = {
					"Each {C:attention}Economy{} Joker",
					"gives {C:money}+$#1#{} per payout",
					"this ante",
				},
			},
			j_wheeloffortune_find_me = {
				name = "Find Me",
				text = {
					"Scored {C:attention}#1#{} cards",
					"are retriggered",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_mosaic = {
				name = "Mosaic",
				text = {
					"{V:1}#1#{} cards: {C:mult}+10 Mult",
					"Other suits: {C:mult}-5 Mult",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_evolution = {
				name = "Evolution",
				text = {
					"Played cards permanently",
					"gain {C:attention}+1 Rank",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_tarot_god = {
				name = "Tarot God",
				text = {
					"{C:attention}+1{} consumable slot",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_recycling = {
				name = "Recycling",
				text = {
					"Cards sell for",
					"{C:money}full price",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_cards_are_tired = {
				name = "Cards Are Tired",
				text = {
					"Some cards in your deck",
					"are {C:red}debuffed",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_dementia = {
				name = "Dementia",
				text = {
					"All hand levels",
					"reduced to {C:attention}0",
					"{C:inactive}(Restored next ante)",
				},
			},
			j_wheeloffortune_dicarderito = {
				name = "Dicarderito",
				text = {
					"Hands and discards",
					"are {C:attention}swapped",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_library = {
				name = "Library",
				text = {
					"All {C:tarot}Tarots{} in packs",
					"become {C:attention}The Fool",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_suit_mastery = {
				name = "Suit Mastery",
				text = {
					"{V:1}#1#{} is Wild",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_vampire_dream = {
				name = "Vampire Dream",
				text = {
					"Played cards gain a",
					"{C:attention}random Enhancement",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_royal_glass = {
				name = "Royal Glass",
				text = {
					"Playing a {C:attention}Royal Flush",
					"adds {C:tarot}Justice{} to consumables",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_shop_taxes = {
				name = "Shop Taxes",
				text = {
					"Buying a Joker costs",
					"{C:attention}-1{} available hand",
					"{C:inactive}(Lost: #1# hands)",
				},
			},
			j_wheeloffortune_resource_drain = {
				name = "Resource Drain",
				text = {
					"Hands and discards",
					"{C:red}don't refresh{} between blinds",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_random_morph = {
				name = "Random Morph",
				text = {
					"Winning hand each blind:",
					"{C:green}50%{} copy or {C:red}50%{} destroy",
					"all scored cards",
					"{C:inactive}(Destroyed next ante)",
				},
			},
			j_wheeloffortune_blinds = {
				name = "Blinds!",
				text = {
					"Stay {C:attention}UNDER{} the blind",
					"to survive. Scoring over",
					"{C:red}loses a life{}",
					"{C:inactive}(Destroyed next ante)",
				},
			},
		},
	},
	misc = {
		dictionary = {
			k_wof_spin = "Spin",
			k_wof_effects = "Effects",
			k_wof_no_effects = "No effects yet",
			k_wof_shared = "Shared",
			k_wof_personal = "Personal",
			k_wof_active = "Active",
			k_wof_inactive = "Inactive",
			k_wof_instant = "Instant",
			k_wof_active_label = "Wheel of Fortune active",
			k_wof_mismatch = "Wheel of Fortune mismatch - both players need the same version",
			k_wof_effect_wrong_loyalty = "X4 on 5th hand played",
			k_wof_effect_haha = "Played cards are destroyed",
			k_wof_effect_shop_inflation = "Shop prices inflated",
			k_wof_effect_ouija_funboy = "All spectrals are Ouija",
			k_wof_effect_tag_bonanza = "Get a random tag",
			k_wof_effect_temperance_value = "Increase sell value of a random joker by $10",
			k_wof_effect_pack_insight = "Get a random tarot or buffoon pack",
			k_wof_effect_double_draw = "Draw 3 extra cards this ante",
			k_wof_effect_shop_upgrade = "Shop gains 2 extra card slots",
			k_wof_effect_legendary_comeback = "The Soul hidden among next 50 tarots",
			k_wof_effect_rare_snowball = "Rare jokers twice as likely this ante",
			k_wof_effect_indigo_blessing = "+1 card selectable from all packs this ante",
			k_wof_effect_lucky_streak = "1 in 10 chance to replay hand this ante",
			k_wof_lucky_streak_trigger = "Lucky Streak!",
			k_wof_effect_training_weights = "All +Mult and +Chips jokers doubled",
			k_wof_effect_we_are_rich = "Economy jokers give +$1 per round this ante",
			k_wof_effect_master_thief = "Opponent's common joker appears in your shop",
			k_wof_effect_economic_boom = "Receive 10% of spent money at ante end",
			k_wof_effect_find_me = "One rank is retriggered when scored",
			k_wof_effect_mosaic = "One suit +10 Mult, others -5 Mult",
			k_wof_effect_evolution = "Played cards permanently gain +1 rank",
			k_wof_effect_vampire_dream = "Played cards gain random enhancements",
			k_wof_effect_gambler_shuffle = "A deck card replaced with an enhanced card",
			k_wof_effect_lucky_day = "All 7s become Lucky 7s with double odds",
			k_wof_effect_parasite = "A random common joker becomes Perishable",
			k_wof_effect_rents_due = "A random joker becomes Rental",
			k_wof_effect_foil_factory = "Next 5 shop jokers are given Foil",
			k_wof_effect_mirage = "Legendary negative Perishable joker in next shop",
			k_wof_effect_phantom_pain = "Random joker sold for $20, 50% chance to reappear",
			k_wof_effect_tarot_god = "Gain +1 consumable slot this ante",
			k_wof_effect_recycling = "Sell cards at full price this ante",
			k_wof_effect_planetary_alignment = "Next 3 planets trigger twice",
			k_wof_effect_suit_mastery = "A random suit is wild this ante",
			k_wof_effect_dementia = "Hand levels reset, restored at ante end",
			k_wof_effect_double_or_nothing = "Double or Nothing!",
			b_wof_bet = "Bet!",
			k_wof_effect_dicarderito = "Hands and discards swapped this ante",
			k_wof_effect_doing_nothing_first = "Nothing Happens",
			k_wof_effect_doing_nothing_second = "Get a Huge Spectral Pack",
			k_wof_effect_library = "All Tarots in packs become The Fool",
			k_wof_effect_tea_break = "Locked in shop for 30 seconds",
			k_wof_effect_switcheroo = "Tarot cards swapped with opponent",
			k_wof_effect_experience_exchange = "Two hand levels are swapped",
			k_wof_effect_royal_glass = "Royal Flush rewards a Justice Tarot",
			k_wof_effect_overflow = "67 random cards added to both decks",
			k_wof_effect_shop_taxes = "Buying a joker costs 1 hand for the ante",
			k_wof_effect_blissful_ignorance = "Opponent's exact score hidden this ante",
			k_wof_effect_resource_drain = "Hands and discards don't refresh between blinds",
			k_wof_effect_boss_interference = "Small and Big blinds act as Boss blinds",
			k_wof_effect_random_morph = "Winning hand each blind: 50/50 destroy or copy",
			k_wof_effect_blinds = "Score under the blind to survive",
			k_wof_royal_glass_trigger = "Justice!",
			k_wof_blissful_higher = "Higher",
			k_wof_blissful_lower = "Lower",
			k_wof_random_morph_destroy = "Dissolved!",
			k_wof_random_morph_copy = "Copied!",
		},
	},
}
