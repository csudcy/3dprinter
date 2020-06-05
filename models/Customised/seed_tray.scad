$fn = 100;

// Overall settings
POTS_WIDE_HIGH = 3;

// Pot settings
POT_INNER_RADIUS = 25;
POT_HOLE_RADIUS = 4;
POT_WALL_THICKNESS = 1;
POT_HEIGHT = 30;

// Connector settings
POT_GAP = 4;
CONNECTOR_THICKNESS = 2.5;
CONNECTOR_LOWER_LENGTH = POT_INNER_RADIUS / 4;
CONNECTION_LOWER_HEIGHT = POT_HEIGHT / 2;

// Base
BASE_THICKNESS = 1.5;
BASE_CORNER_RADIUS = 5;
BASE_HEIGHT = CONNECTION_LOWER_HEIGHT + 2;
BASE_WALL_THICKNESS = 2;
GRID_WALL_THICKNESS = 1.5;
GRID_LOWER_LENGTH = POT_INNER_RADIUS / 2;
GRID_LOWER_HEIGHT = BASE_HEIGHT / 2;

// Tray Calculated
POT_OUTER_RADIUS = POT_INNER_RADIUS + POT_WALL_THICKNESS;
POT_TOTAL_WH = 2*POT_OUTER_RADIUS + POT_GAP;
POT_POT_LENGTH = sqrt(2 * POT_TOTAL_WH * POT_TOTAL_WH);
CONNECTOR_HALF_WIDTH = CONNECTOR_THICKNESS / 2;
CONNECTOR_LENGTH = POT_POT_LENGTH - 2 * POT_INNER_RADIUS;
CONNECTOR_GAP_LENGTH = CONNECTOR_LENGTH - 2 * CONNECTOR_LOWER_LENGTH;

TRAY_OFFSET_XY = POT_OUTER_RADIUS+BASE_WALL_THICKNESS+POT_GAP/2;
TRAY_OFFSET_Z = BASE_THICKNESS;

// Base Calculated
BASE_INNER_WH = POT_TOTAL_WH * POTS_WIDE_HIGH;
BASE_OUTER_WH = BASE_INNER_WH + 2 * BASE_WALL_THICKNESS;
GRID_GAP_LENGTH = POT_TOTAL_WH - 2 * GRID_LOWER_LENGTH;


module pot() {
  // Pot sides
  linear_extrude(height=POT_HEIGHT) {
    difference() {
      circle(POT_OUTER_RADIUS);
      circle(POT_INNER_RADIUS);
    }
  }

  // Pot bases
  linear_extrude(height=POT_WALL_THICKNESS) {
    difference() {
      circle(POT_OUTER_RADIUS);
      circle(POT_HOLE_RADIUS);
    }
  }
}

module connector(angle) {
  rotate(angle) {
    translate([-CONNECTOR_HALF_WIDTH, POT_INNER_RADIUS]) {
      difference() {
        linear_extrude(POT_HEIGHT) {
          square(size=[CONNECTOR_THICKNESS, CONNECTOR_LENGTH]);
        }
        linear_extrude(CONNECTION_LOWER_HEIGHT) {
          translate([0, CONNECTOR_LOWER_LENGTH]) {
            square(size=[CONNECTOR_THICKNESS, CONNECTOR_GAP_LENGTH]);
          }
        }
      }
    }
  }
}

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

module tray_top() {
  translate([TRAY_OFFSET_XY, TRAY_OFFSET_XY, TRAY_OFFSET_Z]) {
    for (x = [0:POTS_WIDE_HIGH-1]) {
      for (y = [0:POTS_WIDE_HIGH-1]) {
        translate([x*POT_TOTAL_WH, y*POT_TOTAL_WH]) {
          pot();

          if (y > 0) {
            // Pot connectors
            if (x > 0) {
              // South West
              connector(180 - 45);
            }

            if (x < POTS_WIDE_HIGH - 1) {
              // South East
              connector(180 + 45);
            }
          }
        }
      }
    }
  }
}

module grid() {
  difference() {
    // Walls
    for (count = [1:POTS_WIDE_HIGH-1]) {
      translate([count*POT_TOTAL_WH + BASE_WALL_THICKNESS - GRID_WALL_THICKNESS/2, 0]) {
        cube([GRID_WALL_THICKNESS, BASE_OUTER_WH, BASE_HEIGHT]);
      }
    }

    // Gaps
    for (count = [0:POTS_WIDE_HIGH-1]) {
      translate([2*BASE_WALL_THICKNESS, count*POT_TOTAL_WH + GRID_LOWER_LENGTH + BASE_WALL_THICKNESS, -1]) {
        cube([BASE_OUTER_WH - 4*BASE_WALL_THICKNESS, GRID_GAP_LENGTH, GRID_LOWER_HEIGHT + 1]);
      }
    }
  }
}

module tray_bottom() {
  // Base plate
  linear_extrude(BASE_THICKNESS) {
    rounded_rect(BASE_OUTER_WH, BASE_OUTER_WH, BASE_CORNER_RADIUS);
  }

  // Sides
  linear_extrude(BASE_HEIGHT) {
    difference() {
      rounded_rect(BASE_OUTER_WH, BASE_OUTER_WH, BASE_CORNER_RADIUS);
      translate([BASE_WALL_THICKNESS, BASE_WALL_THICKNESS]) {
        rounded_rect(BASE_INNER_WH, BASE_INNER_WH, BASE_CORNER_RADIUS);
      }
    }
  }

  // Horizontal
  grid();

  // Vertical
  translate([BASE_OUTER_WH, 0, 0]) {
    rotate(a=90) {
      grid();
    }
  }
}

tray_bottom();
// tray_top();
