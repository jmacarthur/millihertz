use <interconnect.scad>;
$fn=20;

translate([100,50]) cable_connector_2d();
optimal_stator_2d();
translate([100,0]) lever_2d();
translate([120,0]) lever_2d();

// Lifters for the row selectors
module generalConRod(len, hole1Diameter, hole2Diameter) {
  difference() {
    union() {
      translate([0,0]) circle(d=10);
      translate([0,-5]) square([len,10]);
      translate([len,0]) circle(d=10);
    }
    translate([0,0]) circle(d=hole1Diameter);
    translate([len,0]) circle(d=hole2Diameter);
  }
}

// Lifters for the row selectors
module conRod(len) {
  generalConRod(len, 3, 3);
}


translate([100,100]) conRod(15);
translate([100,130]) conRod(15);
translate([100,220]) conRod(20);
translate([100,240]) conRod(20);
