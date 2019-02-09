$fn=50;

// General
PLATE_DEPTH = 3.5;

// Screw settings
WASHER_DIAMETER = 6.9;
SCREW_DIAMETER = 3.50;
SCREW_RADIUS_DISTANCE_FROM_GLASS_Y = 4;
SCREW_RADIUS_DISTANCE_FROM_GLASS_X = -4;
SCREW_SUPPPORT_DEPTH = 1.5;

// Arm settings
Y_LENGTH = 35;
Y_THICKNESS = 10;
X_LENGTH = 35;
X_THICKNESS = 10;
CORNER_ROUND_DIAMETER = 8;


module xPartSmoothCylinder() {
    translate([Y_THICKNESS,X_THICKNESS]){
        scale([(X_LENGTH-Y_THICKNESS)/X_THICKNESS, 1, 1])
        cylinder(PLATE_DEPTH, X_THICKNESS, X_THICKNESS);
    }
}

module yPartSmoothCylinder() {
    translate([Y_THICKNESS, X_THICKNESS]){
        scale([1, (Y_LENGTH-X_THICKNESS)/Y_THICKNESS, 1])
        cylinder(PLATE_DEPTH, Y_THICKNESS, Y_THICKNESS);
    }
}

module xPart() {
    intersection(){
        xPartSmoothCylinder();
        translate([Y_THICKNESS, 0])
        cube([X_LENGTH-Y_THICKNESS,X_THICKNESS,PLATE_DEPTH]); 
    }   
}

module yPart() {
    intersection(){
        yPartSmoothCylinder();
        translate ([0, X_THICKNESS])
        cube([Y_THICKNESS,Y_LENGTH-X_THICKNESS,PLATE_DEPTH]);
    }
}

module union_block() {
    cube([Y_THICKNESS, X_THICKNESS, PLATE_DEPTH]);
}

module ScrewHole() {
  cylinder(PLATE_DEPTH, d1=SCREW_DIAMETER, d2=SCREW_DIAMETER, center=false);  
}

module WasherHole() {
    translate([0,0,SCREW_SUPPPORT_DEPTH])
    cylinder(PLATE_DEPTH, d1=WASHER_DIAMETER, d2=WASHER_DIAMETER, center=false);  
}

module RoundedCorner(){
    translate([0, 0])
    difference(){
        cube([CORNER_ROUND_DIAMETER, CORNER_ROUND_DIAMETER, 2 * PLATE_DEPTH]);
        translate([CORNER_ROUND_DIAMETER, CORNER_ROUND_DIAMETER]){
            cylinder(2*PLATE_DEPTH, CORNER_ROUND_DIAMETER, CORNER_ROUND_DIAMETER, center=false);
        }
    }
}

module MakeBracket(){
    difference(){
        union(){
            xPart();
            yPart();
            union_block();
        };
        translate([Y_THICKNESS+SCREW_RADIUS_DISTANCE_FROM_GLASS_X,X_THICKNESS-SCREW_RADIUS_DISTANCE_FROM_GLASS_Y]){
            ScrewHole();
            WasherHole();
        }
        RoundedCorner();
    }
}

MakeBracket();
