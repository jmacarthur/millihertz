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

// Output for the optimal stators
translate([100,240]) conRod(25);

translate([200,0]) basic_stator_2d();
translate([200,80]) basic_stator_top_plate_2d();
translate([200,100]) cable_connector_2d();


// Cable clamps
translate([75,-50]) rotate(90)  conRod(15);
translate([88,-50]) rotate(90)  conRod(15);

translate([250,-50]) rotate(90)  conRod(15);
translate([270,-50]) rotate(90)  conRod(15);
