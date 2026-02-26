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

| Effect | Description | Type | Duration |
|--------|-------------|------|----------|
| **Wrong Loyalty** | Creates an indicator joker that gives X4 Mult every 5th hand played | Shared | Until next shared spin |
| **Haha** | Creates an indicator joker that destroys all played cards | Shared | Until next shared spin |
| **Shop Inflation** | Increases all shop card prices by X(1 + 0.1 * ante). Creates an indicator joker | Personal | Until end of ante |
| **Ouija Funboy** | Forces all Spectral cards to be generated as Ouija, even if banned by the ruleset. Creates an indicator joker | Personal | Until end of ante |
| **Tag Bonanza** | Gives a random tag to the player | Personal | Instant |
| **Temperance Value** | Picks a random joker and adds $10 to its sell value | Personal | Instant |
