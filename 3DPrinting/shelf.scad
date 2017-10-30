use <lib/centered_cube.scad>
use <lib/lego_brick_builder.scad>
use <rocket-bottom.scad>

do_slow=true;

FLU = 1.6; // Fundamental Lego Unit = 1.6 mm

BRICK_WIDTH = 5*FLU; // basic brick width
BRICK_HEIGHT = 6*FLU;
PLATE_HEIGHT = 2*FLU; // basic plate height

rib_thickness=3;
rib_depth=4;
rib_spacing=20.5;

lip_thinckness=3;
lip_depth=rib_depth;

platform_x = 366;
platform_y = 180;
platform_z = 50;

module platform_with_ribs() {
    color([.8,.8,.8]) {

    ccube([platform_x,platform_y,platform_z], centered=[1,1,0]);
        
    // fill in the ribs at the back of the platform so they 
    // don't gouge the wall.
    translate([0,-platform_y/2-rib_depth,0])
    ccube([platform_x,rib_depth*2,platform_z], centered=[1,0,0]);

    // corners
    for (x = [-platform_x/2, platform_x/2]) {
        for (y = [-platform_y/2, platform_y/2]) {
            translate([x, y, 0])
            ccube([rib_depth*2,rib_depth*2,platform_z], centered=[1,1,0]);
        }
    }

    for (y = [-platform_y/2, platform_y/2]) {
        // top and bottom lip at front of platform
        for (z = [0, platform_z-lip_thinckness]) {
            translate([0,y,z])
            ccube([platform_x,lip_depth*2,lip_thinckness], centered=[1,1,0]);
        }

        // ribs at front (and back) of platform
        for (x = [-platform_x/2:rib_spacing:platform_x/2]) {
            translate([x, y, 0])
                ccube([rib_thickness,rib_depth*2,platform_z], centered=[1,1,0]);
        }
    }

    for (x = [-platform_x/2, platform_x/2]) {
        // top and bottom lip at sides of platform
        for (z = [0, platform_z-lip_thinckness]) {
            translate([x,0,z])
            ccube([lip_depth*2,platform_y,lip_thinckness], centered=[1,1,0]);
        }

        // ribs on sides of platform
        for (y = [-platform_y/2:rib_spacing:platform_y/2]) {
            translate([x, y, 0])
                ccube([rib_depth*2,rib_thickness,platform_z], centered=[1,1,0]);
        }
    }

    }
}

module wedge() {
    hull() {
        cube([1,1,0.1]);
        cube([0.1,1,1]);
    }
}

module lego_double_wedge() {
    translate([-BRICK_WIDTH, 0, 0])
    brick(2,1,1,1);
    *translate([-BRICK_WIDTH, 0, 0])
    brick(1,1,1,1);
    translate([BRICK_WIDTH, 0, 0])
    resize([BRICK_WIDTH, BRICK_WIDTH, PLATE_HEIGHT])
    wedge();
    
    translate([BRICK_WIDTH-0.5, 0, 0])
    cube([1,BRICK_WIDTH,1]);
}

module lego_wedge() {
    brick(1,4,1,1);
    translate([BRICK_WIDTH, 0, 0])
    resize([BRICK_WIDTH*1, BRICK_WIDTH*4, PLATE_HEIGHT])
    wedge();
    
    translate([BRICK_WIDTH-0.5, 0, 0])
    cube([1,BRICK_WIDTH*4,1]);
}

module lego_corner_wedge() {
    translate([-BRICK_WIDTH, 0, 0])
    difference() {
        brick(2,1,1,1);
        translate([1.6+BRICK_WIDTH,6,-1])
        cube([4.8,3,2.6]);
    }
    
    difference() {
        brick(1,2,1,1);
        translate([-0.5,1.6,-1])
        cube([3,4.8,2.6]);
    }
    
    
    translate([BRICK_WIDTH, 0, 0])
    resize([BRICK_WIDTH*1, BRICK_WIDTH*2, PLATE_HEIGHT])
    wedge();
    
    translate([-BRICK_WIDTH, 0, 0])
    rotate([0,0,-90])
    resize([BRICK_WIDTH*1, BRICK_WIDTH*2, PLATE_HEIGHT])
    wedge();

    intersection() {
        translate([BRICK_WIDTH, -BRICK_WIDTH, 0])
        resize([BRICK_WIDTH*1, BRICK_WIDTH*1, PLATE_HEIGHT])
        wedge();
        
        translate([BRICK_WIDTH, 0, 0])
        rotate([0,0,-90])
        resize([BRICK_WIDTH*1, BRICK_WIDTH*1, PLATE_HEIGHT])
        wedge();
    }
    
