// obj_GameController - Main game controller object

// Create Event
player_health = 100;
player_money = 100;
current_wave = 1;
game_paused = false;
selected_tower_type = "";
wave_active = false;
enemies_to_spawn = 10;
enemies_spawned = 0;
spawn_timer = 0;
spawn_delay = 60; // frames between spawns

// Define path waypoints
path_points = [
    {x: 0, y: 300},
    {x: 200, y: 300},
    {x: 200, y: 150},
    {x: 400, y: 150},
    {x: 400, y: 450},
    {x: 600, y: 450},
    {x: 600, y: 300},
    {x: 800, y: 300}
];

// Tower definitions
tower_basic = {
    cost: 20,
    damage: 25,
    range: 100,
    fire_rate: 60, // frames between shots
    color: c_green
};

tower_rapid = {
    cost: 40,
    damage: 15,
    range: 80,
    fire_rate: 30,
    color: c_orange
};

tower_heavy = {
    cost: 60,
    damage: 50,
    range: 120,
    fire_rate: 120,
    color: c_red
};

// Step Event
if (!game_paused) {
    // Handle wave spawning
    if (wave_active && enemies_spawned < enemies_to_spawn) {
        spawn_timer++;
        if (spawn_timer >= spawn_delay) {
            spawn_enemy();
            enemies_spawned++;
            spawn_timer = 0;
        }
    }
    
    // Check if wave is complete
    if (wave_active && enemies_spawned >= enemies_to_spawn && instance_number(obj_Enemy) == 0) {
        wave_complete();
    }
    
    // Check game over
    if (player_health <= 0) {
        show_message("Game Over! You reached wave " + string(current_wave));
        game_restart();
    }
}

// Mouse Events
if (mouse_check_button_pressed(mb_left)) {
    handle_mouse_click();
}

// Keyboard Events
if (keyboard_check_pressed(vk_space)) {
    start_wave();
}

if (keyboard_check_pressed(ord("P"))) {
    game_paused = !game_paused;
}

if (keyboard_check_pressed(ord("1"))) {
    selected_tower_type = "basic";
}

if (keyboard_check_pressed(ord("2"))) {
    selected_tower_type = "rapid";
}

if (keyboard_check_pressed(ord("3"))) {
    selected_tower_type = "heavy";
}

// Draw Event
draw_self();

// Draw path
draw_set_color(c_brown);
for (var i = 0; i < array_length(path_points) - 1; i++) {
    draw_line_width(
        path_points[i].x, path_points[i].y,
        path_points[i + 1].x, path_points[i + 1].y,
        40
    );
}

// Draw UI
draw_ui();

// Draw tower placement preview
if (selected_tower_type != "") {
    draw_tower_preview();
}