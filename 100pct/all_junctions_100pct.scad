/*
The modules in this script generate standalone junctions used by the molecule models. They are mapped onto the models using the aff_tran() function in "/lib/affine_transformation.scad".

List of junction modules in this script:
             Name                |   Naming prefix*  |    Short Description
    perm_pin()/perm_socket()     |       perm        |  print-in-place articulation
      hb_pin()/hb_socket()       |        hb         |       hydrogen bond
  bsbk_duckbill()/bsbk_socket()  |       bsbk        |    base-backbone junction
 bsbkp_duckbill()/bsbkp_socket() |       bsbkp       |  same as bsbk but permanent
    bkbk_pin()/bkbk_socket()     |       bkbk        |  backbone-backbone junction

*: Implemented to prevent variable/module name collisions 

Note: Atom sizes does not reflect actual size ratios. For more information, please check out "global_variables.scad"

*/

include <./global_variables.scad>
include <../lib/two_point_cylinder.scad>

/*-------------------------------------------------------------------------------*/

// These two modules generates a permanent, print-in-place junction between two arbitrary atoms. 

// Parameters (mm)
perm_rod_r = 1.2;            // Radius of rod
perm_rodend_r = 1.75;        // Radius of rodend sphere
perm_gap = 0.2;              // Gap between parts
perm_rodend_cutoff = 0.5;    // Cutoff of rodend sphere

module perm_pin(bond_len, atomic_radius, include_atom) {
    scale([s,s,s]){
        union(){
            difference(){
                union(){
                    if(include_atom) translate([bond_len,0,0]) sphere(atomic_radius); // Atom
                    sphere(perm_rodend_r); // Pin spherical end
                }
                cyl_2p([perm_rodend_cutoff,0,0],[bond_len/2 +perm_gap/2,0,0],3); // shave off
            }
            cyl_2p([0,0,0],[bond_len,0,0],perm_rod_r); // rod
        }
    }
}

module perm_socket(bond_len, atomic_radius) {
    scale([s,s,s]){
        difference(){
            sphere(atomic_radius); // Atom
            difference(){
                sphere(perm_rodend_r+perm_gap);  // Cavity for rod end
                cyl_2p([perm_rodend_cutoff+perm_gap,0,0],[5,0,0],3); // shave off of rod end cavity
            }
            cyl_2p([perm_rodend_cutoff,0,0],[bond_len/2,0,0],perm_rod_r+perm_gap); // pin entry hole
            cyl_2p([bond_len/2 - perm_gap/2,0,0],[5,0,0],3); // shave off
        }
    }
}

module perm_cutaway(plane) { // For preview and debug uses
    difference(){
        union(){
            perm_pin(3.75,Cr,1);
            perm_socket(3.75,Cr);
        }
        if(plane == "XY"){
            translate([-10,-10,0]) cube([20,20,5]);
        }
        if(plane == "XZ"){
            translate([-10,-5,-10]) cube([20,5,20]);
        }
    }
}



/*-------------------------------------------------------------------------------*/

// These two modules generate the hydrogen bond between nucleobases.

// Parameters (mm)
hb_bond_len = hydrogen_bond_len;
hb_rod_r = 1;                     // Radius of rod
hb_rodend_r = 1.1;                // Radius of rodend sphere
hb_rodend_z_shaveoff = 1;         // Shave off of rodend sphere
hb_rodstop_r = 1.3;               // Radius of rod stop cylinder
hb_gap = 0.1;                     // Gap between two parts
hb_crevice_width = 0.75;          // Width of crevice
hb_cavity_constrict_start = 2.7;  // Socket cavity constriction start
hb_cavity_constrict_end = 3.1;    // Socket cavity constriction end
hb_socket_shaveoff = 2.4;         // Shave off of pin entry hole

module hb_pin(){
    scale([s,s,s]){
        translate([hb_bond_len,0,0]) sphere(Hr); // Hydrogen atom
        cyl_2p([0, 0, 0], [hb_bond_len, 0, 0], hb_rod_r); // rod
        cyl_2p([hb_socket_shaveoff + hb_gap, 0, 0], [hb_bond_len, 0, 0], hb_rodstop_r); // rod stop cylinder
        difference(){
            sphere(hb_rodend_r); // rod end sphere
            translate([0,0,1+hb_rodend_z_shaveoff]) cube(2, center = true); // top shave off
            translate([0,0,-1-hb_rodend_z_shaveoff]) cube(2, center = true); // bottom shave off
        }
    }
}