    translate([BRICK_WIDTH-0.5, 0, 0])
    cube([1,BRICK_WIDTH*2,1]);
    
    translate([-BRICK_WIDTH, -0.5, 0])
    cube([BRICK_WIDTH*2, 1,1]);

}

module yellow_outlines() {
    for (r = [0:1:3]) {
        rotate([0,0,r*90])
        translate([55,-55,platform_z]) {
            corner_d=5;
            w=50;
            l=10;
            t=7;
            h=1;
            o=1;
            
            color([.8,.8,0])
            translate([0, BRICK_WIDTH, 0])
            lego_wedge();
                
            color([.85,.85,0])
            translate([0, BRICK_WIDTH*5, 0])
            lego_double_wedge();

            color([.85,.85,0])
            translate([0, -BRICK_WIDTH, 0])
            lego_corner_wedge();

            color([.85,.85,0])
            mirror([1,1,0])
            translate([0, BRICK_WIDTH*5, 0])
            lego_double_wedge();

            color([.8,.8,0])
            mirror([1,1,0])
            translate([0, BRICK_WIDTH, 0])
            lego_wedge();
        }
    }
}

module flame_channels() {
    for (r = [0:1:3])
    rotate([0,0,r*90])
    translate([BRICK_WIDTH*4,BRICK_WIDTH*4,-1])
    ccube([BRICK_WIDTH*6, BRICK_WIDTH*6,200], centered=[1,1,0]);
    
    hull() {
        translate([0,0,-1])
        ccube([BRICK_WIDTH*14, BRICK_WIDTH*14, 1], centered=[1,1,0]);
        translate([0,0,platform_z-PLATE_HEIGHT])
        ccube([BRICK_WIDTH*10, BRICK_WIDTH*10, 0.01], centered=[1,1,0]);
    }
    translate([0,0,platform_z-PLATE_HEIGHT])
    ccube([BRICK_WIDTH*10, BRICK_WIDTH*10, PLATE_HEIGHT*2], centered=[1,1,0]);
}

module hold_down_arm() {
    translate([BRICK_WIDTH*5,-BRICK_WIDTH,platform_z]) {
        color([.8,.8,.8])
        brick(4, 2, 3);

        color([1,1,1])
        translate([BRICK_WIDTH,0,BRICK_HEIGHT])
        brick(3, 2, 3);
        color([.9,.9,.9])
        translate([-BRICK_WIDTH,0,BRICK_HEIGHT])
        brick(2, 2, 3);
        

        color([.8,.8,.8])
        translate([-BRICK_WIDTH*2,0,BRICK_HEIGHT*2])
        brick(2, 2, 3);
        color([.9,.9,.9])
        translate([0,0,BRICK_HEIGHT*2])
        brick(3, 2, 3);
        
        color([.8,.8,.8])
        translate([-BRICK_WIDTH*2,0,BRICK_HEIGHT*3])
        brick(1, 2, 1, 1);
        color([.7,.7,.7])
        translate([-BRICK_WIDTH,0,BRICK_HEIGHT*3])
        brick(2, 2, 1, 1);
        color([1,1,1])
        translate([BRICK_WIDTH*1,0,BRICK_HEIGHT*3])
        brick(1, 2, 3);
        color([.8,.8,.8])
        translate([BRICK_WIDTH*2,0,BRICK_HEIGHT*3])
        brick(1, 2, 3);

        color([.8,.8,.8])
        translate([0,0,BRICK_HEIGHT*3+PLATE_HEIGHT])
        brick(1, 2, 2);
        
        color([.9,.9,.9])
        translate([0,0,BRICK_HEIGHT*4])
        brick(3, 2, 3);
    }
}

module hold_down_arms() {
    for (r = [0:1:3])
    rotate([0,0,r*90])
    hold_down_arm();
}

module launch_platform() {
    difference() {
        union() {
            platform_with_ribs();
            if (do_slow) {
                lego_plate();
            }
        }
        flame_channels();

        // Cut it in half to visualize the interior
        // of the flame channels
        *ccube([500, 500, 500], centered=[0,1,1]);
    }
}

module lego_plate() {
    color([.8,.8,.8])
    for (r = [0:1:3])
    rotate([0,0,r*90])
    translate([-BRICK_WIDTH,BRICK_WIDTH*5,platform_z-PLATE_HEIGHT]) {

        // hold down arms attachment
        brick(2, 4, 1);
        
        // yellow outlines attachment
        translate([-BRICK_WIDTH*7, BRICK_WIDTH*2, 0])
        brick(15, 1, 1);
    }
}

