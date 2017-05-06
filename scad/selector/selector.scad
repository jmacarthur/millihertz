include <globs.scad>;

output_positions = [ 1, 0, 1, 1, 0, 1 ];
input_data = [ 1, 0, 1, 1, 1 ];

raise_position = 31-(input_data[0] + input_data[1]*2+input_data[2]*4+
		     input_data[3]*8+input_data[4]*16);

seesaw_spacing = 10;

// Enumeration rods
for(s=[0:4]) {
  translate([-15+input_data[s]*5,50+10*s,0])
    difference() {
    union() {
      cube(size=[370,3,10]);
      for(i=[0:31]) {
	align = 1-(floor(i/pow(2,s)) % 2);
	translate([20+seesaw_spacing*i+(seesaw_spacing/2)*align,0,10-thin]) cube(size=[(seesaw_spacing/2)+thin,3,seesaw_spacing+thin]);
      }
    }
    translate([355,4,5]) rotate([90,0,0]) cylinder(d=3,h=5);
    translate([7,4,5]) rotate([90,0,0]) cylinder(d=3,h=5);
  }
}


module lever()
{
  union() {
    cube(size=[3,80,10]);
  }
}

// The seesaw levers
color([0.5,0,0]) {
  for(i=[0:31]) {
    drop = (i==raise_position?-10:0);
    translate([10+10*i+1,30,20+drop]) lever();
  }
}

// These are writer arms - they push ball bearings in both directions
tineSpacing = gridSpacing+ballBearingDiameter;


offset1 = -23;

readWriteXOffset = -10;
readWriteYOffset = -4.5;

reader_positions = [ 4, 2.5, 0, 0, 0 ];
follower_readers = [ 0, 0, 0, 2.5, 4.0 ];

// Fixed sections (chassis)
module xBar(slotStart, leftSide) {

  color([0.5,0.5,0.5]) {
    difference() {
      union() {
	translate([0,0,-10]) cube([350,3,40]);
       }    
      for(i=[1:32]) {
	translate([i*10+1,-thin,5+slotStart]) cube([3,3+thin*2,40-slotStart]);
      }
    }
  }
}

translate([0,45,0]) xBar(0,0);
translate([0,100,0]) xBar(0,0);
translate([0,110,-10]) cube([350,3,40]);
