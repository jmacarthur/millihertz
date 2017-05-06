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
    cube(size=[3,220,10]);
    translate([0,0,0]) cube(size=[3,5,15]);
    translate([0,10,0]) cube(size=[3,5,15]);
    translate([0,15,0]) cube(size=[3,5,15]);
  }
}

// The seesaw levers
color([0.5,0,0]) {
  for(i=[0:31]) {
    rot = (i==raise_position?-6:0);
    translate([0,0,20])  rotate([rot,0,0]) translate([10+10*i+1,-100,00]) lever();
  }
}

// Seesaw axis
translate([0,0,20+5]) rotate([0,90,0]) cylinder(r=1.5,h=350);

// These are writer arms - they push ball bearings in both directions
tineSpacing = gridSpacing+ballBearingDiameter;

module biasLever()
{
  translate([0,-70,0]) 
  difference() {
    union() {
      cube([3,80,10]);
      cube([3,10,70]);
    }
    translate([-thin,5,5]) rotate([0,90,0]) cylinder(d=3,h=10);
    translate([-thin,5,45]) rotate([0,90,0]) cylinder(d=3,h=10);
    translate([-thin,5,60]) rotate([0,90,0]) cylinder(d=3,h=10);
    translate([-thin,5-1.5,45]) cube([3+thin*2, 3, 15]);
    translate([-thin,65,8]) cube([3+thin*2, 10, 15]);
  }
}

offset1 = -23;

readWriteXOffset = -10;
readWriteYOffset = -4.5;

reader_positions = [ 4, 2.5, 0, 0, 0 ];
follower_readers = [ 0, 0, 0, 2.5, 4.0 ];

// Fixed sections (chassis)
module xBar(slotStart, leftSide, yposition) {

  color([0.5,0.5,0.5]) {
    difference() {
      union() {
	translate([-10,0,-10]) cube([350,3,40]);
       }    
      for(i=[1:32]) {
	translate([i*10+1,-thin,5+slotStart]) cube([3,3+thin*2,40-slotStart]);
      }
    }
  }
}

translate([0,-35,0]) xBar(10,0);
translate([0,110,0]) xBar(0,0,1);

// Bias arms for the enumeration rods
module enumBiasArm()
{
  rotate([90,0,0]) linear_extrude(height=3) {
    translate([-5,-45]) {
      difference() {
	union() {
	  translate([-70,40]) square([80,10]);
	  translate([0,0]) square([10,50]);
	}
	translate([5,45]) circle(r=1.5);
	translate([5,10]) circle(r=1.5);
	translate([5-1.5,0]) square([3,10]);
      }
    }
  }
}

for(i=[0:4]) {
  translate([345,50+10*i,45]) rotate([0,7-7*input_data[i],0]) enumBiasArm();
}
