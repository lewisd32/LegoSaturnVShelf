module ccube(size, centered=[1,1,1]) {
    centered_cube(size, centered);
}

module centered_cube(size, centered=[1,1,1]) {
    translate([(-size[0]/2)*centered[0], (-size[1]/2)*centered[1], (-size[2]/2)*centered[2]])
    cube(size);
}
