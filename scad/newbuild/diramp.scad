include <params.scad>

// Direction amplifier bar

dirAmpMaxRotate = 5;

dirAmpRotate = ( $t < 0.45 ? 0: dirAmpMaxRotate);

dirAmpControlLen = 50;

// This is the amount we need to pull the amp bar back by
//dirAmpPull = dirAmpComtrolLen*sin(dirAmpRotate);

module diramp()
{
  color([0.5,1,1]) {
    rotate([0,0,dirAmpRotate])
    difference() {
      union () {
        translate([-90,-7.5,0]) cube(size=[100,15,3]);
        translate([-90,-23.5,0]) cube(size=[15,31,3]);
      }
      // Main axle
      translate([0,0,-1]) cylinder(r=2.5,h=10);
      // Output holes
      translate([-dirAmpControlLen,2.5,-1]) cylinder(r=1.5,h=10);
      translate([-60,2.5,-1]) cylinder(r=1.5,h=10);
      translate([-70,2.5,-1]) cylinder(r=1.5,h=10);
      translate([-80,2.5,-1]) cylinder(r=1.5,h=10);
      
      // Input (spring) hole
      translate([-85,-20,-1]) cylinder(r=1.5,h=10);
    }
}
}
