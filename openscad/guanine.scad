/*
This script generates a standalone guanine model for B-DNA
*/

include <./lib/global_variables.scad>
include <./lib/affine_transformation.scad>
include <./lib/all_junctions.scad>

translate([-1.5450, -8.0350, 0]) sphere(Cr);
translate([-1.5450, -1.9650, 0]) sphere(Cr);
//translate([-3.7500, -5.0000, 0]) sphere(Nr);
aff_tran([bsbk_bond_len,0,0],[-1,0,0],[-3.75, -5, 0],[-3.75, -5, 0] - [-0.56,-5,0]) bsbkp_duckbill();
translate([2.0200, -6.8750, 0]) sphere(Nr);
translate([2.0200, -3.1250, 0]) sphere(Cr);

translate([-2.3250, 1.7025, 0]) sphere(Nr);
translate([0.4625, 4.2100, 0]) sphere(Cr);
translate([4.0275, 3.0525, 0]) sphere(Nr);
difference(){ // Sphere would otherwise invade hydrogen bond socket cavity
    translate([4.8075, -0.6150, 0]) sphere(Cr);
    translate([8.3750, -1.7750, 0]) sphere(Or-0.3); // preserved a bit of intersection for mesh integrity
}
aff_tran([0,0,0],[1,0,0],[8.3750, -1.7750, 0],[5.9775, 4.8100, 0] - [1.2421,0.5433,0]) hb_socket(); // parallel to hb_pin();
translate([-2.0875, -9.6975, 0]) sphere(Hr);
translate([-0.3175, 7.8800, 0]) sphere(Nr);
//translate([5.9775, 4.8100, 0]) sphere(Hr);
aff_tran([hb_bond_len,0,0],[-1,0,0],[5.9775, 4.8100, 0],[5.9775, 4.8100, 0] - [1.2421,0.5433,0]) hb_pin();
//translate([1.6325, 9.6350, 0]) sphere(Hr);
aff_tran([hb_bond_len,0,0],[-1,0,0],[1.6325, 9.6350, 0],[5.9775, 4.8100, 0] - [1.2421,0.5433,0]) hb_pin();
translate([-2.8150, 8.6900, 0]) sphere(Hr);

// Markers
//translate([1.2421,0.5433,0]) sphere(0.2); // center of hexagon
//translate([-0.56,-5,0]) sphere(0.2); // center of pentagon

/* Coordinates only:
translate([-3.7500, -5.0000, 0]) sphere(Nr);
translate([-1.5450, -8.0350, 0]) sphere(Cr);
translate([2.0200, -6.8750, 0]) sphere(Nr);
translate([2.0200, -3.1250, 0]) sphere(Cr);
translate([-1.5450, -1.9650, 0]) sphere(Cr);
translate([-2.3250, 1.7025, 0]) sphere(Nr);
translate([0.4625, 4.2100, 0]) sphere(Cr);
translate([4.0275, 3.0525, 0]) sphere(Nr);
translate([4.8075, -0.6150, 0]) sphere(Cr);
translate([8.3750, -1.7750, 0]) sphere(Or);
translate([-2.0875, -9.6975, 0]) sphere(Hr);
translate([-0.3175, 7.8800, 0]) sphere(Nr);
translate([5.9775, 4.8100, 0]) sphere(Hr);
translate([1.6325, 9.6350, 0]) sphere(Hr);
translate([-2.8150, 8.6900, 0]) sphere(Hr);
*/