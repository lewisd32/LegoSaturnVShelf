use <lib/centered_cube.scad>
use <lib/lego_brick_builder.scad>

screw_head_diameter=8.1 + 0.1;
screw_head_height=3.5;
screw_thread_diameter=4.25 + 0.1;

screw_ledge_depth=7.5;

FLU = 1.6; // Fundamental Lego Unit = 1.6 mm

BRICK_WIDTH = 5*FLU; // basic brick width
BRICK_HEIGHT = 6*FLU;
PLATE_HEIGHT = 2*FLU; // basic plate height

difference() {
    union() {
        translate([0,0,PLATE_HEIGHT])
        ccube([BRICK_WIDTH*2, BRICK_WIDTH*3, BRICK_HEIGHT*2 - PLATE_HEIGHT], centered=[1,0,0]);
        
        translate([-BRICK_WIDTH,0,-0.3])
        brick(2,3,1.25,1);

        translate([-BRICK_WIDTH,0,BRICK_HEIGHT*2])
        brick(2,3,0,0);
    }
    
    translate([0,0,-0.31])
    ccube([BRICK_WIDTH*2+1, BRICK_WIDTH*3+1, 0.4], centered=[1,0,0]);

    // hole for screw thread
    hull() {
        translate([0,-0.01,BRICK_HEIGHT*2-5])
        rotate([-90,0,0])
        cylinder(d=screw_thread_diameter+0.1, h=screw_ledge_depth+screw_head_height+5, $fs=0.5);

        translate([0,-0.01,7])
        rotate([-90,0,0])
        cylinder(d=screw_thread_diameter+0.1, h=screw_ledge_depth+screw_head_height+5, $fs=0.5);
    }

    // inner hole for screw head
    hull() {
        translate([0,screw_ledge_depth,BRICK_HEIGHT*2-5])
        rotate([-90,0,0])
        cylinder(d=screw_head_diameter+0.1, h=screw_head_height+5, $fs=0.5);

        translate([0,screw_ledge_depth,7])
        rotate([-90,0,0])
        cylinder(d=screw_head_diameter+0.1, h=screw_head_height+5, $fs=0.5);
    }
    
    // outer hole for screw head
        translate([0,-0.01,7])
        rotate([-90,0,0])
        cylinder(d=screw_head_diameter+0.1, h=screw_ledge_depth+screw_head_height+5, $fs=0.5);

}


/*
translate([-FLU*2.5,FLU*2.5,-0.1])
cylinder(d=FLU*3, h=FLU, $fn=50);

*/