module hb_socket(){
    scale([s,s,s]){
        difference(){
            sphere(Or); // Oxygen atom (or Nitrogen atom)
            translate([-(hb_rodend_r+hb_gap),0,0]) rotate([0,90,0]) rotate_extrude(){ // Carve out the cavity
                polygon([[0,0],[hb_rodend_r+hb_gap,0],[hb_rodend_r+hb_gap,hb_cavity_constrict_start],[hb_rod_r+hb_gap,hb_cavity_constrict_end],[hb_rod_r+hb_gap,5],[0,5]]);
            }
            translate([0,0,-5]) linear_extrude(height = 10){ // Vertical crevice for flexibility
                polygon([[0,-hb_crevice_width/2],[0,hb_crevice_width/2],[5,hb_crevice_width/2],[5,-hb_crevice_width/2]]);
                circle(d = hb_crevice_width);
            }
            translate([2+hb_socket_shaveoff,0,0]) cube(4, center = true);
        }
    }
}

module hb_cutaway(plane) { // For preview and debug uses
    difference(){
        union(){
            hb_pin();
            hb_socket();
        }
        if(plane == "XY"){
            translate([-10,-10,0]) cube([20,20,5]);
        }
        if(plane == "XZ"){
            translate([-10,-5,-10]) cube([20,5,20]);
        }
    }
}



/*-------------------------------------------------------------------------------*/

// These two modules generate a duckbill junction between nucleobase and backbone

// Parameters (mm)
bsbk_bond_len = CN_bond_len;
bsbk_rod_r = 1.4;                // Radius of rod
bsbk_rodend_r = 1.7;             // Radius of rodend sphere
bsbk_gap = 0.15;                 // Gap between two parts
bsbk_end_cutoff = 0.5;           // Cutoff of rodend sphere
bsbk_rodend_z_shaveoff = 1.2;    // Shave off of rodend sphere
bsbk_crevice_width = 0.7;        // Width of duckbill crevice
bsbk_crevice_x_offset = 1;       // X-offset of crevice

module bsbk_duckbill() {
    scale([s,s,s]){
        difference(){
            union(){
                difference(){
                    union(){
                        translate([bsbk_bond_len,0,0]) sphere(Nr); // Nitrogen atom
                        sphere(bsbk_rodend_r); // Pin sphereical end
                    }
                    cyl_2p([bsbk_end_cutoff,0,0],[(bsbk_bond_len/2)+bsbk_gap/2,0,0],3); // shave off
                }
                cyl_2p([0,0,0],[bsbk_bond_len,0,0],bsbk_rod_r); // rod
            }
            translate([0,0,-5]) linear_extrude(height = 10){ // crevice
                polygon([[-5,bsbk_crevice_width/2],[bsbk_crevice_x_offset,bsbk_crevice_width/2],[bsbk_crevice_x_offset,-bsbk_crevice_width/2],[-5,-bsbk_crevice_width/2]]);
                translate([bsbk_crevice_x_offset,0,0]) circle(d = bsbk_crevice_width);
            }
            translate([0,0,bsbk_rodend_z_shaveoff]) linear_extrude(height = 2){ // top shave off
                polygon([[-2,2],[bsbk_bond_len/2 + bsbk_gap/2,2],[bsbk_bond_len/2 + bsbk_gap/2,-2],[-2,-2]]);
            }
            rotate([180,0,0]) translate([0,0,bsbk_rodend_z_shaveoff]) linear_extrude(height = 2){ // bottom shave off
                polygon([[-2,2],[bsbk_bond_len/2 + bsbk_gap/2,2],[bsbk_bond_len/2 + bsbk_gap/2,-2],[-2,-2]]);
            }
        }
    }
}

