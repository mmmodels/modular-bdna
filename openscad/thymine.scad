/*
This script generates a standalone thymine piece for B-DNA
*/

include <./lib/global_variables.scad>
include <./lib/affine_transformation.scad>
include <./lib/all_junctions.scad>

//translate([-4.9425, -3.7700, 0]) sphere(Hr);
aff_tran([hb_bond_len,0,0],[-1,0,0],[-4.9425, -3.7700, 0],[-4.9425, -3.7700, 0] - [-2.9925, -2.0125, 0]) hb_pin();
translate([-2.9925, -2.0125, 0]) sphere(Nr);
translate([-3.7700, 1.6550, 0]) sphere(Cr);
translate([2.5825, 3.0050, 0]) sphere(Cr);
//translate([-0.9850, 4.1650, 0]) sphere(Nr);
aff_tran([bsbk_bond_len,0,0],[-1,0,0],[-0.9850, 4.1650, 0],[-0.9850, 4.1650, 0] - [-0.205,0.49625,0]) bsbkp_duckbill();
translate([3.3625, -0.6625, 0]) sphere(Cr);
difference(){ // Sphere would otherwise invade hydrogen bond socket cavity
    translate([0.5750, -3.1725, 0]) sphere(Cr);
    translate([1.3550, -6.8400, 0]) sphere(Or-0.3); // preserved a bit of intersection for mesh integrity
}
aff_tran([0,0,0],[1,0,0],[1.3550, -6.8400, 0],[-4.9425, -3.7700, 0] - [-2.9925, -2.0125, 0]) hb_socket(); // parallel to hb_pin();
translate([6.9275, -1.8225, 0]) sphere(Cr);
translate([-7.3375, 2.8150, 0]) sphere(Or);
translate([7.9925, -0.4325, 0]) sphere(Hr);
translate([7.2275, -2.7850, 1.4300]) sphere(Hr);
translate([7.2275, -2.7850, -1.4300]) sphere(Hr);
translate([4.0000, 4.5000, 0]) sphere(Hr);

// Markers
// translate([-0.205,0.49625,0]) sphere(0.2); // center of hexagon

/* Coordinates only:
translate([-4.9425, -3.7700, 0]) sphere(Hr);
translate([-2.9925, -2.0125, 0]) sphere(Nr);
translate([-3.7700, 1.6550, 0]) sphere(Cr);
translate([-0.9850, 4.1650, 0]) sphere(Nr);
translate([2.5825, 3.0050, 0]) sphere(Cr);
translate([3.3625, -0.6625, 0]) sphere(Cr);
translate([0.5750, -3.1725, 0]) sphere(Cr);
translate([1.3550, -6.8400, 0]) sphere(Or);
translate([6.9275, -1.8225, 0]) sphere(Cr);
translate([-7.3375, 2.8150, 0]) sphere(Or);
translate([7.9925, -0.4325, 0]) sphere(Hr);
translate([7.2275, -2.7850, 1.4300]) sphere(Hr);
translate([7.2275, -2.7850, -1.4300]) sphere(Hr);
translate([4.0000, 4.5000, 0]) sphere(Hr);
*/
