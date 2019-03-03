/* [Text & Font] */

// for your keyring
Font_name = "Courier"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

// for your keyring
Text = "SIMRAN";

// of the preview
Rotation = 50; // [0:5:360]

/* [Spacing and Height] */

letter_1_height = 8; // [-20:1:20]
letter_1_space = 13.6; // [-20:1:20]

letter_2_height = 5; // [-20:1:20]
letter_2_space = 14.1; // [-20:1:20]

letter_3_height = 5.5; // [-20:1:20]
letter_3_space = 15.5; // [-20:1:20]

letter_4_height = 6; // [-20:1:20]
letter_4_space = 16; // [-20:1:20]

letter_5_height = 6.5; // [-20:1:20]
letter_5_space = 16; // [-20:1:20]

letter_6_height = 7; // [-20:1:20]
letter_6_space = 12.75; // [-20:1:20]

letter_7_height = 6; // [-20:1:20]
letter_7_space = 13; // [-20:1:20]

letter_8_height = 6; // [-20:1:20]
letter_8_space = 10; // [-20:1:20]

/* [ Twist ] */

// angle in degrees
twist = 0; // [-10:0.5:10]

// of twist rotation
center = 30; // [0:1:70]

/* [ Loop Settings ] */

// adjument
Loop_x_position = -47; // [-150:1:50]

// adjument
Loop_y_position = 0; // [-20:1:20]

// to use (default : u)
Loop_character = "";

// to use (default : Chewy)
Loop_font = "Chewy"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

/* [Hidden */

// between letters adjust the overlap (e.g. 5 letters = 5 comma seperated numbers [5,5,4.8,4.2,4,5,6])
spacing = [0,letter_1_space,letter_2_space,letter_3_space,letter_4_space,letter_5_space,letter_6_space,letter_7_space, letter_8_space];

// of each letter (e.g. 5 letters = 5 comma seperated numbers [4,3,3.5,3,4])
height = [letter_1_height,letter_2_height,letter_3_height,letter_4_height,letter_5_height,letter_6_height,letter_7_height,letter_8_height];

rotate([0,0,Rotation]) {

    linear_extrude(height = 3, $fn = 100) {
        translate ([-center-Loop_x_position,Loop_y_position,0]) rotate([0,0,-90]) 
        text(size = 20, text = Loop_character, font = Loop_font, halign = "center", valign= "center", $fn = 100);
    }

    for (i = [0 : len(Text) -1]) {
       linear_extrude(height = height[i], twist = twist, $fn = 100) {
            translate ([(spacing[i]*i)-center,0,0])
            text(size = 25, text = Text[i], font = Font_name, halign = "center", valign= "center", $fn = 100);
        } 
    }
}