module bsbk_socket() {
    scale([s,s,s]){
        difference(){
            sphere(Cr); // Carbon atom
            union(){
                difference(){
                    sphere(bsbk_rodend_r+bsbk_gap); // Cavity for rod end
                    cyl_2p([bsbk_end_cutoff+bsbk_gap,0,0],[5,0,0],3); // shave off of rod end cavity
                }
                cyl_2p([bsbk_end_cutoff,0,0],[bsbk_bond_len/2,0,0],bsbk_rod_r+bsbk_gap); // duckbill entry hole
                cyl_2p([bsbk_bond_len/2 - bsbk_gap/2,0,0],[5,0,0],3); // shave off
            }
        }
    }
}

module bsbk_cutaway(plane) { // For preview and debug uses
    difference(){
        union(){
            bsbk_duckbill();
            bsbk_socket();
        }
        if(plane == "XY"){
            translate([-10,-10,0]) cube([20,20,5]);
        }
        if(plane == "XZ"){
            translate([-10,-5,-10]) cube([20,5,20]);
        }
    }
}



/*-------------------------------------------------------------------------------*/

// These two modules are identical to bsbk modules, except the fact that they are designed to be a permanent junction after connection.

// Parameters (mm)
bsbkp_bond_len = CN_bond_len;
bsbkp_rod_r = 1.4;                // Radius of rod
bsbkp_rodend_r = 1.8;             // Radius of rodend sphere
bsbkp_gap = 0.1;                  // Gap between two parts
bsbkp_end_cutoff = 0.5;           // Cutoff of rodend sphere
bsbkp_rodend_z_shaveoff = 1.2;    // Shave off of rodend sphere
bsbkp_crevice_width = 0.7;        // Width of duckbill crevice
bsbkp_crevice_x_offset = 1;       // X-offset of crevice

module bsbkp_duckbill() {
    scale([s,s,s]){
        difference(){
            union(){
                difference(){
                    union(){
                        translate([bsbkp_bond_len,0,0]) sphere(Nr); // Nitrogen atom
                        sphere(bsbkp_rodend_r); // Pin sphereical end
                    }
                    cyl_2p([bsbkp_end_cutoff,0,0],[(bsbkp_bond_len/2)+bsbkp_gap/2,0,0],3); // shave off
                }
                cyl_2p([0,0,0],[bsbkp_bond_len,0,0],bsbkp_rod_r); // rod
            }
            translate([0,0,-5]) linear_extrude(height = 10){ // crevice
                polygon([[-5,bsbkp_crevice_width/2],[bsbkp_crevice_x_offset,bsbkp_crevice_width/2],[bsbkp_crevice_x_offset,-bsbkp_crevice_width/2],[-5,-bsbkp_crevice_width/2]]);
                translate([bsbkp_crevice_x_offset,0,0]) circle(d = bsbkp_crevice_width);
            }
            translate([0,0,bsbkp_rodend_z_shaveoff]) linear_extrude(height = 2){ // top shave off
                polygon([[-2,2],[bsbkp_bond_len/2 + bsbkp_gap/2,2],[bsbkp_bond_len/2 + bsbkp_gap/2,-2],[-2,-2]]);
            }
            rotate([180,0,0]) translate([0,0,bsbkp_rodend_z_shaveoff]) linear_extrude(height = 2){ // bottom shave off
                polygon([[-2,2],[bsbkp_bond_len/2 + bsbkp_gap/2,2],[bsbkp_bond_len/2 + bsbkp_gap/2,-2],[-2,-2]]);
            }
        }
    }
}

module bsbkp_socket() {
    scale([s,s,s]){
        difference(){
            sphere(Cr); // Carbon atom
            union(){
                difference(){
                    sphere(bsbkp_rodend_r+bsbkp_gap); // Cavity for rod end
                    cyl_2p([bsbkp_end_cutoff+bsbkp_gap,0,0],[5,0,0],3); // shave off of rod end cavity
                }
                cyl_2p([bsbkp_end_cutoff,0,0],[bsbkp_bond_len/2,0,0],bsbkp_rod_r+bsbkp_gap); // duckbill entry hole
                cyl_2p([bsbkp_bond_len/2 - bsbkp_gap/2,0,0],[5,0,0],3); // shave off
            }
        }
    }
}