// gantry settings
g_d=60;
g_t=4;

module gantry_layer1() {
    // horizontal braces
    translate([0,0,-150])
    difference() {
        ccube([g_d, g_d, g_t]);
        translate([0,0,-g_t/4])
        ccube([g_d-g_t*2, g_d-g_t*2, g_t*2]);
    }
    
    // platform
    translate([0,0,-150])
    ccube([g_d/2, g_d/2, g_t]);

    // platform braces
    translate([0,0,-150]){
        for (r = [0:1:3])
        rotate([0,0,r*90+45])
        ccube([40,g_t,g_t], centered=[0,1,1]);
    }

    // vertical verticals
    for (m = [0,1])
    mirror([m,0,0]) 
    translate([g_d*0.5-g_t/2, -g_d/2 + g_t/2, -150])
    rotate([0,90,0])
    ccube([48.6, g_t, g_t], centered=[0,1,1]);

    for (m = [0,1])
    mirror([m,0,0]) 
    translate([g_d*0.5-g_t/2, g_d*0.5-g_t/2+0.6, -150])
    rotate([-50.3,0,0])rotate([0,90,0])
    ccube([74.2, g_t, g_t], centered=[0,1,1]);

    // front/rear angled supports between "verticals"
    for (m = [0,1])
    mirror([m,0,0]) 
    translate([0, -g_d/2 + g_t/2, -150])
    rotate([0,60,0])
    ccube([55, g_t, g_t], centered=[0,1,1]);

    for (m = [0,1])
    mirror([m,0,0]) 
    translate([0, -g_d/2 + g_d-g_t/2, -150])
    rotate([-50,0,0])
    rotate([0,69,0])
    ccube([79, g_t, g_t], centered=[0,1,1]);



    // horizontal brace, against wall, very bottom
    translate([-g_d*0.5, -g_d/2, -200 + g_t])
    ccube([g_d, g_t, g_t], centered=[0,0,1]);
}

module gantry_layer2() {
    // horizontal braces
    translate([0,0,-100])
    difference() {
        ccube([g_d, g_d, g_t]);
        translate([0,0,-g_t/4])
        ccube([g_d-g_t*2, g_d-g_t*2, g_t*2]);
    }

    // platform
    translate([0,0,-100])
    ccube([g_d/2, g_d/2, g_t]);

    // platform braces
    translate([0,0,-100]){
        for (r = [0:1:3])
        rotate([0,0,r*90+45])
        ccube([40,g_t,g_t], centered=[0,1,1]);
    }

    // vertical verticals
    for (m = [0,1])
    mirror([m,0,0]) 
    translate([g_d*0.5-g_t/2, -g_d/2 + g_t/2, -100])
    rotate([0,90,0])
    ccube([50, g_t, g_t], centered=[0,1,1]);

    for (m = [0,1])
    mirror([m,0,0]) 
    translate([g_d*0.5-g_t/2, g_d*0.5-g_t/2, -100])
    rotate([0,90,0])
    ccube([50, g_t, g_t], centered=[0,1,1]);

    // front/rear angled supports between "verticals"
    for (r = [0:1:3])
    rotate([0,0,r*90]) {
    translate([0, -g_d/2 + g_t/2, -100])
    rotate([0,62,0])
    ccube([56, g_t, g_t], centered=[0,1,1]);

    translate([0, -g_d/2 + g_t/2, -100])
    mirror([1,0,0])
    rotate([0,62,0])
    ccube([56, g_t, g_t], centered=[0,1,1]);
    }
}

module gantry_layer3() {
    // horizontal braces
    translate([0,g_d*.25/2,-50])
    difference() {
        ccube([g_d*1.5, g_d*1.25, g_t]);
        translate([0, 0,-g_t/4])
        ccube([g_d*1.5-g_t*1.25*2, g_d*1.25-g_t*2, g_t*2]);
    }

    // platform
    translate([0,7.5,-50])
    ccube([g_d/2+4.5, g_d/2, g_t]);

    // platform braces
    *for (m = [0,1])
    mirror([m,0,0]) 
    translate([0,0,-50]){
        rotate([0,0,45])
        ccube([62,g_t,g_t], centered=[0,1,1]);

        translate([0,-7,0])
        rotate([0,0,-30])
        ccube([52,g_t,g_t], centered=[0,1,1]);
    }

    // platform braces
    for (m = [0,1])
    mirror([m,0,0])
    translate([0,7.5,-50]){
        for (r = [-1,1])
        rotate([0,0,r*40])
        ccube([56,g_t,g_t], centered=[0,1,1]);
    }

