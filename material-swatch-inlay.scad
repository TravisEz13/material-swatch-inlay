/*
 * Material Swatches rebuilt in OpenSCAD
 * By smkent (GitHub) / bulbasaur0 (Printables) / TravisEz13 (GitHub/Printables)
 *
 * Licensed under Creative Commons CC0 1.0 Universal (Public Domain)
 */

/* [Options] */
Color = "grey";
TextColor = "white";
string1 = "PETG/PLA";
string2 = "Maker";
string3 = "comment";
string4 = "comment2";
Steps = true;
/* [Text parameters] */
text_lstart = 2.5; //[0:0.1:12]

// See Font List dialog
string1_origin = 18; //[15:1:20]
string1_size = 5; //[1:1:10]
string2_origin = 10.7; //[1:0.1:12]
string2_size = 4; //[1:1:10]
string3_font = "Liberation Mono:style=Bold";
string3_origin = 5.6; //[1:0.1:12]
string3_size = 4; //[1:1:10]
string4_origin = 1.2; //[1:0.1:12]
string4_size = 4; //[1:1:10]
module __end_customizer_options__() { }

// Constants //

$fa = $preview ? $fa : 2;
$fs = $preview ? $fs : 0.4;

size = 31.75;
height_thin = 1.6;
height_inlay = 1.4;
height_thick_inlay = 3.0;
textColorDepth = 2;
inlay_height = 0.2;
height_thick = 3.2;
corner_radius = 2;
hole_diameter = 4.25;
hole_radius = hole_diameter / 2;
hole_inset = hole_radius * 2;
step_height = size / 4;
step_increment = 0.2;
step_min = 0.2;
step_count = 5;
step_width = 23.5 / step_count;

// Modules //

module rounded_square(x, y, radius, color = "orange") {
    offset(radius)
    offset(-radius)
    color(color)
    square([x, y]);
}

module main_swatch() {
        difference() {
            union() {
                    linear_extrude(height=height_thick)
                    translate([0, size / 2])
                    rounded_square(size, size / 2, corner_radius);
                    // name plate portion
                    linear_extrude(height=height_thin)
                        rounded_square(size, size, corner_radius);
                    
            }
        }       
}

module swatch_text(height) {
                translate([text_lstart, string1_origin, height_thick_inlay])
                  linear_extrude(height=height)
                    text(string1, font=string1_font, size=string1_size, spacing=0.95);

                translate([text_lstart, string2_origin, height_inlay])
                  linear_extrude(height=height)
                    text(string2, font=string2_font, size=string2_size, spacing=0.95);
                    
                translate([text_lstart, string3_origin, height_inlay])
                  linear_extrude(height=height)
                    text(string3, font=string3_font, size=string3_size, spacing=0.95);

                translate([text_lstart, string4_origin, height_inlay])
                  linear_extrude(height=height)
                    text(string4, font=string4_font, size=string4_size, spacing=0.95);
}

module main() {
    union() {
        color(Color)
            difference() {
                    main_swatch();

                // cut out text
                swatch_text(height_thin);
                    
                if (Steps) {
                    for (i = [1:1:step_count]) {
                        xoff = size - step_width * i;
                        yoff = size - step_height;
                        // echo("i", i, 0.2 * i, xoff, yoff);
                        step_thickness = step_min + step_increment * i;
                        translate([xoff, yoff, step_thickness])
                            linear_extrude(height = (height_thick+0.01) - step_thickness)
                                square([step_width + 0.01, step_height+0.01]);
                    }
                }
                // Cut out circle
                translate([hole_inset, size - hole_inset,- 0.01])
                    linear_extrude(height=height_thick+ 0.02)
                        circle(hole_radius);
            }

        // add color back to cut out text
        color(TextColor) {
            swatch_text(height=inlay_height - 0.1);
        }
    }
}

main();
