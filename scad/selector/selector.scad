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

This file contains 2D modules and a 3D assembly made by extruding them.
The file "2d_assembly_a4.scad" uses this file with the "use" directive
and lays out the 2D modules on a flat plane.

*/

include <globs.scad>;
use <../interconnect/interconnect.scad>;

// Various parameters
follower_spacing = 10; // Spacing between each input follower
$fn = 20;
explode = 0; // Moves parts apart for easier inspection

// Number of inputs. This was originally defined for 5 inputs;
// other numbers may work, but are in development.
n_inputs = 4;

// The position of the input rods for this rendering
input_data = [ 0, 1, 1, 1, 0 ];

// Enumerator supports still have to be manually placed when changing n_inputs.
// For n=5, we suggest [64,225].
enumerator_support_x1 = 64;
enumerator_support_x2 = 135;

// The spacing between output rods
output_y_spacing = 9;

// Calculated globals
n_positions = pow(2,n_inputs);

// Calculates the position of the fallen input follower and raised
// crank for this rendering.
raise_position = n_positions-1-(input_data[0] + input_data[1]*2+input_data[2]*4+
		     input_data[3]*8+input_data[4]*16);

// The spacing between internal plates (i.e. the gap between them plus one thickness)
x_internal_space = 10*n_positions;

// Enumerator rod - one per input; follower rods drop into the gaps in these.

// Parameters:
// Value - the bit value, 0 for bit 0, 1 for bit 1 (2^1), 2 for bit 2 (2^2) etc.
// follower_spacing - the spacing between the rods intended to drop into this.
// stagger - alters the position of the input connector; use this to make some rods longer to stagger input.
// travel - the amount each rods travels. Rods travel inwards - 0 is out of the unit, 1 is in.
// rise_height - how much each bump is raised above the baseline.
module enumerator_rod(value, n_inputs, follower_spacing, stagger, travel, rise_height)
{
  actual_travel = (travel==0)?follower_spacing/2:travel;
  difference() {
    union() {
      square(size=[40+x_internal_space,10]);
      // End stops
      translate([0,0]) square(size=[15,15]);
      translate([31+x_internal_space,0]) square(size=[5,12]);
      positions = pow(2,n_inputs);
      for(i=[0:positions-1]) {
	align = 1-(floor(i/pow(2,value)) % 2);
	translate([20+follower_spacing*i+actual_travel*align,10-thin]) square(size=[actual_travel+thin,rise_height+thin]);
      }
    }
    translate([7,5+stagger]) circle(d=3); // To attach to the input
  }
}

// Place enumeration rods on 3D diagram
for(s=[0:n_inputs-1]) {
  translate([-15+input_data[s]*5,53+10*s,0])
    rotate([90,0,0]) linear_extrude(height=3) {
    enumerator_rod(s, n_inputs, follower_spacing, (s%2==1?5:0), 5, 10);
  }
}

