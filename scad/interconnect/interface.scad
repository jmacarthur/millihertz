// Manual interface for Bowden cable bus
use <interconnect.scad>;

$fn=20;
thin=0.1;
switch_spacing = 15;

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

module output_2d(stagger) {
  difference() {
    translate([-5-stagger,-5]) square([50+stagger,10]);    
    translate([-stagger,0]) circle(d=3);
    translate([40,0]) circle(d=3);
  }
}

module hardpoint_2d(stagger) {
  difference() {
    union() {
      translate([0-stagger,0]) square([50+stagger,35]);
      translate([10-stagger,-10]) square([40+stagger,11]);
      translate([10-stagger,-10]) square([43+stagger,10]);
      translate([10-stagger,20]) square([43+stagger,10]);
      // Box lugs
      translate([10,35-thin]) square([5,3+thin]);
      translate([20,35-thin]) square([5,3+thin]);
      translate([30,35-thin]) square([5,3+thin]);
    }
    translate([5-stagger,5]) circle(d=3);
    translate([5-stagger,25]) circle(d=3);    
    translate([15-stagger,5]) circle(d=3);
    translate([15-stagger,25]) circle(d=3);    
    translate([45,5]) circle(d=3);    
  }
}

module frontpanel_2d() {
  difference() {
    union() {
      square([8*switch_spacing+20,50]);
      // Box lugs
      for(i=[0:8]) {
	translate([5+i*switch_spacing,50-thin]) square([switch_spacing-5,3+thin]);
      }
    }
    for(i=[0:8]) {
      translate([10+switch_spacing*i,5]) square([3,20]);
      translate([10+switch_spacing*i-3,5]) square([3+thin,10]);
      translate([10+switch_spacing*i-3,35]) square([3,10]);
    }
  }
}


module topplate_2d(){
  difference() {
    union() {
      square([8*switch_spacing+20,50]);
      // Box lugs
      for(i=[0:9]) {
	translate([i*switch_spacing,-3]) square([5,3+thin]);
      }
    }

    for(i=[0:8]) {
      for(j=[0:2]) {
	translate([7+i*switch_spacing,15+10*j]) square([3,j==2?8:5]);
      }
    }
  }
}

module back_comb_2d() {
  union() {
    difference() {
      square([8*switch_spacing+20,20]);
      for(i=[0:8]) {
	translate([10+i*switch_spacing, -thin]) square([3,15+thin]);
      }
    }
    for(i=[0:8]) {
      translate([7+i*switch_spacing, 20-thin]) square([3,3+thin]);
    }
   
  }
}

for(i=[0:8]) {
  translate([-5,13+i*switch_spacing,20]) rotate([90,0,0]) {
    stagger = (i%2==0?-20:-10);
    linear_extrude(height=3) lever_2d();
    color([1.0,0.5,0.5]) translate([-40,-20,3]) linear_extrude(height=3) output_2d(stagger);
    translate([-45,-5,3]) linear_extrude(height=3) hardpoint_2d(stagger);
  }
 }

rotate([90,0,0]) rotate([0,90,0]) linear_extrude(height=3) frontpanel_2d();
translate([-43,0,30]) rotate([90,0,0]) rotate([0,90,0]) linear_extrude(height=3) back_comb_2d();
rotate([0,0,90]) translate([0,0,60]) linear_extrude(height=3) topplate_2d();


// Interconnect, for reference
for(i=[0:7]) {
  stagger = (i%2==0?0:-10);
  translate([-40+stagger,10+switch_spacing*i,-5]) rotate([0,0,180]) rotate([90,0,0]) {
    linear_extrude(height=3) cable_connector_2d();
    color([0,1.0,0]) linear_extrude(height=3) stator_2d();
    translate([0,0,3]) color([0,0,1.0,0.5]) linear_extrude(height=3) top_plate_2d();
  }
}
  
