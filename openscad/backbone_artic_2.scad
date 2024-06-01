/*
Same as "backbone.scad" but with built-in articulation at C3-O and C4-C5 bond.
*/

include <./lib/global_variables.scad>
include <./lib/affine_transformation.scad>
include <./lib/all_junctions.scad>

aff_tran([6.9868, -2.3512, -3.8792],[6.9868, -2.3512, -3.8792] - [5.2383, -3.4807, -0.5328], [0,0,0],[0,0,-1]){ // orient model
difference(){ // Trim spheres that would invade socket cavity
    union(){
        translate([4.0262, 6.3469, 9.2785]) sphere(Or);
        translate([-1.3447, 8.3213, 6.9670]) sphere(Or);
        translate([0.4819, 2.4908, 6.0545]) sphere(Or);
        translate([-1.8850, -3.6886, 3.8837]) sphere(Or);
        translate([-0.4960, -1.5481, -1.1696]) sphere(Cr);
        //translate([1.5599, -2.9009, 4.2117]) sphere(Cr);
        translate([-2.1019, -5.8090, -0.1550]) sphere(Hr);
        translate([3.3490, 0.0316, 1.0145]) sphere(Hr);
        translate([3.71904, -0.309533, 7.34671]) sphere(Hr);
        translate([1.28095, -1.1826, 8.47491]) sphere(Hr);
        translate([-0.1896, -1.8735, -2.8616]) sphere(Hr);
        translate([-1.3011, 0.0056, -1.1510]) sphere(Hr);
        translate([2.5559, -4.2852, 4.6045]) sphere(Hr);
    }
    // preserved a bit of intersection for mesh integrity
    translate([0.5463, 5.5951, 8.4549]) sphere(Pr-0.3);
    translate([-2.5155, -4.2220, 0.4555]) sphere(Cr-0.3);
    translate([2.6485, -1.5676, 0.8952]) sphere(Cr-0.3);
    translate([2.0177, -0.5536, 7.0175]) sphere(Cr-0.3);
}
aff_tran([0,0,0],[1,0,0],[0.5463, 5.5951, 8.4549],[-1.2022, 4.4656, 11.8013] - [0.5463, 5.5951, 8.4549]) bkbk_socket(38);
aff_tran([0,0,0],[1,0,0],[-2.5155, -4.2220, 0.4555],[-6.1062, -3.7639, -0.1061] - [-2.5155, -4.2220, 0.4555]) bsbk_socket();
aff_tran([bkbk_bond_len,0,0],[-1,0,0],[5.2383, -3.4807, -0.5328],[6.9868, -2.3512, -3.8792] - [5.2383, -3.4807, -0.5328]) bkbk_pin(false);
difference(){
    aff_tran([3.52224,0,0],[-1,0,0],[5.2383, -3.4807, -0.5328],[2.6485, -1.5676, 0.8952] - [5.2383, -3.4807, -0.5328]) perm_pin(3.52224, Cr, true);
    cyl_2p([6.9868, -2.3512, -3.8792],[6.9868, -2.3512, -3.8792] + 0.67*([5.2383, -3.4807, -0.5328]- [6.9868, -2.3512, -3.8792]),5); // a crude fix of the excess sphere, good enough for 3d printing.
}
aff_tran([0,0,0],[1,0,0],[2.6485, -1.5676, 0.8952],[5.2383, -3.4807, -0.5328] - [2.6485, -1.5676, 0.8952]) perm_socket(3.52224, Cr);
difference(){ // Trim again otherwise the bottom articulating joint will be stuck
aff_tran([3.68672,0,0],[-1,0,0],[1.5599, -2.9009, 4.2117],[2.0177, -0.5536, 7.0175] - [1.5599, -2.9009, 4.2117]) perm_pin(3.68672, Cr, true);
translate([2.6485, -1.5676, 0.8952]) sphere(Cr-0.3);
}
aff_tran([0,0,0],[1,0,0],[2.0177, -0.5536, 7.0175],[1.5599, -2.9009, 4.2117] - [2.0177, -0.5536, 7.0175]) perm_socket(3.68672, Cr);
}