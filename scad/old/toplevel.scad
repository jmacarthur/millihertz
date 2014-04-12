include <stateflip.scad>
include <turing.scad>
include <dirbox.scad>
include <raiser.scad>
include <mover.scad>
include <params.scad>
include <camshaft.scad>
include <statebox.scad>

module everything() {
translate([30+15,20-6,60+15]) { rotate([0,90,0]) { stateflip(); }  }
//translate([30-6,20-6,50]) { dirbox(); dirbar(); }  // Manifold issues
//translate([gridSeparation,0,30]) { rotate([0,-45,0]) {raiser();}}
//translate([0,5,20]) { maze(); }
//translate([0,5,20]) { fakemaze(); }
//translate([-250,0,0]) { rails(); }
//translate([-30,railWidth,10]) { mover(); } // Manifold issues
//translate([-30,railWidth,10]) { camshaft(); } // manifold issues
//translate([30-6,20-6,60]) { punchedStateBox(); } 
//axles();
}

rideHeight = sqrt(wheelRadius*wheelRadius - 3*3) - wheelAxleZ;

/*for(x=[-30:30]) {
translate([axle2X-3-gridMetalWidth+x*gridSeparation,0,-rideHeight-gridHeight]) color([0.1,0.1,0.1]) cube([gridMetalWidth,15*gridSeparation,gridHeight]);
}
for(x=[0:15]) {
translate([-250,x*gridSeparation,-rideHeight-gridHeight]) color([0.1,0.1,0.1]) cube([500,gridMetalWidth,gridHeight]);
}
*/

ballRadius = (9.58/2);
if(drawData) {
  for(x=[0:5])
    translate([-100,railWidth+(x*2+1)*gridSeparation,-rideHeight-gridHeight+ballRadius]) sphere(r=ballRadius);
}

everything();
