/* Laser cutter test file */

// Credit card sized box (86x54) with rounded corners
round_radius = 5;

module outer_box() {
  union() {
    translate([0,round_radius]) square([86, 54-round_radius*2]);
    translate([round_radius,0]) square([86-round_radius*2, 54]);
    translate([round_radius,round_radius]) circle(r=round_radius);
    translate([round_radius,54-round_radius]) circle(r=round_radius);
    translate([86-round_radius,round_radius]) circle(r=round_radius);
    translate([86-round_radius,54-round_radius]) circle(r=round_radius);
  }
}

// Set kerf - the radius of the laser beam. 0.1 is a reasonable average
// value; you may want to adjust this after measurement.

kerf =0.1;

// Now create the top-level object

offset(r=+kerf) {
difference() {
  outer_box();
  // Squares of exactly 10mm
  for(x=[0:3]) {
    translate([x*20+10,-1]) square([10,11]);
  }
  // Circles of varying diameter close to 3mm
  for(x=[0:10]) {
    step = (x%2==1)?8:0;
    translate([x*5+10,20+step]) circle(d=2.5+0.1*x, $fn=20);
  }
  // Hexagons of various a/f distance close to 3mm
  for(x=[0:10]) {
    step = (x%2==1)?8:0;
    af = 2.5+0.1*x;
    r = af / (2*sin(60));
    translate([x*5+10,37+step]) circle(r, $fn=6);
  }
}
}
