$fn = 100;

// 10 cm (H): 60.5 cm (W): 11 cm (D)

DEPTH = 20;
INNER_WIDTH = 98;
INNER_HEIGHT = 99;
WALL_WIDTH = 5;
CORNER_RADIUS = 5;
HANGER_HEIGHT = 10;
HANGER_TOP_HEIGHT = 20;
HANGER_WIDTH = 20;
HANGER_RADIUS = 2;
HOLE_RADIUS = 2.5;

// Calculated
OUTER_WIDTH = INNER_WIDTH + 2*WALL_WIDTH;
OUTER_HEIGHT = INNER_HEIGHT + 2*WALL_WIDTH;
HANGER_RADIUS = HANGER_WIDTH / 4;
TOP_HEIGHT = OUTER_HEIGHT + HANGER_HEIGHT;

module rounded_rect(w, h, r) {
  hull() {
    translate([r, r]) {
      circle(r);
    }
    translate([w-r, r]) {
      circle(r);
    }
    translate([r, h-r]) {
      circle(r);
    }
    translate([w-r, h-r]) {
      circle(r);
    }
  }
}

difference() {
  linear_extrude(DEPTH) {
    difference() {
      // Solid
      union() {
        hull() {
          // Outside
          rounded_rect(OUTER_WIDTH, OUTER_HEIGHT, CORNER_RADIUS);
          // Top point
          translate([OUTER_WIDTH/2, TOP_HEIGHT]) {
            circle(HANGER_RADIUS);
          }
        }
        // Top hanger
        translate([(OUTER_WIDTH - HANGER_WIDTH)/2, TOP_HEIGHT-HANGER_RADIUS]) {
          rounded_rect(HANGER_WIDTH, HANGER_TOP_HEIGHT, HANGER_RADIUS);
        }
      }
      // Centre
      translate([WALL_WIDTH, WALL_WIDTH]) {
        rounded_rect(INNER_WIDTH, INNER_HEIGHT, CORNER_RADIUS);
      }
    }
  }
  // Hanger hole
  translate([0, TOP_HEIGHT + HANGER_TOP_HEIGHT / 3, DEPTH/2]) {
    rotate([0, 90, 0]) {
      cylinder(h=OUTER_WIDTH, r=HOLE_RADIUS);
    }
  }
}
