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

module chassis()
{
	translate([0,0,0]) squareBoxSection(605);
	translate([chassisThickness+chassisInternalSpacing,0,0]) squareBoxSection(605);
	translate([chassisThickness,crossBeam1Y+chassisThickness,0]) rotate([0,0,270]) squareBoxSection(chassisInternalSpacing);
	translate([chassisThickness,crossBeam2Y+chassisThickness,0]) rotate([0,0,270]) squareBoxSection(chassisInternalSpacing);
}

// Laser beam diameter
cutWidth=0.5;

module acrylicBeams()
{
	difference() {
		union() {
                  translate([0,0,0]) cube(size=[5,605,20]);
		  translate([chassisThickness-5,0,0]) cube(size=[5,605,20]);
		  translate([chassisThickness+chassisInternalSpacing,0,0]) cube(size=[5,605,20]);
		  translate([chassisThickness+chassisInternalSpacing+chassisThickness-5,0,0]) cube(size=[5,605,20]);
                }
		for(y=[crossBeam1Y,crossBeam2Y]) {
		translate([-1,y-cutWidth/2,15]) cube(size=[chassisInternalSpacing*2,5+cutWidth,20]);
		}
	}
}



module acrylicCrossBeam() 
{
	difference() {
	translate([0,0,10]) cube(size=[chassisInternalSpacing+chassisThickness*2,5,10]);
	for(x=[0,chassisThickness-5,chassisThickness+chassisInternalSpacing,chassisInternalSpacing+chassisThickness*2-5]) {
	translate([x-cutWidth/2,-1,9]) cube(size=[5+cutWidth,7,6]);
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
		acrylicBeams();
		acrylicCrossBeams();


	}
}