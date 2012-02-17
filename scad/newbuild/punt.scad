include <params.scad>

// Argument is Y offset

puntWidth = 3;

puntPosX = row1x+gridSpacing*3+puntWidth/2; // MUST be an odd number otherwise you'll
// hit the data!

// Note - the measurements here are not accurately calculated, just done by eye
leverLen=120;
puntLen=50;

up = ($t<0.5)?1:($t<0.7)?1-($t-0.5)*5:$t;

leverAngle = 10*up;

puntMaterialThickness = 3;


leverPuntPos = 75;
puntAxleY = leverPuntPos*cos(leverAngle);
puntAxleZ = leverPuntPos*sin(leverAngle);
puntAngle=31*(1-up); // Full deflect at 31
bearingPos = leverLen-15;
bearingPosY = bearingPos*cos(leverAngle);
bearingPosZ = bearingPos*sin(leverAngle);

leverDescend = bearingPos*sin(10); 
selectorRadius = 1.5;
selectorRodHeight = 7.5;
module dirSelector()
{
      difference() {
      linear_extrude(height=3) {
      polygon(points=[[0,0],[5,5],[10,5],[10,10],[15,15],[20,10],[20,5],[25,5],[30,0]], paths=[[0,1,2,3,4,5,6,7,8]]);
      }
      translate([15,7.5,-1]) cylinder(r=selectorRadius,h=7);
      }
}

drawBasePlate = 1;

module punt(yOffset)
{
  translate([puntPosX,yOffset,chassisTop-20]) {
    // Two bits of angle to hold the punt
    union() {
      translate([-20,0,0]) cube(size=[20,puntMaterialThickness,20]); // This bit needs tabs
      difference() {
	translate([-puntMaterialThickness,0,0])	cube(size=[puntMaterialThickness,20,70]);
	translate([-puntMaterialThickness-1,15,60]) rotate([0,90,0]) cylinder(r=1.5,h=5); // Hole for spring
	translate([-puntMaterialThickness-1,10,15]) rotate([0,90,0]) cylinder(r=2.5,h=5); // Axle hole
      }
    }
  }
  
  translate([puntPosX+puntWidth,yOffset,chassisTop-chassisThickness-10]) {
    // Two bits of angle to hold the punt
    difference() {
      union() {
        translate([0,0,0]) cube(size=[20,puntMaterialThickness,30]); // This bit needs tabs
	translate([0,0,0]) cube(size=[puntMaterialThickness,20,30]);
        
      }
      translate([-1,10,25]) rotate([0,90,0]) cylinder(r=2.5,h=5); // Axle hole
      translate([-1,10,10-puntMaterialThickness]) cube(size=[10,20,puntMaterialThickness]);
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
          cube(size=[puntWidth, 10, puntLen]); // Actual punt plate
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
  if(drawBasePlate) {
    difference() {
      translate([wheelWidth+gridWallWidth,yOffset,rideHeight-puntMaterialThickness])
        
        cube(size=[chassisInternalSpacing+chassisThickness*2,120,puntMaterialThickness]);
      translate([row1x+gridSpacing*3-puntWidth/2,yOffset+30,rideHeight-puntMaterialThickness-1])
        cube(size=[puntWidth,80,5]);
      
      // These are cutout tabs for things mounted above
      translate([row1x+gridSpacing*3-puntWidth/2,yOffset,
                 rideHeight-puntMaterialThickness-1]) 
      {
        translate([0-puntMaterialThickness*4,puntAxleY-5-30,0])
          cube(size=[puntMaterialThickness,10,5]);
        translate([0-puntMaterialThickness*4,puntAxleY-5-30+60,0])
          cube(size=[puntMaterialThickness,20,5]);
        translate([0-puntMaterialThickness*2,puntAxleY-5-30+60,0])
          cube(size=[puntMaterialThickness,10,5]); 
        translate([0-puntMaterialThickness*2,puntAxleY-5-30,0])
          cube(size=[puntMaterialThickness,10,5]); 
        // Two cutouts to hold the punt axle blocks	  
        translate([0+puntMaterialThickness*2,-1,0])
          cube(size=[puntMaterialThickness,11,5]); 
        translate([0,-1,0])
          cube(size=[puntMaterialThickness,11,5]); 
      }
      // Cutouts to locate the plate to the chassis
      translate([wheelWidth+gridWallWidth-thin,yOffset+20,rideHeight-puntMaterialThickness-thin]) 
        cube(size=[chassisAcrylThick+thin,20,puntMaterialThickness+thin*2]);
      translate([wheelWidth+gridWallWidth+chassisInternalSpacing+chassisThickness*2-chassisAcrylThick,yOffset+20,rideHeight-puntMaterialThickness-thin]) 
        cube(size=[chassisAcrylThick+thin,20,puntMaterialThickness+thin*2]);
    }
  }

      // Selector rail
      union() {
      translate([row1x+gridSpacing*3-puntWidth/2-6,yOffset+10,rideHeight])
      cube(size=[puntMaterialThickness,100,puntMaterialThickness]);
      translate([row1x+gridSpacing*3-puntWidth/2-6,yOffset+puntAxleY+10-15-30,rideHeight-puntMaterialThickness])
      cube(size=[puntMaterialThickness,10,puntMaterialThickness]); // TAB
      translate([row1x+gridSpacing*3-puntWidth/2-6,yOffset+puntAxleY+10-15+30,rideHeight-puntMaterialThickness])
      cube(size=[puntMaterialThickness,10,puntMaterialThickness]); // TAB
      }

      // Mover guide thing
      translate([row1x+gridSpacing*3-puntWidth/2-3,yOffset+puntAxleY+10-15,rideHeight])
      {
      rotate([90,0,0])
      rotate([0,90,0])
      color([0.5,0.5,0.5])
      union() {

            dirSelector();
	    translate([0,0,-puntMaterialThickness*2])            dirSelector();
	    }
	    translate([-30,15,selectorRodHeight])
	    rotate([0,90,0])
	    color([0.8,0.8,0.2])
	    cylinder(r=selectorRadius,h=30);
  // Slider - vertical guide
  translate([-puntMaterialThickness*3,-30,-puntMaterialThickness])
  difference() {
    cube(size=[puntMaterialThickness,80,20]);
    translate([-1,5,selectorRodHeight-selectorRadius+puntMaterialThickness])
    cube(size=[puntMaterialThickness+2,70,selectorRadius*2]);
    translate([-1,10,-1])
    cube(size=[puntMaterialThickness+2,50,puntMaterialThickness+1]);
    }
  }
}
