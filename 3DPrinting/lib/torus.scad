module torus(
outer_diameter,
circle_diameter
) {
    rotate_extrude(convexity = 4)
    translate([(outer_diameter-circle_diameter)/2, 0, 0])
    circle(d=circle_diameter, $fn=$fn/3);
}
