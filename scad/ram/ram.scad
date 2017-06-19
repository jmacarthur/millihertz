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
    translate([9,126]) circle(d=3);

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
    translate([5,0]) circle(d=3);
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
    square(size=[25*cols+120,6]);
    for(c=[0:cols]) {
      translate([70-1.5+c*25,-3]) square([3,4]);
    }
  }
}

// Y Axis combs, which also extend enough to hold the axles for the column selector.

module yAxisComb()
{
  difference() {
    square(size=[260,20]);
    for(r=[0:rows]) {
      translate([r*20+7.5,10]) square(size=[3,11]);
    }
    // Holes which hold the selector axles and weight axis
    translate([190,16]) circle(d=3);
    translate([250,16]) circle(d=3);
    // Hole to allow access to the column selectors

    translate([190,0]) square([50,10]);
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
module conRod(len) {
  difference() {
    union() {
      translate([0,0]) circle(d=10);
      translate([0,-5]) square([len,10]);
      translate([len,0]) circle(d=10);
    }
    translate([0,0]) circle(d=3);
    translate([len,0]) circle(d=3);
  }
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

module basePlate()
{
  difference() {
    translate([-10,-5]) {
      square([190,190]);
    }
    translate([-10,-5]) {
      // Holes for static rods
      for(c=[0:cols-1]) {
	translate([c*column_x_spacing+4, 5]) circle(d=3);
	translate([c*column_x_spacing+3, 168+5]) circle(d=3);
      }
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
