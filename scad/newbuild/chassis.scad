include <params.scad>

// The chassis is a ladder frame which supports all the rest of the equipment.
// It's made of 20mm square box section aluminium. 

// The second revision chassis is made to replace the 20mm aluminium section.
// It will be cut from 3 or 5mm acrylic.

module squareBoxSection(l)
{
	color([0.7,0.7,0.7])
	difference() {
  	  cube(size=[chassisThickness,l,chassisThickness]);
	  translate([chassisWallThickness,-1,chassisWallThickness]) cube (size=[chassisThickness-chassisWallThickness*2, l+2, chassisThickness-chassisWallThickness*2]);
	}
}

crossBeam1Y = 100;
crossBeam2Y = 250+crossBeam1Y;
chassisAcrylThick = 5;
module chassis()
{
	translate([0,0,0]) squareBoxSection(605);
	translate([chassisThickness+chassisInternalSpacing,0,0]) squareBoxSection(605);
	translate([chassisThickness,crossBeam1Y+chassisThickness,0]) rotate([0,0,270]) squareBoxSection(chassisInternalSpacing);
	translate([chassisThickness,crossBeam2Y+chassisThickness,0]) rotate([0,0,270]) squareBoxSection(chassisInternalSpacing);
}

/*          difference() {
            cube(size=[5,80,120]);
            translate([-1,-50,90]) rotate([-45,0,0]) cube(size=[7,50,150]);
            translate([-1,20,75]) rotate([0,90,0])	cylinder(r=bearingRadius,h=7);
            translate([-1,70,110]) rotate([0,90,0])	cylinder(r=2.5,h=7);
          }
*/

module acrylicBeams()
{
  for(x=[0,chassisThickness-5,
         chassisThickness+chassisInternalSpacing,
         chassisThickness*2+chassisInternalSpacing-5]) {
    difference() {
      union() {
        translate([x,0,0]) cube(size=[5,450,20]);
        // For some reason we have to fudge axle1Y in this way. We should refactor.
        translate([x,gridWallWidth+gridHoleSize/2+axle1Y-15,-10]) cube(size=[5,30,10]);
        translate([x,gridWallWidth+gridHoleSize/2+axle2Y-15,-10]) cube(size=[5,30,10]);
        translate([x,camsYoffset-20,0]) cube(size=[5,80,120]);
      }
      for(y=[crossBeam1Y,crossBeam2Y]) {
        translate([-1,y-cutWidth/2,15]) cube(size=[chassisInternalSpacing*2,5+cutWidth,20]);
      }
      // Cam support holes/cutoff
      translate([x-1,camsYoffset-50-20,100]) rotate([-45,0,0]) cube(size=[7,50,150]);
      translate([x-1,camsYoffset,75]) rotate([0,90,0])	cylinder(r=needleRollerRadius,h=7);
      translate([x-1,camsYoffset+70-20,110]) rotate([0,90,0])	cylinder(r=2.5,h=7);

      // Holes for bearings
      translate([x-1,gridWallWidth+gridHoleSize/2+axle1Y,-axleRadius]) rotate([0,90,0])  cylinder(r=axleBearingDiameter/2,h=10);
      translate([x-1,gridWallWidth+gridHoleSize/2+axle2Y,-axleRadius]) rotate([0,90,0])  cylinder(r=axleBearingDiameter/2,h=10);     
    }
  }
}

module drilledAcrylicBeams()
{
  difference() {
    acrylicBeams();
    for(holeY=[10,60])
    translate([-thin,holeY,ballBearingHeight+clearance+20-axleRadius-axleHeight])
    rotate([0,90,0]) {
      cylinder(r=1.5,h=chassisInternalSpacing+2*chassisThickness+2*thin);
    }
  }
}


module acrylicCrossBeam() 
{
	difference() {
	translate([-10,0,0]) cube(size=[chassisInternalSpacing+chassisThickness*2+20,5,20]);
	for(x=[0,chassisThickness-5,chassisThickness+chassisInternalSpacing,chassisInternalSpacing+chassisThickness*2-5]) {
	translate([x,-1,-1]) cube(size=[5+cutWidth,7,16]);
	}
	}
}
module acrylicCrossBeams()
{
	for(y=[crossBeam1Y,crossBeam2Y]) {
	translate([0,y,0]) acrylicCrossBeam();
	}
}

module acrylicChassis()
{
	color([1.0,0,0.5]) {	
          union() {
            drilledAcrylicBeams();
            // Tabs for punt plate
            translate([0,140,-3]) cube([chassisAcrylThick,20,3]);
            translate([chassisInternalSpacing+chassisThickness*2-chassisAcrylThick,140,-3]) cube([chassisAcrylThick,20,3]);
          }
          acrylicCrossBeams();
	}
}
