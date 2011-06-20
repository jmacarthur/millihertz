include <params.scad>

// Argument is Y offset

puntWidth = 2;

puntPosX = row1x+gridSpacing*3+puntWidth/2; // MUST be an odd number otherwise you'll
	 // hit the data!
puntLen=120;
module punt(yOffset)
{
	translate([puntPosX,yOffset,chassisTop-20]) {
	// Two bits of angle to hold the punt
	union() {
	translate([-20,0,0]) cube(size=[20,1.5,20]);
	translate([-1.5,0,0])	cube(size=[1.5,20,20]);
	}
      }
      
	translate([puntPosX+puntWidth,yOffset,chassisTop-20]) {
	// Two bits of angle to hold the punt
	union() {
	translate([0,0,0]) cube(size=[20,1.5,20]);
	translate([0,0,0])	cube(size=[1.5,20,20]);
	}
      }
      
      difference() {
      translate([puntPosX,yOffset,chassisTop-15]) {
      cube(size=[puntWidth, puntLen, 10]);
      }
      // Punch holes
      translate([puntPosX-1,yOffset+80+5,chassisTop-10]) {
      rotate([0,90,0]) cylinder(r=2.5,h=100);
      }
      translate([puntPosX-1,yOffset+puntLen-5,chassisTop-10]) {
      rotate([0,90,0]) cylinder(r=2.5,h=100);
      }
      }

// The punt itself
   translate([puntPosX-puntWidth,yOffset+80+5,50-50+chassisTop-10]) {
   
   rotate([30,0,0])
      difference() {

      translate([0,-5,-chassisTop+10]) {
      cube(size=[puntWidth, 10, 50]);
      }
      translate([-1,0,0]) {
      rotate([0,90,0]) cylinder(r=2.5,h=100);
      }
     translate([-1,0,-chassisTop+10]) rotate([45,0,0]) translate([0,-20,0]) cube(size=[20,20,20]);
     translate([-1,0,-chassisTop+10]) rotate([45,0,0]) translate([0,0,-20]) cube(size=[20,20,20]);
 

    }      

}
    // This is the grading plate on the bottom
      difference() {
          translate([wheelWidth+gridWallWidth,yOffset,rideHeight-1.5])

      cube(size=[chassisInternalSpacing+chassisThickness*2,120,1.5]);
      translate([row1x+gridSpacing*3-puntWidth/2,yOffset+10,rideHeight-2.5])
      cube(size=[puntWidth,100,5]);
      }
      
}
