// Game Scripts - Helper functions for tower defense game

// Function: spawn_enemy
// Creates a new enemy at the start of the path
function spawn_enemy() {
    var enemy = instance_create_layer(0, 0, "Instances", obj_Enemy);
    return enemy;
}

// Function: start_wave
// Begins spawning enemies for the current wave
function start_wave() {
    if (!wave_active) {
        wave_active = true;
        enemies_spawned = 0;
        spawn_timer = 0;
        enemies_to_spawn = 10 + (current_wave - 1) * 2; // Increase enemies per wave
    }
}

// Function: wave_complete
// Called when a wave is finished
function wave_complete() {
    wave_active = false;
    current_wave++;
    player_money += 50; // Bonus money for completing wave
}

// Function: handle_mouse_click
// Handles mouse clicks for tower placement
function handle_mouse_click() {
    if (selected_tower_type != "") {
        if (can_place_tower(mouse_x, mouse_y)) {
            place_tower(mouse_x, mouse_y, selected_tower_type);
        }
    }
}

// Function: can_place_tower
// Checks if a tower can be placed at the given position
function can_place_tower(xx, yy) {
    var tower_def = get_tower_definition(selected_tower_type);
    
    // Check if player has enough money
    if (player_money < tower_def.cost) {
        return false;
    }
    
    // Check distance from other towers
    var nearest_tower = instance_nearest(xx, yy, obj_Tower);
    if (nearest_tower != noone && distance_to_object(nearest_tower) < 50) {
        return false;
    }
    
    // Check distance from path
    for (var i = 0; i < array_length(path_points) - 1; i++) {
        var p1 = path_points[i];
        var p2 = path_points[i + 1];
        var dist_to_path = distance_to_line_segment(xx, yy, p1.x, p1.y, p2.x, p2.y);
        if (dist_to_path < 40) {
            return false;
        }
    }
    
    return true;
}

// Function: place_tower
// Places a tower at the specified position
function place_tower(xx, yy, tower_type) {
    var tower_def = get_tower_definition(tower_type);
    var tower = instance_create_layer(xx, yy, "Instances", obj_Tower);
    
    with (tower) {
        damage = tower_def.damage;
        range = tower_def.range;
        fire_rate = tower_def.fire_rate;
        tower_color = tower_def.color;
        tower_type = tower_type;
    }
    
    player_money -= tower_def.cost;
    selected_tower_type = ""; // Deselect after placing
}

// Function: get_tower_definition
// Returns tower stats based on type
function get_tower_definition(tower_type) {
    switch (tower_type) {
        case "basic":
            return tower_basic;
        case "rapid":
            return tower_rapid;
        case "heavy":
            return tower_heavy;
        default:
            return tower_basic;
    }
}

// Function: distance_to_line_segment
// Calculates distance from point to line segment
function distance_to_line_segment(px, py, x1, y1, x2, y2) {
    var dx = x2 - x1;
    var dy = y2 - y1;
    var length_squared = dx * dx + dy * dy;
    
    if (length_squared == 0) {
        return point_distance(px, py, x1, y1);
    }
    
    var t = max(0, min(1, ((px - x1) * dx + (py - y1) * dy) / length_squared));
    var proj_x = x1 + t * dx;
    var proj_y = y1 + t * dy;
    
    return point_distance(px, py, proj_x, proj_y);
}

// Function: move_along_path (for enemy object)
// Moves enemy along the predefined path
function move_along_path() {
    if (path_index < array_length(obj_GameController.path_points) - 1) {
        var current_point = obj_GameController.path_points[path_index];
        var next_point = obj_GameController.path_points[path_index + 1];
        
        var dx = next_point.x - current_point.x;
        var dy = next_point.y - current_point.y;
        var distance_to_next = point_distance(current_point.x, current_point.y, next_point.x, next_point.y);
        
        path_progress += move_speed / distance_to_next;
        
        if (path_progress >= 1) {
            path_progress = 0;
            path_index++;
        } else {
            x = current_point.x + dx * path_progress;
            y = current_point.y + dy * path_progress;
        }
    }
}

// Function: find_target (for tower object)
// Finds the closest enemy within range
function find_target() {
    target = noone;
    var closest_distance = range;
    
    with (obj_Enemy) {
        var dist = distance_to_object(other);
        if (dist <= other.range && dist < closest_distance) {
            other.target = id;
            closest_distance = dist;
        }
    }
}

// Function: fire_projectile (for tower object)
// Creates a projectile aimed at the target
function fire_projectile() {
    if (target != noone && instance_exists(target)) {
        var projectile = instance_create_layer(x, y, "Instances", obj_Projectile);
        with (projectile) {
            damage = other.damage;
            target = other.target;
        }
    }
}

// Function: draw_ui
// Draws the game UI
function draw_ui() {
    draw_set_color(c_white);
    draw_set_font(-1);
    
    // Health
    draw_text(10, 10, "Health: " + string(player_health));
    
    // Money
    draw_text(10, 30, "Money: $" + string(player_money));
    
    // Wave
    draw_text(10, 50, "Wave: " + string(current_wave));
    
    // Tower selection
    draw_text(10, 80, "Selected: " + selected_tower_type);
    
    // Instructions
    draw_text(10, room_height - 100, "Controls:");
    draw_text(10, room_height - 80, "1 - Basic Tower ($20)");
    draw_text(10, room_height - 60, "2 - Rapid Tower ($40)");
    draw_text(10, room_height - 40, "3 - Heavy Tower ($60)");
    draw_text(10, room_height - 20, "SPACE - Start Wave, P - Pause");
    
    // Tower costs and availability
    var basic_cost = tower_basic.cost;
    var rapid_cost = tower_rapid.cost;
    var heavy_cost = tower_heavy.cost;
    
    draw_set_color(player_money >= basic_cost ? c_white : c_gray);
    draw_text(200, room_height - 80, "Basic: $" + string(basic_cost));
    
    draw_set_color(player_money >= rapid_cost ? c_white : c_gray);
    draw_text(200, room_height - 60, "Rapid: $" + string(rapid_cost));
    
    draw_set_color(player_money >= heavy_cost ? c_white : c_gray);
    draw_text(200, room_height - 40, "Heavy: $" + string(heavy_cost));
    
    // Game state
    if (game_paused) {
        draw_set_color(c_yellow);
        draw_text(room_width / 2 - 50, room_height / 2, "PAUSED");
    }
    
    if (wave_active) {
        draw_set_color(c_lime);
        draw_text(10, 110, "Wave Active - Enemies: " + string(enemies_spawned) + "/" + string(enemies_to_spawn));
    } else {
        draw_set_color(c_yellow);
        draw_text(10, 110, "Press SPACE to start wave");
    }
}

// Function: draw_tower_preview
// Shows where tower will be placed
function draw_tower_preview() {
    var tower_def = get_tower_definition(selected_tower_type);
    var can_place = can_place_tower(mouse_x, mouse_y);
    
    draw_set_color(can_place ? c_green : c_red);
    draw_set_alpha(0.5);
    draw_circle(mouse_x, mouse_y, 20, false);
    
    draw_set_alpha(0.2);
    draw_circle(mouse_x, mouse_y, tower_def.range, false);
    
    draw_set_alpha(1);
}

// Function: game_restart
// Restarts the game
function game_restart() {
    player_health = 100;
    player_money = 100;
    current_wave = 1;
    wave_active = false;
    selected_tower_type = "";
    
    // Destroy all instances
    with (obj_Enemy) instance_destroy();
    with (obj_Tower) instance_destroy();
    with (obj_Projectile) instance_destroy();
}