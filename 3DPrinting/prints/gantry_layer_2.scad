use <../shelf.scad>
use <../lib/centered_cube.scad>

g_t=3;

intersection() {
    translate([0,0,-100])
    rotate([0,180,0])
    gantry_layer2();

    translate([0,0,-g_t/2])
    ccube([60,60,50.5], centered=[1,1,0]);
}