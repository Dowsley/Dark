# The Dark Series
## Premise (WIP)
Just once, Humanity had first contact, and with it, came war. We were no match to their technology, almost indistinguishable from magic. Our only chance was to use their own weapons against them, augmenting ourselves, effectively turning the whole planet into a belligerent machine, sacrificing our freedom to save us from annihilation.

They say the war lasted one week. Truth is, all we know from this time is that no one ever won. Civilization was torn apart, with decentralized pockets of survivors left with a bleeding, war-torn home, filled with weapons from the past and the remnants of the invading forces crippled and unable to leave.

Still, there are some who believe the war is still going. Some believe there's deeper secret.

There, a Hero will rise.

## TODO

- [X] Implement State Machines for Player
- [X] Add running
- [X] Add dashes
- [X] Adapt state machines as a generic abstract class and decouple individual states
- [X] Less friction on jump run
- [X] Add roll
- [X] Add initial attack states
- [ ] Add enemies
  - Add a middleman Entity state machine then separate AI decision vs Player input
- [ ] Make attacks deal damage and properly handle the state(s)
- [ ] Add interaction between enemies and player
- [ ] Responsive jump
- [ ] Better jump arcs like in Dead Cells
- [ ] Delay management for abilities
- [ ] Add more intricate movement (wall jump perhaps)
- [ ] Create first level

## Notes

### Dead Cells

- Definitely has input buffers

### Attacks

- There is a time in which the attack combo order is still active. Between 1 to 2 seconds.
- Attacks can be early cancelled with anything except walking.
  - The time window for cancelling is the pre-animation (before the damaging swing)
  - If tried to cancelled after the window, input will be buffered if its a roll
  - If cancelled, the combo order is kept the same as it was before the attack.
- Character moves forward a little bit upon attacking. Intensified more by the type of weapon.
- Screen shakes depending on size of weapon
- Depending on the weapon, attacks stop the character midair till animation is finished
  - Smaller weapons like swords and arrow shooting keep the character in air
  - Big ass swords will cancel jump momentum and immediate start falling
