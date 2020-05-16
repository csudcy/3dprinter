// Control constants
WIDTH_END = 3;
WIDTH_DIVIDER = 3;
WIDTH_GAP = 25;
HEIGHT_BASE = 3;
HEIGHT_DIVIDER = 70;
DEPTH = 20;
COUNT_DIVIDERS = 7;

$fn = 50;

// Calculated constants
COUNT_GAPS = COUNT_DIVIDERS - 1;
WIDTH_DIVIDER_HALF = WIDTH_DIVIDER / 2;
WIDTH_TOTAL = 2 * WIDTH_END + COUNT_DIVIDERS * WIDTH_DIVIDER + COUNT_GAPS * WIDTH_GAP;
HEIGHT_BASE_HALF = HEIGHT_BASE / 2;

module rounded_rectangle(w, h, r) {
  hull() {
    translate([r, r]) { circle(r); }
    translate([r, h-r]) { circle(r); }
    translate([w-r, r]) { circle(r); }
    translate([w-r, h-r]) { circle(r); }
  }
}

linear_extrude(height=DEPTH) {
  // Base
  rounded_rectangle(WIDTH_TOTAL, HEIGHT_BASE, HEIGHT_BASE_HALF);

  // Dividers
  for (x = [0:COUNT_DIVIDERS-1]) {
    translate([WIDTH_END + x * (WIDTH_GAP + WIDTH_DIVIDER), HEIGHT_BASE_HALF]) {
      rounded_rectangle(WIDTH_DIVIDER, HEIGHT_DIVIDER + HEIGHT_BASE_HALF, WIDTH_DIVIDER_HALF);
      translate([-WIDTH_DIVIDER_HALF, HEIGHT_BASE_HALF]) {
        difference() {
          square([WIDTH_DIVIDER * 2, WIDTH_DIVIDER_HALF]);
          translate([0, WIDTH_DIVIDER_HALF]) {
            circle(WIDTH_DIVIDER_HALF);
          }
          translate([WIDTH_DIVIDER * 2, WIDTH_DIVIDER_HALF]) {
            circle(WIDTH_DIVIDER_HALF);
          }
        }
      }
    }
  }
}
