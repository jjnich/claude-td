# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a browser-based tower defense game built with HTML5 Canvas and vanilla JavaScript. Players place towers to defend against waves of enemies following a predefined path.

## Development Setup

This is a client-side web application that requires no build process or dependencies. Simply open `index.html` in a web browser to run the game.

## Commands

No build commands are needed. To run the game:
- Open `index.html` in any modern web browser
- Or serve the directory with a local web server (e.g., `python -m http.server` or `npx http-server`)

## Architecture

### File Structure
- `index.html` - Main HTML file with game UI and canvas
- `game.js` - Core game logic, classes, and game loop
- `style.css` - Styling for UI panels and responsive design

### Game Architecture
- **Game Class**: Main game controller handling state, game loop, and coordination
- **Enemy System**: Enemies follow a predefined path with health/damage mechanics
- **Tower System**: Three tower types (Basic, Rapid, Heavy) with different stats
- **Projectile System**: Bullet physics and collision detection
- **Wave Management**: Progressive difficulty with configurable enemy spawning
- **UI Integration**: Real-time updates for health, money, and wave information

### Game Mechanics
- **Path System**: Fixed path with waypoint navigation for enemies
- **Economy**: Money earned from defeating enemies, spent on towers
- **Tower Placement**: Grid-free placement with collision detection
- **Targeting**: Towers auto-target closest enemy in range
- **Health System**: Player loses health when enemies reach the end

### Key Classes and Systems
- Game loop runs at 60fps using `requestAnimationFrame`
- Enemy pathfinding uses linear interpolation between waypoints
- Tower targeting uses distance calculations for range detection
- Collision detection for projectiles uses simple distance checks