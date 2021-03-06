include <ram.scad>
use <../selector/selector.scad>
include <globs.scad>;

activated_column = 0;
activated_row = 0;

inject = false;
eject = true;

balls = true;
base_plate_on = true;

// Add all row selectors and backing
for(i=[0:cols-1]) {
  translate([i*column_x_spacing,(i==activated_column?column_travel:0),0]) {
    linear_extrude(height=3) {
      rowSelect();
    }
    translate([9,160,10])
      rotate([0,90,0])
      linear_extrude(height=3) {
      columnPeg();
    }
  }
  translate([-11+i*column_x_spacing,0,0]) {
    linear_extrude(height=3) {
      backing();
    }
  }
 }


module rowControl()
{
  for(i=[0:cols-1]) {
    color([0.0,0.5,0])
      translate([-13+i*column_x_spacing,0,0])
      linear_extrude(height=3) {
      ejector();
    }
  }

  for(i=[0:cols-1]) {
    color([0.0,0.5,0])
      translate([-11+17+i*column_x_spacing-1,0,0])
      linear_extrude(height=3) {
      injector();
    }
  }

  color([0.5,0.5,0.5,1.0])
    translate([-80,3+1.5,3])
    rotate([90,0,0])
    linear_extrude(height=3) {
    rowBar();
  }
}


for(i=[0:rows-1]) {
  active = (activated_row==i?1:0);
  movement = (eject?6:0) + (inject?-6:0);
  translate([movement,20*i+6,3+5-active*5]) rowControl();
}

if(balls) {
  for(x=[0:rows-1]) {
    for(y=[0:cols-1]) {
      translate([column_x_spacing*x-4.5, 20*y+8,2.5]) sphere(d=5, $fn=20);
    }
  }
}


for(side=[0,1])
translate([-22+221*side,0,-5])
rotate([0,0,90])
rotate([90,0,0])
linear_extrude(height=3) {
  yAxisComb();
}

// Objects from the selector (3D)
// Row enumeration rods
follower_spacing = 20;
travel = 5;
n_inputs = 3;
row_input_data = [ 1, 1, 0 ];

for(side = [0,1]) {
  translate([15+273*side,-5+1.5,-10])
    rotate([0,0,90])
    for(s=[0:2]) {
      translate([-15+row_input_data[s]*travel,53+10*s,6])
	rotate([90,0,0]) linear_extrude(height=3) {
	union() {
	  row_enumerator_rod(s, n_inputs, follower_spacing, 0, travel, 5);
	}
      }
    }
 }

col_input_data = [ 0,1,0];
// Column enumeration rods
translate([4,150,-10]) {
  for(s=[0:2]) {
    translate([-21+col_input_data[s]*5,53+10*s,1])
      rotate([90,0,0]) linear_extrude(height=3) {
      union() {
	col_enumerator_rod(s, n_inputs, column_x_spacing, 0, travel, 5);
      }
    }
  }


  // Column followers
  translate([5,40,21]) {
    for(col=[0:7]) {
      translate([col*column_x_spacing,0,0])
	rotate([90+(col==activated_column?-8.5:0),0,0])
	rotate([0,90,0])
	linear_extrude(height=3) columnFollower();
    }
  }
}


// A rod - axle for the followers
translate([-22,190,11]) {
  rotate([0,90,0])
  cylinder(d=3,h=224);
}

// A rod to hang weights over for the column rods
translate([-22,250,11]) {
  rotate([0,90,0])
  cylinder(d=3,h=224);
}


// Mechanism for lifting all row rods
for(side=[0,1]) {

  // Lifter rods
  translate([-28+233*side,0,0])
    rotate([90,0,0])
    rotate([0,90,0])
    linear_extrude(height=3) conRod(150);

  // Modules that support the lifter
  rod_rotation = asin(10/30);

  translate([-25+227*side,0,0])
    rotate([90-rod_rotation,0,0])
    rotate([0,90,0])
    linear_extrude(height=3) conRod(30);

  translate([-22+227*side,150+raiser_offset,-10])
    rotate([0,0,180])
    rotate([90+rod_rotation,0,0])
    rotate([0,90,0])
    linear_extrude(height=3) crankRod(30,50);

}

resetAngle = -80;
swingArmLen = 30;
// Long conrod for restting columns
translate([-7+swingArmLen*cos(resetAngle)-10,14*12+swingArmLen*sin(resetAngle),-6])
linear_extrude(height=3)
difference() {
  union () {
    conRod(14*12+10);
    translate([-5,-11]) square([14*12+26,10]);
  }
  translate([10,0]) circle(d=3);
  translate([12*12,-5]) circle(d=3);
  translate([14*12+10,0]) circle(d=3);
}

// Smaller levers which attach to the column reset lever
translate([-7,14*12,-9])
rotate([0,0,resetAngle]) linear_extrude(height=3)
union() {
  generalConRod(swingArmLen,3,3);
  rotate(90) generalConRod(swingArmLen,3,3);
}

translate([-7+14*12,14*12,-9])
rotate([0,0,resetAngle]) linear_extrude(height=3) generalConRod(swingArmLen,3,3);

// Base plate
if(base_plate_on) {
  translate([0,0,-3])   color([0.6,0.6,0.6])
    linear_extrude(height=3) basePlate();
 }

// Feet for y axis combs
for(y=[0,12*12]) {
  for(x=[0,12*18]) {
    translate([-30+x,y,-20]) linear_extrude(height=3) combFeet(align=(x==0?8:13));
  }
}

for(side=[0,1]) {
  zrot = (side==0?0:180);
  yadjust = (side==0?0:-3);
  xpos = (side==0?-63:243);
  translate([xpos,40+yadjust,-15]) rotate([0,0,zrot]) rotate([90,0,0]) linear_extrude(height=3) rowSelectorComb();
  translate([xpos,120+yadjust,-15]) rotate([0,0,zrot]) rotate([90,0,0]) linear_extrude(height=3) rowSelectorComb();
}


translate([-22,169,0]) rotate([0,0,-90]) rotate([0,-90,0]) linear_extrude(height=3) inputRampEdge2();
translate([-22,172,0]) rotate([0,0,-90]) rotate([0,-90,0]) linear_extrude(height=3) inputRamp();
translate([-22,175,0]) rotate([0,0,-90]) rotate([0,-90,0]) linear_extrude(height=3) inputRamp();
translate([-22,178,0]) rotate([0,0,-90]) rotate([0,-90,0]) linear_extrude(height=3) inputRampEdge();


// Injector/ejector assembly

for(side=[0:1]) {
  translate([-80+360*side,0,0]) {
    translate([0,0,6]) rotate([0,0,90]) linear_extrude(height=3) conRod(150);
    translate([0,0,12]) rotate([0,0,90]) linear_extrude(height=3) conRod(150);
    translate([0,0,3]) rotate([0,0,-150+120*side]) linear_extrude(height=3) generalConRod(30,3,4);
    translate([0,0,9]) rotate([0,0,-150+120*side]) linear_extrude(height=3) generalConRod(30,3,4);
    translate([0,150,3]) rotate([0,0,-150+120*side]) linear_extrude(height=3) generalConRod(30,3,4);
    translate([0,150,9]) rotate([0,0,-150+120*side]) linear_extrude(height=3) generalConRod(30,3,4);
  }
}


// Comb
translate([40,195,-15]) rotate([0,0,90]) rotate([90,0,0]) linear_extrude(height=3) colSelectorComb();
translate([120,195,-15]) rotate([0,0,90]) rotate([90,0,0]) linear_extrude(height=3) colSelectorComb();
