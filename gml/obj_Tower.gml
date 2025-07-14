// obj_Tower - Base tower object

// Create Event
damage = 25;
range = 100;
fire_rate = 60;
last_fire = 0;
tower_type = "basic";
tower_color = c_green;
target = noone;

// Step Event
if (!obj_GameController.game_paused) {
    // Increment fire timer
    last_fire++;
    
    // Find target
    find_target();
    
    // Fire at target
    if (target != noone && last_fire >= fire_rate) {
        fire_projectile();
        last_fire = 0;
    }
}

// Draw Event
draw_self();

// Draw tower (colored circle)
draw_set_color(tower_color);
draw_circle(x, y, 20, false);

// Draw range (when selected or hovered)
if (distance_to_point(mouse_x, mouse_y) < 25) {
    draw_set_color(tower_color);
    draw_set_alpha(0.1);
    draw_circle(x, y, range, false);
    draw_set_alpha(1);
}

// Draw targeting line to current target
if (target != noone && instance_exists(target)) {
    draw_set_color(c_yellow);
    draw_line(x, y, target.x, target.y);
}