    // second tier of angled verticals
    for (m = [0,1])
    mirror([m,0,0]) 
    translate([g_d*0.75-g_t/2, -g_d/2 + g_t/2, -50])
    rotate([0,107.4,0])
    ccube([52.5, g_t, g_t], centered=[0,1,1]);

    for (m = [0,1])
    mirror([m,0,0]) 
    translate([g_d*0.75-g_t/2, g_d*0.75-g_t/2, -50])
    rotate([-17.3,0,0])
    rotate([0,106.6,0])
    ccube([54, g_t, g_t], centered=[0,1,1]);

    // front/rear angled supports between "verticals"
    for (m = [0,1])
    mirror([m,0,0]) 
    translate([0, -g_d/2 + g_t/2, -50])
    rotate([0,62,0])
    ccube([56, g_t, g_t], centered=[0,1,1]);

    for (m = [0,1])
    mirror([m,0,0]) 
    translate([0, g_d*0.75-g_t/2, -50])
    rotate([-17.3,0,0])
    rotate([0,62,0])
    ccube([58, g_t, g_t], centered=[0,1,1]);

    // left/right angled supports between "verticals"

    for (m = [0,1]) {
    mirror([m,0,0])
    translate([g_d*1.5/2 - g_t/2, 0, -50])
    rotate([29,0,0])
    rotate([0,105.4,0])
    ccube([60, g_t, g_t], centered=[0,1,1]);

    mirror([m,0,0])
    translate([g_d*1.5/2 - g_t/2, 0, -50])
    mirror([0,1,0])
    rotate([29,0,0])
    rotate([0,105.4,0])
    ccube([60, g_t, g_t], centered=[0,1,1]);
    }
}

module gantry_layer4() {
    // horizontal braces, embedded in underside of platform
    translate([0,g_d*.5/2+3,0])
    difference() {
        ccube([g_d*2, g_d*1.5+6, g_t]);
        translate([0, 0,-g_t/4])
        ccube([g_d*2-g_t*1.5*2, g_d*1.5-g_t*2+6, g_t*2]);
    }


    // first tier of angled verticals
    for (m = [0,1])
    mirror([m,0,0]) 
    translate([g_d-g_t/2, -g_d/2 + g_t/2, 0])
    rotate([0,107.4,0])
    ccube([52.5, g_t, g_t], centered=[0,1,1]);

    for (m = [0,1])
    mirror([m,0,0]) 
    translate([g_d-g_t/2, g_d-g_t/2 + 6.5, 0])
    rotate([-24.3,0,0])
    rotate([0,106.1,0])
    ccube([55, g_t, g_t], centered=[0,1,1]);

    // front/rear angled supports between "verticals"
    for (m = [0,1])
    mirror([m,0,0]) 
    translate([0, -g_d/2 + g_t/2, 0])
    rotate([0,50,0])
    ccube([64, g_t, g_t], centered=[0,1,1]);

    for (m = [0,1])
    mirror([m,0,0]) 
    translate([0, g_d-g_t/2 + 6.5, 0])
    rotate([-24.3,0,0])
    rotate([0,51.5,0])
    ccube([67, g_t, g_t], centered=[0,1,1]);

    // left/right angled supports between "verticals"

    for (m = [0,1]) {
    mirror([m,0,0])
    translate([g_d*2/2 - g_t/2, g_d/8, 0])
    rotate([35,0,0])
    rotate([0,104.5,0])
    ccube([63, g_t, g_t], centered=[0,1,1]);

    mirror([m,0,0])
    translate([g_d*2/2 - g_t/2, g_d/8, 0])
    mirror([0,1,0])
    rotate([35,0,0])
    rotate([0,104.5,0])
    ccube([64, g_t, g_t], centered=[0,1,1]);
    }
}

module gantry() {
    translate([0,-(platform_y-g_d)/2- rib_depth,0])
    color([1, 0, 0]) {

        gantry_layer1();
        gantry_layer2();
        gantry_layer3();
        gantry_layer4();

    }
}

launch_platform();
if (do_slow) {
    yellow_outlines();
    hold_down_arms();
}

for (m = [0,1])
mirror([m,0,0])
translate([-(platform_x-g_d*2)/2- rib_depth+5, 0, 0])
gantry();


translate([0,0,platform_z - 20])
rotate([0,0,45])
rocket_bottom();


// wall
*color([1,1,1])
translate([0, -platform_y/2 - 1 - rib_depth, 500])
ccube([1000, 1, 2000], centered=[1,0,1]);