// The follower levers. These drop into the enumeration rods.
module lever_2d()
{
  difference() {
    union() {
      translate([-85.5,-5]) square(size=[85.5,10]);
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
    translate([10+10*i+1,30,20]) translate([0,85,5]) rotate([rot,0,0]) lever();
  }
}

// An xBar is one of the 'input combs' which accomodate the followers.
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

// An output comb accomodates all the crank levers and hangs
// down from the top of the chassis.
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
    // A slot for the output plate
    translate([15,27]) square([140,4]);
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


// A yComb holds all the input enumerator rods.
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
// Three bars which extend in the x dimension

translate([0,-27,0]) xBar(15,20,50,true); // On the output side
translate([0,45,0]) xBar(5,20,50,false); // Middle
translate([0,100,0]) xBar(5,20,50,false); // On the input side

translate([enumerator_support_x1,40,-10]) yComb();
translate([enumerator_support_x2,40,-10]) yComb();

// Cranks lift up the output rods; one of these will remain propped
// up by a fallen input follower. The rest fall.
module crank_2d(output_map)
{
  difference() {
    union() {
      translate([-5,-25]) square([20,5]);
      translate([-5,-25]) square([10,30]);
      translate([-55,-5]) square([60,10]);
      for(s=[0:4]) {
	align = 1-(floor(output_map/pow(2,s)) % 2);
	if(align) {
	  translate([-55+s*output_y_spacing,0]) polygon(points=[[0,0],[5,0],[4,10],[1,10]]);
	}
      }
    }
    translate([0,0]) circle(r=1.5);
  }
}

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

// Output bars
module output_sum_bar(stagger)
{
  difference() {
    union() {
      translate([5,0]) square([x_internal_space + 25, 10]);
      translate([0,-3+stagger]) square([10, 8]);
      translate([5,-5+slot_height+3+stagger]) circle(d=10);
      translate([5,-5+3+stagger]) circle(d=10);
      // Tabs for driving forwards. Must be at least as long as the output travel.
      translate([50,5]) square([30, 10]);
      translate([120,5]) square([30, 10]);
      // Tabs for driving backwards
      translate([50,5]) square([10, 15]);
      translate([120,5]) square([10, 15]);
    }
    slot_height = 7;
    translate([5,-5+3+stagger]) circle(d=3);
    translate([5-1.5,-5+3+stagger]) square([3,slot_height]);
    translate([5,-5+slot_height+3+stagger]) circle(d=3);
  }
}

// 'trim' indicates we have reduced headroom and should remove the top tab.
module output_mounting_bracket(trim, extend_bar)
{
  difference() {
    union() {
      square([19,30]);
      if(extend_bar!=0) translate([0,extend_bar]) square([50,5]);
      translate([16,-5]) square([3,trim?35:40]);
    }
    translate([5,5]) circle(d=3);
    translate([5,25]) circle(d=3);
    // For low headroom tabs, this extra hole allows us to reinforce by placing a long
    // bar through other holes.
    if(trim)
      translate([5,20]) circle(d=3);
    translate([5,45]) circle(d=3); // Marks spot where drive will be
  }
}
 
// Output summing bars
for(i=[0:4]) {
  stagger = (i%2==1) ? 5: 0;
  translate([-8,-36+i*output_y_spacing,45]) rotate([90,0,0]) linear_extrude(height=3) output_sum_bar(stagger);
}

// "Hardpoints" for output
for(i=[0:4]) {
  stagger = (i%2==1) ? 5: 0;
  extend = (i==3 ? 10: i==4?-5:0);
  translate([-8-explode,-36+i*output_y_spacing,stagger]) rotate([90,0,0]) linear_extrude(height=3) output_mounting_bracket(i%2==1?1:0, extend);
}

// "Hardpoints" for input
for(i=[0:4]) {
  stagger = (i%2==1) ? 5: 0;
  translate([-8-explode,50+3+i*10,20+stagger]) rotate([90,0,0]) linear_extrude(height=3) output_mounting_bracket(0,0);
}



module common_endplate_cutaway()
{
  // Clearance for the input lifter
  translate([76,-50])
    square([5,60]);
  // Clearance for the xbar closest to the output
  translate([8,-50])
    square([3,55]);
  // Space for the rail support bar
  translate([-11,40])
    square([4,11]);
  // Space for the xbar closest to the input
  translate([135,-50])
    square([3,80]);


  translate([150,15])
    circle(d=3);
  // Space for the output lifter. This one meets at the
  // bottom, as it's next to a hardpoint which splits the
  // whole front panel.
  translate([26,-10])
    square([3,33]);
  // Cutout for central xbar
  translate([80,-50])
    square([3,80]);

  translate([50,47])
    square([10,11]); // holes to mount output pivot

