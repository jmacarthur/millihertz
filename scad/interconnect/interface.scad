// Manual interface for Bowden cable bus
$fn=20;
thin=0.1;
switch_spacing = 10;
module lever_2d()
{
  difference() {
    
    union() {
      translate([-5,-5]) square([40,10]);
      translate([-5,-30]) square([10,25]);
      translate([35,5-1.5]) circle(d=3);
      translate([35,-5+1.5]) circle(d=3);
      translate([35,-5+1.5]) square([1.5,7]);
    }
    circle(d=3);
    translate([0,-25]) circle(d=3);
    translate([-1.5,-25]) square([3,5]);
    translate([0,-20]) circle(d=3);
  }
}

module output_2d() {
  difference() {
    translate([-5,-5]) square([50,10]);    
    circle(d=3);
    translate([40,0]) circle(d=3);
  }
}

module hardpoint_2d() {
  difference() {
    union() {
      square([50,35]);
      translate([10,-10]) square([40,11]);
      translate([10,-10]) square([43,10]);
      translate([10,20]) square([43,10]);
      // Box lugs
      translate([10,35-thin]) square([5,3+thin]);
      translate([20,35-thin]) square([5,3+thin]);
      translate([30,35-thin]) square([5,3+thin]);
    }
    translate([5,5]) circle(d=3);
    translate([5,25]) circle(d=3);    
    translate([45,5]) circle(d=3);    
  }
}

module frontpanel_2d() {
  difference() {
    union() {
      square([100,50]);
            // Box lugs
      for(i=[0:8]) {
	translate([10+i*switch_spacing,50-thin]) square([5,3+thin]);
      }
    }
    for(i=[0:8]) {
      translate([10+switch_spacing*i,5]) square([3,20]);
      translate([10+switch_spacing*i-3,5]) square([3,10]);
      translate([10+switch_spacing*i-3,35]) square([3,10]);
    }
  }
}


module topplate_2d(){
  difference() {
    union() {
      square([100,50]);
      for(i=[0:8]) {
	translate([15+i*switch_spacing,-3]) square([5,3+thin]);
      }
    }
    for(i=[0:8]) {
      for(j=[0:2]) {
	translate([7+i*switch_spacing,15+10*j]) square([3,5]);
      }
    }
  }
}


translate([-5,13,20]) rotate([90,0,0]) {
  linear_extrude(height=3) lever_2d();
  color([1.0,0.5,0.5]) translate([-40,-20,3]) linear_extrude(height=3) output_2d();
  translate([-45,-5,3]) linear_extrude(height=3) hardpoint_2d();
}

rotate([90,0,0]) rotate([0,90,0]) linear_extrude(height=3) frontpanel_2d();
rotate([0,0,90]) translate([0,0,60]) linear_extrude(height=3) topplate_2d();
