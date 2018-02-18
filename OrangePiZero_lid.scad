// Orange Pi Zero enclosure: lid
// (c) 2018, Phil Dubach
//
// Creative Commons License
// Orange Pi Zero Case by Phil Dubach is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// Based on a work at https://github.com/phildubach/OrangePiZeroCase.

pcb_w = 46.1;
pcb_l = 48.1;
pcb_h = 1.6;

pcb_below = 3;
pcb_above = 15;

wall = 2;
gap = 0.2;

$fs = 0.2;
eps = 0.001;

inner_w = pcb_w + 2*gap;
inner_l = pcb_l + 2*gap;

outer_w = inner_w + 2*wall;
outer_l = inner_l + 2*wall;

inner_h = pcb_below + pcb_h + pcb_above;

raised_gap = 0.1;
raised_w = inner_w - 2*raised_gap;
raised_l = inner_l - 2*raised_gap;
raised_r = 2;
raised_h = 0.6;

hole_d = 2.7;
hole_inset = 1.5 + hole_d/2; // actually 1.4 to 1.6

post_d = 5;

antenna_d = 5;

slit_w = 1;
slit_l = 10;

corners=[
    [gap+hole_inset, gap+hole_inset],
    [gap+hole_inset, inner_l-gap-hole_inset],
    [inner_w-gap-hole_inset, gap+hole_inset],
    [inner_w-gap-hole_inset, inner_l-gap-hole_inset]
];

module standoff(di, do, h) {
    difference() {
        cylinder(h=h, d=do);
        translate([0,0,-eps]) cylinder(h=h+2*eps, d=di);
    }
}

difference() {
    union() {
        // rounded top lid
        linear_extrude(height=wall) offset(r=wall) square([inner_w, inner_l]);
        // raised area to center lid on bottom shell
        translate([raised_r+raised_gap, raised_r+raised_gap, wall-eps]) linear_extrude(height=raised_h+eps) offset(r=raised_r) square([raised_w-2*raised_r, raised_l-2*raised_r]);
        // hollow posts for M3 machine screws
        for (pos = corners) {
            translate([pos[0], pos[1], wall]) standoff(di=hole_d, do=post_d, h=pcb_above);
        }
    }
    
    translate([inner_w/2, inner_l/2, -eps]) {
        through_h = wall + raised_h + 2*eps;
        // antenna hole
        cylinder(h=through_h, d=antenna_d);
        // ventilation slits
        for (angle=[0:45:360]) rotate([0,0,angle]) {
            translate([antenna_d/2+slit_w/2+wall,-antenna_d/2,0]) {
                cylinder(d=slit_w, h=through_h);
                translate([0, -slit_w/2, 0]) cube([slit_l-slit_w, slit_w, through_h]);
                translate([slit_l-slit_w,0,0]) cylinder(d=slit_w, h=through_h);
            }
        }
    }
}

