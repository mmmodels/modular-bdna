// This module generates a cylinder between P1 to P2 (two arbitrary points)

module cyl_2p(p1, p2, R){
    v = p2 - p1; // vector from P1 to P2
    rot_axis = norm(cross(v, [0, 0, 1])) < 1e-6 ? [1, 0, 0] : [0, 0, norm(v)] + v; // find rotation axis + exception handling
    translate(p1) rotate(a = 180, v = rot_axis){
        cylinder(h=norm(v), r=R);
    }
}