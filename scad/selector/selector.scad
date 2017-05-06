include <globs.scad>;

output_positions = [ 1, 0, 1, 1, 0, 1 ];
input_data = [ 0, 0, 1, 1, 0 ];

raise_position = 31-(input_data[0] + input_data[1]*2+input_data[2]*4+
		     input_data[3]*8+input_data[4]*16);

seesaw_spacing = 10;
$fn = 20;

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
    translate([0,3,0]) 
    rotate([90,0,0]) 
    linear_extrude(height=3) {
      difference() {
	union() {
	  translate([0,-10]) square([350,50]);	
	}    
	for(i=[1:32]) {
	  translate([i*10+1,5+slotStart]) square([3,25-slotStart]);
	}
	translate([45,-5]) circle(d=3);
	translate([335,-5]) circle(d=3);
      }
    }
  }
}

translate([0,45,0]) xBar(5,0);
translate([0,100,0]) xBar(5,0);

translate([0,110,10]) cube([350,3,20]);

// Reader levers
module crank(output_map) {
  rotate([90,0,0]) rotate([0,90,0])
  linear_extrude(height=3) {
    difference() {
      union() {
	translate([-5,-25]) square([20,5]);
	translate([-5,-25]) square([10,30]);
	translate([-45,-5]) square([50,10]);
	for(s=[0:4]) {
	  align = 1-(floor(output_map/pow(2,s)) % 2);
	  if(align) {
	    translate([-45+s*5,0]) polygon(points=[[0,0],[5,0],[4,10],[1,10]]); 
	  }
	}	
      }
      translate([0,0]) circle(r=1.5);
    }
  }
}

for(i=[0:31]) {
  rot = (i==raise_position?0:12);
  translate([11+10*i,15,35])
    rotate([rot,0,0]) 
    crank(i); // Here, you should have a map of desired output values
	      // instead of 'i' - - using the sequence number will not
	      // produce a very useful function.
}

// Axle for the output bars
translate([3,15,35]) rotate([0,90,0]) cylinder(r=1.5,h=330);


// Output summing bars
for(i=[0:4]) {
  union() {
    translate([3,-29+i*5,45]) cube([330,3,10]);
    translate([10+10*i,-29+i*5,45]) cube([10,3,20]);
  }
 }


// End bars
module inner_end_plate()
{
  translate([0,-35,10])
    rotate([90,0,0])
    rotate([0,90,0])
  linear_extrude(height=3) {
    difference() {
      square([150,50]);
      for(i=[0:4]) {
	translate([6+i*5,25])
	  square([3,20]);
      }
      translate([50,25])
	circle(d=3);
      translate([80,-1])
	square([3,31]);
      translate([76,-1])
	square([5,11]);
      translate([135,-1])
	square([3,31]);
      translate([137,-1])
	square([5,11]);
      translate([145,-1])
	square([3,21]);
    }
  }
}

// End bars
module outer_end_plate()
{
  translate([0,-35,10])
    rotate([90,0,0])
    rotate([0,90,0])
  linear_extrude(height=3) {
    difference() {
      square([150,50]);
      translate([80,-1])
	square([3,31]);
      translate([76,-1])
	square([5,11]);
      translate([135,-1])
	square([3,31]);
      translate([137,-1])
	square([5,11]);
      translate([145,-1])
	square([3,21]);
    }
  }
}

color([0,0,1.0]) {
  translate([5,0,0])
  inner_end_plate();
  translate([325,0,0])
  inner_end_plate();
  translate([0,0,0])
    outer_end_plate();
  translate([333,0,0])
    outer_end_plate();
}

// Lifting bars
module lifter_bar()
{
  rotate([90,0,0])
  linear_extrude(height=3) {
    difference() {
      square([350,10]);
      translate([17,5]) circle(d=3);
      translate([307,5]) circle(d=3);
    }
  }
}

module front_lifter_lever() {
  len = 30;
  rotate([90,0,0])
    linear_extrude(height=3) {
    difference() {
      union() {
	square([len,10]);
	translate([0,5]) circle(r=5);
	translate([len,5]) circle(r=5);
      }
      translate([0,5]) circle(d=3);
      translate([len,5]) circle(d=3);
    }
  }
}

module back_lifter_lever() {
  len = 30;
  leg_angle = 45;
  rotate([90,0,0])    
    linear_extrude(height=3) {
    difference() {
      union() {
	square([len,10]);
        translate([len,0]) translate([0,5]) rotate(leg_angle) translate([0,-5]) square([50,10]);
	translate([0,5]) circle(r=5);
	translate([len,5]) circle(r=5);
      }
      translate([0,5]) circle(d=3);
      translate([len,5]) circle(d=3);
      translate([len,5]) rotate(leg_angle) translate([45,0]) circle(d=3);
    }
  }
}


translate([0,45,0]) lifter_bar();
translate([0,106,0]) lifter_bar();
for(side=[0:1]) {
  translate([15,42+67*side,0]) rotate([0,17,0]) front_lifter_lever();
  translate([305,42+67*side,0]) rotate([0,17,0]) back_lifter_lever();
 }
