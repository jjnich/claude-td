# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a tower defense game built with GameMaker Language (GML) for GameMaker Studio. Players place towers to defend against waves of enemies following a predefined path.

## Development Setup

This project requires GameMaker Studio to run. Import the GML files into a new GameMaker project following the setup instructions in `gml/README_GML.md`.

## Commands

No build commands are needed. To run the game:
- Open GameMaker Studio
- Create new project and import the GML objects and scripts
- Run the project in GameMaker Studio

## Architecture

### File Structure
- `gml/obj_GameController.gml` - Main game controller object
- `gml/obj_Enemy.gml` - Enemy object with pathfinding
- `gml/obj_Tower.gml` - Tower object with targeting system
- `gml/obj_Projectile.gml` - Projectile object for bullets
- `gml/scripts.gml` - Helper functions and game logic
- `gml/room_Main.gml` - Main game room setup
- `gml/README_GML.md` - Detailed setup and implementation guide

### Game Architecture
- **GameController Object**: Main game state management, wave spawning, UI rendering
- **Enemy System**: Path-following enemies with health and damage mechanics
- **Tower System**: Three tower types (Basic, Rapid, Heavy) with different stats and targeting
- **Projectile System**: Bullet physics with target tracking and collision detection
- **Wave Management**: Progressive difficulty with configurable enemy spawning

### Game Mechanics
- **Path System**: Fixed zigzag path using waypoint interpolation
- **Economy**: Money earned from defeating enemies, spent on tower placement
- **Tower Placement**: Grid-free placement with collision detection against path and other towers
- **Targeting**: Towers auto-target closest enemy within range
- **Health System**: Player loses health when enemies reach path end

### Key GML Systems
- Game runs at 60 FPS using room_speed setting
- Enemy pathfinding uses linear interpolation between path waypoints
- Tower targeting uses distance_to_object() for range detection
- Collision detection uses instance_place() and distance calculations
- UI rendered using draw_text() and draw_circle() functions