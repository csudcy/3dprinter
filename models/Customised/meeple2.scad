// author: clayb.rpi@gmail.com
// date: 2012-05-05
// units: mm
// description: a meeple character for games

LEG_WIDTH = 12;
ARM_WIDTH = 14;
HEIGHT = 16;
MEEPLE_THICKNESS = 5;
HEAD_DIAM = 5;
HEAD_POSITION = HEAD_DIAM * 1.25;
ROUNDED_RADIUS = 1;
FOOT_CUTOUT_RADIUS = 4;
HAND_RADIUS = 1.3;
SHOULDER_POSITION = HEIGHT * 0.45;
HAND_POSITION = HEIGHT * 0.4;

LETTER_THICKNESS = 0.4;
LETTER_SIZE = 5;
LETTER = "N";
FONT = "Comic Sans MS";

$fn=50;

module meeple_2d() {
  // head
  hull() {
    // Top
    translate([0, HEIGHT - HEAD_POSITION])
    circle(r=HEAD_DIAM / 2);
    // Bottom
    translate([0, HEIGHT - 1.5*HEAD_POSITION])
    circle(r=HEAD_DIAM / 2);
  }

  // body
  difference() {
    hull() {
      // Top
      translate([0, HEIGHT - HEAD_DIAM])
      circle(r=ROUNDED_RADIUS);
      // Left
      translate([-(LEG_WIDTH /2 - ROUNDED_RADIUS), ROUNDED_RADIUS])
      circle(r=ROUNDED_RADIUS);
      // Right
      translate([LEG_WIDTH /2 - ROUNDED_RADIUS, ROUNDED_RADIUS])
      circle(r=ROUNDED_RADIUS);
    }

    // foot cutout
    hull() {
      // Top
      translate([0, FOOT_CUTOUT_RADIUS /2])
      circle(r=ROUNDED_RADIUS);
      // Left
      translate([-(FOOT_CUTOUT_RADIUS /2 - ROUNDED_RADIUS), 0])
      circle(r=ROUNDED_RADIUS);
      // Right
      translate([FOOT_CUTOUT_RADIUS /2 - ROUNDED_RADIUS, 0])
      circle(r=ROUNDED_RADIUS);
    }
  }

  // arms
  hull() {
    // Top
    translate([0, SHOULDER_POSITION])
    circle(r=HEAD_DIAM / 2);
    // Left
    translate([-ARM_WIDTH / 2 + HAND_RADIUS, HAND_POSITION])
    circle(r=HAND_RADIUS);
  }
  hull() {
    // Top
    translate([0, SHOULDER_POSITION])
    circle(r=HEAD_DIAM / 2);
    // Right
    translate([ARM_WIDTH / 2 - HAND_RADIUS, HAND_POSITION])
    circle(r=HAND_RADIUS);
  }
}

difference() {
  linear_extrude(height=MEEPLE_THICKNESS)
  meeple_2d();

  translate([-LETTER_SIZE/2, HEIGHT*0.2, MEEPLE_THICKNESS-LETTER_THICKNESS])
  linear_extrude(height=2*LETTER_THICKNESS)
  text(LETTER, size=LETTER_SIZE, font=FONT);
}
