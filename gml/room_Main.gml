// room_Main - Main game room setup

// Room Properties
room_width = 1024;
room_height = 768;
room_speed = 60; // 60 FPS

// Room Creation Code
// This code runs when the room is created

// Create the main game controller
instance_create_layer(0, 0, "Controllers", obj_GameController);

// Room can have a background color
background_colour = make_colour_rgb(100, 150, 100); // Light green background

// Layer Setup Instructions:
// In GameMaker Studio IDE, create these layers in the room editor:
// 1. "Background" - for background elements
// 2. "Instances" - for game objects (enemies, towers, projectiles)
// 3. "Controllers" - for game controller object
// 4. "UI" - for UI elements (if using objects for UI)

// Alternative: Use draw events in game controller for simple UI