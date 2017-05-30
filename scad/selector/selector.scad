/* Universal combinational logic element suitable for laser cutting. 

The system comprises four main moving parts: 

1) Input rods (enumeration rods) - there are N of these. These are
moved backwards and forwards, with a travel of 10mm.

2) Input followers. There are 2^N of these, and one of them will fall
into a gap made by the enumeration rods.

3) Cranks. These are meant to fall into gaps when the input followers
don't fall, negating that function.

4) Output rods. These will be lifted up by the crank that doesn't
fall. There can be as many output rods as you like, within reason,
providing any function of the five inputs. This implementation has 5
outputs.

Note that the output rods are unpowered; you will need to find some
other means to amplify the output.

*/

include <globs.scad>;


// Various parameters
follower_spacing = 10; // Spacing between each input follower
$fn = 20;

// Number of inputs. This was originally defined for 5 inputs;
// other numbers may work, but are in development.
n_inputs = 4;

// The position of the input rods for this rendering
input_data = [ 0, 1, 1, 1, 0 ];



// Enumerator supports still have to be manually placed when changing n_inputs.
// For n=5, we suggest [64,225].

enumerator_support_x1 = 64;
enumerator_support_x2 = 135;

// Calculated globals


n_positions = pow(2,n_inputs);
// Calculates the position of the fallen input follower and raised
// crank for this rendering.
raise_position = n_positions-1-(input_data[0] + input_data[1]*2+input_data[2]*4+
		     input_data[3]*8+input_data[4]*16);


x_internal_space = 10*n_positions;

module enumerator_rod(value)
{
  difference() {
    union() {
      square(size=[40+x_internal_space,10]);
      // End stops
      translate([5,0]) square(size=[5,12]);
      translate([31+x_internal_space,0]) square(size=[5,12]);
      positions = pow(2,n_inputs);
      for(i=[0:positions-1]) {
	align = 1-(floor(i/pow(2,value)) % 2);
	translate([20+follower_spacing*i+(follower_spacing/2)*align,10-thin]) square(size=[(follower_spacing/2)+thin,follower_spacing+thin]);
      }
    }
    translate([355,5]) circle(d=3);
    translate([7,5]) circle(d=3);
  }
}

// Enumeration rods
for(s=[0:n_inputs-1]) {
  translate([-15+input_data[s]*5,53+10*s,0])
    rotate([90,0,0]) linear_extrude(height=3) {
    enumerator_rod(s);
  }
}

// The follower levers
module lever_2d()
{
  difference() {
    union() {
      translate([-85,-5]) square(size=[85,10]);
      circle(d=10);
    }
    circle(d=3);
  }
}

module lever()
{
  rotate([90,0,0])
  rotate([0,90,0])
  linear_extrude(height=3) lever_2d();
}

color([0.5,0,0]) {
  for(i=[0:n_positions-1]) {
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
      translate([0,-10]) square([20+x_internal_space,height]);
    }
    for(i=[1:n_positions]) {
      translate([i*10+1,5+slotStart]) square([3,slotHeight]);
    }
    translate([45,-5]) circle(d=3);
    translate([15+x_internal_space,-5]) circle(d=3);
    translate([enumerator_support_x1,-11]) square([3,6]);
    translate([enumerator_support_x2,-11]) square([3,6]);
    if(hooks) {
      translate([5,15]) square([3,6]);
      translate([5+x_internal_space,15]) square([3,6]);
      translate([0,15]) square([3,6]);
      translate([13+x_internal_space,15]) square([3,6]);
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
      translate([5,0]) square([3+x_internal_space,30]);
    }
    translate([0,-1]) square([8,26]);
    translate([3+x_internal_space,-1]) square([8,26]);
    for(i=[0:n_positions-1]) {
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

translate([enumerator_support_x1,40,-10]) yComb();
translate([enumerator_support_x2,40,-10]) yComb();

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

for(i=[0:n_positions-1]) {
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
    translate([3,-29+i*5,45]) cube([x_internal_space+10,3,10]);
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
  translate([5+x_internal_space,0,0])
  inner_end_plate();
  translate([0,0,0])
  outer_end_plate();
  translate([13+x_internal_space,0,0])
  outer_end_plate();
}

module lifter_bar_2d()
{
  difference() {
    square([30+x_internal_space,10]);
    translate([17,5]) circle(d=3);
    translate([x_internal_space-13,5]) circle(d=3);
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
  translate([x_internal_space-15,42+y,0]) rotate([0,17,0]) back_lifter_lever();
}


module output_lifter_bar_2d() {
  difference() {
    square([10+x_internal_space,20]);
    translate([17,5]) circle(d=3);
    translate([x_internal_space-13,5]) circle(d=3);
  }
}

module output_lifter_bar() {
  rotate([90,0,0]) 
    linear_extrude(height=3) {
    output_lifter_bar_2d();
  }
}

translate([0,-6,0]) output_lifter_bar();
