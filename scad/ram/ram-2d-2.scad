include <globs.scad>;
use <../selector/selector.scad>;
include <ram.scad>;

translate([20,5]) rotate(90) yAxisComb();
translate([60,5]) rotate(90) yAxisComb();

translate([350,5]) combFeet(13);
translate([350,35]) combFeet(13);

translate([90,70]) basePlate();

n_inputs = 3;
travel = 5;
for(s=[0:2]) {
  union() {
    translate([80,20*s])
    col_enumerator_rod(s, n_inputs, column_x_spacing, 0, travel, 5);
  }
 }


n_inputs = 3;
travel = 5;
for(s=[0:2]) {
  union() {
    translate([300+20*s,0])
      rotate(90) 
      row_enumerator_rod(s, n_inputs, column_x_spacing, 0, travel, 5);
  }
}



translate([10,280]) conRod(150);

swingArmLen = 30;


translate([395,5]) rotate(90) difference() {
  union () {
    conRod(14*12+10);
    translate([-5,-11]) square([14*12+26,10]);
  }
  translate([10,0]) circle(d=3);
  translate([12*12,-5]) circle(d=3);
  translate([14*12+10,0]) circle(d=3);
}

translate([350,60])
generalConRod(swingArmLen,3,3);

translate([350,80])

union() {
  generalConRod(swingArmLen,3,3);
  rotate(90) generalConRod(swingArmLen,3,3);
}

for(x=[0:3]) for(y=[0:1]) translate([280+x*20, 210+y*20]) columnPeg();


translate([180,280]) 
conRod(150);

translate([390,100]) 
	   rotate(90)
translate([0,20]) conRod(150);

translate([350,130]) rotate(90) generalConRod(30,3,4);
translate([390,200]) rotate(90) generalConRod(30,3,4);

translate([290,180]) {
  translate([0,80]) generalConRod(30,3,4);
  translate([60,90]) generalConRod(30,3,4);
}
