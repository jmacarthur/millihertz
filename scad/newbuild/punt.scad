include <params.scad>

// Argument is Y offset

puntWidth = 2;

puntPosX = row1x+gridSpacing*3+puntWidth/2; // MUST be an odd number otherwise you'll
// hit the data!

// Note - the measurements here are not accurately calculated, just done by eye
leverLen=120;
puntLen=50;

up = 1;

leverAngle = 10*up;




leverPuntPos = 75;
      puntAxleY = leverPuntPos*cos(leverAngle);
      puntAxleZ = leverPuntPos*sin(leverAngle);
puntAngle=31*(1-up); // Full deflect at 31
bearingPos = leverLen-15;
bearingPosY = bearingPos*cos(leverAngle);
bearingPosZ = bearingPos*sin(leverAngle);

leverDescend = bearingPos*sin(10); 

module dirSelector()
{
      difference() {
      linear_extrude(height=3) {
      polygon(points=[[0,0],[5,5],[10,5],[10,10],[15,15],[20,10],[20,5],[25,5],[30,0]], paths=[[0,1,2,3,4,5,6,7,8]]);
      }
      translate([15,7.5,-1]) cylinder(r=1.5,h=7);
      }
}

module punt(yOffset)
{
	translate([puntPosX,yOffset,chassisTop-20]) {
	// Two bits of angle to hold the punt
	union() {
	translate([-20,0,0]) cube(size=[20,1.5,20]);
	difference() {
	translate([-1.5,0,0])	cube(size=[1.5,20,70]);
	translate([-2,15,60]) rotate([0,90,0]) cylinder(r=1.5,h=5); // Hole for spring
	}
	}
      }
      
	translate([puntPosX+puntWidth,yOffset,chassisTop-20]) {
	// Two bits of angle to hold the punt
	union() {
	translate([0,0,0]) cube(size=[20,1.5,20]);
	translate([0,0,0])	cube(size=[1.5,20,20]);
	}
      }
      
      // Lever
      translate([puntPosX,yOffset+10,chassisTop-5]) {
      rotate([leverAngle,0,0])
      difference() {
      translate([0,-10,-5])
      cube(size=[puntWidth, leverLen, 10]);
      // Punch holes
      translate([-1,leverPuntPos,0]) {
      rotate([0,90,0]) cylinder(r=2.5,h=100); // Punt hole
      }
      translate([-1,40,2]) {
      rotate([0,90,0]) cylinder(r=1.5,h=100); // Spring hole
      }
      translate([-1,bearingPos,0]) {
      rotate([0,90,0]) cylinder(r=2.5,h=100); // Bearing hole
      }
      translate([-1,0,0]) {
      rotate([0,90,0]) cylinder(r=2.5,h=100); // axis hole
      }
      }
      }

    // Bearing on the end of the pusher bar
    translate([0,yOffset+10,chassisTop-5]) {
    translate([puntPosX-5,bearingPosY,bearingPosZ]) {
    rotate([0,90,0])    cylinder(r=8,h=5);
    }
    translate([puntPosX+puntWidth,bearingPosY,bearingPosZ]) {
    rotate([0,90,0])    cylinder(r=8,h=5);
    }
}

// The punt itself
   puntDescend = -chassisTop-1;
     translate([puntPosX-puntWidth,yOffset+puntAxleY+10,puntAxleZ+chassisTop-5]) {
     translate([0,0,-100])     color([1,0,0]) cylinder(r=1,h=1000);
     rotate([puntAngle,0,0])
     union() {
     translate([-5,0,-10])rotate([0,90,0]) cylinder(r=1.5,h=5); // Deflector peg
      difference() {
      
      translate([0,-5,puntDescend]) {
      cube(size=[puntWidth, 10, puntLen	]); // Actual punt plate
      }
      translate([-1,0,0]) {
      rotate([0,90,0]) cylinder(r=2.5,h=100); 
      }
     translate([-1,0,puntDescend]) rotate([45,0,0]) translate([0,-20,0]) cube(size=[20,20,20]);
     translate([-1,0,puntDescend]) rotate([45,0,0]) translate([0,0,-20]) cube(size=[20,20,20]);

    }      
    }

}
    // This is the grading plate on the bottom
      difference() {
          translate([wheelWidth+gridWallWidth,yOffset,rideHeight-1.5])

      cube(size=[chassisInternalSpacing+chassisThickness*2,120,1.5]);
      translate([row1x+gridSpacing*3-puntWidth/2,yOffset+10,rideHeight-2.5])
      cube(size=[puntWidth,100,5]);
      }

      // Selector rail
      translate([row1x+gridSpacing*3-puntWidth/2-6,yOffset+10,rideHeight])
      cube(size=[3,100,3]);

      // Mover guide thing
      translate([row1x+gridSpacing*3-puntWidth/2-3,yOffset+puntAxleY+10-15,rideHeight])
      {
      rotate([90,0,0])
      rotate([0,90,0])
      color([0.5,0.5,0.5])
      union() {

            dirSelector();
	    translate([0,0,-6])            dirSelector();
	    }
	    translate([-30,15,7.5])
	    rotate([0,90,0])
	    color([0.8,0.8,0.2])
	    cylinder(r=1.5,h=30);
	}    
}
