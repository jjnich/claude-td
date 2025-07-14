# Tower Defense Game - GameMaker Language (GML)

This is a complete tower defense game written in GameMaker Language for GameMaker Studio.

## Setup Instructions

1. **Create a new GameMaker Studio project**
2. **Create the following objects:**
   - `obj_GameController` - Main game controller
   - `obj_Enemy` - Enemy units
   - `obj_Tower` - Tower base object
   - `obj_Projectile` - Bullets/projectiles

3. **Copy the code:**
   - Copy `obj_GameController.gml` code into the GameController object events
   - Copy `obj_Enemy.gml` code into the Enemy object events
   - Copy `obj_Tower.gml` code into the Tower object events
   - Copy `obj_Projectile.gml` code into the Projectile object events
   - Add `scripts.gml` functions to your project scripts

4. **Create the main room:**
   - Create a room called `room_Main`
   - Set room dimensions to 1024x768
   - Set room speed to 60 FPS
   - Create layers: "Background", "Instances", "Controllers", "UI"
   - Place one `obj_GameController` instance in the room

## Game Features

### Tower Types
- **Basic Tower** (Key: 1) - $20, moderate damage and range
- **Rapid Tower** (Key: 2) - $40, fast firing, shorter range
- **Heavy Tower** (Key: 3) - $60, high damage, slow firing, long range

### Controls
- **1, 2, 3** - Select tower type
- **Mouse Click** - Place selected tower
- **SPACE** - Start wave
- **P** - Pause/unpause game

### Game Mechanics
- Start with 100 health and $100
- Enemies follow a predefined zigzag path
- Lose 10 health when enemies reach the end
- Earn $10 per enemy defeated
- Earn $50 bonus per wave completed
- Waves increase in difficulty (more enemies, more health)

### Path System
The game uses a predefined path with waypoints:
1. (0, 300) → (200, 300) - Horizontal entry
2. (200, 300) → (200, 150) - Turn up
3. (200, 150) → (400, 150) - Horizontal section
4. (400, 150) → (400, 450) - Turn down
5. (400, 450) → (600, 450) - Horizontal section
6. (600, 450) → (600, 300) - Turn up
7. (600, 300) → (800, 300) - Exit

## Object Hierarchy

### obj_GameController
- Manages game state (health, money, waves)
- Handles input and UI
- Controls wave spawning
- Draws the path and UI elements

### obj_Enemy
- Follows the predefined path using interpolation
- Has health bars and takes damage
- Rewards money when destroyed
- Damages player when reaching the end

### obj_Tower
- Three different types with varying stats
- Automatically targets closest enemy in range
- Fires projectiles at regular intervals
- Shows range when hovered

### obj_Projectile
- Tracks target enemy
- Deals damage on contact
- Automatically destroys when off-screen

## Code Structure

The code is organized into:
- **Object Events** - Create, Step, Draw events for each object
- **Helper Scripts** - Reusable functions for game logic
- **Room Setup** - Initial room configuration

## Customization Ideas

1. **Add more tower types** - Modify tower definitions in GameController
2. **Create boss enemies** - Add special enemies with more health
3. **Add upgrades** - Allow towers to be upgraded for more cost
4. **Power-ups** - Add temporary abilities like freeze or damage boost
5. **Multiple paths** - Create branching paths for enemies
6. **Particle effects** - Add visual effects for explosions and impacts

## Technical Notes

- Game runs at 60 FPS
- Uses distance calculations for targeting and collision
- Path following uses linear interpolation between waypoints
- UI is drawn using basic draw functions
- No external dependencies required