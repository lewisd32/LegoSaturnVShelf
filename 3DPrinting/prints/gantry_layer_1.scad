use <../shelf.scad>
use <../lib/centered_cube.scad>

g_t=3;

difference() {
    intersection() {
        translate([0,0,-150])
        rotate([0,180,0])
        gantry_layer1();
        
        translate([0,0,-g_t/2])
        ccube([60,60,50], centered=[1,1,0]);
    }
    
    translate([0,-1+0.01,2.01])
    ccube([52-0.01,50,47.01], centered=[1,3,0]);

    translate([0,-1+0.0-25,2.01])
    ccube([52-0.01,55,46.01], centered=[1,0,0]);
}

