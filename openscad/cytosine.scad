/*
This script generates a standalone cytosine model for B-DNA
*/

include <./lib/global_variables.scad>
include <./lib/affine_transformation.scad>
include <./lib/all_junctions.scad>

//translate([-0.5950, -8.5950, 0]) sphere(Hr);
aff_tran([hb_bond_len,0,0],[-1,0,0],[-0.5950, -8.5950, 0],[-2.9925, -2.0125, 0] - [-0.2046,0.4958,0]) hb_pin();
translate([1.3550, -6.8400, 0]) sphere(Nr);
difference(){
    union(){
        translate([0.5750, -3.1725, 0]) sphere(Cr);
        translate([-3.7700, 1.6550, 0]) sphere(Cr);
    }
    translate([-2.9925, -2.0125, 0]) sphere(Nr-0.3);
    translate([-7.3375, 2.8150, 0]) sphere(Or-0.3); // preserved a bit of intersection for mesh integrity
}
aff_tran([0,0,0],[1,0,0],[-2.9925, -2.0125, 0],[-2.9925, -2.0125, 0] - [-0.2046,0.4958,0]) hb_socket();
aff_tran([0,0,0],[1,0,0],[-7.3375, 2.8150, 0],[-2.9925, -2.0125, 0] - [-0.2046,0.4958,0]) hb_socket();
//translate([-0.9850, 4.1650, 0]) sphere(Nr);
aff_tran([bsbk_bond_len,0,0],[-1,0,0],[-0.9850, 4.1650, 0],[-0.9850, 4.1650, 0] - [-0.2046,0.4958,0]) bsbkp_duckbill();
translate([2.5825, 3.0050, 0]) sphere(Cr);
translate([3.3625, -0.6625, 0]) sphere(Cr);
translate([3.8825, 4.1775, 0]) sphere(Hr);
translate([5.0250, -1.2025, 0]) sphere(Hr);
translate([3.8500, -7.6500, 0]) sphere(Hr);

// Markers
//translate([-0.2046,0.4958,0]) sphere(0.2); // center of hexagon

/* Coordinates only:
translate([-0.5950, -8.5950, 0]) sphere(Hr);
translate([1.3550, -6.8400, 0]) sphere(Nr);
translate([0.5750, -3.1725, 0]) sphere(Cr);
translate([-2.9925, -2.0125, 0]) sphere(Nr);
translate([-3.7700, 1.6550, 0]) sphere(Cr);
translate([-0.9850, 4.1650, 0]) sphere(Nr);
translate([2.5825, 3.0050, 0]) sphere(Cr);
translate([3.3625, -0.6625, 0]) sphere(Cr);
translate([-7.3375, 2.8150, 0]) sphere(Or);
translate([3.8825, 4.1775, 0]) sphere(Hr);
translate([5.0250, -1.2025, 0]) sphere(Hr);
translate([3.8500, -7.6500, 0]) sphere(Hr);
*/