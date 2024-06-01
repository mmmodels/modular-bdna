/*
This script calculates the affine transformation matrix that maps one vector onto another vector. It is used for putting junctions onto models.

This script is an OpenSCAD implementation of the formula mentioned in this Math Stack Exchange answer: (https://math.stackexchange.com/a/476311)
*/

// Identity matrix
I3 = [[1,0,0],[0,1,0],[0,0,1]];

// Cross product matrix
function cpm(v) = [[0,-v[2],v[1]],[v[2],0,-v[0]],[-v[1],v[0],0]];

// Rotation matrix from one arbitrary vector to another 
function rot_matrix(v1, v2) = 
    let (u1 = v1/norm(v1), u2 = v2/norm(v2), vec = cross(u1,u2), R = I3 + cpm(vec) + cpm(vec)*cpm(vec)*(1/(1+u1*u2)))
        [[R[0][0],R[0][1],R[0][2],0],
         [R[1][0],R[1][1],R[1][2],0],
         [R[2][0],R[2][1],R[2][2],0]];
 
// It takes in 4 coordinates/vectors: [starting point of original vector],[original vector],[starting point of target vector],[target vector]
module aff_tran(p1, v1, p2, v2){
    translate(p2) multmatrix(rot_matrix(v1,v2)) translate(-p1) children();
}
    