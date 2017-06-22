include <globs.scad>;

$fn=20;
rowselect_slot_x_centre = 9;
module rowSelect()
{
  difference() {
    square(size=[12,20*rows+12]);
    for(i=[0:rows]) {
      translate([0,i*20]) circle(r=6);

      if(i != rows) translate([0,i*20+12]) circle(r=6);
      translate([-1,i*20+12]) square(size=[7,8]);
    }
    // Two holes used to keep the row selector vertical.
    translate([9,46]) circle(d=3);
    translate([9,46+80]) circle(d=3);

    // A slot to allow driving
    translate([rowselect_slot_x_centre,160]) square(size=[3,10]);
  }
}

module backing()
{
  difference() {
    translate([0,-5]) square(size=[10,20*rows+12+5]);
    for(i=[0:rows]) {
      if(i!=0) translate([10,i*20-1]) circle(r=6);
      if(i!=rows) translate([4,i*20+5]) polygon(points=[[0,0], [7,1], [7,7], [0,6]]);
    }
    // Two holes used to mount the rod to the backing.
    translate([5,0]) circle(d=4);
    translate([4,168]) circle(d=3);

  }
}

module ejector()
{
  difference() {
    square(size=[6,6]);
    translate([1.5,1.5]) square(size=[3,3]);
  }
}

module injector()
{
  difference() {
    square(size=[12,6]);
    translate([0,6]) circle(r=6);
    translate([6+1.5,1.5]) square(size=[3,3]);
  }
}


module rowBar()
{
  union() {
    square(size=[column_x_spacing*cols+150,6]);
    for(c=[0:cols]) {
      translate([70-1.5+c*column_x_spacing,-3]) square([3,4]);
    }
  }
}

// Y Axis combs, which also extend enough to hold the axles for the column selector.

raiser_offset = sqrt(30*30 - 10*10);
module yAxisComb()
{
  difference() {
    translate([-5,-10]) square(size=[260,30]);
    for(r=[0:rows-1]) {
      translate([r*20+7.5,10]) square(size=[3,11]);
    }
    // Holes which hold the selector axles and weight axis
    translate([190,16]) circle(d=3);
    translate([250,16]) circle(d=3);

    // Hole to allow access to the column selectors
    translate([190,0]) square([50,10]);

    // Hole for the row bar raisers
    translate([raiser_offset,-5]) circle(d=3);
    // Hole for the row bar raisers
    translate([raiser_offset+150,-5]) circle(d=3);

    // Hole to fit into mounting plate feet
    translate([0,-11]) square([10,4]);
    translate([12*12,-11]) square([10,4]);

    // Holes for enumerator combs
    translate([40-3,-11]) square([3,9]);
    translate([120-3,-11]) square([3,9]);

    // Holes for mounting the col selector combs
    translate([235,-5]) circle(d=3);
    translate([205,-5]) circle(d=3);
 }
}


// Tiny square which allows column drive
module columnPeg()
{
  difference() {
    square(size=[10,10]);
    translate([5,5]) circle(d=3);
  }
}

// Mounting feet for y axis combs
module combFeet(align)
{
  // Aligned so the first hole is at (0,0).
  difference() {
    translate([-5,-5]) {
      square([35,20]);
    }
    translate([0,0]) circle(d=4);
    translate([24,0]) circle(d=4);
    translate([align,-6]) square([3,6]);
    translate([align,10]) square([3,10]);
  }
}

module columnFollower()
{
  difference() {
    union() {
      circle(d=10);
      translate([0,-5]) square([50,10]);
      translate([-20,0]) square([50,5]);
      translate([-20,-2]) polygon(points=[[0,0], [5,0], [7,2], [7,5], [0,5]]);
    }
    circle(d=3);
  }
}


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

// like two conrods at a right angle

module crankRod(len1,len2) {
  difference() {
    union() {
      translate([0,0]) circle(d=10);
      translate([0,-5]) square([len1,10]);
      translate([len1,0]) circle(d=10);
      translate([-5,0]) square([10,len2]);
      translate([0,len2]) circle(d=10);
     }
    translate([0,0]) circle(d=3);
    translate([len1,0]) circle(d=3);
    translate([0,len2]) circle(d=3);
  }
}


// The baseplate determines the location of the tool board. The tool board
// requires 4mm holes and the holes are on a 12mm grid. The first hole is
// at (-6,0), so all other holes must be aligned around that.

module basePlate()
{
  difference() {
    translate([-10,-5]) {
      square([195,205]);
    }
    translate([-10,-5]) {
      // Holes for static rods
      for(c=[0:cols-1]) {
	// These won't both fit into the toolboard..
	translate([c*column_x_spacing+4, 5]) circle(d=4);
	translate([c*column_x_spacing+3, 168+5]) circle(d=3);
      }

      // Holes for the tool board at the top
      translate([4, 5+12*16]) circle(d=4);
      translate([4+12*12, 5+12*16]) circle(d=4);
    }
    // Slots to guide moving rods
    slotlen = column_travel;

    for(t=[0:1]) {
      for(c=[0:cols-1]) {
	x = c*column_x_spacing+rowselect_slot_x_centre;
	y = 46+t*80;
	translate([x, y]) circle(d=3);
	translate([x-1.5, y]) square([3,slotlen]);
	translate([x, y+slotlen]) circle(d=3);
      }
    }
  }
}


// Combs for row selectors
module rowSelectorComb()
{
  difference() {
    square([47,20]);
    for(i=[0:2])
      translate([5+10*i,11]) square([3,11]);
    // Hole for raiser
    translate([34,8]) square([10,13]);
  }
}

// Combs for col selectors
module colSelectorComb()
{
  difference() {
    square([47,20]);
    translate([10,5]) circle(d=3);
    translate([40,5]) circle(d=3);
    for(i=[0:2])
      translate([5+10*i,11]) square([3,11]);
  }
}


// A ramp which can inject new data into the array
module inputRamp()
{
  difference() {
    square([20,20]);
    translate([20,25]) circle(r=20);
    translate([5,-1]) square([10,4]);
  }
}

module inputRampEdge()
{
  difference() {
    square([20,20]);
    translate([20,25]) circle(r=15);
    translate([5,-1]) square([10,4]);
  }
}

module inputRampEdge2()
{
  difference() {
    square([20,20]);
    translate([-1,11]) square([4,20]);
    translate([20,25]) circle(r=15);
    translate([5,-1]) square([10,4]);
  }
}


module col_enumerator_rod(value, n_inputs, follower_spacing, stagger, travel, rise_height)
{
  union() {
    enumerator_rod(value, n_inputs, follower_spacing, stagger, travel, rise_height);
    // Stops
    translate([42,-1]) square([10,2]);
    translate([140,-1]) square([10,2]);
  }
}

module row_enumerator_rod(value, n_inputs, follower_spacing, stagger, travel, rise_height)
{
  union() {
    enumerator_rod(value, n_inputs, follower_spacing, stagger, travel, rise_height);
    // Stops
    translate([39+1.5,-1]) square([10,2]);
    translate([138.5,-1]) square([10,2]);
  }
}
