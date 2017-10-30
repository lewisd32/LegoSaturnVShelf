
use <lib/centered_cube.scad>
use <lib/torus.scad>

translate([0,0,-1.1])
ccube([93,93,1]);

module nozzle() {
    color([.2,.2,.2])
    cylinder(d1=40, d2=16+(40-16)*((40-16)/40), h=16);

    color([.35,.35,.35])
    translate([0,0,16])
    torus(34, 5);

    color([.5,.5,.5])
    translate([0,0,16])
    cylinder(d1=16+(40-16)*((40-16)/40), d2=16, h=40-16);
}


module nozzle_and_fin() {
    nozzle();

    color([.8, .8, .8])
    translate([0,0,41.6]) {
        intersection() {
            cylinder(d=38, h=16);
            translate([0,0,-1])
            ccube([50,50,20], centered=[0,1,0]);
        }
        rotate([0,0,180])
        ccube([4,38,16], centered=[0,1,0]);
    }
    
    color([0,0,0])
    translate([0,0,40])
    ccube([16, 16, 8], centered=[1,1,0]);


    // fin mount
    color([1,1,1])
    translate([0,0,57.6])
    resize([38,32,64])
    cylinder(d1=32, d2=16, h=64);

    // fin
    color([1,1,1])
    translate([18,0,65.6])
    rotate([90,0,0])
    translate([0,0,-0.8])
    linear_extrude(height=1.6) {
        polygon(points=[
            [0,0],
            [3,-8],
            [32, -22],
            [32, -6],
            [0, 24]
        ]);
    }
}

module rocket_bottom() {
    nozzle();
    color([.8, .8, .8])
    translate([0,0,40])
    cylinder(d=16, h=18);

    for (r = [0:1:3]) {
        rotate([0,0,r*90])
        translate([42.5,0,0])
        nozzle_and_fin();
    }
    
    // bottom of fuel tank
    color([1,1,1])
    translate([0,0,58])
    cylinder(d=80, h=32);
}

rocket_bottom();
