include <globs.scad>;

output_positions = [ 1, 0, 1, 1, 0, 1 ];
input_data = [ 0, 0, 0, 0, 1 ];

raise_position = 31-(input_data[0] + input_data[1]*2+input_data[2]*4+
		     input_data[3]*8+input_data[4]*16);

seesaw_spacing = 10;
$fn = 20;

module enumerator_rod(value)
{
  difference() {
    union() {
      square(size=[370,10]);
      // End stops
      translate([5,0]) square(size=[5,12]);
      translate([351,0]) square(size=[5,12]);
      for(i=[0:31]) {
	align = 1-(floor(i/pow(2,value)) % 2);
	translate([20+seesaw_spacing*i+(seesaw_spacing/2)*align,10-thin]) square(size=[(seesaw_spacing/2)+thin,seesaw_spacing+thin]);
      }
    }
    translate([355,5]) circle(d=3);
    translate([7,5]) circle(d=3);
  }
}

// Enumeration rods
for(s=[0:4]) {
  translate([-15+input_data[s]*5,53+10*s,0])
    rotate([90,0,0]) linear_extrude(height=3) {
    enumerator_rod(s);
  }
}


module lever()
{
  difference() {
    translate([0,-85,-5]) cube(size=[3,90,10]);
    translate([-1,0,0]) rotate([0,90,0]) cylinder(d=3,h=5);
  }
}

// The seesaw levers
color([0.5,0,0]) {
  for(i=[0:31]) {
    rot = (i==raise_position?7.5:0);
    translate([10+10*i+1,30,20])   translate([0,85,5]) rotate([rot,0,0]) lever();
  }
}

offset1 = -23;

readWriteXOffset = -10;
readWriteYOffset = -4.5;

reader_positions = [ 4, 2.5, 0, 0, 0 ];
follower_readers = [ 0, 0, 0, 2.5, 4.0 ];

module xBar_2d(slotStart, slotHeight, height, hooks) {
  difference() {
    union() {
      translate([0,-10]) square([350,height]);	
    }    
    for(i=[1:32]) {
      translate([i*10+1,5+slotStart]) square([3,slotHeight]);
    }
    translate([45,-5]) circle(d=3);
    translate([335,-5]) circle(d=3);
    translate([65,-11]) square([3,6]);
    translate([225,-11]) square([3,6]);
    if(hooks) {
      translate([5,15]) square([3,6]);
      translate([325,15]) square([3,6]);
      translate([0,15]) square([3,6]);
      translate([333,15]) square([3,6]);
    }
  }
}

// Fixed sections (chassis)
module xBar(slotStart, slotHeight, height, hooks) {
  color([0.5,0.5,0.5]) {
    translate([0,3,0]) 
    rotate([90,0,0]) 
    linear_extrude(height=3) {
      xBar_2d(slotStart, slotHeight, height, hooks);
    }
  }
}

module outputComb_2d() {
  difference() {
    union() {
      translate([5,0]) square([323,30]);	
    }
    translate([0,-1]) square([8,26]);
    translate([323,-1]) square([8,26]);
    for(i=[0:31]) {
      translate([11+i*10,-1]) square([3,20]);	
    }
  }  
}

module outputComb() {
  color([0.5,0.5,0.5]) {
    translate([0,3,0]) 
    rotate([90,0,0]) 
    linear_extrude(height=3) {
      outputComb_2d();
    }
  }
}

module yComb_2d()
{
  difference() {
    union() {
      
      square([65,10]);
      for(i=[0:4]) {
	translate([13+i*10,9])
	  square([7,11]);	
      }
      translate([8,9])
	square([2,6]);	
      
    }
    translate([5,5]) square([3,6]);
    translate([60,5]) square([3,6]);
  }
}

module yComb() {
  rotate([90,0,0]) rotate([0,90,0]) 
  linear_extrude(height=3) {
    yComb_2d();
  }
}

translate([0,5,30]) outputComb();
translate([0,45,0]) xBar(5,20,50,false);
translate([0,100,0]) xBar(5,20,50,false);
translate([0,-30,0]) xBar(15,20,30,true);

//translate([0,110,10]) cube([350,3,20]);
translate([65,40,-10]) yComb();
translate([225,40,-10]) yComb();

module crank_2d(output_map)
{
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

// Reader levers
module crank(output_map) {
  rotate([90,0,0]) rotate([0,90,0])
  linear_extrude(height=3) {
    crank_2d(output_map);
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


module common_endplate_cutaway()
{
  translate([76,-1])
    square([5,11]);
  translate([5,-1])
    square([3,6]);
  translate([135,-1])
    square([3,31]);
  translate([137,-1])
    square([5,11]);
  translate([150,15])
    circle(d=3);
  translate([26,-1])
    square([3,22]);
  translate([80,-1])
    square([3,31]);
}


module inner_end_plate_2d()
{
  difference() {
    square([155,50]);
    for(i=[0:4]) {
      translate([6+i*5,25])
	square([3,20]);
    }
    translate([50,25])
      circle(d=3);
    translate([40,45])
      square([3,11]);
    common_endplate_cutaway();
  }
}

// End bars
module inner_end_plate()
{
  translate([0,-35,10])
    rotate([90,0,0])
    rotate([0,90,0])
  linear_extrude(height=3) {
    inner_end_plate_2d();
  }
}

module outer_end_plate_2d()
{
  difference() {
    square([155,50]);
    common_endplate_cutaway();
  }
}

// End bars
module outer_end_plate()
{
  translate([0,-35,10])
    rotate([90,0,0])
    rotate([0,90,0])
    linear_extrude(height=3) {
    outer_end_plate_2d();
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

module lifter_bar_2d()
{
  difference() {
    square([350,10]);
    translate([17,5]) circle(d=3);
    translate([307,5]) circle(d=3);
  }
}

// Lifting bars
module lifter_bar()
{
  rotate([90,0,0])
  linear_extrude(height=3) {
    lifter_bar_2d();
  }
}

module front_lifter_lever_2d() {
  len = 30;
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

module front_lifter_lever() {
  rotate([90,0,0])
    linear_extrude(height=3) {
    front_lifter_lever_2d();
  }
}

module back_lifter_lever_2d() {
  len = 30;
  leg_angle = 45;
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

module back_lifter_lever() {
  rotate([90,0,0])    
    linear_extrude(height=3) {
    back_lifter_lever_2d();
  }
}


translate([0,45,0]) lifter_bar();
for(y=[-45,0]) {
  translate([15,42+y,0]) rotate([0,17,0]) front_lifter_lever();
  translate([305,42+y,0]) rotate([0,17,0]) back_lifter_lever();
}


module output_lifter_bar_2d() {
  difference() {
    square([330,20]);
    translate([17,5]) circle(d=3);
    translate([307,5]) circle(d=3);
  }
}

module output_lifter_bar() {
  rotate([90,0,0]) 
    linear_extrude(height=3) {
    output_lifter_bar_2d();
  }
}

translate([0,-6,0]) output_lifter_bar();
