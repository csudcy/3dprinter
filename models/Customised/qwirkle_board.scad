// Control constants
TILE_WH = 19.2;
GAP_WH = 2;
BOARD_WIDTH = 7;
BOARD_HEIGHT = 7;
BOARD_DEPTH = 2;
CONNECTOR_WIDTH = 2;

$fn = 50;

// Calculated constants
TILE_TOTAL_WH = TILE_WH + GAP_WH;
BOARD_TOTAL_WIDTH = BOARD_WIDTH * TILE_TOTAL_WH + GAP_WH;
BOARD_TOTAL_HEIGHT = BOARD_HEIGHT * TILE_TOTAL_WH + GAP_WH;
HALF_TILE_WH = TILE_TOTAL_WH / 2;
HALF_GAP_WH = GAP_WH / 2;

module horizontal_edge() {
  for (x = [0:BOARD_WIDTH-1]) {
    translate ([HALF_GAP_WH+x*TILE_TOTAL_WH, 0]) {
      polygon(points=[[0, 0],[HALF_TILE_WH, CONNECTOR_WIDTH],[TILE_TOTAL_WH, 0]]);
    }
  }
}

module verical_edge() {
  for (y = [0:BOARD_HEIGHT-1]) {
    translate ([0, HALF_GAP_WH+y*TILE_TOTAL_WH]) {
      polygon(points=[[0, 0],[CONNECTOR_WIDTH, HALF_TILE_WH],[0, TILE_TOTAL_WH]]);
    }
  }
}

linear_extrude(height=BOARD_DEPTH) {
  difference(){
    // Overall board
    square([BOARD_TOTAL_WIDTH, BOARD_TOTAL_HEIGHT]);

    // The squares
    for (x = [0:BOARD_WIDTH-1]) {
      for (y = [0:BOARD_HEIGHT-1]) {
        translate ([GAP_WH+x*TILE_TOTAL_WH, GAP_WH+y*TILE_TOTAL_WH]) {
          square([TILE_WH, TILE_WH]);
        }
      }
    }
  }

  // Right edge
  translate ([BOARD_TOTAL_WIDTH, 0]) {
    verical_edge();
  }
  // Top edge
  translate ([0, BOARD_TOTAL_HEIGHT]) {
    horizontal_edge();
  }
  // Left
  translate ([-CONNECTOR_WIDTH, 0]) {
    difference() {
      translate([0, HALF_GAP_WH])
      square([CONNECTOR_WIDTH, BOARD_TOTAL_HEIGHT-GAP_WH]);
      verical_edge();
    }
  }
  // Bottom
  translate ([0, -CONNECTOR_WIDTH]) {
    difference() {
      translate([HALF_GAP_WH, 0])
      square([BOARD_TOTAL_WIDTH-GAP_WH, CONNECTOR_WIDTH]);
      horizontal_edge();
    }
  }

}
