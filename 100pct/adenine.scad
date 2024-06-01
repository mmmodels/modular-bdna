/*
This script generates a standalone adenine model
*/

include <./global_variables.scad>
include <../lib/affine_transformation.scad>
include <./all_junctions_100pct.scad>

scale([s,s,s]){
    translate([-1.5450, -5.5350, 0]) sphere(Cr);
    translate([-1.5450, 0.5350, 0]) sphere(Cr);
    //translate([-3.7500, -2.5000, 0]) sphere(Nr);
    aff_tran([bsbk_bond_len,0,0],[-1,0,0],[-3.75, -2.5, 0],[-3.75, -2.5, 0] - [-0.558,-2.498,0])bsbkp_duckbill();
    translate([2.0200, -4.3750, 0]) sphere(Nr);
    translate([2.0200, -0.6250, 0]) sphere(Cr);
    translate([-2.3250, 4.2025, 0]) sphere(Nr);
    difference(){ // Spheres would otherwise invade hydrogen bond socket cavity
        union(){
            translate([0.4625, 6.7100, 0]) sphere(Cr);
            translate([4.8075, 1.8850, 0]) sphere(Cr);
        }
        translate([4.0275, 5.5525, 0]) sphere(Nr-0.3); // preserved a bit of intersection for mesh integrity
    }
    aff_tran([0,0,0],[1,0,0],[4.0275, 5.5525, 0],[4.0275, 5.5525, 0] - [1.24125,3.04375,0]) hb_socket();
    translate([8.3750, 0.7250, 0]) sphere(Nr);
    translate([-2.0875, -7.1975, 0]) sphere(Hr);
    translate([0.0975, 8.4225, 0]) sphere(Hr);
    //translate([10.3250, 2.4825, 0]) sphere(Hr);
    aff_tran([hb_bond_len,0,0],[-1,0,0],[10.3250, 2.4825, 0],[10.3250, 2.4825, 0] - [8.3750, 0.7250, 0]) hb_pin();
    translate([8.8950, -1.8425, 0]) sphere(Hr);
}

// Markers
// translate([-0.558,-2.498,0]) sphere(0.2); // center of pentagon
// translate([1.24125,3.04375,0]) sphere(0.2); // center of hexagon

/* Coordinates only:
translate([-3.7500, -2.5000, 0]) sphere(Nr);
translate([-1.5450, -5.5350, 0]) sphere(Cr);
translate([2.0200, -4.3750, 0]) sphere(Nr);
translate([2.0200, -0.6250, 0]) sphere(Cr);
translate([-1.5450, 0.5350, 0]) sphere(Cr);
translate([-2.3250, 4.2025, 0]) sphere(Nr);
translate([0.4625, 6.7100, 0]) sphere(Cr);
translate([4.0275, 5.5525, 0]) sphere(Nr);
translate([4.8075, 1.8850, 0]) sphere(Cr);
translate([8.3750, 0.7250, 0]) sphere(Nr);
translate([-2.0875, -7.1975, 0]) sphere(Hr);
translate([0.0975, 8.4225, 0]) sphere(Hr);
translate([10.3250, 2.4825, 0]) sphere(Hr);
translate([8.8950, -1.8425, 0]) sphere(Hr);
*/