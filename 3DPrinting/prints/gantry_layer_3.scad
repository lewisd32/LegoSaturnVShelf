use <../shelf.scad>
use <../lib/centered_cube.scad>

g_t=3;

intersection() {
    translate([0,0,-50])
    rotate([0,180,0])
    gantry_layer3();

    translate([0,7.5,-g_t/2])
    ccube([90,75,50], centered=[1,1,0]);
}