module bsbkp_cutaway(plane) { // For preview and debug uses
    difference(){
        union(){
            bsbkp_duckbill();
            bsbkp_socket();
        }
        if(plane == "XY"){
            translate([-10,-10,0]) cube([20,20,5]);
        }
        if(plane == "XZ"){
            translate([-10,-5,-10]) cube([20,5,20]);
        }
    }
}



/*-------------------------------------------------------------------------------*/

// These two modules generate a pin-socket junction between backbones

// Parameters (mm)
bkbk_bond_len = PO_bond_len;
bkbk_intersect_plane = 2.565;    // Two spheres intersect at x = 2.565 (need recalc if you want to modify atomic radii)
bkbk_rod_r = 1.8;                // Radius of rod
bkbk_rodend_r = 2.1;             // Radius of rodend sphere
bkbk_gap = 0.15;                 // Gap between two parts
bkbk_end_r_cutoff = 0.6;         // Right-cutoff of rodend sphere
bkbk_end_l_cutoff = -1.7;        // Left-cutoff of rodend sphere
bkbk_crevice_width = 0.6;        // Width of socket crevice
bkbk_crevice_x_offset = -1.2;    // X-offset of socket crevice

module bkbk_pin(include_atom){
    scale([s,s,s]){
        difference(){
            union(){
                difference(){
                    union(){
                        if(include_atom) translate([bkbk_bond_len,0,0]) sphere(Or); // Oxygen atom
                        sphere(bkbk_rodend_r); // Pin sphereical end
                    }
                    cyl_2p([bkbk_end_l_cutoff,0,0],[-5,0,0],3); // left cut off (bigger contact area for FDM support)
                    cyl_2p([bkbk_end_r_cutoff,0,0],[bkbk_intersect_plane + bkbk_gap/2,0,0],3); // right cut off
                }
                cyl_2p([0,0,0],[bkbk_bond_len,0,0],bkbk_rod_r); // rod
            }
        }
    }
}

module socket_crevice(){ // Crevice on socket, separated for easier management
    linear_extrude(height = 10){ // crevice
        polygon([[5,bkbk_crevice_width/2],[bkbk_crevice_x_offset,bkbk_crevice_width/2],[bkbk_crevice_x_offset,-bkbk_crevice_width/2],[5,-bkbk_crevice_width/2]]);
        translate([bkbk_crevice_x_offset,0,0]) circle(d = bkbk_crevice_width);
    }
}

module bkbk_socket(rot_angle){
    rotate([rot_angle,0,0]) scale([s,s,s]){
        difference(){   
            sphere(Pr); // Phosphorus atom
            difference(){
                sphere(bkbk_rodend_r+bkbk_gap); // Cavity for rod end
                cyl_2p([bkbk_end_r_cutoff+bkbk_gap,0,0],[5,0,0],3); // shave off of rod end cavity
            }
            cyl_2p([bkbk_end_r_cutoff,0,0],[bkbk_intersect_plane,0,0],bkbk_rod_r+bkbk_gap); // duckbill entry hole
            cyl_2p([bkbk_intersect_plane - bkbk_gap/2,0,0],[5,0,0],3); // shave off
            socket_crevice(); // crevice #1
            rotate([120,0,0]) socket_crevice(); // crevice #2
            rotate([240,0,0]) socket_crevice(); // crevice #3
        }
    }
}

module bkbk_cutaway(plane) { // For preview and debug uses
    difference(){
        union(){
            bkbk_pin(true);
            bkbk_socket(0);
        }
        if(plane == "XY"){
            translate([-10,-10,0]) cube([20,20,5]);
        }
        if(plane == "XZ"){
            translate([-10,-5,-10]) cube([20,5,20]);
        }
    }
}


perm_cutaway("XY");
translate([12,0,0]) perm_cutaway("XZ");

//hb_cutaway("XY");
//translate([10,0,0]) hb_cutaway("XZ");

//bsbk_cutaway("XY");
//translate([10,0,0]) bsbk_cutaway("XZ");

//bsbkp_cutaway("XY");
//translate([10,0,0]) bsbkp_cutaway("XZ");

//bkbk_cutaway("XY");
//translate([12,0,0]) bkbk_cutaway("XZ");
