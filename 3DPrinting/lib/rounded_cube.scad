module rounded_cube(size,
    corner_diameter=1,
    center=false) {
        
    centered = center?1:0;

    translate([(-size[0]/2)*centered + corner_diameter/2, (size[1]/2)*centered - corner_diameter/2, (-size[2]/2)*centered + corner_diameter/2])
    hull() {
        for (xy = [[0,0], [1,0], [0,1], [1,1]]) {
            translate([0, -xy[0]*(size[1] - corner_diameter), xy[1]*(size[2] - corner_diameter)])
            rotate([0,90,0]) {
                cylinder(d=corner_diameter, h=size[0]-corner_diameter, $fn=$fn);
                sphere(d=corner_diameter, $fn=$fn);
                translate([0,0,size[0]-corner_diameter])
                sphere(d=corner_diameter, $fn=$fn);
            }
        }

        for (xy = [[0,0], [1,0], [0,1], [1,1]]) {
            translate([xy[0]*(size[0] - corner_diameter),0,xy[1]*(size[2] - corner_diameter)])
            rotate([90,0,0]) {
                cylinder(d=corner_diameter, h=size[1]-corner_diameter, $fn=$fn);
            }
        }

        for (xy = [[0,0], [1,0], [0,1], [1,1]]) {
            translate([xy[0]*(size[0] - corner_diameter),-xy[1]*(size[1] - corner_diameter),0]) {
                cylinder(d=corner_diameter, h=size[2]-corner_diameter, $fn=$fn);
            }
        }
    }
}
