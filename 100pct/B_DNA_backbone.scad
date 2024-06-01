/*
This script generates a backbone piece for B-DNA with C2'-endo sugar pucker

Atom coordinates obtained from PDB 2BNA, specifically atom #352, #365~#376, #385. 

Note: An oxygen atom (#352) was slightly moved so as to line up with the other end of the piece, and also to un-distort the tetrahedron of the phosphate group.

Hydrogen atom coordinates calculated & added by me.
*/

include <./global_variables.scad>
include <../lib/affine_transformation.scad>
include <./all_junctions_100pct.scad>

scale([s,s,s]){
    aff_tran([6.9868, -2.3512, -3.8792],[6.9868, -2.3512, -3.8792] - [5.2383, -3.4807, -0.5328], [0,0,0],[0,0,-1]){ // orient model
    difference(){ // Trim spheres that would invade socket cavity
        union(){
            translate([4.0262, 6.3469, 9.2785]) sphere(Or);
            translate([-1.3447, 8.3213, 6.9670]) sphere(Or);
            translate([0.4819, 2.4908, 6.0545]) sphere(Or);
            translate([-1.8850, -3.6886, 3.8837]) sphere(Or);
            translate([-0.4960, -1.5481, -1.1696]) sphere(Cr);
            translate([-2.1019, -5.8090, -0.1550]) sphere(Hr);
            translate([2.0177, -0.5536, 7.0175]) sphere(Cr);
            translate([1.5599, -2.9009, 4.2117]) sphere(Cr);
            translate([2.6485, -1.5676, 0.8952]) sphere(Cr);
            translate([-0.1896, -1.8735, -2.8616]) sphere(Hr);
            translate([-1.3011, 0.0056, -1.1510]) sphere(Hr);
            translate([2.5559, -4.2852, 4.6045]) sphere(Hr);
            translate([3.3490, 0.0316, 1.0145]) sphere(Hr);
            translate([3.71904, -0.309533, 7.34671]) sphere(Hr);
            translate([1.28095, -1.1826, 8.47491]) sphere(Hr);
        }
        translate([0.5463, 5.5951, 8.4549]) sphere(Pr-0.3);  // preserved a bit of intersection for mesh integrity
        translate([-2.5155, -4.2220, 0.4555]) sphere(Cr-0.3); 
    }
    aff_tran([0,0,0],[1,0,0],[0.5463, 5.5951, 8.4549],[-1.2022, 4.4656, 11.8013] - [0.5463, 5.5951, 8.4549]) bkbk_socket(38);
    aff_tran([0,0,0],[1,0,0],[-2.5155, -4.2220, 0.4555],[-6.1062, -3.7639, -0.1061] - [-2.5155, -4.2220, 0.4555]) bsbk_socket();
    aff_tran([bkbk_bond_len,0,0],[-1,0,0],[5.2383,-3.4807,-0.5328],[6.9868, -2.3512, -3.8792] - [5.2383, -3.4807, -0.5328]) bkbk_pin(true);
    }
}


/*  Unmodified data:
translate([-1.1675, 4.1893, 11.7128]) sphere(Or);   // Actual O coordinate in PDB
translate([-1.2022, 4.4656, 11.8013]) sphere(Or);   // This lines up with the next backbone
translate([0.5463, 5.5951, 8.4549]) sphere(Pr);
translate([4.0262, 6.3469, 9.2785]) sphere(Or);
translate([-1.3447, 8.3213, 6.9670]) sphere(Or);
translate([0.4819, 2.4908, 6.0545]) sphere(Or);
translate([2.0177, -0.5536, 7.0175]) sphere(Cr);
translate([1.5599, -2.9009, 4.2117]) sphere(Cr);
translate([-1.8850, -3.6886, 3.8837]) sphere(Or);
translate([2.6485, -1.5676, 0.8952]) sphere(Cr);
translate([-0.4960, -1.5481, -1.1696]) sphere(Cr);
translate([-2.5155, -4.2220, 0.4555]) sphere(Cr);
translate([5.2383, -3.4807, -0.5328]) sphere(Or);
translate([-6.1062, -3.7639, -0.1061]) sphere(Nr);
translate([6.9868, -2.3512, -3.8792]) sphere(Pr);
translate([-0.1896, -1.8735, -2.8616]) sphere(Hr);
translate([-1.3011, 0.0056, -1.1510]) sphere(Hr);
translate([-2.1019, -5.8090, -0.1550]) sphere(Hr);
translate([2.5559, -4.2852, 4.6045]) sphere(Hr);
translate([3.3490, 0.0316, 1.0145]) sphere(Hr);
translate([3.71904, -0.309533, 7.34671]) sphere(Hr);
translate([1.28095, -1.1826, 8.47491]) sphere(Hr);
*/


/*
A = [-1.2022, 4.4656, 11.8013];
B = [0.5463, 5.5951, 8.4549];
C = [4.0262, 6.3469, 9.2785];
D = [-1.3447, 8.3213, 6.9670];
E = [0.4819, 2.4908, 6.0545];
F = [2.0177, -0.5536, 7.0175];
G = [1.5599, -2.9009, 4.2117];
H = [-1.8850, -3.6886, 3.8837];
I = [2.6485, -1.5676, 0.8952];
J = [-0.4960, -1.5481, -1.1696];
K = [-2.5155, -4.2220, 0.4555];
L = [5.2383, -3.4807, -0.5328];
M = [-6.1062, -3.7639, -0.1061];
N = [6.9868, -2.3512, -3.8792];

function angle(u,v) = acos((u*v)/(norm(u)*norm(v)));
function unit(v) = v/norm(v);

function first(u,v) = -0.5*unit(u) + -0.5*unit(v) + sqrt(2/3)*unit(cross(u,v));
function second(u,v) = -0.5*unit(u) + -0.5*unit(v) - sqrt(2/3)*unit(cross(u,v));

echo(1.75*unit(first(E-F,G-F))+F);
//echo(unit(G-I)+unit(J-I)+unit(L-I));
//echo(-1.75*unit([-0.391955, -0.89479, -0.0667194]) + I);
*/