  translate([80,-21])
    square([50,21]); // Cut enough space to allow the enumerator rods to be added

}

// These are the cutouts for the output bars.
module inner_plate_cutouts()
{
    for(i=[0:4]) {
      translate([-4+i*output_y_spacing,30])
	square([3,15]);
    }
}

module inner_end_plate_2d()
{
  difference() {
    translate([-10,0]) square([165,50]);
    inner_plate_cutouts();
    translate([50,25])
      circle(d=3);
    translate([40,45])
      square([3,11]);
    common_endplate_cutaway();
  }
}

module front_panel_2d()
{
  difference() {
    translate([-10,-20]) square([165,70]);
    inner_plate_cutouts();
    translate([50,25])
      circle(d=3);
    translate([40,45])
      square([3,11]);
    translate([50,47])
      square([10,11]); // holes to mount output pivot
    // Cutout for input hard points
    for(i=[0:4]) {
      stagger = (i%2==1?5:0);
      translate([85+10*i,10+stagger]) square([3,30]);
    }
    // Cutout for output hard points
    for(i=[0:4]) {
      stagger = (i%2==1?5:0);
      translate([-4+output_y_spacing*i,-10+stagger]) square([3,30]);
    }
    // The leftmost (y-positive) output hardpoint must be longer to hold
    // the guide rod
    translate([-4+output_y_spacing*4,-15]) square([3,30]);
    
    // Slots for the output bars
    for(i=[0:5])
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

module front_panel()
{
  translate([0,-35,10])
    rotate([90,0,0])
    rotate([0,90,0])
  linear_extrude(height=3) {
    front_panel_2d();
  }
}


module outer_end_plate_2d()
{
  difference() {
    translate([-10,0]) square([165,50]);
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

// 3D assembly of all end plates
color([0,0,1.0]) {
  translate([5,0,0])
  front_panel();
  translate([5+x_internal_space,0,0])
  inner_end_plate(0);
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
    translate([5,0]) square([5+x_internal_space,20]);
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



module drive_plate_2d() {
  difference() {
    union() {
      square([120,60]);
      translate([120-1,40]) square([11,15]);
    }
    translate([10,13]) square([30,39]);
    translate([80,13]) square([30,39]);
    translate([60,13]) square([3,39]);
    translate([120,40+7.5]) circle(d=3);
  }
}

translate([32,-52,60-3]) color([1.0,0,0,0.5]) linear_extrude(height=3) drive_plate_2d();

module output_rail_2d()
{
  difference() {
    square([x_internal_space+20,20]);
    translate([10,10]) square([x_internal_space-20,3]);
    translate([5,-1]) square([3,4]);
    translate([5+x_internal_space,-1]) square([3,4]);
    translate([5+x_internal_space+8,-1]) square([3,4]);
  }
}

translate([0,-40-2,47]) rotate([90,0,0]) linear_extrude(height=3) output_rail_2d();

// Output pivot
module pivot_2d()
{
  difference() {
    union() {
      square([x_internal_space+60,10]);
      translate([3,-7]) square([x_internal_space-3,10]);
    }
    translate([60+22,0]) circle(d=3);
    translate([193,5]) circle(d=3);
    translate([203,5]) circle(d=3);
  }
}

translate([5,15,60-3]) color([1.0,0,0]) linear_extrude(height=3) pivot_2d();

// A plate which holds the drive cables
translate([198+explode,20,60]) color([0,0,1.0]) linear_extrude(height=3) difference() {
  dual_stator_2d();
  translate([0,0]) circle(d=3);
  translate([10,0]) circle(d=3);
}


// Output drive lever
module drive_lever_2d()
{
  length = 60;
  difference() {
    union() {
      circle(d=10);
      translate([length/2,0]) circle(d=10);
      translate([-length/2,0]) circle(d=10);
      translate([-length/2,-5]) square([length,10]);
    }
    circle(d=3);
    translate([length/2,0]) circle(d=3);
    translate([-length/2,0]) circle(d=3);
    translate([20,0]) circle(d=3);
  }
}


translate([87,15,60+explode]) linear_extrude(height=3) rotate(90) drive_lever_2d();
