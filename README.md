# Wheel of Fortune

A Balatro mod that adds random wheel effects to [Multiplayer](https://github.com/Virtualized1/BalatroMultiplayer) matches.

## Requirements

- [Steamodded](https://github.com/Steamopollys/Steamodded) (>=1.0.0~BETA-1221a)
- [Lovely](https://github.com/ethangreen-dev/lovely-injector) (>=0.8)
- Balatro
- [Multiplayer](https://github.com/Virtualized1/BalatroMultiplayer) (>=0.3.0)

## Features

### Shop Spin

Each shop visit, you can pay to spin the Wheel of Fortune for a personal effect. The cost scales with the current ante (base $3, capped at $15). You can only spin once per shop.

### Shared Spin

After every PvP blind, both players enter a shared spin phase. A waiting screen appears until both players are ready, then the host spins the wheel. The result is broadcast to both players, applying the same shared effect to each. Shared effects persist until the next shared spin replaces them.

### Effect History

The lobby info overlay has an "Effects" tab that shows the last 10 effects applied. Each entry displays:

- The effect description
- A **Shared** or **Personal** tag
- An **Active**, **Inactive**, or **Instant** status tag

### Lobby Integration

The mod detects whether both players have the same version of Wheel of Fortune installed. If versions match, the lobby status shows "Wheel of Fortune active" in green. If they mismatch, a warning is displayed and the mod features are disabled.

### Joker Indicators

Several effects create eternal, negative jokers as visual indicators while the effect is active. These jokers are automatically removed when the effect ends.

## Effects

### Personal

| Effect                  | Description                                                                                                                         | Type     | Duration                | Status      |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | -------- | ----------------------- | ----------- |
| **Pack Insight**        | Get a random Tarot or Buffoon pack                                                                                                  | Positive | Instant                 | Implemented |
| **Tag Bonanza**         | Get a random tag                                                                                                                    | Positive | Instant                 | Implemented |
| **Double Draw**         | Draw +3 cards for the rest of the ante. Creates an indicator joker                                                                  | Positive | Until end of ante       | Implemented |
| **Shop Upgrade**        | Adds 2 card slots to the shop (up to a max of 4)                                                                                    | Positive | Current shop only       | Implemented |
| **Immolate**            | Guarantees Immolate will appear as one of the next 50 Tarot cards                                                                   | Positive | Until Immolate appears  | Implemented |
| **Training Weights**    | All +Mult and +Chips jokers are doubled                                                                                             | Positive | Instant                 | Implemented |
| **Temperance Value**    | Increase the sell value of a random joker by $10                                                                                    | Positive | Instant                 | Implemented |
| **Rare Snowball**       | Doubles the probability of rolling a Rare joker in the shop for the rest of the ante                                                | Positive | Until end of ante       | Implemented |
| **We Are Rich**         | Every economy joker gives +$1 per payout for the rest of the ante                                                                   | Positive | Until end of ante       | Implemented |
| **Master Thief**        | One random common joker from your opponent's setup appears for sale in your shop                                                    | Positive | Instant                 | Implemented |
| **Indigo Blessing**     | Select an additional card from all packs for the rest of the ante. Idea credit to ЗАХАРОСАН                                         | Positive | Until end of ante       | Implemented |
| **Lucky Streak**        | Every hand played has a 1 in 10 chance to be played a second time until the end of the ante                                         | Positive | Until end of ante       | Implemented |
| **Economic Boom**       | At the end of the ante, receive 10% of all money spent during the ante                                                              | Positive | Instant, Delayed        | Implemented |
| **Foil Factory**        | The next 5 jokers that appear in the shop are given the Foil enhancement                                                            | Positive | Next 5 jokers generated | Implemented |
| **Tarrot God**          | Gain +1 consumable slot for the rest of the ante                                                                                    | Positive | Until end of ante       | Implemented |
| **Recycling**           | Selling any card gives you its full base price for the rest of the ante                                                             | Positive | Until end of ante       | Implemented |
| **Planetary Alignment** | The next 3 Planet cards used each trigger twice                                                                                     | Positive | Next 3 planets used     | Implemented |
| **Suit Mastery**        | A random suit is treated as The Lovers for the rest of the ante                                                                     | Positive | Until end of ante       | Implemented |
| **Shop Inflation**      | Increases all shop card prices by X(1 + 0.1 \* ante). Creates an indicator joker                                                    | Negative | Until end of ante       | Implemented |
| **Parasite**            | A random common joker in your setup becomes Perishable                                                                              | Negative | Instant                 | Implemented |
| **Cards Are Tired**     | 4 \* (ante - 1) random playing cards in your deck are debuffed for the rest of the ante                                             | Negative | Until end of ante       | Implemented |
| **Ouija Funboy**        | Forces all Spectral cards to be generated as Ouija, even if banned by the ruleset. Creates an indicator joker                       | Negative | Until end of ante       | Implemented |
| **Dementia**            | All poker hand levels are reduced to 0. After the ante ends, all lost levels are added back                                         | Negative | Until end of ante       | Implemented |
| **Rent's Due**          | A random joker becomes Rental                                                                                                       | Negative | Instant                 | Implemented |
| **Dicarderito**         | Your hands and discards are swapped for the rest of the ante                                                                        | Neutral  | Until end of ante       | Implemented |
| **Doing Nothing?**      | First time triggered, nothing happens. Second time, you receive a choose 2 out of 8 Spectral Pack                                   | Neutral  | Instant                 | Implemented |
| **Library**             | All Tarot cards in packs are replaced with The Fool for the rest of the ante                                                        | Neutral  | Until end of ante       | Implemented |
| **Phantom Pain**        | A random joker is sold for $15 and returns with Rental in the next shop                                                             | Neutral  | Until next shop         | Implemented |
| **Double or Nothing**   | Bet your current money: 50/50 chance to double it or lose everything. Minimum bet is $5                                             | Neutral  | Instant                 | Implemented |
| **Mirage**              | Adds a random legendary negative joker with Perishable at 2 charges left to the next shop                                           | Neutral  | Instant                 | Implemented |
| **Mosaic**              | All cards of one random suit gain +10 Mult when played until the end of the ante. Cards of any other suit lose 5 Mult               | Neutral  | Until end of ante       | Implemented |
| **Tea Break**           | You are locked in the shop for 30 seconds while Russian music plays                                                                 | Neutral  | 30 seconds              | Implemented |
| **Gambler's Shuffle**   | A random card in your deck is destroyed and replaced with a new random card that has a Polychrome, Foil, or Holographic enhancement | Neutral  | Instant                 | Implemented |
| **Switcheroo**          | All Tarot cards in your consumable area are swapped with your opponent's                                                            | Neutral  | Instant                 | Implemented |
| **Eternal Spin**        | Lose or gain $(5 \* ante), then spin the wheel again                                                                                | Neutral  | Instant                 | Implemented |
| **Experience Exchange** | The levels of two random poker hands are swapped                                                                                    | Neutral  | Instant                 | Implemented |

### Shared

| Effect                 | Description                                                                                                                          | Type  | Duration               | Status      |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ----- | ---------------------- | ----------- |
| **Haha**               | All played cards are destroyed. Creates an indicator joker                                                                           | Chaos | Until next shared spin | Implemented |
| **Blinds!**            | Both players must score less than the blind score to survive the round; scoring over loses a life                                    | Chaos | Until end of ante      | Planned     |
| **Wrong Loyalty**      | X4 Mult every 5th hand played. Creates an indicator joker                                                                            | Chaos | Until next shared spin | Implemented |
| **Shop Taxes**         | Buying a joker reduces your available hands by 1 for the rest of the ante                                                            | Chaos | Until end of ante      | Implemented |
| **Boss Interference**  | Small and Big blinds become Boss blinds for the ante                                                                                 | Chaos | Until end of ante      | Implemented |
| **Find Me**            | One random playing card type is retriggered when scored. Card changes every round, like idol                                         | Chaos | Until end of ante      | Implemented |
| **Vampire Dream**      | Every played card gains a random enhancement (excluding Glass)                                                                       | Chaos | Until end of ante      | Implemented |
| **Lucky Day**          | All 7s in both players' decks become Lucky 7s with the Oops! All 6s effect                                                           | Chaos | Until end of ante      | Implemented |
| **Royal Glass**        | Playing a Royal Straight Flush rewards a Justice Tarot card                                                                          | Chaos | Until end of ante      | Implemented |
| **Ov6rf7ow**           | Adds 67 random playing cards to both players' decks. Both players receive the same cards                                             | Chaos | Instant                | Implemented |
| **Blissful Ignorance** | During the next PvP, your opponent's exact score is hidden. You can only see whether you have higher or lower score                  | Chaos | Until end of ante      | Implemented |
| **RandomMorph**        | Every hand played has a 50/50 to either destroy or copy all scored cards                                                             | Chaos | Until end of ante      | Implemented |
| **Resource Drain**     | Hands and discards are not restored between blinds for the rest of the ante                                                          | Chaos | Until end of ante      | Implemented |
| **Groundhog Day**      | The next PvP round is played three times from the same starting state. The best result counts, gold gained in all three runs is kept | Chaos | Next PvP only          | Planned     |
| **Evolution**          | Each card played permanently increases its rank by 1                                                                                 | Chaos | Until end of ante      | Implemented |
