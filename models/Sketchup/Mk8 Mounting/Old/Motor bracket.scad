motor_outer = 42.3;
motor_inner = 31.0;
motor_diff = (motor_outer - motor_inner) / 2.0;
motor_wall = 3.0;

surround_height = 10.0;

clamp_gap = 2.0;
clamp_height = 12.0;
clamp_outer = motor_outer+2*motor_wall;
clamp_inner = (clamp_outer / motor_outer) * motor_inner;
clamp_diff = (clamp_outer - clamp_inner) / 2.0;

screw_diameter = 4.0;
screw_head_diameter = screw_diameter + 2.0;
screw_nut_diameter = screw_diameter + 2.0;
screw_length = clamp_gap + 2*4.0;

support_hole_diameter = 4.0;
support_x_inner_space = 17.5;
support_y_inner_space = 18.1;
support_x = motor_inner;
support_space = (support_x - (support_x_inner_space + 2*support_hole_diameter)) / 2;
support_y = support_y_inner_space + 2*support_hole_diameter + support_space;

module cut_corner_square(outer, inner) {    
    // Work out the dimentions of the chamfer square
    diff = (outer-inner) / 2.0;
    diff_dash = sqrt(pow(diff, 2) * 2);
    inner_dash = sqrt(pow(inner, 2) / 2);
    chamfer = diff_dash + 2 * inner_dash;
    
    intersection() {
        square([outer, outer]);
        translate([inner/2+diff, -inner/2, 0])
            rotate(45)
                square([chamfer, chamfer]);
    }
}

module motor_surround() {
    difference() {
        resize([clamp_outer, clamp_outer]) {
            cut_corner_square(motor_outer, motor_inner);
        }
        translate([motor_wall, motor_wall]) {
            cut_corner_square(motor_outer, motor_inner);
        }
    }
}

module clamp() {
    chamfer_wh = 2*clamp_height;
    chamfer_hyp = sqrt(2 * pow(chamfer_wh, 2));

    translate([clamp_outer, clamp_diff, 0]) {
        difference() {
            square([clamp_height, clamp_inner]);
            translate([chamfer_hyp/2.0, -chamfer_hyp/2.0, 0]) {
                rotate([0, 0, 45]) {
                    square([2*clamp_height, 2*clamp_height]);
                }
            }
            translate([chamfer_hyp/2.0, clamp_inner-chamfer_hyp/2.0, 0]) {
                rotate([0, 0, 45]) {
                    square([2*clamp_height, 2*clamp_height]);
                }
            }
        }
    }
}

module motor_with_clamp() {
    difference() {
        union() {
            motor_surround();
            clamp();
        }
        // Clamp gap
        translate([clamp_outer-motor_wall-1, (clamp_outer-clamp_gap)/2, 0]) {
            square([clamp_height+motor_wall+2, clamp_gap]);
        }
    }
}

module screw(shaft_d, shaft_l, head_d, head_l, nut_d, nut_l) {
    union() {
        // Shaft
        translate([-0.1, 0, 0])
            cylinder(h=shaft_l+0.2, d=shaft_d, $fs=0.5);
        // Head
        translate([0, 0, shaft_l])
            cylinder(h=head_l, d=head_d, $fs=0.5);
        // Nut
        translate([0, 0, -nut_l])
            cylinder(h=nut_l, d=nut_d, $fn=6);
    }
}

module full_surround() {
    difference() {
        linear_extrude(surround_height) {
            motor_with_clamp();
        }
        translate([clamp_outer+clamp_height/2, (clamp_outer+screw_length)/2, surround_height/2]) {
            rotate([0, 360/12, 0]) {
                rotate([90, 0, 0]) {
                    screw(
                        shaft_d=screw_diameter,
                        shaft_l=screw_length,
                        head_d=screw_head_diameter,
                        head_l=clamp_outer+1.0,
                        nut_d=screw_nut_diameter,
                        nut_l=clamp_outer+1.0
                    );
                }
            }
        }
    }
}

module support() {
    support_hole_centre = support_space+support_hole_diameter*3/4;
    difference() {
        cube([support_x, support_y, motor_wall]);
        translate([support_hole_centre, support_hole_centre, -motor_wall/2]) {
            cylinder(h=2*motor_wall, d=4, $fs=0.5);
        }
        translate([support_hole_centre+support_x_inner_space, support_hole_centre, -motor_wall/2]) {
            cylinder(h=2*motor_wall, d=4, $fs=0.5);
        }
        translate([support_hole_centre, support_hole_centre+support_y_inner_space, -motor_wall/2]) {
            cylinder(h=2*motor_wall, d=4, $fs=0.5);
        }
        translate([support_hole_centre+support_x_inner_space, support_hole_centre+support_y_inner_space, -motor_wall/2]) {
            cylinder(h=2*motor_wall, d=4, $fs=0.5);
        }
    }
}

union() {
    full_surround();
    translate([motor_wall, motor_diff+motor_wall, surround_height-0.01]) {
        rotate([0, -90, 0]) {
            support();
        }
    }
}

