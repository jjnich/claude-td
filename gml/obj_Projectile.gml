// obj_Projectile - Projectile object

// Create Event
damage = 25;
move_speed = 5;
target = noone;
direction_to_target = 0;

// Step Event
if (!obj_GameController.game_paused) {
    // Move towards target
    if (target != noone && instance_exists(target)) {
        // Update direction to target
        direction_to_target = point_direction(x, y, target.x, target.y);
        
        // Move towards target
        x += lengthdir_x(move_speed, direction_to_target);
        y += lengthdir_y(move_speed, direction_to_target);
        
        // Check if hit target
        if (distance_to_object(target) < 10) {
            target.health -= damage;
            instance_destroy();
        }
    } else {
        // Target doesn't exist, continue in last direction
        x += lengthdir_x(move_speed, direction_to_target);
        y += lengthdir_y(move_speed, direction_to_target);
    }
    
    // Destroy if off screen
    if (x < -50 || x > room_width + 50 || y < -50 || y > room_height + 50) {
        instance_destroy();
    }
}

// Draw Event
draw_self();

// Draw projectile (yellow circle)
draw_set_color(c_yellow);
draw_circle(x, y, 3, false);