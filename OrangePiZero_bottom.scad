// Orange Pi Zero enclosure: bottom shell
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


hole_d = 3.2;
hole_inset = 1.5 + hole_d/2; // actually 1.4 to 1.6

post_d = 6;

sd_gap = 0.5;
sd_w = 11 + 2*sd_gap;
sd_h = 1.1 + 2*sd_gap;
sd_x = gap + 22.4 - sd_gap;
sd_below = 1.9+sd_gap;

eth_gap = 0.5;
eth_w = 16.16 + 2*eth_gap;
eth_h = 13.14 + 2*eth_gap;
eth_x = gap + 15.22 - eth_gap;
eth_above = 0 - eth_gap;

usba_gap = 0.5;
usba_w = 5.82 + 2*usba_gap;
usba_h = 13.12 + 2*usba_gap;
usba_x = gap + 6.66 - usba_gap;
usba_above = 2.14 - pcb_h - usba_gap;

usbm_gap = 0.5;
usbm_w = 7.9 + 2*usbm_gap;
usbm_h = 2.9 + 2*usbm_gap;
usbm_x = gap + 6.3 - usbm_gap;
usbm_above = 0 - usbm_gap;

usbc_gap = 3;
usbc_w = usbm_w + 2*usbc_gap;
usbc_h = usbm_h + 2*usbc_gap;
usbc_x = usbm_x - usbc_gap;
usbc_above = usbm_above - usbc_gap;
usbc_t = 0.8;

screwhead_gap = 0.2;
screwhead_d = 5.5 + 2*screwhead_gap;
screwhead_h = 2.5;

corners=[
    [gap+hole_inset, gap+hole_inset],
    [gap+hole_inset, inner_l-gap-hole_inset],
    [inner_w-gap-hole_inset, gap+hole_inset],
    [inner_w-gap-hole_inset, inner_l-gap-hole_inset]
];

module standoff(di, do, h) {
    difference() {
        union() {
            cylinder(h=h, d=do);
            cylinder(h=h/2, d=do+wall);
        }
        translate([0,0,-eps]) cylinder(h=h+2*eps, d=di);
    }
}

difference() {
    union() {
        difference() {
            // rounded outer shell
            linear_extrude(height=inner_h + wall) offset(r=wall) square([inner_w, inner_l]);
            // carve out inner space
            translate([0,0,wall]) cube([inner_w, inner_l, inner_h+eps]);
            // sd
            translate([sd_x,-wall-eps,wall+pcb_below-sd_below]) cube([sd_w,wall+2*eps,sd_h]);
            // eth
            translate([eth_x,inner_l-eps,wall+pcb_below+pcb_h+eth_above]) cube([eth_w,wall+2*eps,eth_h]);
            // USB-A
            translate([usba_x,inner_l-eps,wall+pcb_below+pcb_h+usba_above]) cube([usba_w,wall+2*eps,usba_h]);
            // USB micro
            translate([usbm_x,-wall-eps,wall+pcb_below+pcb_h+usbm_above]) cube([usbm_w,wall+2*eps,usbm_h]);
            // USB micro clearance
            translate([usbc_x,-wall-eps,wall+pcb_below+pcb_h+usbc_above]) cube([usbc_w,wall-usbc_t+eps,usbc_h]);
        }
        // standoff for PCB
        for (pos = corners) {
            translate([pos[0], pos[1], wall-eps]) standoff(di=hole_d, do=post_d, h=pcb_below+eps);
        }
    }
    // screw holes and screw head sink
    for (pos = corners) {
        translate([pos[0], pos[1], -eps]) {
            cylinder(h=wall+2*eps, d=hole_d);
            cylinder(h=screwhead_h+eps, d=screwhead_d);
        }
    }
}
