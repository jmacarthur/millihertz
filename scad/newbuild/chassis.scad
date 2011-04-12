include <params.scad>

// The chassis is a ladder frame which supports all the rest of the equipment.
// It's made of 20mm square box section aluminium. 

chassisInternalSpacing = 90;
chassisWallThickness = 1;

module squareBoxSection(l)
{
	difference() {
  	  cube(size=[20,l,20]);
	  translate([chassisWallThickness,-1,chassisWallThickness]) cube (size=[20-chassisWallThickness*2, l+2, 20-chassisWallThickness*2]);
	}
}

module chassis()
{
	translate([0,0,0]) squareBoxSection(200);
	translate([20+chassisInternalSpacing,0,0]) squareBoxSection(200);
}