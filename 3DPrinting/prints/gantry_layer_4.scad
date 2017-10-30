use <../shelf.scad>
use <../lib/centered_cube.scad>

g_t=3;

intersection() {
    translate([0,0,0])
    rotate([0,180,0])
    gantry_layer4();

    translate([0,15+3,g_t/2 + 0.01])
    ccube([120,90+6,50 - g_t], centered=[1,1,0]);
}


for (m = [0,1])
mirror([m,0,0]) 
translate([45,45,46.51]) {
ccube([3,5.3,2], centered=[2,2,0]);
ccube([5.3,3,2], centered=[2,2,0]);
}

for (m = [0,1])
mirror([m,0,0]) 
translate([56,62,1.2]) {
ccube([5.3,5.3,2], centered=[1,1,0]);
translate([0,-88,0])
ccube([5.3,5.3,2], centered=[1,1,0]);
translate([0,-54.5,0])
ccube([5.3,10,2], centered=[1,1,0]);
}


translate([0,62,1.2])
ccube([10,5.3,2], centered=[1,1,0]);

translate([0,-26,1.2])
ccube([10,5.3,2], centered=[1,1,0]);



FLU = 1.6; // Fundamental Lego Unit = 1.6 mm

BRICK_WIDTH = 5*FLU; // basic brick width
BRICK_HEIGHT = 6*FLU;
PLATE_HEIGHT = 2*FLU; // basic plate height

module mybrick(x,y,z) {
    cube([x*BRICK_WIDTH, y*BRICK_WIDTH, z*PLATE_HEIGHT]);
    *brick(x,y,z,0);
    for (a = [0:1:x-1]) {
        for (b = [0:1:y-1]) {
            translate([a*BRICK_WIDTH+BRICK_WIDTH/2,b*BRICK_WIDTH+BRICK_WIDTH/2,z*PLATE_HEIGHT])
            cylinder(d=3*FLU+0.1, h=FLU*2, $fn=50);
        }
    }
}

translate([-BRICK_WIDTH/2,2,FLU]) {
    translate([BRICK_WIDTH*8, BRICK_WIDTH*7,FLU])
    rotate([0,180,0])
    mybrick(15,1,1);

    translate([BRICK_WIDTH*8, -BRICK_WIDTH*4,FLU])
    rotate([0,180,0])
    mybrick(15,1,1);

    translate([BRICK_WIDTH*8, -BRICK_WIDTH*4,FLU])
    rotate([0,180,0])
    mybrick(1,11,1);

    translate([-BRICK_WIDTH*6, -BRICK_WIDTH*4,FLU])
    rotate([0,180,0])
    mybrick(1,11,1);


    // Wall
    *translate([BRICK_WIDTH*8, -BRICK_WIDTH*5,-FLU+PLATE_HEIGHT*18])
    rotate([0,180,0])
    mybrick(15,1,18);
}