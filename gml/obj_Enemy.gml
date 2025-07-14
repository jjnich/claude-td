// obj_Enemy - Enemy object with pathfinding

// Create Event
max_health = 50 + (obj_GameController.current_wave - 1) * 10;
health = max_health;
move_speed = 1;
reward = 10;
path_index = 0;
path_progress = 0;
target_x = obj_GameController.path_points[0].x;
target_y = obj_GameController.path_points[0].y;
x = target_x;
y = target_y;

// Step Event
if (!obj_GameController.game_paused) {
    move_along_path();
    
    // Check if reached end of path
    if (path_index >= array_length(obj_GameController.path_points) - 1) {
        obj_GameController.player_health -= 10;
        instance_destroy();
    }
    
    // Check if dead
    if (health <= 0) {
        obj_GameController.player_money += reward;
        instance_destroy();
    }
}

// Draw Event
draw_self();

// Draw enemy (red circle)
draw_set_color(c_red);
draw_circle(x, y, 15, false);

// Draw health bar
var bar_width = 30;
var bar_height = 5;
var health_percentage = health / max_health;

// Background
draw_set_color(c_black);
draw_rectangle(x - bar_width/2, y - 25, x + bar_width/2, y - 25 + bar_height, false);

// Health bar
draw_set_color(c_lime);
draw_rectangle(x - bar_width/2, y - 25, x - bar_width/2 + bar_width * health_percentage, y - 25 + bar_height, false);

// Collision with projectiles
var projectile = instance_place(x, y, obj_Projectile);
if (projectile != noone) {
    health -= projectile.damage;
    with (projectile) {
        instance_destroy();
    }
}